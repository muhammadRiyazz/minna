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
            color: Colors.black.withOpacity(0.04),
            blurRadius: 15,
            offset: const Offset(0, 6),
          ),
        ],
        border: Border.all(color: borderSoft, width: 1),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: Column(
          children: [
            // Top Header Section
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: maincolor1.withOpacity(0.03),
                border: Border(bottom: BorderSide(color: borderSoft)),
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: maincolor1.withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      widget.title.contains('Electricity') ? Iconsax.flash_1 : Iconsax.drop,
                      size: 20,
                      color: maincolor1,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          transaction.billerCategory,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w900,
                            color: maincolor1,
                            letterSpacing: -0.5,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          "Consumer ID: ${transaction.txtConsumer}",
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            color: textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  _buildStatusBadge(transaction.displayStatus, statusColor),
                ],
              ),
            ),

            // Content Section
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildInfoItem(
                        label: "Payment Date",
                        value: transaction.formattedDate,
                        icon: Iconsax.calendar_1,
                      ),
                      Container(height: 30, width: 1, color: borderSoft),
                      _buildInfoItem(
                        label: "Status",
                        value: transaction.billStatus.toUpperCase(),
                        icon: isSuccess ? Iconsax.verify : Iconsax.info_circle,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        valueColor: statusColor,
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Divider(color: borderSoft, height: 1),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Iconsax.mobile,
                            size: 14,
                            color: secondaryColor,
                          ),
                          const SizedBox(width: 6),
                          Text(
                            transaction.mobile,
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w700,
                              color: textPrimary,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        "₹${transaction.txtAmount}",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w900,
                          color: maincolor1,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusBadge(String status, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.12),
        borderRadius: BorderRadius.circular(100),
      ),
      child: Text(
        status.toUpperCase(),
        style: TextStyle(
          fontSize: 10,
          color: color,
          fontWeight: FontWeight.w900,
          letterSpacing: 0.5,
        ),
      ),
    );
  }

  Widget _buildInfoItem({
    required String label,
    required String value,
    required IconData icon,
    CrossAxisAlignment crossAxisAlignment = CrossAxisAlignment.start,
    Color? valueColor,
  }) {
    return Column(
      crossAxisAlignment: crossAxisAlignment,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 12, color: textSecondary),
            const SizedBox(width: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 11,
                color: textSecondary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w800,
            color: valueColor ?? maincolor1,
          ),
        ),
      ],
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
