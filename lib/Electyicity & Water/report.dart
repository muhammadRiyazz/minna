import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
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
    required this.billerCategory,
  });

  @override
  State<BillPaymentPage> createState() => _BillPaymentPageState();
}

class _BillPaymentPageState extends State<BillPaymentPage> {
  // Use standardized theme colors from const.dart


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
    return Container(
      color: backgroundColor,
      child: Column(
        children: [
          // Header
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 24, 20, 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'RECENT TRANSACTIONS',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w800,
                    color: textLight,
                    letterSpacing: 1.2,
                  ),
                ),
                Text(
                  DateFormat('MMM dd, yyyy').format(DateTime.now()),
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: secondaryColor,
                  ),
                ),
              ],
            ),
          ),

          // Transactions List
          Expanded(
            child: BlocBuilder<BillPaymentBloc, BillPaymentState>(
              builder: (context, state) {
                if (state is BillPaymentLoading) {
                  return _buildShimmerLoading();
                } else if (state is BillPaymentLoaded) {
                  return _buildTransactionsList(state.transactions);
                } else if (state is BillPaymentEmpty ||
                    state is BillPaymentInitial ||
                    state is BillPaymentError) {
                  return _buildEmptyState(
                    'No ${widget.title.toLowerCase()} found',
                  );
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

  Widget _buildTransactionsList(List<BillPaymentModel> transactions) {
    if (transactions.isEmpty) return _buildEmptyState('No transactions found');

    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      physics: const BouncingScrollPhysics(),
      itemCount: transactions.length,
      itemBuilder: (context, index) {
        return _buildTransactionCard(transactions[index]);
      },
    );
  }

  Widget _buildTransactionCard(BillPaymentModel transaction) {
    final isSuccess = transaction.billStatus.toLowerCase() == 'success';
    final statusColor = isSuccess ? successColor : errorColor;

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
        border: Border.all(color: borderSoft),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // Header Row
            Row(
              children: [
                // Status Icon with background
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: statusColor.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    isSuccess ? Iconsax.tick_circle : Iconsax.close_circle,
                    color: statusColor,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 16),

                // Biller Info
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        transaction.billerCategory,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w800,
                          color: textPrimary,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Consumer ID: ${transaction.txtConsumer}',
                        style: TextStyle(
                          fontSize: 12,
                          color: textSecondary,
                          fontWeight: FontWeight.w600,
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
                      '₹${transaction.txtAmount}',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w900,
                        color: secondaryColor,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: statusColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(100),
                        border: Border.all(color: statusColor.withOpacity(0.2)),
                      ),
                      child: Text(
                        transaction.displayStatus.toUpperCase(),
                        style: TextStyle(
                          fontSize: 10,
                          color: statusColor,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),

            const Padding(
              padding: EdgeInsets.symmetric(vertical: 16),
              child: Divider(height: 1),
            ),

            // Details Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildDetailItem('Mobile', transaction.mobile, Iconsax.mobile),
                _buildDetailItem(
                  'Date',
                  transaction.formattedDate,
                  Iconsax.calendar_1,
                ),
                _buildPaymentBadge(transaction),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailItem(String title, String value, IconData icon) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, size: 12, color: textLight),
            const SizedBox(width: 4),
            Text(
              title,
              style: TextStyle(
                fontSize: 10,
                color: textLight,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: TextStyle(
            fontSize: 12,
            color: textPrimary,
            fontWeight: FontWeight.w800,
          ),
        ),
      ],
    );
  }

  Widget _buildPaymentBadge(BillPaymentModel transaction) {
    final paySuccess = transaction.paymentStatus.toLowerCase() == 'success';
    final payColor = paySuccess ? successColor : warningColor;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: payColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: payColor.withOpacity(0.2)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            paySuccess ? Iconsax.verify : Iconsax.info_circle,
            size: 14,
            color: payColor,
          ),
          const SizedBox(width: 6),
          Text(
            transaction.paymentStatusText.toUpperCase(),
            style: TextStyle(
              fontSize: 10,
              color: payColor,
              fontWeight: FontWeight.w900,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildShimmerLoading() {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemCount: 4,
      itemBuilder: (context, index) {
        return Container(
          margin: const EdgeInsets.only(bottom: 16),
          decoration: BoxDecoration(
            color: cardColor,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: borderSoft),
          ),
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Row(
                children: [
                  _buildShimmerCircle(size: 48),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildShimmerBox(width: 120, height: 16),
                        const SizedBox(height: 8),
                        _buildShimmerBox(width: 100, height: 12),
                      ],
                    ),
                  ),
                  _buildShimmerBox(width: 60, height: 32, radius: 20),
                ],
              ),
              const SizedBox(height: 16),
              const Divider(height: 1),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildShimmerBox(width: 80, height: 24, radius: 8),
                  _buildShimmerBox(width: 80, height: 24, radius: 8),
                  _buildShimmerBox(width: 60, height: 24, radius: 8),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildShimmerBox({
    required double width,
    required double height,
    double radius = 4,
  }) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(radius),
      ),
    );
  }

  Widget _buildShimmerCircle({required double size}) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: Colors.grey[200],
        shape: BoxShape.circle,
      ),
    );
  }

  Widget _buildEmptyState(String message) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(30),
            decoration: BoxDecoration(
              color: secondaryColor.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(Iconsax.receipt_2, color: secondaryColor, size: 48),
          ),
          const SizedBox(height: 24),
          Text(
            'No History',
            style: TextStyle(
              color: textPrimary,
              fontSize: 18,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            message,
            style: TextStyle(
              color: textSecondary,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 32),
          ElevatedButton.icon(
            onPressed: _fetchBillPayments,
            style: ElevatedButton.styleFrom(
              backgroundColor: maincolor1,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            icon: const Icon(Iconsax.refresh, size: 18),
            label: const Text(
              'Refresh',
              style: TextStyle(fontWeight: FontWeight.w700),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorState(String message) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: errorColor.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(Iconsax.danger, color: errorColor, size: 48),
          ),
          const SizedBox(height: 24),
          Text(
            'Failed to Load Data',
            style: TextStyle(
              color: textPrimary,
              fontSize: 18,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            message,
            style: TextStyle(color: textSecondary, fontSize: 14),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            onPressed: _fetchBillPayments,
            style: ElevatedButton.styleFrom(
              backgroundColor: maincolor1,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            icon: const Icon(Iconsax.refresh, size: 18),
            label: const Text(
              'Try Again',
              style: TextStyle(fontWeight: FontWeight.w700),
            ),
          ),
        ],
      ),
    );
  }
}
