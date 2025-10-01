import 'package:flutter/material.dart';
import 'package:minna/comman/const/const.dart';

class AboutUsPage extends StatelessWidget {
  const AboutUsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          'About Us',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: maincolor1,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            // Header Section
            _buildHeaderSection(),
            SizedBox(height: 24),

            // Description Card
            _buildDescriptionCard(),
            SizedBox(height: 24),

            // Services Grid
            _buildServicesSection(),
            SizedBox(height: 24),

            // Why Choose Us
            _buildWhyChooseUsSection(),
            SizedBox(height: 24),

            // Final Statement
            _buildFinalStatement(),
            SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildHeaderSection() {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [maincolor1!, maincolor1!.withOpacity(0.8)],
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: maincolor1!.withOpacity(0.3),
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          // Logo placeholder
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 8,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Icon(
              Icons.travel_explore,
              color: maincolor1,
              size: 40,
            ),
          ),
          SizedBox(height: 16),
          Text(
            "Minna Travels and Tourism",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 8),
          Text(
            "Your Trusted Travel Companion",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              color: Colors.white.withOpacity(0.9),
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDescriptionCard() {
    return Card(
      elevation: 4,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Row(
              children: [
                Icon(Icons.flag, color: maincolor1, size: 24),
                SizedBox(width: 12),
                Text(
                  "About Minna Travels",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: maincolor1,
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            Text(
              "Minna Travels and Tourism is your trusted companion for unforgettable journeys across India and beyond. Based in Kerala, we specialize in curated travel experiences that blend comfort, culture, and adventure.",
              style: TextStyle(
                fontSize: 16,
                height: 1.6,
                color: Colors.grey[700],
              ),
            ),
            SizedBox(height: 12),
            Text(
              "Whether you're planning a family vacation, a honeymoon getaway, a business trip, or a group tour, our experienced team ensures every detail is perfectly arranged for a seamless travel experience.",
              style: TextStyle(
                fontSize: 16,
                height: 1.6,
                color: Colors.grey[700],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildServicesSection() {
    final List<Map<String, dynamic>> services = [
      {
        'icon': Icons.directions_bus,
        'title': 'Bus Booking',
        'color': Colors.blue,
        'description': 'AC & Non-AC buses across India'
      },
      {
        'icon': Icons.flight,
        'title': 'Flight Booking',
        'color': Colors.green,
        'description': 'Domestic & international flights'
      },
      {
        'icon': Icons.hotel,
        'title': 'Hotel Booking',
        'color': Colors.orange,
        'description': 'Luxury to budget stays'
      },
      {
        'icon': Icons.local_taxi,
        'title': 'Cab Services',
        'color': Colors.purple,
        'description': 'Outstation & local cabs'
      },
      {
        'icon': Icons.train,
        'title': 'Train Booking',
        'color': Colors.red,
        'description': 'IRCTC & private trains'
      },
      {
        'icon': Icons.receipt_long,
        'title': 'Bill Payments',
        'color': Colors.teal,
        'description': 'Utility bills & recharges'
      },
      {
        'icon': Icons.phone_android,
        'title': 'Mobile Recharge',
        'color': Colors.pink,
        'description': 'Prepaid & postpaid recharge'
      },
      {
        'icon': Icons.card_travel,
        'title': 'Tour Packages',
        'color': Colors.indigo,
        'description': 'Customized holiday packages'
      },
      // {
      //   'icon': Icons.verified_user,
      //   'title': 'Travel Insurance',
      //   'color': Colors.cyan,
      //   'description': 'Comprehensive travel coverage'
      // },
      // {
      //   'icon': Icons.v,
      //   'title': 'Visa Services',
      //   'color': Colors.brown,
      //   'description': 'Visa assistance & documentation'
      // },
      {
        'icon': Icons.corporate_fare,
        'title': 'Corporate Travel',
        'color': Colors.deepPurple,
        'description': 'Business travel solutions'
      },
      {
        'icon': Icons.beach_access,
        'title': 'Holiday Packages',
        'color': Colors.amber,
        'description': 'Domestic & international tours'
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.grid_view, color: maincolor1, size: 24),
            SizedBox(width: 12),
            Text(
              "Our Services",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: maincolor1,
              ),
            ),
          ],
        ),
        SizedBox(height: 16),
        GridView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 0.6,
          ),
          itemCount: services.length,
          itemBuilder: (context, index) {
            final service = services[index];
            return _buildServiceCard(
              service['icon'],
              service['title'],
              service['color'],
              service['description'],
            );
          },
        ),
      ],
    );
  }

  Widget _buildServiceCard(IconData icon, String title, Color color, String description) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.white,
        ),
        child: Padding(
          padding: EdgeInsets.all(12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  icon,
                  color: color,
                  size: 20,
                ),
              ),
              SizedBox(height: 8),
              Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[800],
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(height: 4),
              Text(
                description,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 8,
                  color: Colors.grey[600],
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildWhyChooseUsSection() {
    final List<Map<String, dynamic>> features = [
      {
        'icon': Icons.verified_user,
        'title': 'Trusted Service',
        'description': '10+ years of excellence in travel industry'
      },
      {
        'icon': Icons.support_agent,
        'title': '24/7 Support',
        'description': 'Round the clock customer support'
      },
      {
        'icon': Icons.savings,
        'title': 'Best Prices',
        'description': 'Guaranteed best deals and offers'
      },
      {
        'icon': Icons.security,
        'title': 'Secure Booking',
        'description': '100% secure and reliable bookings'
      },
    ];

    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.star, color: Colors.amber, size: 24),
                SizedBox(width: 12),
                Text(
                  "Why Choose Minna?",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: maincolor1,
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            Column(
              children: features.map((feature) => _buildFeatureItem(
                feature['icon'],
                feature['title'],
                feature['description'],
              )).toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeatureItem(IconData icon, String title, String description) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: maincolor1!.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: maincolor1,
              size: 20,
            ),
          ),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[800],
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFinalStatement() {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [maincolor1!, maincolor1!.withOpacity(0.9)],
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: maincolor1!.withOpacity(0.3),
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(
            Icons.favorite,
            color: Colors.white,
            size: 32,
          ),
          SizedBox(height: 12),
          Text(
            "Our Promise to You",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 12),
          Text(
            "At Minna Travels, we believe that every journey should be seamless and memorable. Let us take care of your travel needs while you focus on creating beautiful memories that last a lifetime.",
            style: TextStyle(
              fontSize: 16,
              color: Colors.white.withOpacity(0.9),
              height: 1.6,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 16),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              "Travel Smart. Travel Minna.",
              style: TextStyle(
                fontSize: 14,
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}