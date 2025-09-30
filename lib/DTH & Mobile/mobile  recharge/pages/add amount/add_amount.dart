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
         callbackId: _callbackId!, // Pass callback ID to the bloc
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
        // callbackId: _callbackId, // Pass callback ID to the bloc
      ),
    );

    _showCustomSnackbar("Payment Failed", isError: true);
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    log("External Wallet: ${response.walletName}");
    _showCustomSnackbar("External wallet selected: ${response.walletName}");
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

    // First make the callback to temporary storage
    final callbackResult = await _makeCallbackToTemporaryStorage(amount);
    if (callbackResult != null) {
      _callbackId = callbackResult;
      await _initiatePayment(amount);
    } else {
      _showCustomSnackbar("Failed to initialize recharge", isError: true);
    }
  }

  Future<String?> _makeCallbackToTemporaryStorage(String amount) async {
    setState(() {
      _isPaymentInProgress = true;
    });

    try {
      final url = Uri.parse('${baseUrl}utility_store');
      
      // final Map<String, String> headers = {
      //   'Content-Type': 'application/json',
      // };

      final Map<String, dynamic> body = {
        'mob': widget.phoneNo,
        'amount': amount,
        'email_id': 'test@gmail.com', // You might want to get this from user profile
        'BillerCategory': 'Mobile Recharge',
      };

      log("Making callback to temporary storage: $url");
      log("Callback parameters: $body");

      final response = await http.post(
        url,
        // headers: headers,
        body: json.encode(body),
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
          _showCustomSnackbar("Failed to initialize recharge", isError: true);
          return null;
        }
      } else {
        log("Callback HTTP error: ${response.statusCode}");
        setState(() {
          _isPaymentInProgress = false;
        });
        _showCustomSnackbar("Network error occurred", isError: true);
        return null;
      }
    } catch (e) {
      log("Callback error: $e");
      setState(() {
        _isPaymentInProgress = false;
      });
      _showCustomSnackbar("Failed to initialize recharge", isError: true);
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
        _showCustomSnackbar("Failed to create order", isError: true);
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
      _showCustomSnackbar("Payment error occurred", isError: true);
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

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<RechargeProceedBloc, RechargeProceedState>(
          listener: (context, state) {
            if (!state.isLoading) {
              // Handle recharge status
              if (state.rechargeStatus == "SUCCESS") {
                _showCustomSnackbar("Recharge Successful ✅");
              } else if (state.rechargeStatus == "FAILED") {
                _showCustomSnackbar("Recharge Failed ❌", isError: true);
                
                if (state.shouldRefund == true) {
                  context.read<RechargeProceedBloc>().add(
                    RechargeProceedEvent.initiateRefund(
                      orderId: state.orderId ?? '',
                      transactionId: state.transactionId ?? '',
                      amount: state.amount ?? '0',
                      phoneNo: widget.phoneNo,
                      // callbackId: _callbackId,
                    ),
                  );
                }
              }

              // Handle refund status
              if (state.refundStatus == "REFUND_INITIATED") {
                _showCustomSnackbar("Refund initiated successfully");
              } else if (state.refundStatus == "REFUND_FAILED") {
                _showCustomSnackbar("Refund failed", isError: true);
              }

              // Handle payment save status
              if (state.paymentSavedStatus == "PAYMENT_SAVED_FAILED") {
                _showCustomSnackbar("Failed to save payment", isError: true);
                
                if (state.shouldRefund == true) {
                  context.read<RechargeProceedBloc>().add(
                    RechargeProceedEvent.initiateRefund(
                      orderId: state.orderId ?? '',
                      transactionId: state.transactionId ?? '',
                      amount: state.amount ?? '0',
                      phoneNo: widget.phoneNo,
                      // callbackId: _callbackId,
                    ),
                  );
                }
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