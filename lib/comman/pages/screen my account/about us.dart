import 'package:flutter/material.dart';
import 'package:minna/comman/const/const.dart';

class AboutUsPage extends StatelessWidget {
  const AboutUsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          'About Us',
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
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            // Logo
            // CircleAvatar(
            //   radius: 60,
            //   backgroundColor: Colors.white,
            //   backgroundImage: AssetImage('assets/minna_logo.png'),
            // ),
            // SizedBox(height: 16),

            // Company Name
            Text(
              "Minna Travels and Tourism",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: maincolor1,
              ),
            ),
            SizedBox(height: 10),

            // Description Card
            Card(
              elevation: 3,
              margin: EdgeInsets.only(top: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  children: [
                    Text(
                      "Minna Travels and Tourism is your trusted companion for unforgettable journeys across India and beyond. Based in Kerala, we specialize in curated travel experiences that blend comfort, culture, and adventure.",
                      style: TextStyle(fontSize: 16, height: 1.6),
                    ),
                    SizedBox(height: 12),
                    Text(
                      "Whether you're planning a family vacation, a honeymoon getaway, or a group tour, our team ensures every detail is perfectly arranged.",
                      style: TextStyle(fontSize: 16, height: 1.6),
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: 20),

            // Services
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Our Services:",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 10),

            serviceTile(
              Icons.card_travel,
              "Domestic & International Tour Packages",
            ),
            serviceTile(
              Icons.airplanemode_active,
              "Flight, Train & Bus Ticket Bookings",
            ),
            serviceTile(Icons.hotel, "Hotel Reservations"),
            serviceTile(Icons.verified_user, "Travel Insurance"),
            serviceTile(Icons.edit_location_alt, "Customized Travel Solutions"),

            SizedBox(height: 24),

            // Final Statement
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Text(
                  "At Minna, we believe that every trip should be seamless and memorable. Let us take care of your journey, while you focus on making memories.",
                  style: TextStyle(fontSize: 16, height: 1.5),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget serviceTile(IconData icon, String title) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Icon(icon, color: maincolor1),
          SizedBox(width: 10),
          Expanded(child: Text(title, style: TextStyle(fontSize: 16))),
        ],
      ),
    );
  }
}
