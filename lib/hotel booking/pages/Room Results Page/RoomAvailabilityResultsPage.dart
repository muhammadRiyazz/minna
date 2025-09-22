import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:minna/comman/const/const.dart';
import 'package:minna/hotel%20booking/pages/PassengerInputPage/PassengerInputPage.dart';

class RoomAvailabilityResultsPage extends StatelessWidget {
  final DateTime checkInDate;
  final DateTime checkOutDate;
  final List<Map<String, dynamic>> rooms;
  final String nationality;

  const RoomAvailabilityResultsPage({
    super.key,
    required this.checkInDate,
    required this.checkOutDate,
    required this.rooms,
    required this.nationality,
  });

  @override
  Widget build(BuildContext context) {
    // Calculate nights
    final nights = checkOutDate.difference(checkInDate).inDays;

    // Dummy data - replace with your API response
    final roomResults = [
      {
        "Name": ["Room, 2 Queen Beds (Ocean)"],
        "BookingCode":
            "1279415!TB!2!TB!85d362b3-fbbf-11ee-b528-966483a6018a!TB!AFF!",
        "Inclusion": "Free valet parking, Free self parking",
        "DayRates": [
          [
            {"BasePrice": 566.10},
          ],
          [
            {"BasePrice": 566.10},
          ],
        ],
        "TotalFare": 2773.84,
        "TotalTax": 509.44,
        "RoomPromotion": ["Free waterpark access for 2 per day"],
        "CancelPolicies": [
          {
            "Index": "1",
            "FromDate": "15-04-2024 00:00:00",
            "ChargeType": "Percentage",
            "CancellationCharge": 100,
          },
        ],
        "MealType": "Room_Only",
        "IsRefundable": false,
        "Supplements": [
          {
            "Index": 1,
            "Type": "AtProperty",
            "Description": "mandatory_tax",
            "Price": 40,
            "Currency": "₹",
          },
        ],
        "WithTransfers": false,
      },
      {
        "Name": ["Room, 2 Queen Beds (Ocean)"],
        "BookingCode":
            "1279415!TB!2!TB!85d362b3-fbbf-11ee-b528-966483a6018a!TB!AFF!",
        "Inclusion": "Free valet parking, Free self parking",
        "DayRates": [
          [
            {"BasePrice": 566.10},
          ],
          [
            {"BasePrice": 566.10},
          ],
        ],
        "TotalFare": 2773.84,
        "TotalTax": 509.44,
        "RoomPromotion": ["Free waterpark access for 2 per day"],
        "CancelPolicies": [
          {
            "Index": "1",
            "FromDate": "15-04-2024 00:00:00",
            "ChargeType": "Percentage",
            "CancellationCharge": 100,
          },
        ],
        "MealType": "Room_Only",
        "IsRefundable": false,
        "Supplements": [
          {
            "Index": 1,
            "Type": "AtProperty",
            "Description": "mandatory_tax",
            "Price": 40,
            "Currency": "₹",
          },
        ],
        "WithTransfers": false,
      },
      {
        "Name": ["Room, 1 King Bed (Palm)"],
        "BookingCode":
            "1279415!TB!1!TB!85d362b3-fbbf-11ee-b528-966483a6018a!TB!AFF!",
        "Inclusion": "Free valet parking, Free self parking",
        "DayRates": [
          [
            {"BasePrice": 534.24},
          ],
          [
            {"BasePrice": 534.24},
          ],
        ],
        "TotalFare": 2617.84,
        "TotalTax": 480.88,
        "RoomPromotion": ["Free waterpark access for 2 per day"],
        "CancelPolicies": [
          {
            "Index": "1",
            "FromDate": "15-04-2024 00:00:00",
            "ChargeType": "Percentage",
            "CancellationCharge": 100,
          },
        ],
        "MealType": "Room_Only",
        "IsRefundable": false,
        "Supplements": [
          {
            "Index": 1,
            "Type": "AtProperty",
            "Description": "mandatory_tax",
            "Price": 40,
            "Currency": "₹",
          },
        ],
        "WithTransfers": false,
      },
      {
        "Name": ["Room, 2 Queen Beds (Ocean)"],
        "BookingCode":
            "1279415!TB!2!TB!85d362b3-fbbf-11ee-b528-966483a6018a!TB!AFF!",
        "Inclusion": "Free valet parking, Free self parking",
        "DayRates": [
          [
            {"BasePrice": 566.10},
          ],
          [
            {"BasePrice": 566.10},
          ],
        ],
        "TotalFare": 2773.84,
        "TotalTax": 509.44,
        "RoomPromotion": ["Free waterpark access for 2 per day"],
        "CancelPolicies": [
          {
            "Index": "1",
            "FromDate": "15-04-2024 00:00:00",
            "ChargeType": "Percentage",
            "CancellationCharge": 100,
          },
        ],
        "MealType": "Room_Only",
        "IsRefundable": false,
        "Supplements": [
          {
            "Index": 1,
            "Type": "AtProperty",
            "Description": "mandatory_tax",
            "Price": 40,
            "Currency": "₹",
          },
        ],
        "WithTransfers": false,
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Available Rooms'),
        centerTitle: true,
        backgroundColor: maincolor1,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.only(bottom: 16),
              itemCount: roomResults.length,
              itemBuilder: (context, index) {
                return _buildRoomCard(context, roomResults[index], nights);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRoomCard(
    BuildContext context,
    Map<String, dynamic> room,
    int nights,
  ) {
    final currencyFormat = NumberFormat.currency(
      symbol: '₹ ',
      decimalDigits: 2,
    );
    final isRefundable = room['IsRefundable'] as bool;
    final totalFare = room['TotalFare'] as double;
    final avgNightlyRate = totalFare / nights;

    return Card(
      margin: const EdgeInsets.fromLTRB(10, 8, 10, 8),
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Room Type and Image
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    'https://images.unsplash.com/photo-1582719478250-c89cae4dc85b',
                    width: 100,
                    height: 80,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        room['Name'][0],
                        style: Theme.of(context).textTheme.titleMedium
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Icon(
                            Icons.king_bed,
                            color: Colors.grey[600],
                            size: 16,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            room['Name'][0].contains('King')
                                ? 'King Bed'
                                : 'Queen Beds',
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                          const SizedBox(width: 12),
                          Icon(
                            Icons.smoke_free,
                            color: Colors.grey[600],
                            size: 16,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            'Non-smoking',
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Room Features
            if (room['RoomPromotion'] != null) ...[
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: (room['RoomPromotion'] as List).map((promo) {
                  return Chip(
                    label: Text(promo),
                    backgroundColor: Colors.teal.withOpacity(0.1),
                    labelStyle: TextStyle(color: maincolor1, fontSize: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
                    side: BorderSide.none,
                    visualDensity: VisualDensity.compact,
                  );
                }).toList(),
              ),
              const SizedBox(height: 12),
            ],

            // Price Section
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.grey[50],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '$nights ${nights > 1 ? 'nights' : 'night'}',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      Text(
                        currencyFormat.format(avgNightlyRate),
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  const Divider(height: 1),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Total for stay',
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        currencyFormat.format(totalFare),
                        style: Theme.of(context).textTheme.titleMedium
                            ?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: maincolor1,
                            ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Includes taxes & fees',
                    style: Theme.of(
                      context,
                    ).textTheme.bodySmall?.copyWith(color: Colors.green),
                  ),
                  //       ],
                  //     ),
                  //   ],
                  // ),
                  const SizedBox(height: 16),

                  // Cancellation Policy
                  Row(
                    children: [
                      Icon(
                        isRefundable
                            ? Icons.cancel_outlined
                            : Icons.do_not_disturb_on,
                        color: isRefundable ? Colors.green : Colors.red,
                        size: 16,
                      ),
                      const SizedBox(width: 8),
                      Flexible(
                        child: Text(
                          isRefundable
                              ? 'Free cancellation available'
                              : 'Non-refundable',
                          style: Theme.of(context).textTheme.bodyMedium
                              ?.copyWith(
                                color: isRefundable ? Colors.green : Colors.red,
                              ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),

                  // View Details Button
                  Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: OutlinedButton(
                          onPressed: () {
                            _showRoomDetails(context, room);
                          },
                          style: OutlinedButton.styleFrom(
                            foregroundColor: maincolor1,
                            side: BorderSide(color: maincolor1!, width: 1.5),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            elevation: 0,
                            textStyle: const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 15,
                            ),
                          ),
                          child: Text(
                            'View Details',
                            style: TextStyle(fontSize: 12),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        flex: 1,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return PassengerInputPage();
                                },
                              ),
                            );
                            // Handle booking
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: maincolor1,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            elevation: 2,
                            shadowColor: maincolor1!.withOpacity(0.3),
                            textStyle: const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                            ),
                          ),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.credit_card, size: 14),
                              SizedBox(width: 8),
                              Text('Book Now', style: TextStyle(fontSize: 12)),
                            ],
                          ),
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

  void _showRoomDetails(BuildContext context, Map<String, dynamic> room) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return _buildRoomDetailsSheet(context, room);
      },
    );
  }

  Widget _buildRoomDetailsSheet(
    BuildContext context,
    Map<String, dynamic> room,
  ) {
    final currencyFormat = NumberFormat.currency(symbol: ' ', decimalDigits: 2);
    final isRefundable = room['IsRefundable'] as bool;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Center(
            child: Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            room['Name'][0],
            style: Theme.of(
              context,
            ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(
              'https://images.unsplash.com/photo-1582719478250-c89cae4dc85b',
              height: 200,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 16),

          // Room Features
          const Text(
            'Room Features',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _buildFeatureChip(Icons.king_bed, 'King Bed'),
              _buildFeatureChip(Icons.smoke_free, 'Non-smoking'),
              _buildFeatureChip(Icons.wifi, 'Free WiFi'),
              _buildFeatureChip(Icons.ac_unit, 'Air Conditioning'),
              _buildFeatureChip(Icons.tv, 'Flat-screen TV'),
              if (room['Inclusion'] != null)
                ...room['Inclusion']
                    .toString()
                    .split(',')
                    .map((e) => _buildFeatureChip(Icons.check, e.trim()))
                    ,
            ],
          ),
          const SizedBox(height: 16),

          // Cancellation Policy
          const Text(
            'Cancellation Policy',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: isRefundable ? Colors.green[50] : Colors.red[50],
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Icon(
                  isRefundable ? Icons.check_circle : Icons.cancel,
                  color: isRefundable ? Colors.green : Colors.red,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    isRefundable
                        ? 'Free cancellation until ${DateFormat('MMM d, y').format(DateTime.now().add(const Duration(days: 3)))}'
                        : 'Non-refundable. No changes or cancellations allowed.',
                    style: TextStyle(
                      color: isRefundable ? Colors.green : Colors.red,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // Price Breakdown
          const Text(
            'Price Breakdown',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          const SizedBox(height: 8),
          Table(
            columnWidths: const {0: FlexColumnWidth(3), 1: FlexColumnWidth(1)},
            children: [
              TableRow(
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 4),
                    child: Text('Room rate'),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: Text(
                      currencyFormat.format(
                        room['TotalFare'] - room['TotalTax'],
                      ),
                      textAlign: TextAlign.end,
                    ),
                  ),
                ],
              ),
              TableRow(
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 4),
                    child: Text('Taxes & fees'),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: Text(
                      currencyFormat.format(room['TotalTax']),
                      textAlign: TextAlign.end,
                    ),
                  ),
                ],
              ),
              TableRow(
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 4),
                    child: Text(
                      'Total',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: Text(
                      currencyFormat.format(room['TotalFare']),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: maincolor1,
                      ),
                      textAlign: TextAlign.end,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 24),

          // Book Now Button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return PassengerInputPage();
                    },
                  ),
                );
                // Handle booking
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: maincolor1,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: const Text('Book Now'),
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _buildFeatureChip(IconData icon, String label) {
    return Chip(
      label: Text(label),
      avatar: Icon(icon, size: 16),
      backgroundColor: Colors.grey[100],
      labelStyle: const TextStyle(fontSize: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      side: BorderSide.none,
      visualDensity: VisualDensity.compact,
    );
  }
}
