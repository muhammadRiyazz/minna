import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:minna/DTH%20&%20Mobile/mobile%20%20recharge/application/report/report_transaction_bloc.dart';
import 'package:minna/DTH%20&%20Mobile/mobile%20%20recharge/domain/report_model.dart'
    show TransactionModel;
import 'package:minna/comman/const/const.dart';

class BaseTransactionReportPage extends StatefulWidget {
  final String title;
  final String billerType;

  const BaseTransactionReportPage({
    super.key,
    required this.title,
    required this.billerType,
  });

  @override
  State<BaseTransactionReportPage> createState() =>
      _BaseTransactionReportPageState();
}

class _BaseTransactionReportPageState extends State<BaseTransactionReportPage> {
  // Theme Variables
  final Color _primaryColor = maincolor1;
  final Color _secondaryColor = secondaryColor;
  final Color _backgroundColor = backgroundColor;
  final Color _cardColor = cardColor;
  final Color _textPrimary = textPrimary;
  final Color _textSecondary = textSecondary;
  final Color _textLight = textLight;
  final Color _errorColor = errorColor;
  final Color _successColor = const Color(0xFF0D9488);
  final Color _borderColor = borderSoft;

  @override
  void initState() {
    super.initState();
    _fetchRecentTransactions();
  }

  void _fetchRecentTransactions() {
    final today = DateTime.now();
    final todayString = DateFormat('yyyy-MM-dd').format(today);

    context.read<TransactionReportBloc>().add(
      FetchTransactions(
        billerType: widget.billerType,
        fromDate: todayString,
        toDate: todayString,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: _backgroundColor,
      child: Column(
        children: [
          // Recent Transactions Header
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
                    color: _textLight,
                    letterSpacing: 1.2,
                  ),
                ),
                Text(
                  DateFormat('MMM dd, yyyy').format(DateTime.now()),
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: _secondaryColor,
                  ),
                ),
              ],
            ),
          ),

          // Transactions List
          Expanded(
            child: BlocBuilder<TransactionReportBloc, TransactionReportState>(
              builder: (context, state) {
                return state.when(
                  initial: () => _buildEmptyState('No recent transactions'),
                  loading: () => _buildShimmerLoading(),
                  loaded: (transactions) =>
                      _buildTransactionsList(transactions),
                  empty: () =>
                      _buildEmptyState('No transactions found for today'),
                  error: (message) => _buildErrorState(message),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTransactionsList(List<TransactionModel> transactions) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      physics: const BouncingScrollPhysics(),
      itemCount: transactions.length,
      itemBuilder: (context, index) {
        return _buildTransactionCard(transactions[index]);
      },
    );
  }

  Widget _buildTransactionCard(TransactionModel transaction) {
    final isSuccess = transaction.paidStatus.toLowerCase() == 'success';
    final statusColor = isSuccess ? _successColor : _errorColor;

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: _cardColor,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 15,
            offset: const Offset(0, 6),
          ),
        ],
        border: Border.all(color: _borderColor, width: 1),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: Column(
          children: [
            // Top Header Section
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: _primaryColor.withOpacity(0.03),
                border: Border(bottom: BorderSide(color: _borderColor)),
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: _primaryColor.withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      widget.billerType == 'Mobile Recharge' ? Iconsax.mobile : Iconsax.monitor_mobbile,
                      size: 20,
                      color: _primaryColor,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.billerType == 'Mobile Recharge'
                              ? (transaction.mobile.isNotEmpty ? transaction.mobile : 'Mobile Recharge')
                              : (transaction.dthnumber ?? 'DTH Recharge'),
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w900,
                            color: _primaryColor,
                            letterSpacing: -0.5,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          widget.billerType,
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            color: _textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  _buildStatusBadge(transaction.paidStatus, statusColor),
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
                        label: "Transaction Date",
                        value: transaction.formattedDate,
                        icon: Iconsax.calendar_1,
                      ),
                      Container(height: 30, width: 1, color: _borderColor),
                      _buildInfoItem(
                        label: "Payment Status",
                        value: transaction.paidStatus.toUpperCase(),
                        icon: isSuccess ? Iconsax.verify : Iconsax.info_circle,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        valueColor: statusColor,
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Divider(color: _borderColor, height: 1),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Iconsax.wallet_2,
                            size: 14,
                            color: _secondaryColor,
                          ),
                          const SizedBox(width: 6),
                          Text(
                            "Standard Plan",
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w700,
                              color: _textPrimary,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        "₹${transaction.amount}",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w900,
                          color: _primaryColor,
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
            Icon(icon, size: 12, color: _textSecondary),
            const SizedBox(width: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 11,
                color: _textSecondary,
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
            color: valueColor ?? _primaryColor,
          ),
        ),
      ],
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
            color: _cardColor,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: _borderColor),
          ),
          padding: const EdgeInsets.all(20),
          child: Row(
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
              _buildShimmerBox(width: 60, height: 24, radius: 10),
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
              color: _secondaryColor.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(Iconsax.receipt_2, color: _secondaryColor, size: 48),
          ),
          const SizedBox(height: 24),
          Text(
            'No History',
            style: TextStyle(
              color: _textPrimary,
              fontSize: 18,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            message,
            style: TextStyle(
              color: _textSecondary,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 32),
          ElevatedButton.icon(
            onPressed: _fetchRecentTransactions,
            style: ElevatedButton.styleFrom(
              backgroundColor: _primaryColor,
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
              color: _errorColor.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(Iconsax.danger, color: _errorColor, size: 48),
          ),
          const SizedBox(height: 24),
          Text(
            'Failed to Load Data',
            style: TextStyle(
              color: _textPrimary,
              fontSize: 18,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            message,
            style: TextStyle(color: _textSecondary, fontSize: 14),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            onPressed: _fetchRecentTransactions,
            style: ElevatedButton.styleFrom(
              backgroundColor: _primaryColor,
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
