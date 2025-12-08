import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minna/Electyicity%20&%20Water/application/confirm%20bill/confirm_bill_bloc.dart';
import 'package:minna/Electyicity%20&%20Water/application/fetch%20bill/fetch_bill_bloc.dart';
import 'package:minna/comman/const/const.dart';
import 'package:minna/comman/core/api.dart';
import 'package:minna/comman/pages/main%20home/home.dart';
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
    _initializeRazorpay();
  }

  void _initializeRazorpay() {
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    log("Razorpay initialized");
  }

  @override
  void dispose() {
    _razorpay.clear();
    super.dispose();
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    // Get the current bill from FetchBillBloc state
    final fetchState = context.read<FetchBillBloc>().state;
    
    // Use pattern matching with freezed methods
    fetchState.maybeWhen(
      success: (bill, receiptId) {
        context.read<ConfirmBillBloc>().add(
          ProcessPaymentSuccess(
            orderId: _currentOrderId ?? '',
            transactionId: response.paymentId ?? '',
            receiptId: receiptId,
            providerID: widget.providerID,
            phoneNo: widget.phoneNo,
            consumerId: widget.consumerId,
            currentBill: bill,
          ),
        );
      },
      orElse: () {
        log("Error: No bill data available in FetchBillBloc state");
        _showAlertDialog('Error', 'No bill data available. Please try again.');
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
    log("_openCheckout--- amount: $amount, orderId: $_currentOrderId");
    
    if (_currentOrderId == null || _currentOrderId!.isEmpty) {
      log("Invalid order ID");
      _showAlertDialog('Payment Error', 'Invalid order ID. Please try again.');
      return;
    }

    if (amount <= 0) {
      log("Invalid amount: $amount");
      _showAlertDialog('Payment Error', 'Invalid amount. Please try again.');
      return;
    }

    final options = {
      'key': razorpaykey,
      'amount': (amount * 100).toInt(),
      'name': 'MT Trip',
      'description': 'Payment for ${widget.provider} Bill',
      'order_id': _currentOrderId,
      'prefill': {
        'contact': widget.phoneNo,
        'email': 'customer@example.com',
      },
      'theme': {'color': maincolor1.value}
    };

    log("Razorpay Options: $options");

    try {
      _razorpay.open(options);
    } catch (e) {
      log("Razorpay open error: $e");
      _showAlertDialog('Payment Error', 'Failed to open payment gateway: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ConfirmBillBloc, ConfirmBillState>(
      listener: (context, state) {
        state.whenOrNull(
          orderCreated: (orderId, receiptId, bill) {
            log("orderCreated listener triggered - orderId: $orderId, receiptId: $receiptId");
            _currentOrderId = orderId;
            _currentReceiptId = receiptId;
            _openCheckout(double.parse(bill.billAmount), bill);
          },
          paymentSuccess: (message, receiptId) {
            _showSuccessBottomSheet(message, receiptId);
          },
          paymentError: (message) {
            _showErrorBottomSheet(message);
          },
          refundProcessing: () {
            _showRefundProcessingBottomSheet();
          },
          refundSuccess: (message, receiptId) {
            _showRefundSuccessBottomSheet(message, receiptId);
          },
          refundFailed: (message, receiptId) {
            _showRefundFailedBottomSheet(message, receiptId);
          },
        );
      },
      builder: (context, confirmState) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: maincolor1,
            iconTheme: IconThemeData(color: Colors.white),
          ),
          body: BlocBuilder<FetchBillBloc, FetchBillState>(
            builder: (context, state) {
              return state.maybeWhen(
                loading: () => _buildShimmer(),
                error: (message) => _buildErrorState(message),
                success: (bill, receiptId) => _buildBillContent(bill, receiptId),
                orElse: () => const SizedBox.shrink(),
              );
            },
          ),
        );
      },
    );
  }

  Widget _buildBillContent(ElectricityBillModel bill, String receiptId) {
    final amount = double.tryParse(bill.billAmount) ?? 0;
    
    if (amount == 0 || bill.billAmount == "0") {
      return _buildNoDueState();
    }

    return BlocBuilder<ConfirmBillBloc, ConfirmBillState>(
      builder: (context, confirmState) {
        return SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildAmountCard(bill),
              const SizedBox(height: 20),
              _buildBillDetailsCard(bill),
              const SizedBox(height: 20),
              confirmState.maybeWhen(
                paymentProcessing: () => _buildProcessingButton(),
                orElse: () => _buildPayButton(bill, amount, receiptId),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildAmountCard(ElectricityBillModel bill) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [maincolor1, maincolor1.withOpacity(0.8)],
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: maincolor1.withOpacity(0.3),
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            "Due Amount",
            style: TextStyle(
              fontSize: 16,
              color: Colors.white.withOpacity(0.9),
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 8),
          Text(
            "₹ ${bill.billAmount}",
            style: TextStyle(
              fontSize: 36,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 4),
          Text(
            widget.provider,
            style: TextStyle(
              fontSize: 14,
              color: Colors.white.withOpacity(0.8),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBillDetailsCard(ElectricityBillModel bill) {
    return Container(
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
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Bill Details",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.grey[800],
              ),
            ),
            SizedBox(height: 16),
            _buildDetailRow("Account Holder Name", bill.customerName),
            _buildDetailRowDivider(),
            _buildDetailRow("Consumer Number", bill.billNumber),
            _buildDetailRowDivider(),
            _buildDetailRow("Bill Period", bill.billPeriod.isNotEmpty ? bill.billPeriod : "N/A"),
            _buildDetailRowDivider(),
            _buildDetailRow("Bill Due Date", bill.dueDate),
            _buildDetailRowDivider(),
            _buildDetailRow("Bill Number", bill.billNumber),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Text(
              label,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.grey[700],
                fontSize: 14,
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              value,
              style: TextStyle(
                color: Colors.black87,
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
              textAlign: TextAlign.right,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRowDivider() {
    return Divider(
      height: 1,
      thickness: 1,
      color: Colors.grey[200],
    );
  }

  Widget _buildPayButton(ElectricityBillModel bill, double amount, String receiptId) {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          backgroundColor: maincolor1,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          foregroundColor: Colors.white,
          elevation: 2,
        ),
        icon: Icon(Icons.payment, size: 24),
        label: Text(
          "Pay Now",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        onPressed: () {
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
      ),
    );
  }

  Widget _buildProcessingButton() {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.grey[400],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          foregroundColor: Colors.white,
        ),
        onPressed: null,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              ),
            ),
            SizedBox(width: 12),
            Text(
              "Processing...",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }


  Widget _buildNoDueState() {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                color: Colors.green.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.check_circle_outline,
                size: 60,
                color: Colors.green,
              ),
            ),
            SizedBox(height: 24),
            Text(
              "No Dues Found!",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.grey[800],
              ),
            ),
            SizedBox(height: 12),
            Text(
              "Your ${widget.provider} bill is already paid\nand there are no pending dues.",
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[600],
                height: 1.4,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 32),
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.green.withOpacity(0.05),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.green.withOpacity(0.2)),
              ),
              child: Row(
                children: [
                  Icon(Icons.info_outline, color: Colors.green, size: 24),
                  SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      "You can check back later for new bills",
                      style: TextStyle(
                        color: Colors.green[700],
                        fontSize: 14,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildErrorState(String message) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                color: Colors.orange.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.info_outline,
                size: 60,
                color: Colors.orange,
              ),
            ),
            SizedBox(height: 24),
            Text(
              "Unable to Fetch Bill",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.grey[800],
              ),
            ),
            SizedBox(height: 12),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                message,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[600],
                  height: 1.4,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 32),
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.orange.withOpacity(0.05),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.orange.withOpacity(0.2)),
              ),
              child: Row(
                children: [
                  Icon(Icons.lightbulb_outline, color: Colors.orange, size: 24),
                  SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      "Please check your consumer ID and try again",
                      style: TextStyle(
                        color: Colors.orange[700],
                        fontSize: 14,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                context.read<FetchBillBloc>().add(
                  FetchBillEvent.fetchElectricityBill(
                    providerID: widget.providerID,
                    consumerId: widget.consumerId,
                    phoneNo: widget.phoneNo,
                    providerName: widget.provider
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: maincolor1,
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text(
                "Try Again",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showSuccessBottomSheet(String message, String receiptId) {
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
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    color: Colors.green.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(Icons.check_circle, color: Colors.green, size: 50),
                ),
                SizedBox(height: 20),
                Text(
                  'Payment Successful!',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
                SizedBox(height: 15),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.grey[50],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    children: [
                      _buildDetailRow('Provider', widget.provider),
                      _buildDetailRow('Consumer ID', widget.consumerId),
                      // _buildDetailRow('Receipt ID', receiptId),
                      _buildDetailRow('Status', 'Successfully Paid'),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  message,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                ),
                SizedBox(height: 25),
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
void _showRefundProcessingBottomSheet() {
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
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: Colors.orange.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.orange),
                  strokeWidth: 3,
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Processing Refund',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.orange,
                ),
              ),
              SizedBox(height: 15),
              Text(
                'Please wait while we process your refund...',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),
              SizedBox(height: 25),
            ],
          ),
        ),
      ),
    ),
  );
}

void _showRefundSuccessBottomSheet(String message, String receiptId) {
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
              // Changed to warning icon since payment failed but refund succeeded
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: Colors.orange.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.autorenew, color: Colors.orange, size: 50),
              ),
              SizedBox(height: 20),
              Text(
                'Payment Failed - Refund Initiated',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.orange,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 15),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.grey[50],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    _buildDetailRow('Provider', widget.provider),
                    _buildDetailRow('Consumer ID', widget.consumerId),
                    // _buildDetailRow('Receipt ID', receiptId),
                    _buildDetailRow('Payment Status', 'Failed'),
                    _buildDetailRow('Refund Status', 'Initiated'),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Column(
                children: [
                  Text(
                    'Sorry, your ${widget.provider} bill payment failed.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[800],
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'We have initiated a refund. The Refund amount will be credited to your account shortly',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  ),
                  SizedBox(height: 12),
                  Container(
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.green.withOpacity(0.05),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.green.withOpacity(0.2)),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.info_outline, color: Colors.green, size: 20),
                        SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            'Refund initiated successfully',
                            style: TextStyle(
                              color: Colors.green[700],
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 25),
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
                  },
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

void _showRefundFailedBottomSheet(String message, String receiptId) {
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
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: Colors.red.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.error_outline, color: Colors.red, size: 50),
              ),
              SizedBox(height: 20),
              Text(
                'Payment & Refund Failed',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.red,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 15),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.grey[50],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    _buildDetailRow('Provider', widget.provider),
                    _buildDetailRow('Consumer ID', widget.consumerId),
                    // _buildDetailRow('Receipt ID', receiptId),
                    _buildDetailRow('Bill Payment', 'Failed ❌'),
                    // _buildDetailRow('Refund', 'Failed ❌'),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Column(
                children: [
                  Text(
                    'Your ${widget.provider} bill payment failed and we encountered an issue while processing the refund.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[800],
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 12),
                  Text(
                    'Sorry for the inconvenience. Please contact our support team for assistance.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  ),
                  SizedBox(height: 16),
                  Container(
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.red.withOpacity(0.05),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.red.withOpacity(0.2)),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.support_agent, color: Colors.red, size: 20),
                        SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            'Please contact customer support',
                            style: TextStyle(
                              color: Colors.red[700],
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 25),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {   Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return HomePage();
                        },
                      ),
                      (route) => false,
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Close',
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
  void _showErrorBottomSheet(String message) {
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
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    color: Colors.red.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(Icons.error_outline, color: Colors.red, size: 50),
                ),
                SizedBox(height: 20),
                Text(
                  'Payment Failed',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.red,
                  ),
                ),
                SizedBox(height: 15),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.grey[50],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    children: [
                      _buildDetailRow('Provider', widget.provider),
                      _buildDetailRow('Consumer ID', widget.consumerId),
                      _buildDetailRow('Status', 'Payment Failed'),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  message,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                ),
                SizedBox(height: 25),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      'close',
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

  Widget _buildShimmer() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Shimmer.fromColors(
            baseColor: Colors.grey.shade300,
            highlightColor: Colors.grey.shade100,
            child: Container(
              width: double.infinity,
              height: 140,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
            ),
          ),
          SizedBox(height: 20),
          Shimmer.fromColors(
            baseColor: Colors.grey.shade300,
            highlightColor: Colors.grey.shade100,
            child: Container(
              width: double.infinity,
              height: 280,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
            ),
          ),
          SizedBox(height: 20),
          Shimmer.fromColors(
            baseColor: Colors.grey.shade300,
            highlightColor: Colors.grey.shade100,
            child: Container(
              width: double.infinity,
              height: 56,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ],
      ),
    );
  }
}