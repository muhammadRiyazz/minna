import 'package:flutter/material.dart';
import 'package:minna/comman/const/const.dart';
import 'package:minna/DTH%20&%20Mobile/mobile%20%20recharge/pages/confirm/confirm_page.dart';

class MobileRechargePlansPage extends StatefulWidget {
  final String mobileNumber;
  final String operator;

  const MobileRechargePlansPage({
    required this.mobileNumber,
    required this.operator,
  });

  @override
  _MobileRechargePlansPageState createState() =>
      _MobileRechargePlansPageState();
}

class _MobileRechargePlansPageState extends State<MobileRechargePlansPage> {
  final TextEditingController amountController = TextEditingController();
  String selectedTab = 'Unlimited';

  List<Map<String, String>> plans = List.generate(
    6,
    (index) => {
      'price': '₹299',
      'validity': '28 Days',
      'desc':
          'Get Rs 99 Limited Validity Talktime. Standard tariff for SMS to 1900. 15 Day Service Validity',
    },
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Color(0xFFF5F5F5),
      appBar: AppBar(
        backgroundColor: maincolor1,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.white, size: 16),
        // title: const Text(
        //   'Mobile Recharge',
        //   style: TextStyle(fontSize: 15, color: Colors.white),
        // ),
        // leading: const Icon(Icons.arrow_back, color: Colors.white, size: 15),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            child: Column(
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.red.shade100,
                      child: Text(
                        widget.operator.substring(0, 2),
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                    SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.operator,
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                        Text(
                          widget.mobileNumber,
                          style: TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 16),
                TextField(
                  controller: amountController,
                  decoration: InputDecoration(
                    hintText: 'Enter Amount for Search',
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Row(
          //   mainAxisAlignment: MainAxisAlignment,..spaceEvenly,
          //   children: ['Unlimited', 'Topup', 'Yearly Plan'].map((label) {
          //     return ChoiceChip(
          //       label: Text(label),
          //       selected: selectedTab == label,
          //       onSelected: (_) => setState(() => selectedTab = label),
          //       selectedColor: Colors.blue.shade100,
          //       backgroundColor: Colors.grey.shade200,
          //       labelStyle: TextStyle(
          //         color: selectedTab == label ? Colors.blue : Colors.black,
          //       ),
          //     );
          //   }).toList(),
          // ),
          // SizedBox(height: 16),
          Expanded(
            child: ListView.builder(
              itemCount: plans.length,
              itemBuilder: (_, index) {
                final plan = plans[index];

                return Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 0,
                    horizontal: 14,
                  ),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => ConfirmPlanPage(
                            mobileNumber: widget.mobileNumber,
                            operator: widget.operator,
                            selectedPlan: plan,
                          ),
                        ),
                      );
                    },
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      margin: EdgeInsets.symmetric(vertical: 6),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              plan['price']!,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              'Validity : ${plan['validity']!}',
                              style: TextStyle(color: Colors.grey[600]),
                            ),
                            SizedBox(height: 8),
                            Text(
                              plan['desc']!,
                              style: TextStyle(color: Colors.grey[800]),
                            ),
                          ],
                        ),
                      ),
                    ),
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
