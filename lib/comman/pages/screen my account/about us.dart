import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:minna/comman/const/const.dart';

class AboutUsPage extends StatelessWidget {
  const AboutUsPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Theme Variables
    final Color _primaryColor = maincolor1;
    final Color _secondaryColor = secondaryColor;
    final Color _backgroundColor = backgroundColor;
    final Color _cardColor = cardColor;
    final Color _textPrimary = textPrimary;
    final Color _textSecondary = textSecondary;
    final Color _textLight = textLight;

    return Scaffold(
      backgroundColor: _backgroundColor,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            expandedHeight: 220.0,
            collapsedHeight: 80.0,
            pinned: true,
            backgroundColor: _primaryColor,
            elevation: 0,
            leading: IconButton(
              icon: const Icon(Iconsax.arrow_left_2, color: Colors.white),
              onPressed: () => Navigator.pop(context),
            ),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(32)),
            ),
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              title: const Text(
                'MT Trip',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 1.0,
                ),
              ),
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [_primaryColor, _primaryColor.withOpacity(0.8)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Stack(
                  children: [
                    Positioned(
                      top: -40,
                      right: -40,
                      child: Container(
                        width: 150,
                        height: 150,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white.withOpacity(0.05),
                        ),
                      ),
                    ),
                    Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.1),
                              shape: BoxShape.circle,
                              border: Border.all(color: _secondaryColor.withOpacity(0.3), width: 1),
                            ),
                            child: Icon(
                              Iconsax.global,
                              size: 56,
                              color: _secondaryColor,
                            ),
                          ),
                          const SizedBox(height: 40),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  // Description Card
                  _buildDescriptionCard(_cardColor, _secondaryColor, _textPrimary, _textSecondary),
                  const SizedBox(height: 24),

                  // Services Grid
                  _buildServicesSection(_cardColor, _secondaryColor, _textPrimary, _textSecondary),
                  const SizedBox(height: 24),

                  // Why Choose Us
                  _buildWhyChooseUsSection(_cardColor, _secondaryColor, _textPrimary, _textSecondary),
                  const SizedBox(height: 24),

                  // Final Statement
                  _buildFinalStatement(_secondaryColor, _primaryColor, _cardColor),
                  const SizedBox(height: 40),
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
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
        border: Border.all(
          color: secondaryColor.withOpacity(0.05),
          width: 1,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: secondaryColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(Iconsax.info_circle, color: secondaryColor, size: 24),
                ),
                const SizedBox(width: 16),
                Text(
                  "About MT Trip",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w900,
                    color: textPrimary,
                    letterSpacing: 0.5,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Text(
              "MT Trip and Tourism is your trusted companion for unforgettable journeys across India and beyond. Based in Kerala, we specialize in curated travel experiences that blend comfort, culture, and adventure.",
              style: TextStyle(
                fontSize: 15,
                height: 1.6,
                color: textSecondary,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              "Whether you're planning a family vacation, a honeymoon getaway, a business trip, or a group tour, our experienced team ensures every detail is perfectly arranged for a seamless travel experience.",
              style: TextStyle(
                fontSize: 15,
                height: 1.6,
                color: textSecondary,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildServicesSection(Color cardColor, Color secondaryColor, Color textPrimary, Color textSecondary) {
    final List<Map<String, dynamic>> services = [
      {'icon': Iconsax.bus, 'title': 'Bus Booking', 'description': 'AC & Non-AC'},
      {'icon': Iconsax.airplane, 'title': 'Flight Booking', 'description': 'Global & Local'},
      {'icon': Iconsax.house_2, 'title': 'Hotel Booking', 'description': 'Luxury Stays'},
      {'icon': Iconsax.car, 'title': 'Cab Services', 'description': 'Safe Travel'},
      {'icon': Iconsax.flash_1, 'title': 'Bill Payments', 'description': 'Quick & Easy'},
      {'icon': Iconsax.mobile, 'title': 'Mobile Recharge', 'description': 'Instant Refill'},
      {'icon': Iconsax.map, 'title': 'Tour Packages', 'description': 'Custom Trips'},
      {'icon': Iconsax.buildings, 'title': 'Corporate', 'description': 'Business Pro'},
      {'icon': Iconsax.sun, 'title': 'Holidays', 'description': 'Best Vacations'},
    ];

    return Container(
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
        border: Border.all(
          color: secondaryColor.withOpacity(0.05),
          width: 1,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: secondaryColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(Iconsax.category, color: secondaryColor, size: 24),
                ),
                const SizedBox(width: 16),
                Text(
                  "Our Services",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w900,
                    color: textPrimary,
                    letterSpacing: 0.5,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 0.75,
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
        borderRadius: BorderRadius.circular(16),
        color: secondaryColor.withOpacity(0.03),
        border: Border.all(
          color: secondaryColor.withOpacity(0.05),
          width: 1,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: secondaryColor,
            size: 26,
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w800,
                color: textPrimary,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            description,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 8,
              color: textSecondary,
              fontWeight: FontWeight.w500,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  Widget _buildWhyChooseUsSection(Color cardColor, Color secondaryColor, Color textPrimary, Color textSecondary) {
    final List<Map<String, dynamic>> features = [
      {
        'icon': Iconsax.verify,
        'title': 'Trusted Service',
        'description': '10+ years of excellence in travel industry'
      },
      {
        'icon': Iconsax.headphone,
        'title': '24/7 Support',
        'description': 'Round the clock customer support'
      },
      {
        'icon': Iconsax.wallet_check,
        'title': 'Best Prices',
        'description': 'Guaranteed best deals and offers'
      },
      {
        'icon': Iconsax.security_safe,
        'title': 'Secure Booking',
        'description': '100% secure and reliable bookings'
      },
    ];

    return Container(
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
        border: Border.all(
          color: secondaryColor.withOpacity(0.05),
          width: 1,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: secondaryColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(Iconsax.award, color: secondaryColor, size: 24),
                ),
                const SizedBox(width: 16),
                Text(
                  "Why Choose Us?",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w900,
                    color: textPrimary,
                    letterSpacing: 0.5,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
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
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: secondaryColor.withOpacity(0.05),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              icon,
              color: secondaryColor,
              size: 22,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                    color: textPrimary,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 13,
                    color: textSecondary,
                    height: 1.4,
                    fontWeight: FontWeight.w500,
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
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [primaryColor, primaryColor.withOpacity(0.8)],
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: primaryColor.withOpacity(0.2),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(
            Iconsax.heart5,
            color: secondaryColor,
            size: 40,
          ),
          const SizedBox(height: 20),
          Text(
            "Our Promise to You",
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w900,
              color: Colors.white,
              letterSpacing: 0.5,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          Text(
            "At MT Trip, we believe that every journey should be seamless and memorable. Let us take care of your travel needs while you focus on creating beautiful memories that last a lifetime.",
            style: TextStyle(
              fontSize: 15,
              color: Colors.white.withOpacity(0.8),
              height: 1.6,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}