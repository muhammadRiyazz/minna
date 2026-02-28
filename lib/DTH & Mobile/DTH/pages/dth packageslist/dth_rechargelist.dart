import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minna/DTH & Mobile/DTH/pages/dth confirm/confirm_page.dart';
import 'package:minna/DTH & Mobile/DTH/application/dth_plans_bloc.dart';

class DTHRechargePlansPage extends StatefulWidget {
  final String phoneNo;
  final String subcriberNo;
  final String operator;

  const DTHRechargePlansPage({
    super.key,
    required this.phoneNo,
    required this.subcriberNo,
    required this.operator,
  });

  @override
  _DTHRechargePlansPageState createState() => _DTHRechargePlansPageState();
}

class _DTHRechargePlansPageState extends State<DTHRechargePlansPage> {
  final TextEditingController amountController = TextEditingController();

  Color _getOperatorColor(String operatorName) {
    switch (operatorName.toUpperCase()) {
      case 'AIRTEL DTH':
      case 'AIRTEL':
        return Colors.red;
      case 'SUN DIRECT':
        return Colors.orangeAccent;
      case 'TATA SKY':
      case 'TATA PLAY':
        return Colors.purple.shade700;
      case 'DISH TV':
        return Colors.red.shade900;
      case 'D2H':
      case 'VIDEOCON D2H':
        return Colors.lightGreen;
      default:
        return const Color(0xFFD4AF37); // Fallback to Secondary Gold
    }
  }

  @override
  void initState() {
    super.initState();
    context.read<DTHPlansBloc>().add(
      FetchDTHPlansEvent(operatorName: widget.operator),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black, // Primary color from input page
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white, size: 20),
        title: const Text(
          'DTH Recharge',
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
                        color: _getOperatorColor(
                          widget.operator,
                        ).withOpacity(0.15),
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: _getOperatorColor(widget.operator),
                          width: 2,
                        ),
                      ),
                      child: Center(
                        child: Text(
                          widget.operator.isNotEmpty
                              ? widget.operator[0].toUpperCase()
                              : '?',
                          style: TextStyle(
                            color: _getOperatorColor(widget.operator),
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
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
                          'ID: ${widget.subcriberNo} | Ph: ${widget.phoneNo}',
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
                        backgroundColor: Colors.black, // Primary color
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
                              builder: (_) => DTHAmountEntryPage(
                                phoneNo: widget.phoneNo,
                                subcriberNo: widget.subcriberNo,
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
            child: BlocBuilder<DTHPlansBloc, DTHPlansState>(
              builder: (context, state) {
                if (state is DTHPlansStateLoading ||
                    state is DTHPlansStateInitial) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is DTHPlansStateError) {
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
                } else if (state is DTHPlansStateLoaded) {
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
                          labelColor: Colors.black,
                          unselectedLabelColor: Colors.grey,
                          indicatorColor: const Color(
                            0xFFD4AF37,
                          ), // Secondary color
                          indicatorWeight: 3,
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
                                          color: Colors.black.withOpacity(0.08),
                                          blurRadius: 15,
                                          offset: const Offset(0, 5),
                                        ),
                                      ],
                                      border: Border.all(
                                        color: Colors.black.withOpacity(0.1),
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
                                              builder: (_) =>
                                                  DTHAmountEntryPage(
                                                    phoneNo: widget.phoneNo,
                                                    subcriberNo:
                                                        widget.subcriberNo,
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
                                                      const Text(
                                                        '₹',
                                                        style: TextStyle(
                                                          fontSize: 18,
                                                          color: Colors.black,
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
                                                      gradient:
                                                          const LinearGradient(
                                                            colors: [
                                                              Color(0xFFC19B3C),
                                                              Color(0xFFD4AF37),
                                                            ],
                                                          ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                            30,
                                                          ),
                                                      boxShadow: [
                                                        BoxShadow(
                                                          color: const Color(
                                                            0xFFD4AF37,
                                                          ).withOpacity(0.3),
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
}
