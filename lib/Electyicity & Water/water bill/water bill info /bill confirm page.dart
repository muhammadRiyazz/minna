import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minna/Electyicity%20&%20Water/application/confirm%20bill/confirm_bill_bloc.dart';
import 'package:minna/Electyicity%20&%20Water/application/fetch%20bill/fetch_bill_bloc.dart';
import 'package:minna/comman/const/const.dart';
import 'package:minna/comman/core/api.dart';
import 'package:minna/comman/pages/main%20home/home.dart';
import 'package:minna/comman/application/login/login_bloc.dart';
import 'package:minna/comman/pages/log%20in/login_page.dart';
import 'package:shimmer/shimmer.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:minna/DTH%20&%20Mobile/mobile%20%20recharge/pages/add%20amount/add_amount.dart';
import 'package:minna/Electyicity%20&%20Water/pages/payment%20status/payment_status_page.dart';

class WaterBillDetailsPage extends StatefulWidget {
  final String provider;
  final String providerID;
  final String phoneNo;
  final String consumerId;

  const WaterBillDetailsPage({
    super.key,
    required this.provider,
    required this.providerID,
    required this.phoneNo,
    required this.consumerId,
  });

  @override
  State<WaterBillDetailsPage> createState() => _WaterBillDetailsPageState();
}

class _WaterBillDetailsPageState extends State<WaterBillDetailsPage> {
  late Razorpay _razorpay;
  String? _currentOrderId;
  String? _currentReceiptId;

  // Premium Theme Colors


  @override
  void initState() {
    super.initState();
    context.read<LoginBloc>().add(const LoginEvent.loginInfo());
    _initializeRazorpay();
  }

  void _initializeRazorpay() {
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  @override
  void dispose() {
    _razorpay.clear();
    super.dispose();
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    final fetchState = context.read<FetchBillBloc>().state;
    fetchState.maybeWhen(
      success: (bill, fetchReceiptId) {
        context.read<ConfirmBillBloc>().add(
          ProcessPaymentSuccess(
            orderId: _currentOrderId ?? '',
            transactionId: response.paymentId ?? '',
            receiptId: fetchReceiptId,
            providerID: widget.providerID,
            phoneNo: widget.phoneNo,
            consumerId: widget.consumerId,
            currentBill: bill,
            signature: response.signature ?? '',
          ),
        );
      },
      orElse: () {
        _showCustomSnackbar('No bill data available. Please try again.', isError: true);
      },
    );
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    context.read<ConfirmBillBloc>().add(
      ProcessPaymentFailure(
        orderId: _currentOrderId ?? '',
        transactionId: '',
        receiptId: _currentReceiptId ?? '',
        errorMessage: response.message ?? 'Payment failed',
      ),
    );
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    log("External wallet: ${response.walletName}");
  }

  void _showCustomSnackbar(String message, {bool isError = false}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError ? errorColor : successColor,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }

  void _openCheckout(double amount, ElectricityBillModel bill) {
    if (_currentOrderId == null || _currentOrderId!.isEmpty) {
      _showCustomSnackbar('Invalid order ID. Please try again.', isError: true);
      return;
    }

    final options = {
      'key': razorpaykey,
      'amount': (amount * 100).toInt(),
      'name': 'Bill Payment',
      'description': 'Payment for ${widget.provider}',
      'order_id': _currentOrderId,
      'prefill': {'contact': widget.phoneNo, 'email': 'customer@example.com'},
      'theme': {'color': '#000D34'},
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      _showCustomSnackbar('Failed to open payment gateway', isError: true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ConfirmBillBloc, ConfirmBillState>(
      listener: (context, state) {
        state.whenOrNull(
          orderCreated: (orderId, receiptId, bill) {
            _currentOrderId = orderId;
            _currentReceiptId = receiptId;
            _openCheckout(double.parse(bill.billAmount), bill);
          },
          billPaymentResponse: (responseData) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => BillPaymentStatusPage(
                  responseData: responseData,
                  provider: widget.provider,
                  consumerId: widget.consumerId,
                ),
              ),
            );
          },
          billPaymentError: (message, transactionId) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => BillPaymentStatusPage(
                  responseData: {
                    'status': 'FAILED',
                    'statusDesc': message,
                    'data': {
                      'billdetails': {
                        'txnRefId': transactionId,
                        'responseReason': 'FAILED',
                      }
                    },
                  },
                  provider: widget.provider,
                  consumerId: widget.consumerId,
                ),
              ),
            );
          },
          paymentError: (message) => _showCustomSnackbar(message, isError: true),
        );
      },
      builder: (context, confirmState) {
        return Scaffold(
          backgroundColor: backgroundColor,
          body: Stack(
            children: [
              // 1. Immersive Header
              Container(
                height: 280,
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
                    SafeArea(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(24, 60, 24, 0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Water Bill\nDetails',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 32,
                                fontWeight: FontWeight.w900,
                                height: 1.1,
                                letterSpacing: -1,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // 2. Main content
              BlocBuilder<FetchBillBloc, FetchBillState>(
                builder: (context, state) {
                  return state.maybeWhen(
                    loading: () => _buildShimmer(),
                    error: (message) => _buildErrorState(message),
                    success: (bill, receiptId) => _buildBillContent(bill, receiptId),
                    orElse: () => const SizedBox.shrink(),
                  );
                },
              ),

              // 3. Navigation
              SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
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
                          child: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white, size: 18),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildBillContent(ElectricityBillModel bill, String receiptId) {
    final amount = double.tryParse(bill.billAmount) ?? 0;

    if (amount <= 0) {
      return _buildNoDueState();
    }

    return Column(
      children: [
        const SizedBox(height: 180),
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              children: [
                // Amount Card
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
                        "Total Payable Amount",
                        style: TextStyle(color: textSecondary, fontWeight: FontWeight.w700, fontSize: 13),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        "₹ ${bill.billAmount}",
                        style: TextStyle(
                          fontSize: 36,
                          fontWeight: FontWeight.w900,
                          color: maincolor1,
                          letterSpacing: -1,
                        ),
                      ),
                      const Divider(height: 32),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.water_drop_rounded, color: Colors.blue, size: 16),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              widget.provider,
                              textAlign: TextAlign.center,
                              style: TextStyle(color: maincolor1, fontWeight: FontWeight.w800, fontSize: 14),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 24),

                // Details Card
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
                      _buildDetailRow("Consumer Name", bill.customerName),
                      const Divider(height: 24),
                      _buildDetailRow("Consumer Number", bill.billNumber),
                      const Divider(height: 24),
                      _buildDetailRow("Bill Period", bill.billPeriod.isNotEmpty ? bill.billPeriod : "N/A"),
                      const Divider(height: 24),
                      _buildDetailRow("Due Date", bill.dueDate),
                    ],
                  ),
                ),
                const SizedBox(height: 120),
              ],
            ),
          ),
        ),
        _buildBottomAction(bill, amount, receiptId),
      ],
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: TextStyle(color: textSecondary, fontSize: 12, fontWeight: FontWeight.w600)),
        Flexible(
          child: Text(
            value,
            textAlign: TextAlign.right,
            style: TextStyle(color: maincolor1, fontSize: 14, fontWeight: FontWeight.w800),
          ),
        ),
      ],
    );
  }

  Widget _buildBottomAction(ElectricityBillModel bill, double amount, String receiptId) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: backgroundColor,
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, -5)),
        ],
      ),
      child: BlocBuilder<ConfirmBillBloc, ConfirmBillState>(
        builder: (context, confirmState) {
          final bool isProcessing = confirmState.maybeWhen(paymentProcessing: () => true, orElse: () => false);
          return SizedBox(
            width: double.infinity,
            height: 60,
            child: ElevatedButton(
              onPressed: isProcessing ? null : () async {
                final isLoggedIn = context.read<LoginBloc>().state.isLoggedIn ?? false;
                if (!isLoggedIn) {
                  await showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    backgroundColor: Colors.transparent,
                    builder: (context) => const LoginBottomSheet(login: 1),
                  );
                  if (context.read<LoginBloc>().state.isLoggedIn != true) return;
                }
                context.read<ConfirmBillBloc>().add(
                  InitiatePayment(
                    bill: bill,
                    providerID: widget.providerID,
                    phoneNo: widget.phoneNo,
                    consumerId: widget.consumerId,
                    providerName: widget.provider,
                    receiptId: receiptId,
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: maincolor1,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                elevation: 0,
              ),
              child: isProcessing
                  ? const SizedBox(width: 24, height: 24, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 3))
                  : const Text(
                      'PAY SECURELY NOW',
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.w900, fontSize: 16, letterSpacing: 1),
                    ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildNoDueState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.check_circle_rounded, color: successColor, size: 80),
          const SizedBox(height: 16),
          Text(
            "No Dues Found",
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.w900, color: maincolor1),
          ),
          const SizedBox(height: 8),
          Text(
            "Your water bill is fully paid.\nThank you!",
            textAlign: TextAlign.center,
            style: TextStyle(color: textSecondary, fontSize: 15),
          ),
          const SizedBox(height: 32),
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            style: ElevatedButton.styleFrom(
              backgroundColor: maincolor1,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            ),
            child: const Text('Go Back', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorState(String message) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline_rounded, color: errorColor, size: 80),
            const SizedBox(height: 16),
            Text(
              "Oops!",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.w900, color: maincolor1),
            ),
            const SizedBox(height: 8),
            Text(
              message,
              textAlign: TextAlign.center,
              style: TextStyle(color: textSecondary, fontSize: 15),
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: maincolor1,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              ),
              child: const Text('Try Again', style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildShimmer() {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Column(
        children: [
          const SizedBox(height: 180),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Container(
              height: 150,
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(24)),
            ),
          ),
          const SizedBox(height: 24),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Container(
              height: 250,
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(24)),
            ),
          ),
        ],
      ),
    );
  }
}
