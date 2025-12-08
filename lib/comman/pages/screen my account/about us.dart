import 'package:flutter/material.dart';
import 'package:minna/comman/const/const.dart';

class AboutUsPage extends StatelessWidget {
  const AboutUsPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Color Theme
    final Color primaryColor = Colors.black;
    final Color secondaryColor = Color(0xFFD4AF37);
    final Color accentColor = Color(0xFFC19B3C);
    final Color backgroundColor = Color(0xFFF8F9FA);
    final Color cardColor = Colors.white;
    final Color textPrimary = Colors.black;
    final Color textSecondary = Color(0xFF666666);
    final Color textLight = Color(0xFF999999);

    return Scaffold(
      backgroundColor: backgroundColor,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 200.0,
            collapsedHeight: 70.0,
            pinned: true,
            snap: false,
            floating: false,
            backgroundColor: primaryColor,
            elevation: 4,
            shadowColor: Colors.black.withOpacity(0.3),
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              title: Text(
                'MT Trip',
                style: TextStyle(
                  color: cardColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [primaryColor, primaryColor.withOpacity(0.9)],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Icon(
                      Icons.travel_explore_rounded,
                      size: 50,
                      color: secondaryColor,
                    ),
                   SizedBox(height: 60,)
                  ],
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(13),
              child: Column(
                children: [
                  // Description Card
                  _buildDescriptionCard(cardColor, secondaryColor, textPrimary, textSecondary),
                  SizedBox(height: 24),

                  // Services Grid
                  _buildServicesSection(cardColor, secondaryColor, textPrimary, textSecondary),
                  SizedBox(height: 24),

                  // Why Choose Us
                  _buildWhyChooseUsSection(cardColor, secondaryColor, textPrimary, textSecondary),
                  SizedBox(height: 24),

                  // Final Statement
                  _buildFinalStatement(secondaryColor, primaryColor, cardColor),
                  SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDescriptionCard(Color cardColor, Color secondaryColor, Color textPrimary, Color textSecondary) {
    return Container(
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(20),
        // boxShadow: [
        //   BoxShadow(
        //     color: Colors.black.withOpacity(0.08),
        //     blurRadius: 12,
        //     offset: const Offset(0, 4),
        //   ),
        // ],
        // border: Border.all(
        //   color: secondaryColor.withOpacity(0.1),
        //   width: 1,
        // ),
      ),
      child: Padding(
        padding: EdgeInsets.all(15),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: secondaryColor.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(Icons.flag_rounded, color: secondaryColor, size: 24),
                ),
                SizedBox(width: 12),
                Text(
                  "About MT Trip",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: textPrimary,
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            Text(
              "MT Trip and Tourism is your trusted companion for unforgettable journeys across India and beyond. Based in Kerala, we specialize in curated travel experiences that blend comfort, culture, and adventure.",
              style: TextStyle(
                fontSize: 16,
                height: 1.6,
                color: textSecondary,
              ),
            ),
            SizedBox(height: 12),
            Text(
              "Whether you're planning a family vacation, a honeymoon getaway, a business trip, or a group tour, our experienced team ensures every detail is perfectly arranged for a seamless travel experience.",
              style: TextStyle(
                fontSize: 16,
                height: 1.6,
                color: textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildServicesSection(Color cardColor, Color secondaryColor, Color textPrimary, Color textSecondary) {
    final List<Map<String, dynamic>> services = [
      {
        'icon': Icons.directions_bus_rounded,
        'title': 'Bus Booking',
        'description': 'AC & Non-AC buses across India'
      },
      {
        'icon': Icons.flight_rounded,
        'title': 'Flight Booking',
        'description': 'Domestic & international flights'
      },
      {
        'icon': Icons.hotel_rounded,
        'title': 'Hotel Booking',
        'description': 'Luxury to budget stays'
      },
      {
        'icon': Icons.local_taxi_rounded,
        'title': 'Cab Services',
        'description': 'Outstation & local cabs'
      },
      {
        'icon': Icons.train_rounded,
        'title': 'Train Booking',
        'description': 'IRCTC & private trains'
      },
      {
        'icon': Icons.receipt_long_rounded,
        'title': 'Bill Payments',
        'description': 'Utility bills & recharges'
      },
      {
        'icon': Icons.phone_android_rounded,
        'title': 'Mobile Recharge',
        'description': 'Prepaid & postpaid recharge'
      },
      {
        'icon': Icons.card_travel_rounded,
        'title': 'Tour Packages',
        'description': 'Customized holiday packages'
      },
      {
        'icon': Icons.corporate_fare_rounded,
        'title': 'Corporate Travel',
        'description': 'Business travel solutions'
      },
      {
        'icon': Icons.beach_access_rounded,
        'title': 'Holiday Packages',
        'description': 'Domestic & international tours'
      },
    ];

    return Container(
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(20),
        // boxShadow: [
        //   BoxShadow(
        //     color: Colors.black.withOpacity(0.08),
        //     blurRadius: 12,
        //     offset: const Offset(0, 4),
        //   ),
        // ],
        // border: Border.all(
        //   color: secondaryColor.withOpacity(0.1),
        //   width: 1,
        // ),
      ),
      child: Padding(
        padding: EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: secondaryColor.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(Icons.grid_view_rounded, color: secondaryColor, size: 24),
                ),
                SizedBox(width: 12),
                Text(
                  "Our Services",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: textPrimary,
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
                childAspectRatio: 0.5,
              ),
              itemCount: services.length,
              itemBuilder: (context, index) {
                final service = services[index];
                return _buildServiceCard(
                  service['icon'],
                  service['title'],
                  service['description'],
                  cardColor,
                  secondaryColor,
                  textPrimary,
                  textSecondary,
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildServiceCard(IconData icon, String title, String description, 
      Color cardColor, Color secondaryColor, Color textPrimary, Color textSecondary) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: cardColor,
        // border: Border.all(
        //   color: secondaryColor.withOpacity(0.1),
        //   width: 1,
        // ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],
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
                color: secondaryColor.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                color: secondaryColor,
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
                color: textPrimary,
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
                color: textSecondary,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWhyChooseUsSection(Color cardColor, Color secondaryColor, Color textPrimary, Color textSecondary) {
    final List<Map<String, dynamic>> features = [
      {
        'icon': Icons.verified_user_rounded,
        'title': 'Trusted Service',
        'description': '10+ years of excellence in travel industry'
      },
      {
        'icon': Icons.support_agent_rounded,
        'title': '24/7 Support',
        'description': 'Round the clock customer support'
      },
      {
        'icon': Icons.savings_rounded,
        'title': 'Best Prices',
        'description': 'Guaranteed best deals and offers'
      },
      {
        'icon': Icons.security_rounded,
        'title': 'Secure Booking',
        'description': '100% secure and reliable bookings'
      },
    ];

    return Container(
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border.all(
          color: secondaryColor.withOpacity(0.1),
          width: 1,
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: secondaryColor.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(Icons.star_rounded, color: secondaryColor, size: 24),
                ),
                SizedBox(width: 12),
                Text(
                  "Why Choose MT TRip?",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: textPrimary,
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
                secondaryColor,
                textPrimary,
                textSecondary,
              )).toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeatureItem(IconData icon, String title, String description, 
      Color secondaryColor, Color textPrimary, Color textSecondary) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: secondaryColor.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: secondaryColor,
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
                    color: textPrimary,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 14,
                    color: textSecondary,
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

  Widget _buildFinalStatement(Color secondaryColor, Color primaryColor, Color cardColor) {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [primaryColor, primaryColor.withOpacity(0.9)],
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 12,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(
            Icons.favorite_rounded,
            color: secondaryColor,
            size: 32,
          ),
          SizedBox(height: 12),
          Text(
            "Our Promise to You",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: cardColor,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 12),
          Text(
            "At MT Trip, we believe that every journey should be seamless and memorable. Let us take care of your travel needs while you focus on creating beautiful memories that last a lifetime.",
            style: TextStyle(
              fontSize: 16,
              color: cardColor.withOpacity(0.9),
              height: 1.6,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 16),
       
        ],
      ),
    );
  }
}