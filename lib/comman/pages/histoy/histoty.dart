import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minna/DTH%20&%20Mobile/mobile%20%20recharge/application/report/report_transaction_bloc.dart';
import 'package:minna/comman/application/login/login_bloc.dart';
import 'package:minna/comman/const/const.dart';
import 'package:minna/comman/pages/histoy/dth_mob.dart';
import 'package:minna/comman/pages/log%20in/login_page.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  _HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  final List<Map<String, dynamic>> services = [
    {
      'name': 'Mobile', 
      'icon': Icons.phone_android,
      'page': const MobileReportPage(),
    },
    {
      'name': 'DTH', 
      'icon': Icons.live_tv,
      'page': const DTHReportPage(),
    },
    {
      'name': 'Electricity', 
      'icon': Icons.bolt,
      'page': Container(), // Add your electricity page later
    },
    {
      'name': 'Water', 
      'icon': Icons.water_drop,
      'page': Container(), // Add your water page later
    },
  ];

  int selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    context.read<LoginBloc>().add(const LoginEvent.loginInfo());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text(
          'Transaction History',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        backgroundColor: maincolor1,
        elevation: 0,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh, color: Colors.white),
            onPressed: () {
              setState(() {});
            },
          ),
        ],
      ),
      body: BlocBuilder<LoginBloc, LoginState>(
        builder: (context, state) {
          final isLoggedIn = state.isLoggedIn ?? false;

          if (!isLoggedIn) {
            return _buildNotLoggedInSection();
          }

          return Column(
            children: [
              _buildServiceSelector(),
              Expanded(
                child: services[selectedIndex]['page'],
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildServiceSelector() {
    return Container(
      margin: const EdgeInsets.only(top: 10,right: 12,left: 12,bottom: 5),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: const Color.fromARGB(31, 207, 206, 206),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: List.generate(services.length, (index) {
          final isSelected = index == selectedIndex;
          final service = services[index];
          
          return Expanded(
            child: GestureDetector(
              onTap: () {
                setState(() {
                  selectedIndex = index;
                });
              },
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 4),
                padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
                decoration: BoxDecoration(
                  color: isSelected ? maincolor1 : Colors.transparent,
                  borderRadius: BorderRadius.circular(12),
                  border: isSelected ? null : Border.all(color: Colors.grey[300]!),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      service['icon'],
                      color: isSelected ? Colors.white : maincolor1,
                      size: 20,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      service['name'],
                      style: TextStyle(
                        color: isSelected ? Colors.white : Colors.black87,
                        fontSize: 10,
                        fontWeight: FontWeight.w500,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget _buildNotLoggedInSection() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                color: maincolor1!.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.history_outlined,
                size: 50,
                color: maincolor1,
              ),
            ),
            const SizedBox(height: 24),
             Text(
              "Login to View History",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Colors.grey[800],
              ),
            ),
            const SizedBox(height: 12),
             Text(
              "Please log in to view your transaction history\nand manage your data",
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
                height: 1.4,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  backgroundColor: Colors.transparent,
                  builder: (context) => LoginBottomSheet(login: 1),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: maincolor1,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 2,
              ),
              child: const Text(
                "Login Now",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}

class MobileReportPage extends StatelessWidget {
  const MobileReportPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TransactionReportBloc(),
      child: const BaseTransactionReportPage(
        title: 'Mobile Recharge History',
        billerType: 'Mobile Recharge',
      ),
    );
  }
}


class DTHReportPage extends StatelessWidget {
  const DTHReportPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TransactionReportBloc(),
      child: const BaseTransactionReportPage(
        title: 'DTH Recharge History',
        billerType: 'DTH Recharge',
      ),
    );
  }
}