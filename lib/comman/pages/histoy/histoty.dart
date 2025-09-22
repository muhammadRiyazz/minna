import 'package:flutter/material.dart';
import 'package:minna/comman/const/const.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  _HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  final List<Map<String, dynamic>> services = [
    {'name': 'Mobile', 'icon': Icons.phone_android},
    {'name': 'DTH', 'icon': Icons.live_tv},
    {'name': 'Electricity', 'icon': Icons.bolt},
    {'name': 'Water', 'icon': Icons.water_drop},
  ];

  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
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
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(16)),
        ),
      ),
      body: Column(
        children: [
          // Service Type Selector
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12.0),
            child: SizedBox(
              height: 70,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.symmetric(horizontal: 16),
                itemCount: services.length,
                itemBuilder: (context, index) {
                  final isSelected = index == selectedIndex;
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedIndex = index;
                      });
                    },
                    child: Container(
                      width: 100,
                      margin: EdgeInsets.symmetric(horizontal: 6),
                      decoration: BoxDecoration(
                        color: isSelected ? maincolor1 : Colors.grey[100],
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: isSelected
                            ? [
                                BoxShadow(
                                  color: maincolor1!.withOpacity(0.3),
                                  blurRadius: 8,
                                  offset: Offset(0, 4),
                                ),
                              ]
                            : null,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            services[index]['icon'],
                            color: isSelected ? Colors.white : maincolor1,
                            size: 24,
                          ),
                          SizedBox(height: 6),
                          Text(
                            services[index]['name'],
                            style: TextStyle(
                              color: isSelected ? Colors.white : Colors.black87,
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),

          // // Recent Transactions Header
          // Padding(
          //   padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
          //   child: Text(
          //     'Recent Transactions',
          //     style: TextStyle(
          //       fontSize: 16,
          //       fontWeight: FontWeight.w600,
          //       color: Colors.grey[800],
          //     ),
          //   ),
          // ),

          // Empty State - Now properly centered
          Expanded(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.history, size: 64, color: Colors.grey[400]),
                  SizedBox(height: 16),
                  Text(
                    'No ${services[selectedIndex]['name']} Transactions',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey[600],
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    'Your transactions will appear here',
                    style: TextStyle(fontSize: 14, color: Colors.grey[500]),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}


  // Widget _buildSearchGrid() {
  //   return Padding(
  //     padding: EdgeInsets.all(16),
  //     child: GridView.builder(
  //       shrinkWrap: true,
  //       physics: NeverScrollableScrollPhysics(),
  //       itemCount: filteredServices.length,
  //       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
  //         crossAxisCount: 2,
  //         crossAxisSpacing: 16,
  //         mainAxisSpacing: 16,
  //         childAspectRatio: 1,
  //       ),
  //       itemBuilder: (context, index) {
  //         final service = filteredServices[index];
  //         return GestureDetector(
  //           onTap: service['action'],
  //           child: Container(
  //             decoration: BoxDecoration(
  //               color: service['color'].withOpacity(0.1),
  //               borderRadius: BorderRadius.circular(12),
  //             ),
  //             padding: EdgeInsets.all(16),
  //             child: Column(
  //               mainAxisAlignment: MainAxisAlignment.center,
  //               children: [
  //                 Icon(service['icon'], size: 28, color: service['color']),
  //                 SizedBox(height: 10),
  //                 Text(
  //                   service['label'],
  //                   style: TextStyle(
  //                     fontSize: 14,
  //                     fontWeight: FontWeight.w500,
  //                     color: Colors.grey[800],
  //                   ),
  //                 ),
  //               ],
  //             ),
  //           ),
  //         );
  //       },
  //     ),
  //   );
  // }
  //  if (_searchController.text.isNotEmpty &&
  //               filteredServices.isNotEmpty)
  //             _buildSearchGrid(),
