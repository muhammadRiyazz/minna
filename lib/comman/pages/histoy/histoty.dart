import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:minna/DTH%20&%20Mobile/mobile%20%20recharge/application/report/report_transaction_bloc.dart';
import 'package:minna/Electyicity%20&%20Water/application/bill%20report/bill_report_bloc.dart';
import 'package:minna/Electyicity%20&%20Water/function/report_api.dart'
    show BillPaymentRepository;
import 'package:minna/Electyicity%20&%20Water/report.dart';
import 'package:minna/comman/application/login/login_bloc.dart';
import 'package:minna/comman/pages/histoy/dth_mob.dart';
import 'package:minna/comman/pages/log%20in/login_page.dart';
import 'package:minna/comman/const/const.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  _HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  // Theme Variables
  final Color _primaryColor = maincolor1; // Deep Ocean Blue
  final Color _secondaryColor = secondaryColor; // Gold
  final Color _backgroundColor = backgroundColor;
  final Color _textPrimary = textPrimary;
  final Color _textSecondary = textSecondary;

  final List<Map<String, dynamic>> services = [
    {
      'name': 'Mobile',
      'icon': Iconsax.mobile,
      'page': const MobileReportPage(),
    },
    {'name': 'DTH', 'icon': Iconsax.monitor, 'page': const DTHReportPage()},
    {
      'name': 'Electricity',
      'icon': Iconsax.flash,
      'page': const BillPaymentPage(
        title: 'Electricity Bill Payments',
        billerCategory: 'Electricity',
      ),
    },
    {
      'name': 'Water',
      'icon': Iconsax.drop,
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
      body: BlocBuilder<LoginBloc, LoginState>(
        builder: (context, state) {
          final isLoggedIn = state.isLoggedIn ?? false;

          return Stack(
            children: [
              // Premium Header Background (Fixed)
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                height: 230,
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        _primaryColor,
                        _primaryColor.withOpacity(0.9),
                        _primaryColor.withOpacity(0.85),
                      ],
                    ),
                  ),
                  child: Stack(
                    children: [
                      // Decorative Element
                      Positioned(
                        right: -30,
                        top: -30,
                        child: Icon(
                          Iconsax.receipt_2,
                          size: 180,
                          color: Colors.white.withOpacity(0.05),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              SafeArea(
                child: Column(
                  children: [
                    // Header Content
                    Padding(
                      padding: const EdgeInsets.fromLTRB(24, 20, 24, 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Transaction History',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.w900,
                              letterSpacing: -0.5,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Securely browse your past records',
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.6),
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 10),

                    // Service Selector
                    _buildServiceSelector(),

                    const SizedBox(height: 20),

                    // Content Area
                    Expanded(
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: _backgroundColor,
                          borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(35),
                          ),
                        ),
                        child: !isLoggedIn
                            ? _buildNotLoggedInSection()
                            : services[selectedIndex]['page'],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildServiceSelector() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withOpacity(0.1)),
      ),
      child: Row(
        children: List.generate(services.length, (index) {
          final isSelected = selectedIndex == index;
          final service = services[index];
          return Expanded(
            child: GestureDetector(
              onTap: () => setState(() => selectedIndex = index),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  color: isSelected ? _secondaryColor : Colors.transparent,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: isSelected
                      ? [
                          BoxShadow(
                            color: _secondaryColor.withOpacity(0.3),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ]
                      : [],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      service['icon'],
                      color: isSelected
                          ? Colors.white
                          : Colors.white.withOpacity(0.6),
                      size: 13,
                    ),
                    const SizedBox(width: 5),
                    Text(
                      service['name'],
                      style: TextStyle(
                        fontSize: 10,
                        color: isSelected
                            ? Colors.white
                            : Colors.white.withOpacity(0.6),
                        fontWeight: isSelected
                            ? FontWeight.w800
                            : FontWeight.w600,
                        letterSpacing: -0.7,
                      ),
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
      padding: const EdgeInsets.all(32),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(30),
            decoration: BoxDecoration(
              color: _secondaryColor.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(Iconsax.lock_1, size: 50, color: _secondaryColor),
          ),
          const SizedBox(height: 32),
          Text(
            'Secure History',
            style: TextStyle(
              fontSize: 24,
              color: _textPrimary,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'Please login to securely view your\ntransaction history and payment records.',
            style: TextStyle(
              fontSize: 15,
              color: _textSecondary,
              height: 1.5,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 40),
          SizedBox(
            width: double.infinity,
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
                backgroundColor: _primaryColor,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                elevation: 4,
                shadowColor: _primaryColor.withOpacity(0.4),
              ),
              child: const Text(
                'Login to Continue',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
              ),
            ),
          ),
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
