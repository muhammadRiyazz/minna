import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minna/comman/const/const.dart';
import 'package:minna/DTH & Mobile/mobile  recharge/pages/add amount/add_amount.dart';
import 'package:minna/DTH & Mobile/mobile  recharge/application/plans/plans_bloc.dart';
import 'package:shimmer/shimmer.dart';

class MobileRechargePlansPage extends StatefulWidget {
  final String mobileNumber;
  final String operator;

  const MobileRechargePlansPage({
    super.key,
    required this.mobileNumber,
    required this.operator,
  });

  @override
  _MobileRechargePlansPageState createState() =>
      _MobileRechargePlansPageState();
}

class _MobileRechargePlansPageState extends State<MobileRechargePlansPage> {
  final TextEditingController amountController = TextEditingController();

  // Use standardized theme colors from const.dart


  Color _getOperatorColor(String operatorName) {
    switch (operatorName.toUpperCase()) {
      case 'AIRTEL':
        return Colors.red;
      case 'JIO':
      case 'RELIANCE JIO':
        return Colors.blue.shade800;
      case 'VI':
      case 'VODAFONE':
      case 'IDEA':
        return Colors.redAccent;
      case 'BSNL':
        return Colors.blue.shade600;
      case 'MTNL':
        return Colors.orange;
      default:
        return secondaryColor;
    }
  }

  String _getOperatorImageURL(String operatorName) {
    switch (operatorName.toUpperCase()) {
      case 'AIRTEL':
        return 'https://upload.wikimedia.org/wikipedia/commons/thumb/1/1a/Airtel_logo.svg/1024px-Airtel_logo.svg.png';
      case 'JIO':
      case 'RELIANCE JIO':
        return 'https://upload.wikimedia.org/wikipedia/commons/thumb/4/4e/Jio_logo.svg/1024px-Jio_logo.svg.png';
      case 'VI':
      case 'VODAFONE':
      case 'IDEA':
        return 'https://upload.wikimedia.org/wikipedia/commons/thumb/0/07/Vi_%28Vodafone_Idea%29_logo.svg/1024px-Vi_%28Vodafone_Idea%29_logo.svg.png';
      case 'BSNL':
        return 'https://upload.wikimedia.org/wikipedia/en/thumb/8/87/Bsnl_logo.png/800px-Bsnl_logo.png';
      case 'MTNL':
        return 'https://upload.wikimedia.org/wikipedia/commons/thumb/6/6c/MTNL_logo.svg/1024px-MTNL_logo.svg.png';
      default:
        return '';
    }
  }

  Widget _buildTextFallback(String opName) {
    return Container(
      color: _getOperatorColor(opName).withOpacity(0.15),
      child: Center(
        child: Text(
          opName.isNotEmpty ? opName[0].toUpperCase() : '?',
          style: TextStyle(
            color: _getOperatorColor(opName),
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    context.read<PlansBloc>().add(
          FetchPlansEvent(operatorName: widget.operator),
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Stack(
        children: [
          // 1. Immersive Header
          Container(
            height: 260,
            width: double.infinity,
            decoration: BoxDecoration(color: maincolor1),
            child: Stack(
              children: [
                Positioned(
                  top: -50,
                  right: -50,
                  child: Container(
                    width: 200,
                    height: 200,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.03),
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
                Positioned(
                  bottom: 40,
                  left: -30,
                  child: Icon(
                    Icons.signal_cellular_alt_rounded,
                    size: 140,
                    color: Colors.white.withOpacity(0.04),
                  ),
                ),
                SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(24, 60, 24, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Mobile\nPlans',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 32,
                            fontWeight: FontWeight.w900,
                            height: 1.1,
                            letterSpacing: -1,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          // 2. Main Content
          Column(
            children: [
              const SizedBox(height: 180),
              // Manual Entry and Operator Info Card
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: cardColor,
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.08),
                        blurRadius: 20,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: _getOperatorColor(widget.operator).withOpacity(0.2),
                                width: 2,
                              ),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(25),
                              child: _getOperatorImageURL(widget.operator).isNotEmpty
                                  ? Image.network(
                                      _getOperatorImageURL(widget.operator),
                                      fit: BoxFit.contain,
                                      errorBuilder: (context, error, stackTrace) {
                                        return _buildTextFallback(widget.operator);
                                      },
                                    )
                                  : _buildTextFallback(widget.operator),
                            ),
                          ),
                          const SizedBox(width: 14),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widget.operator,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w900,
                                    fontSize: 17,
                                    color: maincolor1,
                                  ),
                                ),
                                Text(
                                  'Number: ${widget.mobileNumber}',
                                  style: TextStyle(
                                    color: textSecondary,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                color: backgroundColor,
                                borderRadius: BorderRadius.circular(16),
                                border: Border.all(color: Colors.grey.withOpacity(0.1)),
                              ),
                              child: TextField(
                                controller: amountController,
                                keyboardType: TextInputType.number,
                                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                                decoration: InputDecoration(
                                  hintText: 'Enter amount manually',
                                  hintStyle: TextStyle(color: textSecondary.withOpacity(0.5), fontSize: 14),
                                  prefixIcon: Icon(Icons.currency_rupee, size: 18, color: maincolor1),
                                  border: InputBorder.none,
                                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          GestureDetector(
                            onTap: () {
                              if (amountController.text.isNotEmpty) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => AmountEntryPage(
                                      phoneNo: widget.mobileNumber,
                                      operator: widget.operator,
                                      initialAmount: amountController.text,
                                    ),
                                  ),
                                );
                              }
                            },
                            child: Container(
                              height: 52,
                              width: 52,
                              decoration: BoxDecoration(
                                color: secondaryColor,
                                borderRadius: BorderRadius.circular(16),
                                boxShadow: [
                                  BoxShadow(
                                    color: secondaryColor.withOpacity(0.3),
                                    blurRadius: 10,
                                    offset: const Offset(0, 4),
                                  ),
                                ],
                              ),
                              child: const Icon(Icons.arrow_forward_rounded, color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // Plans Tabs
              Expanded(
                child: BlocBuilder<PlansBloc, PlansState>(
                  builder: (context, state) {
                    if (state is PlansStateLoading || state is PlansStateInitial) {
                      return _buildShimmerLoading();
                    } else if (state is PlansStateError) {
                      return Center(
                        child: Text(
                          state.message,
                          style: const TextStyle(color: Colors.red),
                        ),
                      );
                    } else if (state is PlansStateLoaded) {
                      final tabs = state.tabs;
                      if (tabs.isEmpty) {
                        return const Center(child: Text("No plans available."));
                      }

                      return DefaultTabController(
                        length: tabs.length,
                        child: Column(
                          children: [
                            TabBar(
                              isScrollable: true,
                              labelColor: maincolor1,
                              unselectedLabelColor: textSecondary,
                              indicatorColor: secondaryColor,
                              indicatorWeight: 3,
                              labelStyle: const TextStyle(fontWeight: FontWeight.w900, fontSize: 14),
                              unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.w700, fontSize: 13),
                              tabs: tabs.map((t) => Tab(text: t.title)).toList(),
                            ),
                            Expanded(
                              child: TabBarView(
                                children: tabs.map((tab) {
                                  if (tab.plans.isEmpty) {
                                    return const Center(child: Text("No plans in this category."));
                                  }
                                  return ListView.builder(
                                    padding: const EdgeInsets.fromLTRB(24, 16, 24, 24),
                                    itemCount: tab.plans.length,
                                    itemBuilder: (context, index) {
                                      final plan = tab.plans[index];
                                      return Container(
                                        margin: const EdgeInsets.only(bottom: 16),
                                        decoration: BoxDecoration(
                                          color: cardColor,
                                          borderRadius: BorderRadius.circular(24),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.black.withOpacity(0.04),
                                              blurRadius: 15,
                                              offset: const Offset(0, 5),
                                            ),
                                          ],
                                          border: Border.all(color: Colors.grey.withOpacity(0.05)),
                                        ),
                                        child: InkWell(
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (_) => AmountEntryPage(
                                                  phoneNo: widget.mobileNumber,
                                                  operator: widget.operator,
                                                  initialAmount: plan.amt,
                                                ),
                                              ),
                                            );
                                          },
                                          borderRadius: BorderRadius.circular(24),
                                          child: Padding(
                                            padding: const EdgeInsets.all(20),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Row(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Padding(
                                                          padding: const EdgeInsets.only(top: 4),
                                                          child: Text(
                                                            '₹',
                                                            style: TextStyle(
                                                              fontSize: 16,
                                                              color: maincolor1,
                                                              fontWeight: FontWeight.bold,
                                                            ),
                                                          ),
                                                        ),
                                                        Text(
                                                          plan.amt,
                                                          style: TextStyle(
                                                            fontSize: 28,
                                                            fontWeight: FontWeight.w900,
                                                            color: maincolor1,
                                                            letterSpacing: -0.5,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    Container(
                                                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                                      decoration: BoxDecoration(
                                                        color: secondaryColor.withOpacity(0.1),
                                                        borderRadius: BorderRadius.circular(30),
                                                      ),
                                                      child: Row(
                                                        children: [
                                                          Icon(Icons.timer_outlined, color: secondaryColor, size: 14),
                                                          const SizedBox(width: 4),
                                                          Text(
                                                            plan.validity,
                                                            style: TextStyle(
                                                              color: secondaryColor,
                                                              fontWeight: FontWeight.w900,
                                                              fontSize: 12,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                const SizedBox(height: 12),
                                                Text(
                                                  plan.descr,
                                                  style: TextStyle(
                                                    color: textSecondary,
                                                    fontSize: 13,
                                                    height: 1.5,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                }).toList(),
                              ),
                            ),
                          ],
                        ),
                      );
                    }
                    return const SizedBox();
                  },
                ),
              ),
            ],
          ),

          // 3. Fixed Header Controls
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.1),
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white.withOpacity(0.1)),
                      ),
                      child: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white, size: 18),
                    ),
                  ),
                  Text(
                    'MOBILE RECHARGE',
                    style: TextStyle(
                      color: secondaryColor,
                      fontSize: 13,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 2,
                    ),
                  ),
                  const SizedBox(width: 40),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildShimmerLoading() {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(4, (index) => Container(width: 80, height: 30, decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)))),
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              itemCount: 5,
              itemBuilder: (context, index) => Container(
                margin: const EdgeInsets.only(bottom: 16),
                height: 150,
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(24)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
