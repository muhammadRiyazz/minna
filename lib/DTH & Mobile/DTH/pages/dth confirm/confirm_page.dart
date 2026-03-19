import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minna/DTH%20&%20Mobile/DTH/application/dth%20proceed/dth_confirm_bloc.dart';
import 'package:minna/comman/core/api.dart';
import 'package:minna/comman/pages/log%20in/login_page.dart';
import 'package:minna/comman/application/login/login_bloc.dart';
import 'package:minna/comman/pages/main%20home/home.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:minna/comman/functions/create_order_id.dart';
import 'package:http/http.dart' as http;

class DTHAmountEntryPage extends StatefulWidget {
  final String phoneNo;
  final String operator;
  final String subcriberNo;
  final String? initialAmount;

  const DTHAmountEntryPage({
    super.key,
    required this.phoneNo,
    required this.operator,
    required this.subcriberNo,
    this.initialAmount,
  });

  @override
  State<DTHAmountEntryPage> createState() => _DTHAmountEntryPageState();
}

class _DTHAmountEntryPageState extends State<DTHAmountEntryPage> {
  final TextEditingController _amountController = TextEditingController();
  late Razorpay _razorpay;
  String? _orderId;
  bool _isPaymentInProgress = false;
  String? _callbackId;

  // New color scheme
  final Color _primaryColor = Colors.black;
  final Color _secondaryColor = Color(0xFFD4AF37); // Gold
  final Color _accentColor = Color(0xFFC19B3C); // Darker Gold
  final Color _backgroundColor = Color(0xFFF8F9FA);
  final Color _cardColor = Colors.white;
  final Color _textPrimary = Colors.black;
  final Color _textSecondary = Color(0xFF666666);
  final Color _textLight = Color(0xFF999999);
  final Color _errorColor = Color(0xFFE53935);
  final Color _successColor = Color(0xFF4CAF50);

  @override
  void initState() {
    super.initState();
    if (widget.initialAmount != null && widget.initialAmount!.isNotEmpty) {
      _amountController.text = widget.initialAmount!;
    }
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

    context.read<DthConfirmBloc>().add(
      DthConfirmEvent.proceedWithPayment(
        phoneNo: widget.phoneNo,
        operator: widget.operator,
        amount: _amountController.text.trim(),
        subcriberNo: widget.subcriberNo,
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

    context.read<DthConfirmBloc>().add(
      DthConfirmEvent.paymentFailed(
        orderId: _orderId ?? '',
        phoneNo: widget.phoneNo,
        operator: widget.operator,
        amount: _amountController.text.trim(),
        subcriberNo: widget.subcriberNo,
        callbackId: _callbackId ?? '',
      ),
    );

    log("Payment Failed");
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
    context.read<DthConfirmBloc>().add(const DthConfirmEvent.resetStates());

    // First make the callback to temporary storage
    final callbackResult = await _makeCallbackToTemporaryStorage(amount);
    if (callbackResult != null) {
      _callbackId = callbackResult;
      await _initiatePayment(amount);
    } else {
      log("Failed to initialize DTH recharge");
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
          'BillerCategory': 'DTH Recharge',
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
          _showCustomSnackbar(
            "Failed to initialize DTH recharge",
            isError: true,
          );
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
      _showCustomSnackbar("Failed to initialize DTH recharge", isError: true);
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
        'name': 'DTH Recharge',
        'order_id': orderId,
        'description': 'DTH Recharge for ${widget.phoneNo}',
        'prefill': {'contact': widget.phoneNo, 'email': 'user@example.com'},
        'theme': {'color': _secondaryColor.value.toRadixString(16)},
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
    final color = isError ? _errorColor : _successColor;
    final icon = isError ? Icons.error_outline : Icons.check_circle_outline;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: color,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
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

  void _showRechargeStatusBottomSheet({
    required String amount,
    required String phoneNo,
    required String operator,
    required String status,
    required String message,
  }) {
    final bool isSuccess = status.toUpperCase() == 'SUCCESS';
    final bool isPending = status == 'On Hold' || status == 'In Process';
    final bool isFailed = !isSuccess && !isPending;

    Color statusColor = _successColor;
    IconData statusIcon = Icons.check_circle_rounded;
    if (isPending) {
      statusColor = Colors.orange;
      statusIcon = Icons.hourglass_empty_rounded;
    } else if (isFailed) {
      statusColor = _errorColor;
      statusIcon = Icons.error_outline_rounded;
    }

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      isDismissible: false,
      enableDrag: false,
      builder: (context) => WillPopScope(
        onWillPop: () async => false,
        child: Container(
          decoration: BoxDecoration(
            color: _cardColor,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(24),
              topRight: Radius.circular(24),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 20,
                offset: const Offset(0, -5),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Status Icon
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    color: statusColor.withOpacity(0.1),
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: statusColor.withOpacity(0.3),
                      width: 2,
                    ),
                  ),
                  child: Icon(
                    statusIcon,
                    color: statusColor,
                    size: 60,
                  ),
                ),
                const SizedBox(height: 24),

                // Title
                Text(
                  isSuccess 
                      ? 'Recharge Successful!' 
                      : (isPending ? 'Waiting for Confirmation' : 'Recharge Failed'),
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: statusColor,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),

                // Details Card
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: _backgroundColor,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: Colors.grey.shade200),
                  ),
                  child: Column(
                    children: [
                      _buildDetailRow('Amount', '₹$amount'),
                      _buildDetailRow('Phone Number', phoneNo),
                      if (operator.isNotEmpty) _buildDetailRow('Operator', operator),
                      _buildDetailRow(
                        'Status',
                        status,
                        isSuccess: isSuccess,
                        isError: isFailed,
                        isWarning: isPending,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),

                // Message
                if (isFailed)
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: _errorColor.withOpacity(0.05),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: _errorColor.withOpacity(0.2)),
                    ),
                    child: Column(
                      children: [
                        Text(
                          'Important Notice',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: _errorColor,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Sorry, your DTH recharge failed. Any deducted amount will be automatically refunded by our servers within 3-5 business days.',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 14, color: _errorColor),
                        ),
                      ],
                    ),
                  )
                else if (isPending)
                  Text(
                    'Your recharge is currently being processed by the operator. Please check the transaction history in 5-10 minutes for the final status.',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 15, color: _textSecondary, height: 1.5),
                  )
                else
                  Text(
                    message,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16, color: _textSecondary),
                  ),
                const SizedBox(height: 32),

                // Action Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => HomePage()),
                        (route) => false,
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: statusColor,
                      padding: const EdgeInsets.symmetric(vertical: 18),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      elevation: 2,
                    ),
                    child: Text(
                      isPending ? 'Got it' : 'Done',
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
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



  Widget _buildDetailRow(
    String title,
    String value, {
    bool isSuccess = false,
    bool isError = false,
    bool isWarning = false,
  }) {
    Color valueColor = _textPrimary;
    if (isSuccess) valueColor = _successColor;
    if (isError) valueColor = _errorColor;
    if (isWarning) valueColor = _secondaryColor;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 16,
              color: _textSecondary,
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 16,
              color: valueColor,
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
        BlocListener<DthConfirmBloc, DthConfirmState>(
          listener: (context, state) {
            if (!state.isLoading) {
              if (state.rechargeStatus != null) {
                log("DTH Recharge Status: ${state.rechargeStatus} - ${state.actualStatus}");
                _showRechargeStatusBottomSheet(
                  amount: state.amount ?? '',
                  phoneNo: widget.phoneNo,
                  operator: widget.operator,
                  status: state.actualStatus ?? state.rechargeStatus ?? 'Unknown',
                  message: state.errorMessage ?? 'Your request is being processed.',
                );
              } else if (state.paymentSavedStatus == "PAYMENT_SAVED_FAILED") {
                log("DTH Payment Saving Failed ❌");
                _showRechargeStatusBottomSheet(
                  amount: state.amount ?? '',
                  phoneNo: widget.phoneNo,
                  operator: widget.operator,
                  status: 'Payment Failed',
                  message: 'Could not save your payment details. Please contact support.',
                );
              }
            }
          },
        ),
      ],
      child: Scaffold(
        backgroundColor: _backgroundColor,
        appBar: AppBar(
          backgroundColor: _primaryColor,
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.white),
          title: const Text(
            'Enter DTH Recharge Amount',
            style: TextStyle(
              fontSize: 15,
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
          centerTitle: true,
        ),
        body: SafeArea(
          child: ListView(
            children: [
              // Header Section
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: _primaryColor,
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(24),
                    bottomRight: Radius.circular(24),
                  ),
                ),
                child: Column(
                  children: [
                    // DTH Info
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                      decoration: BoxDecoration(
                        color: _secondaryColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: _secondaryColor.withOpacity(0.3),
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.satellite_alt,
                                color: _secondaryColor,
                                size: 20,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                widget.operator,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),

                          SizedBox(height: 10),
                          Row(
                            children: [
                              Icon(
                                Icons.credit_card,
                                color: _secondaryColor,
                                size: 20,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                widget.subcriberNo,
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 50),
              // Amount Input Section
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Container(
                  padding: const EdgeInsets.all(25),
                  decoration: BoxDecoration(
                    color: _cardColor,
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 20,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Title
                      Text(
                        "Enter DTH Recharge Amount",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: _primaryColor,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        "Please enter the amount you want to recharge",
                        style: TextStyle(fontSize: 14, color: _textSecondary),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 32),

                      // Amount Input
                      Container(
                        decoration: BoxDecoration(
                          color: _backgroundColor,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: _secondaryColor.withOpacity(0.3),
                          ),
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 16,
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '₹',
                              style: TextStyle(
                                fontSize: 40,
                                fontWeight: FontWeight.bold,
                                color: _secondaryColor,
                              ),
                            ),
                            const SizedBox(width: 16),
                            SizedBox(
                              width: 150,
                              child: TextField(
                                controller: _amountController,
                                keyboardType:
                                    const TextInputType.numberWithOptions(
                                      decimal: true,
                                    ),
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 48,
                                  fontWeight: FontWeight.bold,
                                  color: _primaryColor,
                                ),
                                decoration: InputDecoration(
                                  hintText: '0.00',
                                  hintStyle: TextStyle(
                                    fontSize: 40,
                                    color: _textLight,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.zero,
                                  isDense: true,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(height: 40),

              // Proceed Button
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: BlocBuilder<DthConfirmBloc, DthConfirmState>(
                  builder: (context, state) {
                    return SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: (state.isLoading || _isPaymentInProgress)
                            ? null
                            : _onProceed,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: _primaryColor,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          elevation: 4,
                          shadowColor: _primaryColor.withOpacity(0.3),
                        ),
                        child: (state.isLoading || _isPaymentInProgress)
                            ? Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    width: 20,
                                    height: 20,
                                    child: CircularProgressIndicator(
                                      color: _secondaryColor,
                                      strokeWidth: 2,
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Text(
                                    'Processing...',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                    ),
                                  ),
                                ],
                              )
                            : Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Proceed to Payment',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Icon(Icons.arrow_forward_rounded, size: 20),
                                ],
                              ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
