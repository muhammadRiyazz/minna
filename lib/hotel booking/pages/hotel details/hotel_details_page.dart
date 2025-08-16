import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:minna/comman/const/const.dart';
import 'package:minna/hotel%20booking/pages/RoomAvailabilityRequestPage/RoomAvailabilityRequestPage.dart';

class HotelDetailsPage extends StatelessWidget {
  const HotelDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    const mainImage =
        'https://images.unsplash.com/photo-1600585154340-be6161a56a0c';

    final galleryImages = [
      'https://images.unsplash.com/photo-1600585154340-be6161a56a0c',
      'https://cf.bstatic.com/xdata/images/hotel/max500/714580349.jpg?k=182d09bcdad8cbd4b090c588a2cf5da2677f65ed2b48a5c8f561af867d2d2e9a&o=',
      'https://cf.bstatic.com/xdata/images/hotel/max1024x768/29857348.jpg?k=60bbf78da9e74ec073da25519c2418ba3f4caec79e14194cd82f7d2c3cdcc5c6&o=',
      'https://cf.bstatic.com/xdata/images/hotel/max300/607574115.jpg?k=6f532852baf8694592420be945c254711e95974ea36111a379d4ef0ecd7f0867&o=',
      'https://jumanji.livspace-cdn.com/magazine/wp-content/uploads/2017/07/27163531/hotel-style-bedroom-ideas-layered-bedding.png',
      'https://images.unsplash.com/photo-1600585154340-be6161a56a0c',
    ];

    const mapImage =
        'https://www.4x3.net/sites/default/files/field/image/googlemaps_b_4x3_blogpost_banner_1000x556.gif';

    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: ListView(
              children: [
                // Hotel Image Header
                Stack(
                  children: [
                    Image.network(
                      mainImage,
                      width: double.infinity,
                      height: 240,
                      fit: BoxFit.cover,
                    ),
                    Positioned(
                      top: 16,
                      left: 16,
                      child: InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: CircleAvatar(
                          backgroundColor: Colors.white,
                          child: Icon(Icons.arrow_back, color: Colors.black),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 16,
                      right: 16,
                      child: CircleAvatar(
                        backgroundColor: Colors.white,
                        child: Icon(Icons.bookmark_border, color: Colors.black),
                      ),
                    ),
                  ],
                ),

                // Hotel Info
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Royale President Hotel",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Row(
                        children: [
                          Icon(Icons.location_on, size: 16, color: maincolor1),
                          SizedBox(width: 4),
                          Text("79 Place de la Madeleine, Paris, France"),
                        ],
                      ),
                      SizedBox(height: 12),
                      // Gallery Photos
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Gallery Photos",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text("See All", style: TextStyle(color: maincolor1)),
                        ],
                      ),
                      SizedBox(height: 8),
                      SizedBox(
                        height: 80,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: galleryImages.length,
                          itemBuilder: (context, index) {
                            return Container(
                              margin: EdgeInsets.only(right: 8),
                              width: 80,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                image: DecorationImage(
                                  image: NetworkImage(galleryImages[index]),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      // SizedBox(height: 16),
                      // Details Row
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.spaceAround,
                      //   children: [
                      //     _detailIcon(Icons.hotel, 'Hotels'),
                      //     _detailIcon(Icons.bed, '4 Beds'),
                      //     _detailIcon(Icons.bathtub, '2 Bath'),
                      //     _detailIcon(Icons.square_foot, '4000 sqft'),
                      //   ],
                      // ),
                      SizedBox(height: 16),
                      // Description
                      Text(
                        "Description",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 6),
                      Text(
                        "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis aute irure dolor in reprehenderit in voluptate.",
                        style: TextStyle(color: Colors.grey[700]),
                      ),
                      SizedBox(height: 16),
                      // Facilities
                      Text(
                        "Facilities",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 8),
                      Wrap(
                        spacing: 16,
                        runSpacing: 12,
                        children: [
                          _facilityIcon(Icons.pool, 'Swimming Pool'),
                          _facilityIcon(Icons.wifi, 'WiFi'),
                          _facilityIcon(Icons.restaurant, 'Restaurant'),
                          _facilityIcon(Icons.local_parking, 'Parking'),
                          _facilityIcon(Icons.meeting_room, 'Meeting Room'),
                          _facilityIcon(Icons.elevator, 'Elevator'),
                          _facilityIcon(Icons.fitness_center, 'Fitness Center'),
                          _facilityIcon(Icons.access_time, '24-Hours Open'),
                        ],
                      ),
                      SizedBox(height: 16),
                      // Map
                      Text(
                        "Location",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 8),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(mapImage),
                      ),
                      SizedBox(height: 16),
                      // Reviews
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.star, color: Colors.amber, size: 20),
                              SizedBox(width: 4),
                              Text(
                                "4.8",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Text(
                                " (4,981 reviews)",
                                style: TextStyle(color: Colors.grey[600]),
                              ),
                            ],
                          ),
                          Text("See All", style: TextStyle(color: maincolor1)),
                        ],
                      ),
                      SizedBox(height: 8),
                      _reviewTile(
                        "Jenny Wilson",
                        "Very nice and comfortable hotel, thank you for accompanying my vacation!",
                        5,
                      ),
                      _reviewTile(
                        "Guy Hawkins",
                        "Very beautiful hotel, my family and I are very satisfied with the service!",
                        4,
                      ),
                      _reviewTile(
                        "Kristin Watson",
                        "The rooms are very comfortable and the natural views are amazing!",
                        5,
                      ),
                      SizedBox(height: 16),

                      // Bottom Price + Button
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const RoomAvailabilityRequestPage(),
                    ),
                  );
                },

                style: ElevatedButton.styleFrom(
                  backgroundColor: maincolor1,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12), // radius
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 32, vertical: 14),
                ),
                child: Text(
                  "Check Room Availability",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white, // changed text color
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _detailIcon(IconData icon, String label) {
    return Column(
      children: [
        Icon(icon, color: maincolor1),
        SizedBox(height: 4),
        Text(label, style: TextStyle(fontSize: 12)),
      ],
    );
  }

  Widget _facilityIcon(IconData icon, String label) {
    return Column(
      children: [
        Icon(icon, color: maincolor1),
        SizedBox(height: 4),
        Text(label, style: TextStyle(fontSize: 12)),
      ],
    );
  }

  Widget _reviewTile(String name, String review, int stars) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 6),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.grey.shade100,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(child: Icon(Icons.person)),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(height: 4),
                RatingBarIndicator(
                  rating: stars.toDouble(),
                  itemBuilder: (context, index) =>
                      Icon(Icons.star, color: Colors.amber),
                  itemCount: 5,
                  itemSize: 16,
                ),
                SizedBox(height: 4),
                Text(review),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
