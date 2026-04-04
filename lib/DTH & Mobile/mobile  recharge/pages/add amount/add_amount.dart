import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minna/comman/core/api.dart';
import 'package:minna/comman/pages/log%20in/login_page.dart';
import 'package:minna/DTH%20&%20Mobile/mobile%20%20recharge/application/proceed_recharge/recharge_proceed_bloc.dart';
import 'package:minna/comman/application/login/login_bloc.dart';
import 'package:minna/comman/pages/main%20home/home.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:minna/comman/functions/create_order_id.dart';
import 'package:http/http.dart' as http;
import 'package:minna/comman/const/const.dart';
import 'package:iconsax/iconsax.dart';

class AmountEntryPage extends StatefulWidget {
  final String phoneNo;
  final String operator;
  final String? initialAmount;

  const AmountEntryPage({
    super.key,
    required this.phoneNo,
    required this.operator,
    this.initialAmount,
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

  // Premium Theme Colors

  @override
  void initState() {
    super.initState();
    if (widget.initialAmount != null) {
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
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    log("External Wallet: ${response.walletName}");
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
      if (newLoginState.isLoggedIn != true) return;
    }

    context.read<RechargeProceedBloc>().add(
      const RechargeProceedEvent.resetStates(),
    );

    final callbackResult = await _makeCallbackToTemporaryStorage(amount);
    if (callbackResult != null) {
      _callbackId = callbackResult;
      await _initiatePayment(amount);
    }
  }

  Future<String?> _makeCallbackToTemporaryStorage(String amount) async {
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

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        if (responseData['status'] == 'SUCCESS' &&
            responseData['data'] != null) {
          final callbackId = responseData['data'].toString();
          setState(() {
            _isPaymentInProgress = false;
          });
          return callbackId;
        }
      }
      setState(() {
        _isPaymentInProgress = false;
      });
      _showCustomSnackbar("Failed to initialize recharge", isError: true);
      return null;
    } catch (e) {
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
        'prefill': {'contact': widget.phoneNo, 'email': 'user@example.com'},
        'theme': {'color': '#000D34'},
      };

      _razorpay.open(options);
    } catch (e) {
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
    final color = isError ? errorColor : successColor;
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

    Color statusColor = successColor;
    IconData statusIcon = Iconsax.tick_circle;
    String statusTitle = 'Recharge Successful!';
    String subtitle = 'Your mobile recharge was successful.';

    if (isPending) {
      statusColor = Colors.orange;
      statusIcon = Iconsax.timer_1;
      statusTitle = 'Recharge Pending';
      subtitle = 'Your recharge is being processed by the operator.';
    } else if (isFailed) {
      statusColor = errorColor;
      statusIcon = Iconsax.info_circle;
      statusTitle = 'Recharge Failed';
      subtitle = 'Your recharge has been failed';
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
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(36)),
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(24, 12, 24, 32),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 48,
                  height: 5,
                  decoration: BoxDecoration(
                    color: const Color(0xFFE2E8F0),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                const SizedBox(height: 32),

                // Status Icon with Animated-like glow
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        color: statusColor.withOpacity(0.1),
                        shape: BoxShape.circle,
                      ),
                    ),
                    Container(
                      width: 76,
                      height: 76,
                      decoration: BoxDecoration(
                        color: statusColor.withOpacity(0.2),
                        shape: BoxShape.circle,
                      ),
                    ),
                    Icon(statusIcon, color: statusColor, size: 48),
                  ],
                ),
                const SizedBox(height: 24),

                // Status Title
                Text(
                  statusTitle,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w900,
                    color: Color(0xFF1A1A1A),
                    letterSpacing: -0.5,
                  ),
                ),
                const SizedBox(height: 8),

                // Subtitle
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    subtitle,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 15,
                      color: Color(0xFF64748B),
                      fontWeight: FontWeight.w500,
                      height: 1.5,
                    ),
                  ),
                ),

                // Refund Section for Failed Transactions
                if (isFailed) ...[
                  const SizedBox(height: 24),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFEF2F2),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: const Color(0xFFFEE2E2)),
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Iconsax.wallet_3,
                            color: Colors.red,
                            size: 18,
                          ),
                        ),
                        const SizedBox(width: 12),
                        const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Refund Initiated",
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w800,
                                color: Color(0xFF991B1B),
                              ),
                            ),
                            Text(
                              "Amount will be back in 3-5 days",
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w500,
                                color: Color(0xFFB91C1C),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],

                const SizedBox(height: 32),

                // Transaction Details Card
                Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF8FAFC),
                    borderRadius: BorderRadius.circular(28),
                    border: Border.all(color: const Color(0xFFF1F5F9)),
                  ),
                  child: Column(
                    children: [
                      _buildDetailRow('Operator', operator),
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 12),
                        child: Divider(height: 1, color: Color(0xFFE2E8F0)),
                      ),
                      _buildDetailRow('Mobile Number', phoneNo),
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 12),
                        child: Divider(height: 1, color: Color(0xFFE2E8F0)),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Amount Paid',
                            style: TextStyle(
                              color: Color(0xFF64748B),
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                            ),
                          ),
                          Text(
                            '₹$amount',
                            style: TextStyle(
                              color: maincolor1,
                              fontWeight: FontWeight.w900,
                              fontSize: 19,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 32),

                // Done Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const HomePage(),
                        ),
                        (route) => false,
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: maincolor1,
                      padding: const EdgeInsets.symmetric(vertical: 18),
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18),
                      ),
                    ),
                    child: const Text(
                      'Done',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w900,
                        fontSize: 16,
                        letterSpacing: 0.5,
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

  Widget _buildDetailRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              color: textSecondary,
              fontWeight: FontWeight.w500,
              fontSize: 13,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              color: maincolor1,
              fontWeight: FontWeight.w700,
              fontSize: 14,
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
              if (state.rechargeStatus != null) {
                _showRechargeStatusBottomSheet(
                  amount: state.amount ?? '',
                  phoneNo: widget.phoneNo,
                  operator: widget.operator,
                  status:
                      state.actualStatus ?? state.rechargeStatus ?? 'Unknown',
                  message:
                      state.errorMessage ?? 'Your request is being processed.',
                );
              }
            }
          },
        ),
      ],
      child: Scaffold(
        backgroundColor: backgroundColor,
        body: Stack(
          children: [
            Container(
              height: 300,
              width: double.infinity,
              decoration: BoxDecoration(color: maincolor1),
              child: Stack(
                children: [
                  Positioned(
                    top: -40,
                    right: -40,
                    child: Container(
                      width: 180,
                      height: 180,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.04),
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 60,
                    left: -20,
                    child: Icon(
                      Icons.payment_rounded,
                      size: 120,
                      color: Colors.white.withOpacity(0.03),
                    ),
                  ),
                  SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(24, 60, 24, 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Complete\nRecharge',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 32,
                              fontWeight: FontWeight.w900,
                              height: 1.1,
                              letterSpacing: -1,
                            ),
                          ),
                          const SizedBox(height: 12),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              'Secure Payment',
                              style: TextStyle(
                                color: secondaryColor,
                                fontSize: 12,
                                fontWeight: FontWeight.w900,
                                letterSpacing: 1,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Column(
              children: [
                const SizedBox(height: 220),
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(24),
                          decoration: BoxDecoration(
                            color: cardColor,
                            borderRadius: BorderRadius.circular(24),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.06),
                                blurRadius: 20,
                                offset: const Offset(0, 10),
                              ),
                            ],
                          ),
                          child: Column(
                            children: [
                              _buildSummaryItem(
                                Icons.phone_iphone_rounded,
                                'Operator',
                                widget.operator,
                              ),
                              const Divider(height: 32),
                              _buildSummaryItem(
                                Icons.call_rounded,
                                'Mobile Number',
                                widget.phoneNo,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 24),
                        Container(
                          padding: const EdgeInsets.all(24),
                          decoration: BoxDecoration(
                            color: cardColor,
                            borderRadius: BorderRadius.circular(24),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.06),
                                blurRadius: 20,
                                offset: const Offset(0, 10),
                              ),
                            ],
                          ),
                          child: Column(
                            children: [
                              Text(
                                "Recharge Amount",
                                style: TextStyle(
                                  color: textSecondary,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 14,
                                ),
                              ),
                              const SizedBox(height: 16),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 20,
                                ),
                                decoration: BoxDecoration(
                                  color: backgroundColor,
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(
                                    color: secondaryColor.withOpacity(0.1),
                                  ),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      '₹',
                                      style: TextStyle(
                                        fontSize: 32,
                                        fontWeight: FontWeight.w900,
                                        color: maincolor1,
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    SizedBox(
                                      width: 140,
                                      child: TextField(
                                        controller: _amountController,
                                        keyboardType:
                                            const TextInputType.numberWithOptions(
                                              decimal: true,
                                            ),
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 40,
                                          fontWeight: FontWeight.w900,
                                          color: maincolor1,
                                          letterSpacing: -1,
                                        ),
                                        decoration: InputDecoration(
                                          hintText: '0',
                                          hintStyle: TextStyle(
                                            color: textSecondary.withOpacity(
                                              0.3,
                                            ),
                                          ),
                                          border: InputBorder.none,
                                          isDense: true,
                                          contentPadding: EdgeInsets.zero,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 120),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [backgroundColor.withOpacity(0), backgroundColor],
                  ),
                ),
                child: BlocBuilder<RechargeProceedBloc, RechargeProceedState>(
                  builder: (context, state) {
                    final bool isLoading =
                        state.isLoading || _isPaymentInProgress;
                    return SizedBox(
                      width: double.infinity,
                      height: 65,
                      child: ElevatedButton(
                        onPressed: isLoading ? null : _onProceed,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: maincolor1,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          elevation: 10,
                          shadowColor: maincolor1.withOpacity(0.4),
                        ),
                        child: isLoading
                            ? const SizedBox(
                                width: 24,
                                height: 24,
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: 3,
                                ),
                              )
                            : const Text(
                                'PROCEED TO PAY',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w900,
                                  fontSize: 16,
                                  letterSpacing: 1.5,
                                ),
                              ),
                      ),
                    );
                  },
                ),
              ),
            ),
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 10,
                ),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.1),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.arrow_back_ios_new_rounded,
                          color: Colors.white,
                          size: 18,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryItem(IconData icon, String title, String value) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: maincolor1.withOpacity(0.05),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: maincolor1, size: 20),
        ),
        const SizedBox(width: 16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                color: textSecondary,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              value,
              style: TextStyle(
                color: maincolor1,
                fontSize: 16,
                fontWeight: FontWeight.w800,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
