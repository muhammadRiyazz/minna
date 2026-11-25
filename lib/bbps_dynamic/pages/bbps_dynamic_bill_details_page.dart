import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:minna/bbps_dynamic/domain/bbps_dynamic_repository.dart';
import 'package:minna/bbps_dynamic/domain/models/bbps_models.dart';
import 'package:minna/comman/const/const.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:minna/bbps_dynamic/pages/bbps_dynamic_payment_status_page.dart';

class BbpsDynamicBillDetailsPage extends StatefulWidget {
  final BbpsDynamicBillResponse billResponse;
  final String category;

  const BbpsDynamicBillDetailsPage({
    super.key,
    required this.billResponse,
    required this.category,
  });

  @override
  State<BbpsDynamicBillDetailsPage> createState() => _BbpsDynamicBillDetailsPageState();
}

class _BbpsDynamicBillDetailsPageState extends State<BbpsDynamicBillDetailsPage> {
  late TextEditingController _amountController;
  final _formKey = GlobalKey<FormState>();
  final BbpsDynamicRepository _repository = BbpsDynamicRepository();
  late Razorpay _razorpay;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    final bill = widget.billResponse.bill;
    _amountController = TextEditingController(
      text: bill != null ? bill.amount.toStringAsFixed(2) : '0.00',
    );
    _initRazorpay();
  }

  void _initRazorpay() {
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  @override
  void dispose() {
    _razorpay.clear();
    _amountController.dispose();
    super.dispose();
  }

  void _showCustomSnackbar(String message, {bool isError = false}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(
              isError ? Icons.error_outline : Icons.check_circle_outline,
              color: Colors.white,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                message,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
        backgroundColor: isError ? Colors.redAccent : Colors.green,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        margin: const EdgeInsets.all(16),
        duration: const Duration(seconds: 4),
      ),
    );
  }

  Future<void> _createOrderAndPay() async {
    if (!_formKey.currentState!.validate()) return;
    final bill = widget.billResponse.bill;
    if (bill == null) return;

    setState(() {
      _isLoading = true;
    });

    try {
      final prefs = await SharedPreferences.getInstance();
      final userId = prefs.getString('userId');
      
      if (userId == null) {
        _showCustomSnackbar('Please login to continue', isError: true);
        setState(() => _isLoading = false);
        return;
      }

      final amount = _amountController.text;

      final orderData = await _repository.createOrder(
        category: widget.category,
        userId: userId,
        reqId: bill.reqId,
        amount: amount,
        consumerNo: bill.consumerNo,
        billNumber: bill.billNumber,
      );

      final options = {
        'key': orderData['key'],
        'amount': orderData['amount'],
        'name': 'MT TRIP',
        'description': 'Payment for ${widget.category} Bill',
        'order_id': orderData['order_id'],
        'prefill': {
          'contact': prefs.getString('phone') ?? '',
          'email': prefs.getString('email') ?? '',
        },
        'theme': {'color': '#113554'},
      };

      _razorpay.open(options);
    } catch (e) {
      log("Create Order Error: $e");
      _showCustomSnackbar(e.toString().replaceAll('Exception: ', ''), isError: true);
      setState(() => _isLoading = false);
    }
  }

  Future<void> _handlePaymentSuccess(PaymentSuccessResponse response) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final userId = prefs.getString('userId');
      
      if (userId == null) return;

      final verificationResult = await _repository.verifyPayment(
        category: widget.category,
        userId: userId,
        razorpayOrderId: response.orderId!,
        razorpayPaymentId: response.paymentId!,
        razorpaySignature: response.signature!,
      );

      setState(() => _isLoading = false);

      final bool success = verificationResult['success'] == true;
      final String status = verificationResult['status'] ?? 'UNKNOWN';
      final String message = verificationResult['message'] ?? 'Payment verification failed.';

      if (success || status == 'SUCCESS') {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BbpsDynamicPaymentStatusPage(
              status: 'SUCCESS',
              message: 'Payment Successful!',
            ),
          ),
        );
      } else {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BbpsDynamicPaymentStatusPage(
              status: status,
              message: message,
            ),
          ),
        );
      }
    } catch (e) {
      log("Verify Payment Error: $e");
      setState(() => _isLoading = false);
      _showCustomSnackbar(e.toString().replaceAll('Exception: ', ''), isError: true);
    }
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    setState(() => _isLoading = false);
    log("Payment Error: ${response.code} - ${response.message}");
    _showCustomSnackbar("Payment failed. Please try again.", isError: true);
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    setState(() => _isLoading = false);
    _showCustomSnackbar("External wallet selected: ${response.walletName}");
  }

  // Removed _showPaymentStatusDialog in favor of full page


  String _getConsumerNameLabel() {
    switch (widget.category.toLowerCase()) {
      case 'fastag':
        return 'Customer Name';
      case 'creditcard':
        return 'Cardholder Name';
      default:
        return 'Consumer Name';
    }
  }

  String _getConsumerNoLabel() {
    switch (widget.category.toLowerCase()) {
      case 'fastag':
        return 'Vehicle Number';
      case 'creditcard':
        return 'Credit Card Number';
      default:
        return 'Consumer Number';
    }
  }

  @override
  Widget build(BuildContext context) {
    final bill = widget.billResponse.bill;

    if (bill == null) {
      return Scaffold(
        appBar: AppBar(title: const Text("Error")),
        body: const Center(child: Text("Failed to load bill details")),
      );
    }
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Stack(
        children: [
          Container(
            height: 250,
            width: double.infinity,
            color: maincolor1,
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 10),
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(
                          Icons.arrow_back_ios_new,
                          color: Colors.white,
                          size: 18,
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                    const Text(
                      'Bill Summary',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 200),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(32),
                topRight: Radius.circular(32),
              ),
            ),
            child: Form(
              key: _formKey,
              child: ListView(
                padding: const EdgeInsets.all(24),
                children: [
                  // Amount Display
                  Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [maincolor1, maincolor1.withOpacity(0.8)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(24),
                      boxShadow: [
                        BoxShadow(
                          color: maincolor1.withOpacity(0.3),
                          blurRadius: 20,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        const Text(
                          'Enter Payment Amount',
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 1,
                          ),
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                            controller: _amountController,
                            keyboardType: const TextInputType.numberWithOptions(decimal: true),
                            textAlign: TextAlign.center,
                            readOnly: !(widget.billResponse.billerAdhoc ?? false) || 
                                      (widget.billResponse.paymentExactness?.toUpperCase() == 'EXACT'),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 36,
                              fontWeight: FontWeight.w900,
                            ),
                            decoration: InputDecoration(
                              prefixText: '₹ ',
                              prefixStyle: const TextStyle(
                                color: Colors.white,
                                fontSize: 36,
                                fontWeight: FontWeight.w900,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16),
                                borderSide: BorderSide.none,
                              ),
                              filled: true,
                              fillColor: Colors.white.withOpacity(0.1),
                              contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) return 'Enter amount';
                              final enteredAmount = double.tryParse(value);
                              if (enteredAmount == null) return 'Invalid amount';
                              if (enteredAmount <= 0) return 'Amount must be > 0';

                              final exactness = widget.billResponse.paymentExactness?.toUpperCase() ?? 'ANY';
                              final maxAmount = widget.billResponse.maxBillAmount ?? 5000000.0;
                              final minAmount = widget.billResponse.minBillAmount ?? 1.0;
                              final originalAmount = widget.billResponse.bill?.amount ?? 0.0;

                              if (exactness == 'EXACT') {
                                if (enteredAmount != originalAmount) {
                                  return 'Amount must be exactly ₹$originalAmount';
                                }
                              } else if (exactness == 'EXACT ABOVE') {
                                if (enteredAmount < originalAmount) {
                                  return 'Amount must be at least ₹$originalAmount';
                                }
                                if (enteredAmount > maxAmount) {
                                  return 'Amount cannot exceed ₹$maxAmount';
                                }
                              } else if (exactness == 'EXACT BELOW') {
                                if (enteredAmount > originalAmount) {
                                  return 'Amount cannot exceed ₹$originalAmount';
                                }
                                if (enteredAmount < minAmount) {
                                  return 'Amount must be at least ₹$minAmount';
                                }
                              } else {
                                // ANY or other cases
                                if (enteredAmount > maxAmount) {
                                  return 'Amount cannot exceed ₹$maxAmount';
                                }
                                if (enteredAmount < minAmount) {
                                  return 'Amount must be at least ₹$minAmount';
                                }
                              }
                              
                              return null;
                            },
                          )
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Details Card
                  Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: Colors.grey[50],
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildDetailRow(_getConsumerNameLabel(), bill.consumerName),
                        const Divider(height: 24),
                        _buildDetailRow(_getConsumerNoLabel(), bill.consumerNo),
                        const Divider(height: 24),
                        _buildDetailRow("Biller", bill.billerName),
                        
                        if (bill.additionalInfo.isNotEmpty) ...[
                          const Divider(height: 24),
                          ...List.generate(bill.additionalInfo.length, (index) {
                            final info = bill.additionalInfo[index];
                            return Column(
                              children: [
                                _buildDetailRow(info.infoName, info.infoValue),
                                if (index < bill.additionalInfo.length - 1)
                                  const Divider(height: 24),
                              ],
                            );
                          }),
                        ],
                      ],
                    ),
                  ),
                  const SizedBox(height: 48),

                  SizedBox(
                    width: double.infinity,
                    height: 60,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: maincolor1,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      onPressed: _isLoading ? null : _createOrderAndPay,
                      child: _isLoading
                          ? const SizedBox(
                              height: 24,
                              width: 24,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                                strokeWidth: 2.5,
                              ),
                            )
                          : const Text(
                              'PROCEED TO PAY',
                              style: TextStyle(
                                fontWeight: FontWeight.w900,
                                fontSize: 16,
                              ),
                            ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          flex: 2,
          child: Text(
            label,
            style: const TextStyle(
              color: textSecondary,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          flex: 3,
          child: Text(
            value,
            textAlign: TextAlign.right,
            style: const TextStyle(
              color: maincolor1,
              fontSize: 14,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
      ],
    );
  }
}
