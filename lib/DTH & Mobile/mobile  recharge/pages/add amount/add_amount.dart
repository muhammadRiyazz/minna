import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minna/comman/const/const.dart';
import 'package:minna/comman/core/api.dart';
import 'package:minna/comman/pages/log%20in/login_page.dart';
import 'package:minna/DTH%20&%20Mobile/mobile%20%20recharge/application/proceed_recharge/recharge_proceed_bloc.dart';
import 'package:minna/comman/application/login/login_bloc.dart';
import 'package:minna/comman/pages/main%20home/home.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:minna/comman/functions/create_order_id.dart';
import 'package:http/http.dart' as http;

class AmountEntryPage extends StatefulWidget {
  final String phoneNo;
  final String operator;

  const AmountEntryPage({
    super.key,
    required this.phoneNo,
    required this.operator,
  });

  @override
  State<AmountEntryPage> createState() => _AmountEntryPageState();
}

class _AmountEntryPageState extends State<AmountEntryPage> {
  final TextEditingController _amountController = TextEditingController();
  late Razorpay _razorpay;
  String? _orderId;
  bool _isPaymentInProgress = false;
  String? _callbackId;
  
  // Track processed states to prevent duplicate handling
  RechargeProceedState? _lastProcessedState;

  @override
  void initState() {
    super.initState();
    context.read<LoginBloc>().add(const LoginEvent.loginInfo());
    _initRazorpay();
  }

  @override
  void dispose() {
    _razorpay.clear();
    _amountController.dispose();
    super.dispose();
  }

  void _initRazorpay() {
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) async {
    log("Payment Success - paymentId: ${response.paymentId}");
    log("Payment Success - orderId: ${response.orderId}");

    setState(() {
      _isPaymentInProgress = false;
    });

    context.read<RechargeProceedBloc>().add(
      RechargeProceedEvent.proceedWithPayment(
        phoneNo: widget.phoneNo,
        operator: widget.operator,
        amount: _amountController.text.trim(),
        orderId: response.orderId ?? _orderId ?? '',
        transactionId: response.paymentId ?? '',
        paymentStatus: 1,
        callbackId: _callbackId!,
      ),
    );
  }

  void _handlePaymentError(PaymentFailureResponse response) async {
    log("Payment Failed: ${response.message}");

    setState(() {
      _isPaymentInProgress = false;
    });

    context.read<RechargeProceedBloc>().add(
      RechargeProceedEvent.paymentFailed(
        orderId: _orderId ?? '',
        phoneNo: widget.phoneNo,
        operator: widget.operator,
        amount: _amountController.text.trim(),
        callbackId: _callbackId ?? '',
      ),
    );

    log("Payment Failed", );
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    log("External Wallet: ${response.walletName}");
    log("External wallet selected: ${response.walletName}");
  }

  Future<void> _onProceed() async {
    String amount = _amountController.text.trim();
    if (amount.isEmpty ||
        double.tryParse(amount) == null ||
        double.parse(amount) <= 0) {
      _showCustomSnackbar("Please enter a valid amount", isError: true);
      return;
    }

    final isLoggedIn = context.read<LoginBloc>().state.isLoggedIn ?? false;

    if (!isLoggedIn) {
      await _showLoginBottomSheet();
      final newLoginState = context.read<LoginBloc>().state;
      if (newLoginState.isLoggedIn != true) {
        return;
      }
    }

    // Reset bloc state for new payment
    context.read<RechargeProceedBloc>().add(const RechargeProceedEvent.resetStates());

    // First make the callback to temporary storage
    final callbackResult = await _makeCallbackToTemporaryStorage(amount);
    if (callbackResult != null) {
      _callbackId = callbackResult;
      await _initiatePayment(amount);
    } else {
      log("Failed to initialize recharge");
    }
  }

  Future<String?> _makeCallbackToTemporaryStorage(String amount) async {
    log("_makeCallbackToTemporaryStorage ------------------");
    setState(() {
      _isPaymentInProgress = true;
    });

    try {
      final url = Uri.parse('${baseUrl}utility_store');
      
      final response = await http.post(
        url,
        body: {
          'mob': widget.phoneNo,
          'amount': amount,
          'email_id': 'test@gmail.com',
          'BillerCategory': 'Mobile Recharge',
        },
      );

      log("Callback response status: ${response.statusCode}");
      log("Callback response body: ${response.body}");

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        
        if (responseData['status'] == 'SUCCESS' && 
            responseData['statusCode'] == 0 && 
            responseData['data'] != null) {
          
          final callbackId = responseData['data'].toString();
          log("Callback successful, received ID: $callbackId");
          
          setState(() {
            _isPaymentInProgress = false;
          });
          
          return callbackId;
        } else {
          log("Callback failed with status: ${responseData['status']}");
          setState(() {
            _isPaymentInProgress = false;
          });
          log("Failed to initialize recharge",);
          return null;
        }
      } else {
        log("Callback HTTP error: ${response.statusCode}");
        setState(() {
          _isPaymentInProgress = false;
        });
        log("Network error occurred",);
        return null;
      }
    } catch (e) {
      log("Callback error: $e");
      setState(() {
        _isPaymentInProgress = false;
      });
      log("Failed to initialize recharge",);
      return null;
    }
  }

  Future<void> _initiatePayment(String amount) async {
    setState(() {
      _isPaymentInProgress = true;
    });

    try {
      final orderId = await createOrder(double.parse(amount));
      if (orderId == null) {
        setState(() {
          _isPaymentInProgress = false;
        });
        log("Failed to create order",);
        return;
      }

      setState(() {
        _orderId = orderId;
      });

      var options = {
        'key': razorpaykey,
        'amount': (double.parse(amount) * 100).toString(),
        'name': 'Mobile Recharge',
        'order_id': orderId,
        'description': 'Mobile Recharge for ${widget.phoneNo}',
        'prefill': {
          'contact': widget.phoneNo,
          'email': 'user@example.com'
        },
        'theme': {'color': maincolor1!.value.toRadixString(16)},
      };

      _razorpay.open(options);
    } catch (e) {
      log("Payment initiation error: $e");
      setState(() {
        _isPaymentInProgress = false;
      });
      log("Payment error occurred",);
    }
  }

  Future<void> _showLoginBottomSheet() async {
    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const LoginBottomSheet(login: 1),
    );
  }

  void _showCustomSnackbar(String message, {bool isError = false}) {
    final color = isError ? Colors.redAccent : Colors.green;
    final icon = isError ? Icons.error_outline : Icons.check_circle_outline;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: color,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        duration: const Duration(seconds: 3),
        content: Row(
          children: [
            Icon(icon, color: Colors.white),
            const SizedBox(width: 12),
            Expanded(
              child: Text(message, style: const TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }

  void _handleRefundLogic(RechargeProceedState state) {
    // Only process if this is a new state
    if (_lastProcessedState == state) return;
    _lastProcessedState = state;

    // Handle recharge failure - trigger refund only once
    if (state.rechargeStatus == "FAILED" && 
        state.shouldRefund == true && 
        !state.hasRefundBeenAttempted &&
        state.hasRechargeFailedHandled == true) {
      
      log("Triggering refund due to recharge failure");
      
      context.read<RechargeProceedBloc>().add(
        RechargeProceedEvent.initiateRefund(
          orderId: state.orderId ?? '',
          transactionId: state.transactionId ?? '',
          amount: state.amount ?? '0',
          phoneNo: widget.phoneNo,
          callbackId: _callbackId ?? "",
        ),
      );
    }

    // Handle payment save failure - trigger refund only once
    if (state.paymentSavedStatus == "PAYMENT_SAVED_FAILED" && 
        state.shouldRefund == true && 
        !state.hasRefundBeenAttempted &&
        state.hasPaymentSaveFailedHandled == true) {
      
      log("Triggering refund due to payment save failure");
      
      context.read<RechargeProceedBloc>().add(
        RechargeProceedEvent.initiateRefund(
          orderId: state.orderId ?? '',
          transactionId: state.transactionId ?? '',
          amount: state.amount ?? '0',
          phoneNo: widget.phoneNo,
          callbackId: _callbackId ?? '',
        ),
      );
    }
  }
void _showSuccessBottomSheet({
  required String amount,
  required String phoneNo,
  required String operator,
}) {
  showModalBottomSheet(
      context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    isDismissible: false, // Prevent closing by tapping outside
    enableDrag: false, // Prevent closing by dragging down
    builder: (context) => WillPopScope(
         onWillPop: () async {
        // Prevent closing by back button
        return false;
      },
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Success Icon
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: Colors.green.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.check_circle,
                  color: Colors.green,
                  size: 50,
                ),
              ),
              const SizedBox(height: 20),
              
              // Success Title
              const Text(
                'Recharge Successful!',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              ),
              const SizedBox(height: 15),
              
              // Details
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.grey[50],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    _buildDetailRow('Amount', '₹$amount'),
                    _buildDetailRow('Mobile Number', phoneNo),
                    _buildDetailRow('Operator', operator),
                    _buildDetailRow('Status', 'Successfully Recharged'),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              
              // Message
              const Text(
                'Your mobile recharge has been processed successfully.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 25),
              
              // Close Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                     Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return HomePage();
                        },
                      ),
                      (route) => false,
                    );
                    // Optional: Navigate back or reset the page
                    // Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Done',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

void _showRefundInitiatedBottomSheet({
  required String amount,
  required String phoneNo,
}) {
  showModalBottomSheet(
  context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    isDismissible: false, // Prevent closing by tapping outside
    enableDrag: false, // Prevent closing by dragging down
    builder: (context) => WillPopScope(

        onWillPop: () async {
        // Prevent closing by back button
        return false;
      },
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Refund Icon
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: Colors.orange.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.autorenew,
                  color: Colors.orange,
                  size: 50,
                ),
              ),
              const SizedBox(height: 20),
              
              // Title
              const Text(
                'Refund Initiated',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.orange,
                ),
              ),
              const SizedBox(height: 15),
              
              // Details
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.grey[50],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    _buildDetailRow('Amount', '₹$amount'),
                    _buildDetailRow('Mobile Number', phoneNo),
                    _buildDetailRow('Status', 'Refund Initiated'),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              
              // Message
              const Text(
                'Sorry, your recharge could not be processed. Refund has been initiated and amount will be credited to your account shortly.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 25),
              
              // Close Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
       Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return HomePage();
                        },
                      ),
                      (route) => false,
                    );                },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Ok',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

void _showRefundFailedBottomSheet({
  required String amount,
  required String phoneNo,
}) {
  showModalBottomSheet(
      context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    isDismissible: false, // Prevent closing by tapping outside
    enableDrag: false, 
    builder: (context) => WillPopScope(
       onWillPop: () async {
        // Prevent closing by back button
        return false;
      },
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Failed Icon
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: Colors.red.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.error_outline,
                  color: Colors.red,
                  size: 50,
                ),
              ),
              const SizedBox(height: 20),
              
              // Title
              const Text(
                'Refund Failed',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.red,
                ),
              ),
              const SizedBox(height: 15),
              
              // Details
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.grey[50],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    _buildDetailRow('Amount', '₹$amount'),
                    _buildDetailRow('Mobile Number', phoneNo),
                    _buildDetailRow('Status', 'Refund Failed'),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              
              // Important Message
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.red.withOpacity(0.05),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.red.withOpacity(0.2)),
                ),
                child: const Column(
                  children: [
                    Text(
                      'Important:',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.red,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Sorry, your recharge failed and we were unable to process the refund automatically. If the amount was debited from your account, please contact our support team for assistance.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.red,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              
              // Support Button
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: () {
 Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return HomePage();
                        },
                      ),
                      (route) => false,
                    );                       // _contactSupport();
                  },
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    side: const BorderSide(color: Colors.red),
                  ),
                  child: const Text(
                    'Close',
                    style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              
            
            ],
          ),
        ),
      ),
    ),
  );
}

void _showFailureBottomSheet({
  required String amount,
  required String phoneNo,
  required String operator,
  required bool isRefundInitiated,
  required bool isRefundFailed,
}) {
  showModalBottomSheet(
   context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    isDismissible: false, // Prevent closing by tapping outside
    enableDrag: false,
    builder: (context) => WillPopScope(
         onWillPop: () async {
        // Prevent closing by back button
        return false;
      },
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Failed Icon
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: Colors.red.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.cancel_outlined,
                  color: Colors.red,
                  size: 50,
                ),
              ),
              const SizedBox(height: 20),
              
              // Title
              const Text(
                'Recharge Failed',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.red,
                ),
              ),
              const SizedBox(height: 15),
              
              // Details
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.grey[50],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    _buildDetailRow('Amount', '₹$amount'),
                    _buildDetailRow('Mobile Number', phoneNo),
                    _buildDetailRow('Operator', operator),
                    _buildDetailRow('Status', 'Failed'),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              
              // Message
              const Text(
                'We encountered an issue while processing your recharge. Please try again later.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 25),
              
              // Try Again Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Try Again',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

// Helper method for detail rows
Widget _buildDetailRow(String title, String value) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 14,
            color: Colors.grey,
            fontWeight: FontWeight.w500,
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            fontSize: 14,
            color: Colors.black87,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    ),
  );
}
  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
     BlocListener<RechargeProceedBloc, RechargeProceedState>(
  listener: (context, state) {
    if (!state.isLoading) {
      _handleRefundLogic(state);
      
      // Show success bottom sheet
      if (state.rechargeStatus == "SUCCESS") {
        log("Recharge Successful ✅");
        _showSuccessBottomSheet(
          amount: state.amount ?? '',
          phoneNo: widget.phoneNo,
          operator: widget.operator,
        );
      } 
      // Show recharge failed but refund will be initiated
      else if (state.rechargeStatus == "FAILED" && state.shouldRefund == true) {
        log("Recharge Failed - Refund will be initiated ❌");
        // Don't show anything here, wait for refund status
      }
      // Show recharge failed without refund
      else if (state.rechargeStatus == "FAILED" && state.shouldRefund != true) {
        log("Recharge Failed - No refund needed ❌");
        _showFailureBottomSheet(
          amount: state.amount ?? '',
          phoneNo: widget.phoneNo,
          operator: widget.operator,
          isRefundInitiated: false,
          isRefundFailed: false,
        );
      }

      // Show refund initiated success
      if (state.refundStatus == "REFUND_INITIATED") {
        log("Refund initiated successfully");
        _showRefundInitiatedBottomSheet(
          amount: state.amount ?? '',
          phoneNo: widget.phoneNo,
        );
      } 
      // Show refund failed
      else if (state.refundStatus == "REFUND_FAILED") {
        log("Refund failed");
        _showRefundFailedBottomSheet(
          amount: state.amount ?? '',
          phoneNo: widget.phoneNo,
        );
      }

      // Show payment save failed
      if (state.paymentSavedStatus == "PAYMENT_SAVED_FAILED") {
        log("Failed to save payment");
        // This will automatically trigger refund, so we don't show anything here
      }
    }
  },
),
      ],
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: maincolor1,
          elevation: 0,
          iconTheme: const IconThemeData(color: Colors.white),
          title: const Text(
            'Enter Amount',
            style: TextStyle(
              fontSize: 15,
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
          centerTitle: true,
        ),
        body: SafeArea(
          child: Column(
            children: [
              const Spacer(),
              Column(
                children: [
                  const Text(
                    "Mobile Recharge Amount",
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.black87,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const Text(
                    "Please enter recharge amount",
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                  const SizedBox(height: 24),
                  Center(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text(
                          '₹',
                          style: TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                        const SizedBox(width: 10),
                        SizedBox(
                          width: 150,
                          child: TextField(
                            controller: _amountController,
                            keyboardType: const TextInputType.numberWithOptions(
                              decimal: true,
                            ),
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 40,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                            decoration: const InputDecoration(
                              hintText: '0.00',
                              hintStyle: TextStyle(
                                fontSize: 40,
                                color: Colors.grey,
                              ),
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: SizedBox(
                  width: double.infinity,
                  child: BlocBuilder<RechargeProceedBloc, RechargeProceedState>(
                    builder: (context, state) {
                      return ElevatedButton(
                        onPressed: (state.isLoading || _isPaymentInProgress) ? null : _onProceed,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.deepPurple,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: (state.isLoading || _isPaymentInProgress)
                            ? const CircularProgressIndicator(
                                color: Colors.white,
                                strokeWidth: 3,
                              )
                            : const Text(
                                'Proceed',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}