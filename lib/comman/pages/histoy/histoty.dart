import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minna/DTH%20&%20Mobile/mobile%20%20recharge/application/report/report_transaction_bloc.dart';
import 'package:minna/Electyicity%20&%20Water/application/bill%20report/bill_report_bloc.dart';
import 'package:minna/Electyicity%20&%20Water/function/report_api.dart' show BillPaymentRepository;
import 'package:minna/Electyicity%20&%20Water/report.dart';
import 'package:minna/comman/application/login/login_bloc.dart';
import 'package:minna/comman/pages/histoy/dth_mob.dart';
import 'package:minna/comman/pages/log%20in/login_page.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  _HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  // White, Black, Gold theme
  final Color _blackColor = Colors.black;
  final Color _whiteColor = Colors.white;
  final Color _goldColor = Color(0xFFD4AF37);
  final Color _backgroundColor = Color(0xFFFAFAFA);
  final Color _borderColor = Color(0xFFEEEEEE);
  final Color _textSecondary = Color(0xFF666666);

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
      'page': const BillPaymentPage(
        title: 'Electricity Bill Payments',
        billerCategory: 'Electricity',
      ),
    },
    {
      'name': 'Water', 
      'icon': Icons.water_drop,
      'page': BlocProvider(
        create: (context) => BillPaymentBloc(BillPaymentRepository()),
        child: const BillPaymentPage(
          title: 'Water Bill Payments', 
          billerCategory: 'Water',
        ),
      ),
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
      backgroundColor: _backgroundColor,
      appBar: AppBar(
        title: Text(
          'Transaction History',
          style: TextStyle(
            color: _blackColor,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        backgroundColor: _whiteColor,
        elevation: 0,
        foregroundColor: _blackColor,
      
      ),
      body: BlocBuilder<LoginBloc, LoginState>(
        builder: (context, state) {
          final isLoggedIn = state.isLoggedIn ?? false;

          if (!isLoggedIn) {
            return _buildNotLoggedInSection();
          }

          return Column(
            children: [
              SizedBox(height: 10),
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
      margin: EdgeInsets.symmetric(horizontal: 12),
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: _whiteColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _borderColor),
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
                padding: EdgeInsets.symmetric(vertical: 12, horizontal: 0),
                decoration: BoxDecoration(
                  color: isSelected ? _goldColor.withOpacity(0.1) : Colors.transparent,
                  borderRadius: BorderRadius.circular(8),
                  // border: isSelected ? Border.all(color: _goldColor) : null,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      service['icon'],
                      color: isSelected ? _goldColor : _textSecondary,
                      size: 15,
                    ),
                    SizedBox(height: 6),
                    Text(
                      service['name'],
                      style: TextStyle(
                        color: isSelected ? _goldColor : _textSecondary,
                        fontSize: 12,
                        fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
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
    return Padding(
      padding: EdgeInsets.all(32),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              color: _whiteColor,
              shape: BoxShape.circle,
              border: Border.all(color: _borderColor),
            ),
            child: Icon(
              Icons.history_outlined,
              size: 40,
              color: _textSecondary,
            ),
          ),
          SizedBox(height: 32),
          Text(
            'Login Required',
            style: TextStyle(
              fontSize: 22,
              color: _blackColor,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 16),
          Text(
            'Please login to view your transaction history\nand manage your payment records',
            style: TextStyle(
              fontSize: 16,
              color: _textSecondary,
              height: 1.4,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 32),
          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  backgroundColor: Colors.transparent,
                  builder: (context) => LoginBottomSheet(login: 1),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: _blackColor,
                foregroundColor: _whiteColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(
                'Login to Continue',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          SizedBox(height: 16),
       
        ],
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