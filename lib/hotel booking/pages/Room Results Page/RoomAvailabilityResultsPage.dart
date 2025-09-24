import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:minna/comman/const/const.dart';
import 'package:minna/hotel%20booking/domain/rooms/rooms.dart' show HotelRoomResult, Room;
import 'package:minna/hotel%20booking/pages/PassengerInputPage/PassengerInputPage.dart';

class RoomAvailabilityResultsPage extends StatelessWidget {
  final List<HotelRoomResult> hotelRoomResult;

  const RoomAvailabilityResultsPage({
    super.key,
    required this.hotelRoomResult,
  });

  @override
  Widget build(BuildContext context) {
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
              itemCount: hotelRoomResult.length,
              itemBuilder: (context, index) {
                final hotelResult = hotelRoomResult[index];
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ...hotelResult.rooms.map((room) => _buildRoomCard(context, room, hotelResult.currency)),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRoomCard(
    BuildContext context,
    Room room,
    String currency,
  ) {
    final currencyFormat = NumberFormat.currency(
      symbol: '₹ ',
      decimalDigits: 2,
    );
    final isRefundable = room.isRefundable;
    final totalFare = room.totalFare;
    final roomName = room.name.isNotEmpty ? room.name[0] : 'Room';

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
                  child: Container(
                   color: Colors.white,
                    width: 100,
                    height: 80,
                  child: Icon(Icons.king_bed,color: maincolor1,size: 35,),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        roomName,
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
                            roomName.contains('King') ? 'King Bed' : 'Queen Beds',
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                          // const SizedBox(width: 12),
                          // Icon(
                          //   Icons.smoke_free,
                          //   color: Colors.grey[600],
                          //   size: 16,
                          // ),
                          // const SizedBox(width: 4),
                          // Text(
                          //   'Non-smoking',
                          //   style: Theme.of(context).textTheme.bodySmall,
                          // ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Meal Type: ${room.mealType}',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: Colors.grey[600],
                            ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Room Features
            if (room.roomPromotion.isNotEmpty) ...[
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: room.roomPromotion.map((promo) {
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
                  // Text(
                  //   'Includes taxes & fees',
                  //   style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.green),
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
                            _showRoomDetails(context, room, currency);
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
                          child: const Text(
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
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: maincolor1,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            elevation: 2,
                            // ignore: deprecated_member_use
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

  void _showRoomDetails(BuildContext context, Room room, String currency) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return _buildRoomDetailsSheet(context, room, currency);
      },
    );
  }
Widget _buildRoomDetailsSheet(
  BuildContext context,
  Room room,
  String currency,
) {
  final currencyFormat = NumberFormat.currency(symbol: '₹ ', decimalDigits: 2);
  final isRefundable = room.isRefundable;
  final roomName = room.name.isNotEmpty ? room.name[0] : 'Room';

  return Container(
    padding: const EdgeInsets.all(16),
    decoration: const BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
    ),
    child: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Drag Handle
          Center(
            child: Container(
              width: 40,
              height: 4,
              margin: const EdgeInsets.only(bottom: 16),
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),

          // Room Name
          Text(
            roomName,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
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
              if (room.inclusion.isNotEmpty)
                ...room.inclusion
                    .split(',')
                    .map((e) => _buildFeatureChip(Icons.check, e.trim())),
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
                        ? 'Free cancellation available'
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

         
       // Price Breakdown Section
const Text(
  'Price Breakdown',
  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
),
const SizedBox(height: 8),

Container(
  padding: const EdgeInsets.all(12),
  decoration: BoxDecoration(
    color: Colors.grey[100],
    borderRadius: BorderRadius.circular(8),
  ),
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      // Sum of Day Rates
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text('Room rate'),
          Text(
            currencyFormat.format(
              room.dayRates.fold(
                0.0,
                (sum, days) => sum +
                    days.fold(
                      0.0,
                      (s, d) => s + (d['BasePrice'] ?? 0.0),
                    ),
              ),
            ),
          ),
        ],
      ),
      const SizedBox(height: 4),

      // Taxes
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text('Taxes & fees'),
          Text(currencyFormat.format(room.totalTax)),
        ],
      ),
      const Divider(height: 20, thickness: 1),

      // Total
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'Total',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(
            currencyFormat.format(room.totalFare),
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: maincolor1,
            ),
          ),
        ],
      ),
    ],
  ),
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
                    builder: (context) => PassengerInputPage(),
                  ),
                );
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