import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:minna/comman/const/const.dart';
import 'package:minna/comman/pages/log%20in/login_screen.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<OnboardingData> _onboardingData = [
    OnboardingData(
      title: 'Travel Without Limits',
      description:
          'Book flights, hotels, and tours seamlessly with MT TRIP. Experience premium travel at your fingertips.',
      imageUrl:
          'https://images.unsplash.com/photo-1436491865332-7a61a109cc05?q=80&w=1000',
      icon: Iconsax.airplane,
    ),
    OnboardingData(
      title: 'Luxury Hotels & Stays',
      description:
          'Experience premium comfort like never before. Discover hand-picked luxury hotels and resorts at exclusive prices.',
      imageUrl:
          'https://images.unsplash.com/photo-1590490359683-658d3d23f972?q=80&w=1000',
      icon: Iconsax.building,
    ),
    OnboardingData(
      title: 'Your Journey Starts Here',
      description:
          'Join thousands of travelers and simplify your lifestyle with our state-of-the-art booking platform.',
      imageUrl:
          'https://images.unsplash.com/photo-1469854523086-cc02fe5d8800?q=80&w=1000',
      icon: Iconsax.magic_star,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Stack(
        children: [
          // Background PageView
          PageView.builder(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                _currentPage = index;
              });
            },
            itemCount: _onboardingData.length,
            itemBuilder: (context, index) {
              return _buildPage(_onboardingData[index]);
            },
          ),

          // Top Navigation
          Positioned(
            top: MediaQuery.of(context).padding.top + 20,
            left: 24,
            right: 24,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(),
                // Skip Button
                TextButton(
                  onPressed: () => _navigateToLogin(),
                  child: Text(
                    'Skip',
                    style: TextStyle(
                      color: maincolor1,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Bottom Controls
          Positioned(
            bottom: 25,
            left: 24,
            right: 24,
            child: Column(
              children: [
                // Progress Dots
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    _onboardingData.length,
                    (index) => AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      height: 8,
                      width: _currentPage == index ? 24 : 8,
                      decoration: BoxDecoration(
                        color: _currentPage == index
                            ? maincolor1
                            : maincolor1.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                // Action Button
                SizedBox(
                  width: double.infinity,
                  height: 60,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_currentPage < _onboardingData.length - 1) {
                        _pageController.nextPage(
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.easeInOutCubic,
                        );
                      } else {
                        _navigateToLogin();
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: maincolor1,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      elevation: 8,
                      shadowColor: maincolor1.withOpacity(0.4),
                    ),
                    child: Text(
                      _currentPage == _onboardingData.length - 1
                          ? 'GET STARTED'
                          : 'NEXT',
                      style: const TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: 16,
                        letterSpacing: 1,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPage(OnboardingData data) {
    return Column(
      children: [
        // Image Header with dynamic curve
        Expanded(
          flex: 3,
          child: Stack(
            children: [
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(data.imageUrl),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.black.withOpacity(0.3),
                      Colors.transparent,

                      backgroundColor,
                    ],
                    stops: const [0.0, 0.4, 1.0],
                  ),
                ),
              ),
              // Positioned(
              //   bottom: 0,
              //   left: 0,
              //   right: 0,
              //   child: Center(
              //     child: Container(
              //       padding: const EdgeInsets.all(20),
              //       decoration: BoxDecoration(
              //         color: Colors.white,
              //         shape: BoxShape.circle,
              //         boxShadow: [
              //           BoxShadow(
              //             color: maincolor1.withOpacity(0.15),
              //             blurRadius: 20,
              //             offset: const Offset(0, 10),
              //           ),
              //         ],
              //       ),
              //       child: Icon(data.icon, color: maincolor1, size: 32),
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
        // Text Content
        Expanded(
          flex: 2,
          child: Container(
            // color: Colors.amber,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(height: 18),

                  Text(
                    data.title,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w900,
                      color: maincolor1,
                      letterSpacing: -0.5,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    data.description,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 13,
                      color: textSecondary,
                      height: 1.6,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  // const SizedBox(height: 190), // Spacer for bottom dots
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _navigateToLogin() {
    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            const LoginScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(opacity: animation, child: child);
        },
        transitionDuration: const Duration(milliseconds: 500),
      ),
    );
  }
}

class OnboardingData {
  final String title;
  final String description;
  final String imageUrl;
  final IconData icon;

  OnboardingData({
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.icon,
  });
}
