// lib/water_electricity/presentation/bill_payment_page.dart

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minna/Electyicity%20&%20Water/application/bill%20report/bill_report_bloc.dart';
import 'package:minna/Electyicity%20&%20Water/application/bill%20report/bill_report_event.dart';
import 'package:minna/Electyicity%20&%20Water/application/bill%20report/bill_report_state.dart';
import 'package:minna/Electyicity%20&%20Water/domain/water_electricity_model.dart';
import 'package:minna/comman/const/const.dart';

class BillPaymentPage extends StatefulWidget {
  final String title;
  final String? billerCategory;

  const BillPaymentPage({
    super.key,
    required this.title,
    this.billerCategory,
  });

  @override
  State<BillPaymentPage> createState() => _BillPaymentPageState();
}

class _BillPaymentPageState extends State<BillPaymentPage> {
  @override
  void initState() {
    super.initState();
    _fetchBillPayments();
  }

  void _fetchBillPayments() {
    log("_fetchBillPayments ------${widget.billerCategory}");
    context.read<BillPaymentBloc>().add(
      FetchBillPayments(billerCategory: widget.billerCategory),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: Column(
        children: [
          // Header
          // _buildHeader(),
          
          // Transactions List
          Expanded(
            child: BlocBuilder<BillPaymentBloc, BillPaymentState>(
              builder: (context, state) {
                if (state is BillPaymentInitial) {
                  return _buildEmptyState('No bill payments found');
                } else if (state is BillPaymentLoading) {
                  return _buildLoadingState();
                } else if (state is BillPaymentLoaded) {
                  return _buildTransactionsList(state.transactions);
                } else if (state is BillPaymentEmpty) {
                  return _buildEmptyState('No ${widget.billerCategory?.toLowerCase() ?? 'bill'} payments found');
                } else if (state is BillPaymentError) {
                  return _buildEmptyState('No bill payments found');
                } else {
                  return _buildEmptyState('No data available');
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [maincolor1, maincolor1.withOpacity(0.8)],
        ),
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(24),
          bottomRight: Radius.circular(24),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          BlocBuilder<BillPaymentBloc, BillPaymentState>(
            builder: (context, state) {
              if (state is BillPaymentLoaded) {
                return _buildStats(state.transactions);
              } else {
                return Text(
                  'View your ${widget.billerCategory?.toLowerCase() ?? 'bill'} payment history',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.9),
                    fontSize: 14,
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _buildStats(List<BillPaymentModel> transactions) {
    final total = transactions.length;
    final successful = transactions.where((t) => 
      t.billStatus.toLowerCase() == 'success').length;
    final totalAmount = transactions.fold(0.0, (sum, transaction) {
      return sum + (double.tryParse(transaction.txtAmount) ?? 0);
    });

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _buildStatItem('Total', '$total', Icons.receipt),
        _buildStatItem('Success', '$successful', Icons.check_circle),
        _buildStatItem('Amount', '₹${totalAmount.toStringAsFixed(2)}', Icons.currency_rupee),
      ],
    );
  }

  Widget _buildStatItem(String title, String value, IconData icon) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.2),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: Colors.white, size: 20),
        ),
        const SizedBox(height: 8),
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          title,
          style: TextStyle(
            color: Colors.white.withOpacity(0.9),
            fontSize: 12,
          ),
        ),
      ],
    );
  }

  Widget _buildTransactionsList(List<BillPaymentModel> transactions) {
    return Column(
      children: [ 
        
                  SizedBox(height: 10,),

        Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '   Recent Transactions',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.grey[800],
            ),
          ),
          // Text(
          //   DateFormat('MMM dd, yyyy').format(DateTime.now()),
          //   style: TextStyle(
          //     fontSize: 14,
          //     color: Colors.grey[600],
          //   ),
          // ),
        ],
      ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: ListView.builder(
              itemCount: transactions.length,
              itemBuilder: (context, index) {
                return _buildTransactionCard(transactions[index]);
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTransactionCard(BillPaymentModel transaction) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Header Row
            Row(
              children: [
                // Status Icon
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: transaction.statusColor.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    transaction.statusIcon,
                    color: transaction.statusColor,
                    size: 20,
                  ),
                ),
                const SizedBox(width: 12),
                
                // Biller Info
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        transaction.billerCategory,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Consumer: ${transaction.txtConsumer}',
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
                
                // Amount
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      transaction.formattedAmount,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: transaction.statusColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        transaction.displayStatus.toUpperCase(),
                        style: TextStyle(
                          fontSize: 10,
                          color: transaction.statusColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            
            const SizedBox(height: 12),
            const Divider(height: 1),
            const SizedBox(height: 12),
            
            // Details Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildDetailItem('Mobile', transaction.mobile),
                _buildDetailItem('Date', transaction.formattedDate),
                _buildPaymentStatus(transaction),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailItem(String title, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 12,
            color: Colors.grey,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            fontSize: 12,
            color: Colors.black87,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Widget _buildPaymentStatus(BillPaymentModel transaction) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        const Text(
          'Payment',
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 4),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: transaction.paymentStatusColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            transaction.paymentStatusText,
            style: TextStyle(
              fontSize: 10,
              color: transaction.paymentStatusColor,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLoadingState() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(),
          SizedBox(height: 16),
          Text(
            'Loading bill payments...',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState(String message) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.receipt_long,
              size: 80,
              color: Colors.grey[400],
            ),
            const SizedBox(height: 16),
            Text(
              message,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
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
            Icon(
              Icons.error_outline,
              size: 80,
              color: Colors.red[400],
            ),
            const SizedBox(height: 16),
            Text(
              message,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.red,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _fetchBillPayments,
              style: ElevatedButton.styleFrom(
                backgroundColor: maincolor1,
                foregroundColor: Colors.white,
              ),
              child: const Text('Try Again'),
            ),
          ],
        ),
      ),
    );
  }
}