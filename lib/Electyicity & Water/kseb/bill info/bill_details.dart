import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minna/Electyicity%20&%20Water/application/fetch%20bill/fetch_bill_bloc.dart';
import 'package:minna/comman/const/const.dart';
import 'package:shimmer/shimmer.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class BillDetailsPage extends StatefulWidget {
  final String provider;
  final String providerID;
  final String phoneNo;
  final String consumerId;

  const BillDetailsPage({
    super.key, 
    required this.provider,
    required this.providerID,
    required this.phoneNo,
    required this.consumerId,
  });

  @override
  State<BillDetailsPage> createState() => _BillDetailsPageState();
}

class _BillDetailsPageState extends State<BillDetailsPage> {
  late Razorpay _razorpay;
  String? _currentOrderId;
  String? _currentReceiptId;

  @override
  void initState() {
    super.initState();
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
    context.read<FetchBillBloc>().add(
      ProcessPaymentSuccess(
        orderId: _currentOrderId ?? '',
        transactionId: response.paymentId ?? '',
        receiptId: _currentReceiptId ?? '',
        providerID: widget.providerID,
        phoneNo: widget.phoneNo,
        consumerId: widget.consumerId,
      ),
    );
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    context.read<FetchBillBloc>().add(
      ProcessPaymentFailure(
        orderId: _currentOrderId ?? '',
        transactionId: '',
        receiptId: _currentReceiptId ?? '',
        errorMessage: response.message ?? 'Payment failed',
      ),
    );
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    _showAlertDialog('External Wallet', '${response.walletName}');
  }

  void _showAlertDialog(String title, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void _openCheckout(double amount, ElectricityBillModel bill) {
    final options = {
      'key': 'rzp_test_Dr1h8dVI9Vimy9', // Replace with your actual key
      'amount': (amount * 100).toInt(), // Convert to paise
      'name': 'Minna Travels',
      'description': 'Payment for ${widget.provider} Bill',
      'order_id': _currentOrderId,
      'prefill': {
        'contact': widget.phoneNo,
        'email': 'customer@example.com',
      },
      'theme': {'color': maincolor1}
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      _showAlertDialog('Error', 'Failed to open payment gateway: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FetchBillBloc, FetchBillState>(
      listener: (context, state) {
        state.whenOrNull(
          paymentSuccess: (message, receiptId) {
            _showSuccessDialog(message, receiptId);
          },
          paymentError: (message) {
            _showAlertDialog('Payment Failed', message);
          },
          orderCreated: (orderId, receiptId) {
            _currentOrderId = orderId;
            _currentReceiptId = receiptId;
          },
        );
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: maincolor1,
            title: const Text(
              "Electricity Bill",
              style: TextStyle(color: Colors.white),
            ),
            iconTheme: const IconThemeData(color: Colors.white),
          ),
          body: state.maybeWhen(
            loading: () => _buildShimmer(),
            error: (message) => buildErrorWidget(message),
            success: (bill) => _buildBillContent(bill),
            paymentProcessing: () => _buildProcessingState(),
            orElse: () => const SizedBox.shrink(),
          ),
        );
      },
    );
  }

  Widget _buildBillContent(ElectricityBillModel bill) {
    if (bill.billAmount == "0") {
      return const Center(
        child: Text(
          "Payment already billed.",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
      );
    }

    final amount = double.tryParse(bill.billAmount) ?? 0;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Column(
                children: [
                  Text(
                    "₹ ${bill.billAmount}",
                    style: const TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  Text(
                    widget.provider,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.black54,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 10),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  spreadRadius: 2,
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                children: [
                  _buildDetailRow(
                    "Account Holder Name",
                    bill.customerName,
                  ),
                  _buildDetailRow("Consumer Number", bill.billNumber),
                  _buildDetailRow(
                    "Bill Period",
                    bill.billPeriod.isNotEmpty ? bill.billPeriod : "N/A",
                  ),
                  _buildDetailRow("Bill Due Date", bill.dueDate),
                  _buildDetailRow("Bill Number", bill.billNumber),
                ],
              ),
            ),
          ),
          const SizedBox(height: 15),
          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: maincolor1,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                foregroundColor: Colors.white,
              ),
              icon: const Icon(Icons.payment),
              label: const Text(
                "Pay Now",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onPressed: () {
                context.read<FetchBillBloc>().add(
                  InitiatePayment(
                    bill: bill,
                    providerID: widget.providerID,
                    phoneNo: widget.phoneNo,
                    consumerId: widget.consumerId,
                    providerName: widget.provider,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProcessingState() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(),
          SizedBox(height: 16),
          Text(
            'Processing Payment...',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }

  void _showSuccessDialog(String message, String receiptId) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) => AlertDialog(
        title: const Row(
          children: [
            Icon(Icons.check_circle, color: Colors.green),
            SizedBox(width: 8),
            Text('Payment Successful'),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(message),
            const SizedBox(height: 8),
            Text('Receipt ID: $receiptId'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.of(context).pop();
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Expanded(
            child: Text(
              label,
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
          ),
          Text(value, style: const TextStyle(color: Colors.black87)),
        ],
      ),
    );
  }

  Widget _buildShimmer() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Column(
                children: [
                  Shimmer.fromColors(
                    baseColor: Colors.grey.shade300,
                    highlightColor: Colors.grey.shade100,
                    child: Container(
                      width: 120,
                      height: 30,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Shimmer.fromColors(
                    baseColor: Colors.grey.shade300,
                    highlightColor: Colors.grey.shade100,
                    child: Container(
                      width: 180,
                      height: 16,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  spreadRadius: 2,
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                children: List.generate(5, (index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Row(
                      children: [
                        Expanded(
                          child: Shimmer.fromColors(
                            baseColor: Colors.grey.shade300,
                            highlightColor: Colors.grey.shade100,
                            child: Container(
                              height: 14,
                              width: 100,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Shimmer.fromColors(
                          baseColor: Colors.grey.shade300,
                          highlightColor: Colors.grey.shade100,
                          child: Container(
                            height: 14,
                            width: 120,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  );
                }),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Shimmer.fromColors(
            baseColor: Colors.grey.shade300,
            highlightColor: Colors.grey.shade100,
            child: Container(
              width: double.infinity,
              height: 50,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Widget buildErrorWidget(String message) {
  return Center(
    child: Padding(
      padding: const EdgeInsets.all(14.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.warning_amber_rounded,
            color: Colors.orangeAccent,
            size: 60,
          ),
          const SizedBox(height: 16),
          Text(
            'Oops!',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.grey[800],
            ),
          ),
          const SizedBox(height: 5),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Text(
              message,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, color: Colors.grey[600]),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    ),
  );
}