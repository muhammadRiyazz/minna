import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:minna/DTH%20&%20Mobile/mobile%20%20recharge/application/report/report_transaction_bloc.dart';
import 'package:minna/DTH%20&%20Mobile/mobile%20%20recharge/domain/report_model.dart' show TransactionModel;
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
  State<BaseTransactionReportPage> createState() => _BaseTransactionReportPageState();
}

class _BaseTransactionReportPageState extends State<BaseTransactionReportPage> {
  @override
  void initState() {
    super.initState();
    // Fetch recent data (today's transactions)
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
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: Column(
        children: [
          // Recent Transactions Header
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Recent Transactions',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[800],
                  ),
                ),
                Text(
                  DateFormat('MMM dd, yyyy').format(DateTime.now()),
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
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
                  loading: () => _buildLoadingState(),
                  loaded: (transactions) => _buildTransactionsList(transactions),
                  empty: () => _buildEmptyState('No transactions found for today'),
                  error: (message) => _buildErrorState(message),
                );
              },
            ),
          ),
          
          // // View More Button
          // Padding(
          //   padding: const EdgeInsets.all(16),
          //   child: SizedBox(
          //     width: double.infinity,
          //     child: ElevatedButton(
          //       onPressed: () {
          //         // View More button action - can be implemented later
          //       },
          //       style: ElevatedButton.styleFrom(
          //         backgroundColor: maincolor1,
          //         foregroundColor: Colors.white,
          //         padding: const EdgeInsets.symmetric(vertical: 16),
          //         shape: RoundedRectangleBorder(
          //           borderRadius: BorderRadius.circular(12),
          //         ),
          //         elevation: 2,
          //       ),
          //       child: const Text(
          //         'View More',
          //         style: TextStyle(
          //           fontSize: 16,
          //           fontWeight: FontWeight.w600,
          //         ),
          //       ),
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }

  Widget _buildTransactionsList(List<TransactionModel> transactions) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          // Transactions List
          Expanded(
            child: ListView.builder(
              itemCount: transactions.length,
              itemBuilder: (context, index) {
                return _buildTransactionCard(transactions[index]);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTransactionCard(TransactionModel transaction) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
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
            
            // Transaction Details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.billerType == 'Mobile Recharge' 
                        ? transaction.mobile
                        : transaction.dthnumber ?? 'N/A',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    transaction.status,
                    style: TextStyle(
                      fontSize: 14,
                      color: transaction.statusColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    transaction.formattedDate,
                    style: const TextStyle(
                      fontSize: 12,
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
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 4),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color: transaction.paidStatus == 'success' 
                        ? Colors.green.withOpacity(0.1)
                        : Colors.red.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    transaction.paidStatus.toUpperCase(),
                    style: TextStyle(
                      fontSize: 10,
                      color: transaction.paidStatus == 'success' 
                          ? Colors.green
                          : Colors.red,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
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
            'Loading recent transactions...',
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
              onPressed: _fetchRecentTransactions,
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