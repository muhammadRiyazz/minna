import 'package:flutter/material.dart';
import 'package:minna/cab/pages/booking_hold/booking_hold_input.dart';
import 'package:minna/comman/const/const.dart';

class CabsListPage extends StatelessWidget {
  final List<Map<String, dynamic>> cabs = [
    {
      "cab": {
        "type": "Compact (Value)",
        "category": "Compact",
        "sClass": "Value",
        "instructions": [
          "5 years or older car",
          "CNG",
          "Car will be of any model in car category you choose",
          "24 hour cancellation policy",
        ],
        "model": "Indica, Swift, Alto, Ford Figo or equivalent",
        "image": "https://yourdomain.com/images/cabs/car-indica.jpg",
        "seatingCapacity": 4,
        "bagCapacity": 1,
        "bigBagCapaCity": 0,
        "isAssured": "0",
        "fuelType": "CNG",
      },
      "fare": {"baseFare": 4366, "gst": 218, "totalAmount": 4584},
      "distance": 10,
      "cancellationPolicy": "FLEXI",
    },
    {
      "cab": {
        "type": "Sedan (Value)",
        "category": "Sedan",
        "sClass": "Value",
        "instructions": [
          "5 years or older car",
          "CNG",
          "Car will be of any model in car category you choose",
          "24 hour cancellation policy",
        ],
        "model": "Dzire, Toyota Etios, Tata Indigo or equivalent",
        "image": "https://yourdomain.com/images/cabs/car-etios.jpg",
        "seatingCapacity": 4,
        "bagCapacity": 3,
        "bigBagCapaCity": 1,
        "isAssured": "0",
      },
      "fare": {"baseFare": 4579, "gst": 229, "totalAmount": 4808},
      "distance": 10,
      "cancellationPolicy": "FLEXI",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleTextStyle: TextStyle(color: Colors.white),
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          "Available Cabs",
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        backgroundColor: maincolor1,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(16)),
        ),
      ),
      // backgroundColor: ,
      body: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: cabs.length,
        itemBuilder: (context, index) {
          final cabData = cabs[index];
          final cab = cabData["cab"];
          final fare = cabData["fare"];

          return Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            elevation: 0,
            margin: const EdgeInsets.symmetric(vertical: 10),
            child: Padding(
              padding: const EdgeInsets.all(14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Cab Type + Fare
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Car Image
                      // ClipRRect(
                      //   borderRadius: BorderRadius.circular(12),
                      //   child: Image.network(
                      //     cab["image"],
                      //     height: 80,
                      //     width: 120,
                      //     fit: BoxFit.cover,
                      //   ),
                      // ),
                      Container(
                        decoration: BoxDecoration(color: Colors.blue.shade100),
                        height: 80,
                        width: 100,
                      ),
                      const SizedBox(width: 12),

                      // Cab Info
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              cab["category"],
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              cab["model"],
                              style: TextStyle(
                                fontSize: 13,
                                color: Colors.grey[700],
                              ),
                            ),
                            const SizedBox(height: 6),
                            Row(
                              children: [
                                Icon(
                                  Icons.event_seat,
                                  size: 18,
                                  color: maincolor1,
                                ),
                                SizedBox(width: 4),
                                Text("${cab["seatingCapacity"]} seats"),
                                SizedBox(width: 12),
                                Icon(
                                  Icons.work,
                                  size: 18,
                                  color: Colors.orange,
                                ),
                                SizedBox(width: 4),
                                Text("${cab["bagCapacity"]} bags"),
                              ],
                            ),
                          ],
                        ),
                      ),

                      // Fare
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            "₹${fare["totalAmount"]}",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: maincolor1,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            "Base: ₹${fare["baseFare"]}",
                            style: TextStyle(fontSize: 12, color: Colors.grey),
                          ),
                        ],
                      ),
                    ],
                  ),

                  const Divider(height: 20),

                  // Extra Info Row
                  Row(
                    children: [
                      Icon(
                        Icons.local_gas_station,
                        size: 16,
                        color: maincolor1,
                      ),
                      SizedBox(width: 4),
                      Text("${cab["fuelType"] ?? "Petrol"}"),
                      Spacer(),
                      Text(
                        "Policy: ${cabData["cancellationPolicy"]}",
                        style: TextStyle(color: Colors.red[700], fontSize: 12),
                      ),
                    ],
                  ),

                  const SizedBox(height: 10),

                  // Instructions
                  Wrap(
                    spacing: 6,
                    runSpacing: -6,
                    children: List.generate(
                      (cab["instructions"] as List).length,
                      (i) => Chip(
                        label: Text(
                          cab["instructions"][i],
                          style: TextStyle(fontSize: 11),
                        ),
                        backgroundColor: Colors.blue[50],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                            8,
                          ), // corner radius

                          side: BorderSide(
                            color: Colors.grey, // border color
                            width: .6, // border thickness
                          ),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 12),

                  // Book Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => BookingPage(),
                          ),
                        );

                        // TODO: Booking flow
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: maincolor1,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                      child: Text(
                        "Book Now",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
