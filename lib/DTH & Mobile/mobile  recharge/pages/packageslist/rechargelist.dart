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
        return const Color(0xFFD4AF37); // Fallback to Secondary Gold
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
            fontSize: 20,
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
      appBar: AppBar(
        backgroundColor: maincolor1,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white, size: 20),
        title: const Text(
          'Mobile Recharge',
          style: TextStyle(fontSize: 18, color: Colors.white),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header & Amount Section
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            color: Colors.white,
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      width: 44,
                      height: 44,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: _getOperatorColor(widget.operator),
                          width: 2,
                        ),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(22),
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
                    const SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.operator,
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          widget.mobileNumber,
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: amountController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          hintText: 'Enter Amount Manually',
                          prefixIcon: const Icon(
                            Icons.currency_rupee,
                            size: 20,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 14,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: maincolor1,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 14,
                        ),
                      ),
                      onPressed: () {
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
                      child: const Text(
                        'Proceed',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          const Divider(thickness: 4, color: Color(0xFFF5F5F5), height: 4),

          // BlocBuilder for Tabs and Plans
          Expanded(
            child: BlocBuilder<PlansBloc, PlansState>(
              builder: (context, state) {
                if (state is PlansStateLoading || state is PlansStateInitial) {
                  return _buildShimmerLoading();
                } else if (state is PlansStateError) {
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Text(
                        state.message,
                        textAlign: TextAlign.center,
                        style: const TextStyle(color: Colors.red, fontSize: 16),
                      ),
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
                          unselectedLabelColor: Colors.grey,
                          indicatorColor: maincolor1,
                          tabs: tabs.map((t) => Tab(text: t.title)).toList(),
                        ),
                        Expanded(
                          child: TabBarView(
                            children: tabs.map((tab) {
                              if (tab.plans.isEmpty) {
                                return const Center(
                                  child: Text("No plans in this category."),
                                );
                              }
                              return ListView.builder(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 12,
                                ),
                                itemCount: tab.plans.length,
                                itemBuilder: (context, index) {
                                  final plan = tab.plans[index];
                                  return Container(
                                    margin: const EdgeInsets.only(bottom: 16),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(20),
                                      boxShadow: [
                                        BoxShadow(
                                          color: maincolor1.withOpacity(0.08),
                                          blurRadius: 15,
                                          offset: const Offset(0, 5),
                                        ),
                                      ],
                                      border: Border.all(
                                        color: maincolor1.withOpacity(0.1),
                                        width: 1.5,
                                      ),
                                    ),
                                    child: Material(
                                      color: Colors.transparent,
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
                                        borderRadius: BorderRadius.circular(20),
                                        child: Padding(
                                          padding: const EdgeInsets.all(20.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        '₹',
                                                        style: TextStyle(
                                                          fontSize: 18,
                                                          color: maincolor1,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                      Text(
                                                        plan.amt,
                                                        style: const TextStyle(
                                                          fontSize: 28,
                                                          fontWeight:
                                                              FontWeight.w900,
                                                          color: Colors.black87,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Container(
                                                    padding:
                                                        const EdgeInsets.symmetric(
                                                          horizontal: 12,
                                                          vertical: 6,
                                                        ),
                                                    decoration: BoxDecoration(
                                                      gradient: LinearGradient(
                                                        colors: [
                                                          maincolor1,
                                                          maincolor1
                                                              .withOpacity(0.8),
                                                        ],
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                            30,
                                                          ),
                                                      boxShadow: [
                                                        BoxShadow(
                                                          color: maincolor1
                                                              .withOpacity(0.3),
                                                          blurRadius: 8,
                                                          offset: const Offset(
                                                            0,
                                                            3,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    child: Row(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      children: [
                                                        const Icon(
                                                          Icons.timer_outlined,
                                                          color: Colors.white,
                                                          size: 14,
                                                        ),
                                                        const SizedBox(
                                                          width: 4,
                                                        ),
                                                        Text(
                                                          plan.validity,
                                                          style:
                                                              const TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: 12,
                                                              ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(height: 16),
                                              Container(
                                                padding: const EdgeInsets.all(
                                                  12,
                                                ),
                                                decoration: BoxDecoration(
                                                  color: Colors.grey.shade50,
                                                  borderRadius:
                                                      BorderRadius.circular(12),
                                                ),
                                                child: Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Icon(
                                                      Icons.check_circle,
                                                      color:
                                                          Colors.green.shade400,
                                                      size: 18,
                                                    ),
                                                    const SizedBox(width: 8),
                                                    Expanded(
                                                      child: Text(
                                                        plan.descr,
                                                        style: TextStyle(
                                                          color:
                                                              Colors.grey[700],
                                                          height: 1.5,
                                                          fontSize: 13,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
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
    );
  }

  Widget _buildShimmerLoading() {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Column(
        children: [
          // Shimmer Tabs
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(
                4,
                (index) => Container(
                  width: 80,
                  height: 30,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
            ),
          ),
          // Shimmer List Items
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: 5,
              itemBuilder: (context, index) {
                return Container(
                  margin: const EdgeInsets.only(bottom: 16),
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.grey.shade200),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: 100,
                            height: 30,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          Container(
                            width: 80,
                            height: 24,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Container(
                        width: double.infinity,
                        height: 40,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
