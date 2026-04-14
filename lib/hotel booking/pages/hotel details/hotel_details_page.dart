import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:iconsax/iconsax.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minna/comman/application/login/login_bloc.dart';
import 'package:minna/comman/pages/log%20in/login_page.dart';
import 'package:minna/comman/const/const.dart';
import 'package:minna/hotel%20booking/domain/authentication/authendication.dart';
import 'package:minna/hotel%20booking/domain/hotel%20list/hotel_list.dart';
import 'package:minna/hotel%20booking/functions/auth.dart' hide ApiResult;
import 'package:minna/hotel%20booking/functions/pre_book_store.dart';
import 'package:minna/hotel%20booking/pages/PassengerInputPage/PassengerInputPage.dart';
import 'package:url_launcher/url_launcher.dart';

// Hotel Details Page
class HotelDetailsPage extends StatefulWidget {
  final DateTime checkInDate;
  final DateTime checkOutDate;
  final List<Map<String, dynamic>> rooms;
  final HotelSearchItem hotelSearchData;
  final String guestNationalityCode;

  const HotelDetailsPage({
    super.key,
    // required this.hotel,
    required this.checkInDate,
    required this.checkOutDate,
    required this.rooms,
    required this.hotelSearchData,
    required this.guestNationalityCode,
  });

  @override
  State<HotelDetailsPage> createState() => _HotelDetailsPageState();
}

class _HotelDetailsPageState extends State<HotelDetailsPage> {
  // State Variables
  int _selectedImageIndex = 0;
  bool _isDescriptionExpanded = false;
  final int _maxDescriptionLines = 6;
  Timer? _imageSliderTimer;

  // Controllers & Keys
  final PageController _imagePageController = PageController();
  final ScrollController _scrollController = ScrollController();
  final GlobalKey _roomsSectionKey = GlobalKey();

  // Loading State
  int? _loadingRoomIndex;
  bool _isFabVisible = true;

  final AuthApiService _apiService = AuthApiService();

  @override
  void initState() {
    super.initState();
    _startImageSlider();
    _scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    _imageSliderTimer?.cancel();
    _imagePageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    if (_roomsSectionKey.currentContext != null) {
      final RenderBox box =
          _roomsSectionKey.currentContext!.findRenderObject() as RenderBox;
      final position = box.localToGlobal(Offset.zero);

      // Hide FAB when approaching bottom/rooms section
      if (position.dy < MediaQuery.of(context).size.height - 100) {
        if (_isFabVisible) setState(() => _isFabVisible = false);
      } else {
        if (!_isFabVisible) setState(() => _isFabVisible = true);
      }
    }
  }

  void _scrollToRooms() {
    final context = _roomsSectionKey.currentContext;
    if (context != null) {
      Scrollable.ensureVisible(
        context,
        duration: const Duration(milliseconds: 800),
        curve: Curves.easeInOutCubic,
        alignment: 0.1,
      );
    }
  }

  void _startImageSlider() {
    final images = widget.hotelSearchData.hotelDetails.images;
    if (images.length > 1) {
      _imageSliderTimer = Timer.periodic(const Duration(seconds: 5), (timer) {
        if (_imagePageController.hasClients) {
          final nextIndex = (_selectedImageIndex + 1) % images.length;
          _imagePageController.animateToPage(
            nextIndex,
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInOut,
          );
        }
      });
    }
  }

  void _toggleDescriptionExpansion() {
    setState(() {
      _isDescriptionExpanded = !_isDescriptionExpanded;
    });
  }

  // --- Map Functions ---
  Future<void> launchGoogleMaps(
    double lat,
    double lng,
    String hotelName,
  ) async {
    final url =
        'https://www.google.com/maps/search/?api=1&query=$lat,$lng&query_place_id=$hotelName';
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      final fallbackUrl = 'https://maps.google.com/?q=$lat,$lng';
      if (await canLaunchUrl(Uri.parse(fallbackUrl))) {
        await launchUrl(Uri.parse(fallbackUrl));
      } else {
        if (mounted) _showErrorSnackBar('Could not launch Google Maps');
      }
    }
  }

  Future<void> launchAppleMaps(double lat, double lng, String hotelName) async {
    final url =
        'https://maps.apple.com/?q=$lat,$lng&name=${Uri.encodeComponent(hotelName)}';
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      if (mounted) _showErrorSnackBar('Could not launch Apple Maps');
    }
  }

  void showMapOptions(double lat, double lng, String hotelName) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          margin: const EdgeInsets.only(top: 100),
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: cardColor,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(28),
              topRight: Radius.circular(28),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Center(
                child: Container(
                  width: 48,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Text(
                'Open Location',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: maincolor1,
                ),
              ),
              const SizedBox(height: 20),
              Container(
                decoration: BoxDecoration(
                  color: backgroundColor,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  children: [
                    ListTile(
                      leading: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: secondaryColor.withOpacity(0.1),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Iconsax.map_1,
                          color: secondaryColor,
                          size: 20,
                        ),
                      ),
                      title: const Text(
                        'Google Maps',
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                      onTap: () {
                        Navigator.pop(context);
                        launchGoogleMaps(lat, lng, hotelName);
                      },
                    ),
                    const Divider(height: 1),
                    ListTile(
                      leading: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: secondaryColor.withOpacity(0.1),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(Icons.map_outlined, color: secondaryColor),
                      ),
                      title: const Text(
                        'Apple Maps',
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                      onTap: () {
                        Navigator.pop(context);
                        launchAppleMaps(lat, lng, hotelName);
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: () => Navigator.pop(context),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: textSecondary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    side: BorderSide(color: Colors.grey.shade300),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                  child: const Text('Cancel'),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // --- UI Sections ---

  Widget buildMapSection() {
    final hotel = widget.hotelSearchData.hotelDetails;
    final parts = widget.hotelSearchData.hotelDetails.map.split('|');
    final latitude = parts.isNotEmpty ? double.tryParse(parts[0]) : null;
    final longitude = parts.length > 1 ? double.tryParse(parts[1]) : null;
    final hasCoordinates = latitude != null && longitude != null;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionHeader("Location"),
        const SizedBox(height: 12),
        GestureDetector(
          onTap: hasCoordinates
              ? () => showMapOptions(latitude, longitude, hotel.hotelName)
              : null,
          child: Container(
            decoration: BoxDecoration(
              color: cardColor,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                children: [
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          secondaryColor,
                          secondaryColor.withOpacity(0.7),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Icon(
                      Iconsax.location5,
                      color: Colors.white,
                      size: 28,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          hotel.address,
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 12,
                            color: textPrimary,
                            height: 1.4,
                          ),
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 6),
                        Text(
                          hasCoordinates
                              ? "Tap to view on map"
                              : "Location details",
                          style: TextStyle(
                            color: textLight,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (hasCoordinates)
                    Icon(
                      Icons.chevron_right_rounded,
                      color: textLight,
                      size: 24,
                    ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildImageGallery(List<String> images) {
    if (images.isEmpty) {
      images = ['https://images.unsplash.com/photo-1600585154340-be6161a56a0c'];
    }

    return Stack(
      children: [
        PageView.builder(
          controller: _imagePageController,
          onPageChanged: (index) {
            setState(() {
              _selectedImageIndex = index;
            });
          },
          itemCount: images.length,
          itemBuilder: (context, index) {
            return _buildImageWithShimmer(
              images[index],
              width: double.infinity,
              height: double.infinity,
              fit: BoxFit.cover,
            );
          },
        ),
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.black.withOpacity(0.6),
                Colors.transparent,
                Colors.transparent,
                Colors.black.withOpacity(0.3),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildImageWithShimmer(
    String imageUrl, {
    double? width,
    double? height,
    BoxFit fit = BoxFit.cover,
  }) {
    return Stack(
      children: [
        Container(width: width, height: height, color: Colors.grey[300]),
        Image.network(
          imageUrl,
          width: width,
          height: height,
          fit: fit,
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) return child;
            return Container(
              width: width,
              height: height,
              color: Colors.grey[300],
            );
          },
          errorBuilder: (context, error, stackTrace) {
            return Container(
              width: width,
              height: height,
              color: Colors.grey[300],
              child: Center(
                child: Icon(
                  Icons.broken_image_rounded,
                  color: Colors.grey[500],
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final hotelDetails = widget.hotelSearchData.hotelDetails;
    final hotelSearchDetails = widget.hotelSearchData.hotelSearchDetails;
    final fullHotelDetails = widget.hotelSearchData.hotelDetails;

    // Check if we have rooms
    final bool hasRooms = hotelSearchDetails.rooms.isNotEmpty;

    return Scaffold(
      backgroundColor: backgroundColor,
      floatingActionButton: (hasRooms && _isFabVisible)
          ? Container(
              margin: const EdgeInsets.only(bottom: 10),
              child: FloatingActionButton.extended(
                onPressed: _scrollToRooms,
                backgroundColor: maincolor1,
                foregroundColor: Colors.white,
                elevation: 10,
                highlightElevation: 12,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
                label: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 4,
                    horizontal: 4,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // 1. Price Section (Left Side)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "Start from",
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.8),
                              fontSize: 10,
                              fontWeight: FontWeight.w500,
                              letterSpacing: 0.5,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            '₹${NumberFormat('#,##0').format(widget.hotelSearchData.hotelSearchDetails.rooms[0].totalFare)}',
                            style: TextStyle(
                              color: secondaryColor, // Gold accent on price
                              fontSize: 16,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(width: 30),

                      // 2. Action Button Section (Right Side)
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 10,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white, // White pill
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Row(
                          children: [
                            Text(
                              "Select Room",
                              style: TextStyle(
                                color: maincolor1,
                                fontWeight: FontWeight.bold,
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          : null,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,

      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          // Image Header
          SliverAppBar(
            leading: IconButton(
              icon: const Icon(Iconsax.arrow_left_2, color: Colors.white),
              onPressed: () => Navigator.pop(context),
            ),
            backgroundColor: maincolor1,
            expandedHeight: 240,
            floating: false,
            pinned: true,
            title: Text(
              widget.hotelSearchData.hotelDetails.hotelName,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            centerTitle: true,
            flexibleSpace: FlexibleSpaceBar(
              collapseMode: CollapseMode.pin,
              background: _buildImageGallery(hotelDetails.images),
            ),
          ),

          // Hotel Content
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Hotel Header Info
                  Container(
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: cardColor,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          hotelDetails.hotelName,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: textPrimary,
                            height: 1.2,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(
                              Iconsax.location5,
                              size: 18,
                              color: secondaryColor,
                            ),
                            const SizedBox(width: 6),
                            Expanded(
                              child: Text(
                                hotelDetails.address,
                                style: TextStyle(
                                  color: textSecondary,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 6,
                              ),
                              decoration: BoxDecoration(
                                color: secondaryColor.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Row(
                                children: [
                                  Icon(
                                    Iconsax.star1,
                                    color: secondaryColor,
                                    size: 14,
                                  ),
                                  const SizedBox(width: 6),
                                  Text(
                                    "${hotelDetails.hotelRating} Star Hotel",
                                    style: TextStyle(
                                      color: secondaryColor,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Image Gallery List
                  if (hotelDetails.images.length > 1) ...[
                    _buildSectionHeader(
                      "Gallery Photos",
                      "${_selectedImageIndex + 1}/${hotelDetails.images.length}",
                    ),
                    const SizedBox(height: 12),
                    SizedBox(
                      height: 90,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: hotelDetails.images.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              _imagePageController.animateToPage(
                                index,
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.easeInOut,
                              );
                            },
                            child: Container(
                              margin: const EdgeInsets.only(right: 12),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                border: Border.all(
                                  color: _selectedImageIndex == index
                                      ? secondaryColor
                                      : Colors.transparent,
                                  width: 2,
                                ),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(13),
                                child: _buildImageWithShimmer(
                                  hotelDetails.images[index],
                                  width: 90,
                                  height: 90,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 24),
                  ],

                  // Check-in/Check-out
                  Row(
                    children: [
                      Expanded(
                        child: _buildInfoCard(
                          'Check-in',
                          Iconsax.login_1,
                          fullHotelDetails.checkInTime,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: _buildInfoCard(
                          'Check-out',
                          Iconsax.logout_1,
                          fullHotelDetails.checkOutTime,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),

                  // Description
                  if (fullHotelDetails.description.isNotEmpty) ...[
                    _buildSectionHeader("Description"),
                    const SizedBox(height: 12),
                    _buildDescriptionSection(fullHotelDetails.description),
                    const SizedBox(height: 24),
                  ],

                  // Facilities
                  if (fullHotelDetails.hotelFacilities.isNotEmpty) ...[
                    _buildSectionHeader("Facilities"),
                    const SizedBox(height: 12),
                    _buildFacilitiesSection(fullHotelDetails.hotelFacilities),
                    const SizedBox(height: 24),
                  ],

                  // // Nearby Attractions
                  // if (fullHotelDetails.attractions.isNotEmpty) ...[
                  //   _buildSectionHeader("Nearby Attractions"),
                  //   const SizedBox(height: 12),
                  //   _buildAttractionsSection(fullHotelDetails.attractions),
                  //   const SizedBox(height: 24),
                  // ],

                  // Contact
                  _buildSectionHeader("Contact Information"),
                  const SizedBox(height: 12),
                  _buildContactSection(),
                  const SizedBox(height: 24),

                  // Map
                  buildMapSection(),
                  const SizedBox(height: 32),

                  // --- AVAILABLE ROOMS HEADER ---
                  Container(key: _roomsSectionKey),

                  if (hasRooms) ...[
                    Row(
                      children: [
                        Icon(Icons.bedroom_parent_rounded, color: maincolor1),
                        const SizedBox(width: 8),
                        Text(
                          "Available Rooms",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: maincolor1,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "Select your preferred room",
                      style: TextStyle(color: textSecondary, fontSize: 13),
                    ),
                    const SizedBox(height: 12),
                  ],
                ],
              ),
            ),
          ),

          // Rooms List
          if (hasRooms)
            SliverList(
              delegate: SliverChildBuilderDelegate((context, index) {
                final room = hotelSearchDetails.rooms[index];
                return _buildRoomCard(room, index);
              }, childCount: hotelSearchDetails.rooms.length),
            )
          else
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Center(
                  child: Column(
                    children: [
                      const SizedBox(height: 16),
                      Text(
                        'No rooms available',
                        style: TextStyle(
                          fontSize: 16,
                          color: textSecondary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Please try different dates',
                        style: TextStyle(fontSize: 14, color: textLight),
                      ),
                    ],
                  ),
                ),
              ),
            ),

          const SliverToBoxAdapter(child: SizedBox(height: 80)),
        ],
      ),
    );
  }

  // --- Widget Builders ---

  Widget _buildSectionHeader(String title, [String? subtitle]) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
            color: textPrimary,
          ),
        ),
        if (subtitle != null)
          Text(
            subtitle,
            style: TextStyle(
              color: secondaryColor,
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
      ],
    );
  }

  Widget _buildInfoCard(String title, IconData icon, String value) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: secondaryColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(icon, color: secondaryColor, size: 14),
              ),
              const SizedBox(width: 8),
              Text(
                title,
                style: TextStyle(
                  fontSize: 14,
                  color: textSecondary,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: textPrimary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDescriptionSection(String description) {
    final cleanedDescription = _cleanDescription(description);

    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AnimatedCrossFade(
            duration: const Duration(milliseconds: 300),
            crossFadeState: _isDescriptionExpanded
                ? CrossFadeState.showSecond
                : CrossFadeState.showFirst,
            firstChild: Text(
              cleanedDescription,
              style: TextStyle(color: textSecondary, height: 1.6, fontSize: 14),
              maxLines: _maxDescriptionLines,
              overflow: TextOverflow.ellipsis,
            ),
            secondChild: Text(
              cleanedDescription,
              style: TextStyle(color: textSecondary, height: 1.6, fontSize: 14),
            ),
          ),
          const SizedBox(height: 12),
          GestureDetector(
            onTap: _toggleDescriptionExpansion,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: secondaryColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    _isDescriptionExpanded ? "Show Less" : "Show More",
                    style: TextStyle(
                      color: secondaryColor,
                      fontWeight: FontWeight.w600,
                      fontSize: 13,
                    ),
                  ),
                  const SizedBox(width: 6),
                  Icon(
                    _isDescriptionExpanded
                        ? Iconsax.arrow_up_1
                        : Iconsax.arrow_down_1,
                    color: secondaryColor,
                    size: 16,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _cleanDescription(String description) {
    return description
        .replaceAll(RegExp(r'<[^>]*>'), '')
        .replaceAll('HeadLine :', '')
        .replaceAll('Location :', '')
        .replaceAll('Rooms :', '')
        .replaceAll('Dining :', '')
        .replaceAll('CheckIn Instructions :', '')
        .replaceAll('Special Instructions :', '')
        .replaceAll(RegExp(r'[\n\r]+'), '\n')
        .replaceAll(RegExp(r'\s+\n'), '\n')
        .replaceAll(RegExp(r'\n\s+'), '\n')
        .trim();
  }

  Widget _buildFacilitiesSection(List<String> facilities) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: maincolor1.withOpacity(0.08),
            blurRadius: 30,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: Column(
        children: [
          GridView.builder(
            padding: EdgeInsets.all(0),
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: facilities.length > 8 ? 8 : facilities.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: 2.8,
            ),
            itemBuilder: (context, index) {
              final facility = facilities[index];
              return Container(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                decoration: BoxDecoration(
                  color: backgroundColor,
                  borderRadius: BorderRadius.circular(20),
                  // border: Border.all(color: borderSoft, width: 1.5),
                ),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(7),
                      decoration: BoxDecoration(
                        color: secondaryColor.withOpacity(0.12),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Icon(
                        _getFacilityIcon(facility),
                        color: secondaryColor,
                        size: 13,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        facility,
                        style: TextStyle(
                          fontSize: 9,
                          color: textPrimary,
                          fontWeight: FontWeight.w800,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
          if (facilities.length > 8) ...[
            const SizedBox(height: 24),
            GestureDetector(
              onTap: () => _showAllFacilitiesBottomSheet(facilities),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 14),
                decoration: BoxDecoration(
                  color: maincolor1.withOpacity(0.06),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Discover All ${facilities.length} Amenities",
                      style: TextStyle(
                        color: maincolor1,
                        fontSize: 14,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Icon(Iconsax.arrow_right_1, color: maincolor1, size: 16),
                  ],
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  void _showAllFacilitiesBottomSheet(List<String> facilities) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          margin: const EdgeInsets.only(top: 120),
          decoration: BoxDecoration(
            color: cardColor,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(28),
              topRight: Radius.circular(28),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: maincolor1,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(28),
                    topRight: Radius.circular(28),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "All Facilities",
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Iconsax.close_circle,
                          color: Colors.white,
                          size: 18,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: GridView.builder(
                  padding: const EdgeInsets.all(12),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    childAspectRatio: 2.8,
                  ),
                  itemCount: facilities.length,
                  itemBuilder: (context, index) {
                    final facility = facilities[index];
                    return Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      decoration: BoxDecoration(
                        color: backgroundColor,
                        borderRadius: BorderRadius.circular(12),
                        // border: Border.all(color: borderSoft),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            _getFacilityIcon(facility),
                            color: secondaryColor,
                            size: 16,
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              facility,
                              style: TextStyle(
                                fontSize: 10,
                                color: textPrimary,
                                fontWeight: FontWeight.w500,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildAttractionsSection(Map<String, String> attractions) {
    if (attractions.isEmpty) return const SizedBox.shrink();
    final attractionList = attractions.entries.toList();

    return Container(
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: maincolor1.withOpacity(0.06),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: ListView.separated(
        shrinkWrap: true,
        padding: const EdgeInsets.all(16),
        physics: const NeverScrollableScrollPhysics(),
        itemCount: attractionList.length > 5 ? 5 : attractionList.length,
        separatorBuilder: (context, index) =>
            Divider(height: 24, color: borderSoft),
        itemBuilder: (context, index) {
          final attraction = attractionList[index];
          return _buildAttractionCard(attraction.key, attraction.value);
        },
      ),
    );
  }

  Widget _buildAttractionCard(String name, String distance) {
    return Row(
      children: [
        Icon(
          name.toLowerCase().contains('airport')
              ? Iconsax.airplane
              : (name.toLowerCase().contains('park')
                    ? Iconsax.tree
                    : Iconsax.building_3),
          color: secondaryColor,
          size: 18,
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            name,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: textPrimary,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        const SizedBox(width: 12),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            distance,
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w800,
              color: textSecondary,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildContactSection() {
    final details = widget.hotelSearchData.hotelDetails;
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: maincolor1.withOpacity(0.08),
            blurRadius: 30,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: Column(
        children: [
          if (details.phoneNumber.isNotEmpty)
            _buildContactItem(Iconsax.call, details.phoneNumber),
          _buildContactItem(
            Iconsax.building_3,
            '${details.cityName}, ${details.countryName}',
          ),
          if (details.email.isNotEmpty)
            _buildContactItem(Iconsax.sms, details.email),
        ],
      ),
    );
  }

  Widget _buildContactItem(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(icon, size: 20, color: secondaryColor),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 14,
                color: textPrimary,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRoomCard(RoomDetail room, int index) {
    final isRefundable = room.isRefundable;
    final roomImages =
        widget.hotelSearchData.hotelDetails.roomDetails.length > index
        ? widget.hotelSearchData.hotelDetails.roomDetails[index].imageURL
        : [];

    final bool isLoading = _loadingRoomIndex == index;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Container(
        decoration: BoxDecoration(
          color: cardColor,
          borderRadius: BorderRadius.circular(28),
          boxShadow: [
            BoxShadow(
              color: maincolor1.withOpacity(0.06),
              blurRadius: 24,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Room Image
            if (roomImages.isNotEmpty)
              Container(
                height: 220,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(28),
                    topRight: Radius.circular(28),
                  ),
                ),
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(28),
                    topRight: Radius.circular(28),
                  ),
                  child: _buildImageWithShimmer(
                    roomImages.first,
                    width: double.infinity,
                    height: 220,
                    fit: BoxFit.cover,
                  ),
                ),
              ),

            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              room.name.isNotEmpty
                                  ? room.name[0]
                                  : 'Standard Room',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w900,
                                color: textPrimary,
                                letterSpacing: -0.5,
                              ),
                            ),
                            if (room.mealType.isNotEmpty) ...[
                              const SizedBox(height: 8),
                              Row(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 10,
                                      vertical: 5,
                                    ),
                                    decoration: BoxDecoration(
                                      color: secondaryColor.withOpacity(0.12),
                                      borderRadius: BorderRadius.circular(20),
                                      border: Border.all(
                                        color: secondaryColor.withOpacity(0.2),
                                      ),
                                    ),
                                    child: Text(
                                      room.mealType,
                                      style: TextStyle(
                                        fontSize: 10,
                                        color: secondaryColor,
                                        fontWeight: FontWeight.w800,
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                  if (isRefundable)
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 10,
                                        vertical: 8,
                                      ),
                                      decoration: BoxDecoration(
                                        color: const Color(
                                          0xFF10B981,
                                        ).withOpacity(0.12),
                                        borderRadius: BorderRadius.circular(20),
                                        border: Border.all(
                                          color: const Color(
                                            0xFF10B981,
                                          ).withOpacity(0.3),
                                        ),
                                      ),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Icon(
                                            Iconsax.tick_circle,
                                            size: 14,
                                            color: const Color(0xFF10B981),
                                          ),
                                          const SizedBox(width: 6),
                                          Text(
                                            'Refundable',
                                            style: TextStyle(
                                              fontSize: 8,
                                              color: const Color(0xFF10B981),
                                              fontWeight: FontWeight.w900,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                ],
                              ),
                            ],
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  if (widget.hotelSearchData.hotelDetails.roomDetails.length >
                      index)
                    _buildRoomSpecsGrid(index),
                  const SizedBox(height: 20),

                  _buildPriceBreakdown(room),

                  const SizedBox(height: 20),

                  SizedBox(
                    width: double.infinity,
                    height: 60,
                    child: ElevatedButton(
                      onPressed: isLoading
                          ? null
                          : () => _bookRoom(room, index),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: maincolor1,
                        foregroundColor: Colors.white,
                        disabledBackgroundColor: Colors.grey[300],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(28),
                        ),
                        elevation: 4,
                        shadowColor: maincolor1.withOpacity(0.4),
                      ),
                      child: isLoading
                          ? SizedBox(
                              width: 24,
                              height: 24,
                              child: CircularProgressIndicator(
                                strokeWidth: 3,
                                color: secondaryColor,
                              ),
                            )
                          : const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Iconsax.direct_right,
                                  size: 20,
                                  color: secondaryColor,
                                ),
                                SizedBox(width: 12),
                                Text(
                                  "Confirm Selection",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w900,
                                    letterSpacing: 0.5,
                                  ),
                                ),
                              ],
                            ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRoomSpecsGrid(int roomIndex) {
    final roomDetails = widget.hotelSearchData.hotelDetails.roomDetails;
    if (roomIndex >= roomDetails.length) return const SizedBox.shrink();

    final detail = roomDetails[roomIndex];
    return Wrap(
      spacing: 12,
      runSpacing: 8,
      children: [
        if (detail.roomSize.isNotEmpty)
          _buildSpecItem(Iconsax.maximize_4, detail.roomSize),
        _buildSpecItem(Iconsax.user, "2 Adults"), // Assuming or could dynamic
        _buildSpecItem(Iconsax.house, "Garden View"), // Placeholder for demo
      ],
    );
  }

  Widget _buildSpecItem(IconData icon, String label) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 14, color: textSecondary),
        const SizedBox(width: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 11,
            color: textSecondary,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  // UPDATED: Now shows full details (Base Fare + Taxes + Service Charge)
  Widget _buildPriceBreakdown(RoomDetail room) {
    final double totalPrice = room.totalFare;
    final int nights = _calculateNights();

    return Container(
      padding: const EdgeInsets.all(0),
      decoration: BoxDecoration(
        // color: backgroundColor,
        // borderRadius: BorderRadius.circular(24),
        // border: Border.all(color: borderSoft.withOpacity(0.8), width: 1.5),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Total Price',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: textSecondary,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    '₹${NumberFormat('#,##0').format(totalPrice)}',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w900,
                      color: maincolor1,
                      letterSpacing: -1,
                    ),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: successColor.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  '₹${NumberFormat('#,##0').format(totalPrice / (nights == 0 ? 1 : nights))} / night',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w900,
                    color: successColor,
                  ),
                ),
              ),
            ],
          ),
          // const SizedBox(height: 16),
          // _buildPriceRow('Base Fare', room.totalFare),
          // const SizedBox(height: 8),
          // _buildPriceRow('Taxes & Professional Fees', room.totalTax),
          // const SizedBox(height: 12),
          if (room.cancelPolicies.isNotEmpty)
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: secondaryColor.withOpacity(0.08),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Icon(Iconsax.info_circle, size: 14, color: secondaryColor),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      room.cancelPolicies.first.chargeType == 'No Charge'
                          ? 'Free cancellation before check-in'
                          : 'Standard cancellation policy applies',
                      style: TextStyle(
                        fontSize: 11,
                        color: textSecondary,
                        fontWeight: FontWeight.w600,
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

  Widget _buildPriceRow(String label, double amount) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: textSecondary,
            fontWeight: FontWeight.w500,
          ),
        ),
        Text(
          '₹${NumberFormat('#,##0').format(amount)}',
          style: TextStyle(
            fontSize: 12,
            color: textPrimary,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }

  int _calculateNights() {
    final days = widget.checkOutDate.difference(widget.checkInDate).inDays;
    return days == 0 ? 1 : days;
  }

  // --- Booking Logic with ROBUST ERROR HANDLING ---

  Future<void> _bookRoom(RoomDetail room, int index) async {
    // 0. Check Login Status
    final isLoggedIn = context.read<LoginBloc>().state.isLoggedIn ?? false;

    if (!isLoggedIn) {
      await showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (context) => const LoginBottomSheet(login: 1),
      );

      final newLoginState = context.read<LoginBloc>().state;
      if (newLoginState.isLoggedIn != true) return;
    }

    // 1. Set loading state for this specific button
    setState(() {
      _loadingRoomIndex = index;
    });

    try {
      // Step 1: Authenticate
      // final authResult = await _apiService.authenticate().timeout(
      //   const Duration(seconds: 15),
      //   onTimeout: () => throw TimeoutException("Authentication timed out"),
      // );

      // if (!authResult.isSuccess) {
      //   if (mounted)
      //     _showErrorSnackBar(
      //       authResult.error ?? "Authentication failed. Please login again.",
      //     );
      //   return;
      // }

      // Step 2: Check wallet balance
      // Wrap in try-catch in case balance check throws unexpected network error
      // bool hasSufficientBalance = false;
      // try {
      //   // hasSufficientBalance = await _apiService.checkSufficientBalance(
      //   //   room.totalFare,
      //   // );
      // } catch (e) {
      //   throw Exception("Failed to verify wallet balance");
      // }

      // if (!hasSufficientBalance) {
      //   if (mounted)
      //     _showErrorSnackBar("Insufficient wallet balance for this booking.");
      //   return;
      // }

      // Step 3: Pre-book room
      final preBookResult = await _apiService
          .preBookRoomWithAuth(bookingCode: room.bookingCode)
          .timeout(
            const Duration(seconds: 20),
            onTimeout: () => throw TimeoutException("Room check timed out"),
          );

      if (!preBookResult.isSuccess || preBookResult.data == null) {
        if (mounted)
          _showErrorSnackBar(
            preBookResult.error ??
                "Room is no longer available. Please select another.",
          );
        return;
      }

      // Step 4: Call Prebook Callback API
      final callbackResult = await _callPrebookCallback(
        room: room,
        preBookResponse: preBookResult.data!.preBookResponse,
      );

      if (callbackResult.isSuccess && callbackResult.data != null) {
        if (mounted) {
          _navigateToPassengerInput(
            room,
            preBookResult.data!,
            callbackResult.data!.prebookId.toString(),
          );
        }
      } else {
        if (mounted)
          _showErrorSnackBar(
            callbackResult.error ??
                "System error initiating booking. Please try again.",
          );
      }
    } on TimeoutException catch (_) {
      if (mounted)
        _showErrorSnackBar(
          "Network connection timed out. Please check your internet.",
        );
    } catch (e) {
      log("Booking Error: $e");
      if (mounted)
        _showErrorSnackBar(
          "An unexpected error occurred. Please try again later.",
        );
    } finally {
      // 2. Always turn off loading state, even if error occurred
      if (mounted) {
        setState(() {
          _loadingRoomIndex = null;
        });
      }
    }
  }

  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Iconsax.info_circle, color: Colors.white),
            const SizedBox(width: 12),
            Expanded(child: Text(message)),
          ],
        ),
        backgroundColor: Colors.red.shade700,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }

  Future<ApiResult<PrebookCallbackResponse>> _callPrebookCallback({
    required RoomDetail room,
    required PreBookResponse preBookResponse,
  }) async {
    try {
      final response = await PreBookService().callPrebookCallback(
        bookingCode: room.bookingCode,
        noOfRooms: room.name.isNotEmpty ? room.name.length : 1,
        hotelCode: widget.hotelSearchData.hotelDetails.hotelCode,
        response: preBookResponse.toJson(),
        serviceCharge: 0.0,
        amount: room.totalFare,
      );
      log(response['status'].toString());
      if (response['status'].toString() == 'true') {
        final prebookCallbackResponse = PrebookCallbackResponse.fromJson(
          response,
        );
        return ApiResult.success(prebookCallbackResponse);
      } else {
        return ApiResult.error(response['statusDesc'] ?? 'Callback API failed');
      }
    } catch (e) {
      log(e.toString());
      return ApiResult.error('Callback API error: $e');
    }
  }

  void _navigateToPassengerInput(
    RoomDetail room,
    PreBookResponseWithAuth preBookResponse,
    String prebookId,
  ) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PassengerInputPage(
          rooms: widget.rooms,
          hotel: widget.hotelSearchData,
          room: room,
          preBookResponse: preBookResponse,
          prebookId: prebookId.toString(),
          guestNationalityCode: widget.guestNationalityCode,
        ),
      ),
    );
  }

  IconData _getFacilityIcon(String facility) {
    final facilityLower = facility.toLowerCase();
    if (facilityLower.contains('wifi') || facilityLower.contains('internet'))
      return Iconsax.wifi;
    if (facilityLower.contains('pool') || facilityLower.contains('swim'))
      return Iconsax.user; // Simplified
    if (facilityLower.contains('parking')) return Iconsax.car;
    if (facilityLower.contains('restaurant') ||
        facilityLower.contains('dining'))
      return Iconsax.coffee;
    if (facilityLower.contains('gym') || facilityLower.contains('fitness'))
      return Iconsax.weight_1;
    if (facilityLower.contains('ac') || facilityLower.contains('air'))
      return Iconsax.wind_2;
    if (facilityLower.contains('bar')) return Iconsax.cup;
    return Iconsax.tick_circle;
  }
}
