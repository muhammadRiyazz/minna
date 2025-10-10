import 'package:flutter/material.dart';
import 'package:minna/comman/const/const.dart';
import 'package:minna/hotel%20booking/domain/hotel%20details%20/hotel_details.dart';
import 'package:minna/hotel%20booking/functions/hotel_details.dart';
import 'package:minna/hotel%20booking/pages/RoomAvailabilityRequestPage/RoomAvailabilityRequestPage.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HotelDetailsPage extends StatefulWidget {
  final String hotelCode;
  final String hotelName;

  const HotelDetailsPage({
    super.key,
    required this.hotelCode,
    required this.hotelName,
  });

  @override
  State<HotelDetailsPage> createState() => _HotelDetailsPageState();
}

class _HotelDetailsPageState extends State<HotelDetailsPage> {
  late Future<HotelDetailsResponse> _hotelDetailsFuture;
  final HotelDetailsApiService _apiService = HotelDetailsApiService();
  String? _selectedMainImage;
  int _selectedImageIndex = 0;
  bool _isDescriptionExpanded = false;
  final int _maxDescriptionLines = 6;
  late GoogleMapController mapController;
  final Set<Marker> markers = {};

  // Color Theme - Consistent throughout
  final Color _primaryColor = Colors.black;
  final Color _secondaryColor = Color(0xFFD4AF37); // Gold
  final Color _accentColor = Color(0xFFC19B3C); // Darker Gold
  final Color _backgroundColor = Color(0xFFF8F9FA);
  final Color _cardColor = Colors.white;
  final Color _textPrimary = Colors.black;
  final Color _textSecondary = Color(0xFF666666);
  final Color _textLight = Color(0xFF999999);

  @override
  void initState() {
    super.initState();
    _hotelDetailsFuture = _apiService.fetchHotelDetails(widget.hotelCode);
  }

  void _updateMainImage(String imageUrl, int index) {
    setState(() {
      _selectedMainImage = imageUrl;
      _selectedImageIndex = index;
    });
  }

  void _toggleDescriptionExpansion() {
    setState(() {
      _isDescriptionExpanded = !_isDescriptionExpanded;
    });
  }

  Future<void> launchGoogleMaps(double lat, double lng, String hotelName) async {
    final url = 'https://www.google.com/maps/search/?api=1&query=$lat,$lng&query_place_id=$hotelName';
    
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      final fallbackUrl = 'https://maps.google.com/?q=$lat,$lng';
      if (await canLaunchUrl(Uri.parse(fallbackUrl))) {
        await launchUrl(Uri.parse(fallbackUrl));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Could not launch Google Maps'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  Future<void> launchAppleMaps(double lat, double lng, String hotelName) async {
    final url = 'https://maps.apple.com/?q=$lat,$lng&name=${Uri.encodeComponent(hotelName)}';
    
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Could not launch Apple Maps'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  void showMapOptions(double lat, double lng, String hotelName) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          margin: EdgeInsets.only(top: 100),
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: _cardColor,
            borderRadius: BorderRadius.only(
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
              SizedBox(height: 24),
              Text(
                'Open Location',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: _primaryColor,
                ),
              ),
              SizedBox(height: 20),
              Container(
                decoration: BoxDecoration(
                  color: _backgroundColor,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  children: [
                    ListTile(
                      leading: Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: _secondaryColor.withOpacity(0.1),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(Icons.map_rounded, color: _secondaryColor),
                      ),
                      title: Text('Google Maps', style: TextStyle(fontWeight: FontWeight.w600)),
                      onTap: () {
                        Navigator.pop(context);
                        launchGoogleMaps(lat, lng, hotelName);
                      },
                    ),
                    Divider(height: 1),
                    ListTile(
                      leading: Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: _secondaryColor.withOpacity(0.1),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(Icons.map_outlined, color: _secondaryColor),
                      ),
                      title: Text('Apple Maps', style: TextStyle(fontWeight: FontWeight.w600)),
                      onTap: () {
                        Navigator.pop(context);
                        launchAppleMaps(lat, lng, hotelName);
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: () => Navigator.pop(context),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: _textSecondary,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    side: BorderSide(color: Colors.grey.shade300),
                    padding: EdgeInsets.symmetric(vertical: 14),
                  ),
                  child: Text('Cancel'),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget buildMapSection(HotelDetail hotel) {
    final parts = hotel.map.split('|');
    final latitude = parts.isNotEmpty ? double.tryParse(parts[0]) : null;
    final longitude = parts.length > 1 ? double.tryParse(parts[1]) : null;
    final hasCoordinates = latitude != null && longitude != null;

    if (!hasCoordinates) {
      return _buildLocationCard(hotel, null, null);
    }

    return _buildLocationCard(hotel, latitude, longitude);
  }

  Widget _buildLocationCard(HotelDetail hotel, double? lat, double? lng) {
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Location",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: _textPrimary,
                ),
              ),
              if (lat != null && lng != null)
                GestureDetector(
                  onTap: () => showMapOptions(lat, lng, hotel.hotelName),
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: _secondaryColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: _secondaryColor.withOpacity(0.3)),
                    ),
                    child: Row(
                      children: [
                        Text(
                          "Open Maps",
                          style: TextStyle(
                            color: _secondaryColor,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(width: 6),
                        Icon(Icons.open_in_new_rounded, size: 14, color: _secondaryColor),
                      ],
                    ),
                  ),
                ),
            ],
          ),
          SizedBox(height: 12),
          GestureDetector(
            onTap: lat != null && lng != null ? () => showMapOptions(lat, lng, hotel.hotelName) : null,
            child: Container(
              decoration: BoxDecoration(
                color: _cardColor,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Row(
                  children: [
                    Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [_secondaryColor, _accentColor],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Icon(
                        Icons.location_on_rounded,
                        color: Colors.white,
                        size: 28,
                      ),
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            hotel.address,
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 12,
                              color: _textPrimary,
                              height: 1.4,
                            ),
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(height: 6),
                          Text(
                            lat != null && lng != null ? "Tap to view on map" : "Location details",
                            style: TextStyle(
                              color: _textLight,
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 8),
                    Icon(
                      Icons.chevron_right_rounded,
                      color: _textLight,
                      size: 24,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _backgroundColor,
      body: FutureBuilder<HotelDetailsResponse>(
        future: _hotelDetailsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return _buildLoadingState();
          } else if (snapshot.hasError) {
            return _buildErrorState(snapshot.error.toString());
          } else if (!snapshot.hasData || snapshot.data!.hotelDetails.isEmpty) {
            return _buildEmptyState();
          } else {
            final hotel = snapshot.data!.hotelDetails.first;
            return _buildHotelDetails(hotel);
          }
        },
      ),
    );
  }

  Widget _buildHotelDetails(HotelDetail hotel) {
    final galleryImages = hotel.images.isNotEmpty ? hotel.images : 
        ['https://images.unsplash.com/photo-1600585154340-be6161a56a0c'];
    
    final mainImage = _selectedMainImage ?? (hotel.images.isNotEmpty ? hotel.images.first : 
        'https://images.unsplash.com/photo-1600585154340-be6161a56a0c');

    final attractions = hotel.attractions;

    return Column(
      children: [
        Expanded(
          child: CustomScrollView(
            slivers: [
              // Image Header
           SliverAppBar(
  leading: IconButton(
    icon: Icon(Icons.arrow_back_rounded, color: Colors.white),
    onPressed: () => Navigator.pop(context),
  ),
  backgroundColor: _primaryColor,
  expandedHeight: 240,
  floating: false,
  pinned: true,
  title: Text(
    widget.hotelName,
    style: TextStyle(
      color: Colors.white,
      fontSize: 16,
      fontWeight: FontWeight.w600,
    ),
  ),
  centerTitle: true,
  flexibleSpace: FlexibleSpaceBar(
    collapseMode: CollapseMode.pin, // This keeps the title bar pinned
    background: Stack(
      children: [
        _buildImageWithShimmer(
          mainImage,
          width: double.infinity,
          height: 280,
          fit: BoxFit.cover,
        ),
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
             end : Alignment.bottomCenter,
             begin : Alignment.topCenter,
              colors: [
                Colors.black.withOpacity(0.6),
                Colors.transparent,
                Colors.transparent,
              ],
            ),
          ),
        ),
      ],
    ),
  ),
),
              // Hotel Content
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15,vertical: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Hotel Header Info
                      Container(
                        padding: EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          color: _cardColor,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.05),
                              blurRadius: 10,
                              offset: Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              hotel.hotelName,
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: _textPrimary,
                                height: 1.2,
                              ),
                            ),
                            SizedBox(height: 12),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Icon(Icons.location_on_rounded, size: 18, color: _secondaryColor),
                                SizedBox(width: 6),
                                Expanded(
                                  child: Text(
                                    hotel.address,
                                    style: TextStyle(
                                      color: _textSecondary,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 8),
                            Row(
                              children: [
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                  decoration: BoxDecoration(
                                    color: _secondaryColor.withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Row(
                                    children: [
                                      Icon(Icons.star_rounded, color: _secondaryColor, size: 14),
                                      SizedBox(width: 6),
                                      Text(
                                        "${hotel.hotelRating} Star Hotel",
                                        style: TextStyle(
                                          color: _secondaryColor,
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
                      SizedBox(height: 24),

                      // Image Gallery
                      if (galleryImages.length > 1) ...[
                        _buildSectionHeader("Gallery Photos", "${_selectedImageIndex + 1}/${galleryImages.length}"),
                        SizedBox(height: 12),
                        SizedBox(
                          height: 90,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: galleryImages.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () => _updateMainImage(galleryImages[index], index),
                                child: Container(
                                  margin: EdgeInsets.only(right: 12),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(16),
                                    border: Border.all(
                                      color: _selectedImageIndex == index 
                                          ? _secondaryColor
                                          : Colors.transparent,
                                      width: 2,
                                    ),
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(13),
                                    child: _buildImageWithShimmer(
                                      galleryImages[index],
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
                        SizedBox(height: 24),
                      ],

                      // Check-in/Check-out
                      Row(
                        children: [
                          Expanded(child: _buildInfoCard('Check-in', Icons.login_rounded, hotel.checkInTime)),
                          SizedBox(width: 10),
                          Expanded(child: _buildInfoCard('Check-out', Icons.logout_rounded, hotel.checkOutTime)),
                        ],
                      ),
                      SizedBox(height: 24),

                      // Description
                      if (hotel.description.isNotEmpty) ...[
                        _buildSectionHeader("Description"),
                        SizedBox(height: 12),
                        _buildDescriptionSection(hotel.description),
                        SizedBox(height: 24),
                      ],

                      // Facilities
                      if (hotel.hotelFacilities.isNotEmpty) ...[
                        _buildSectionHeader("Facilities"),
                        SizedBox(height: 12),
                        _buildFacilitiesSection(hotel.hotelFacilities),
                        SizedBox(height: 24),
                      ],

                      // Nearby Attractions
                      if (attractions.isNotEmpty) ...[
                        _buildSectionHeader("Nearby Attractions"),
                        SizedBox(height: 12),
                        _buildAttractionsSection(attractions),
                        SizedBox(height: 24),
                      ],

                      // Contact Information
                      _buildSectionHeader("Contact Information"),
                      SizedBox(height: 12),
                      _buildContactSection(hotel),
                      SizedBox(height: 24),

                      // Location
                      buildMapSection(hotel),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),

        // Check Availability Button
        Container(
          padding: EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: _cardColor,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 10,
                offset: Offset(0, -2),
              ),
            ],
          ),
          child: SizedBox(
            width: double.infinity,
            height: 56,
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => RoomAvailabilityRequestPage(hotel: hotel),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: _primaryColor,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                elevation: 2,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.search_rounded, size: 20),
                  SizedBox(width: 12),
                  Text(
                    "Check Room Availability",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSectionHeader(String title, [String? subtitle]) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
            color: _textPrimary,
          ),
        ),
        if (subtitle != null)
          Text(
            subtitle,
            style: TextStyle(
              color: _secondaryColor,
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
      ],
    );
  }

  Widget _buildInfoCard(String title, IconData icon, String value) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _cardColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: _secondaryColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(icon, color: _secondaryColor, size: 14),
              ),
              SizedBox(width: 8),
              Text(
                title,
                style: TextStyle(
                  fontSize: 14,
                  color: _textSecondary,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          SizedBox(height: 8),
          Text(
            value,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: _textPrimary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDescriptionSection(String description) {
    final cleanedDescription = _cleanDescription(description);
    
    return Container(
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: _cardColor,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AnimatedCrossFade(
            duration: Duration(milliseconds: 300),
            crossFadeState: _isDescriptionExpanded 
                ? CrossFadeState.showSecond 
                : CrossFadeState.showFirst,
            firstChild: Text(
              cleanedDescription,
              style: TextStyle(
                color: _textSecondary,
                height: 1.6,
                fontSize: 14,
              ),
              maxLines: _maxDescriptionLines,
              overflow: TextOverflow.ellipsis,
            ),
            secondChild: Text(
              cleanedDescription,
              style: TextStyle(
                color: _textSecondary,
                height: 1.6,
                fontSize: 14,
              ),
            ),
          ),
          SizedBox(height: 12),
          GestureDetector(
            onTap: _toggleDescriptionExpansion,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: _secondaryColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    _isDescriptionExpanded ? "Show Less" : "Show More",
                    style: TextStyle(
                      color: _secondaryColor,
                      fontWeight: FontWeight.w600,
                      fontSize: 13,
                    ),
                  ),
                  SizedBox(width: 6),
                  Icon(
                    _isDescriptionExpanded 
                        ? Icons.keyboard_arrow_up_rounded 
                        : Icons.keyboard_arrow_down_rounded,
                    color: _secondaryColor,
                    size: 18,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFacilitiesSection(List<String> facilities) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 15),
      decoration: BoxDecoration(
        color: _cardColor,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Wrap(alignment: WrapAlignment.start,
            spacing: 12,
            runSpacing: 12,
            children: facilities.take(8).map((facility) {
              return Container(
                padding: EdgeInsets.symmetric(horizontal: 0, vertical: 8),
                decoration: BoxDecoration(
                  color: _secondaryColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Row(
                    
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        _getFacilityIcon(facility),
                        color: _secondaryColor,
                        size: 16,
                      ),
                      SizedBox(width: 6),
                      Text(
                        facility,
                        style: TextStyle(
                          fontSize: 12,
                          color: _textPrimary,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
          if (facilities.length > 8) ...[
            SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: GestureDetector(
                onTap: () => _showAllFacilitiesBottomSheet(facilities),
                child: Container(
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: _primaryColor.withOpacity(0.05),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: _primaryColor.withOpacity(0.2)),
                  ),
                  child: Center(
                    child: Text(
                      "+ ${facilities.length - 8} more facilities",
                      style: TextStyle(
                        color: _primaryColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildAttractionsSection(List<String> attractions) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: _cardColor,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          GridView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 3,
            ),
            itemCount: attractions.length > 6 ? 6 : attractions.length,
            itemBuilder: (context, index) {
              return _buildAttractionCard(attractions[index]);
            },
          ),
          if (attractions.length > 6) ...[
            SizedBox(height: 12),
            GestureDetector(
              onTap: () => _showAllAttractionsBottomSheet(attractions),
              child: Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: _primaryColor.withOpacity(0.05),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: _primaryColor.withOpacity(0.2)),
                ),
                child: Center(
                  child: Text(
                    "+ ${attractions.length - 6} more attractions",
                    style: TextStyle(
                      color: _primaryColor,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 12,)
          ],
        ],
      ),
    );
  }

  Widget _buildAttractionCard(String attraction) {
    return Container(
      decoration: BoxDecoration(
        color: _backgroundColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        child: Row(
          children: [
            Container(
              // width: 28,
              // height: 38,
              decoration: BoxDecoration(
                color: _secondaryColor,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: Icon(
                    Icons.place_rounded,
                    color: Colors.white,
                    size: 16,
                  ),
                ),
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: Text(
                attraction,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: _textPrimary,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContactSection(HotelDetail hotel) {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: _cardColor,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          if (hotel.phoneNumber.isNotEmpty)
            _buildContactItem(Icons.phone_rounded, hotel.phoneNumber),
          if (hotel.faxNumber.isNotEmpty)
            _buildContactItem(Icons.fax_rounded, hotel.faxNumber),
          _buildContactItem(Icons.location_city_rounded, '${hotel.cityName}, ${hotel.countryName}'),
        ],
      ),
    );
  }

  Widget _buildContactItem(IconData icon, String text) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: _secondaryColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, size: 20, color: _secondaryColor),
          ),
          SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 14,
                color: _textPrimary,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // [Rest of the helper methods remain the same as your original code]
  // _buildImageWithShimmer, _cleanDescription, _showAllFacilitiesBottomSheet,
  // _showAllAttractionsBottomSheet, _getFacilityIcon, _buildLoadingState,
  // _buildShimmerHotelDetails, _buildErrorState, _buildEmptyState

  // [Include all the remaining helper methods from your original code here]
  // They will work the same way but with the updated theme colors

  Widget _buildImageWithShimmer(String imageUrl, {
    double? width,
    double? height,
    BoxFit fit = BoxFit.cover,
  }) {
    return Stack(
      children: [
        Container(
          width: width,
          height: height,
          color: Colors.grey[300],
          child: Center(
            child: Icon(
              Icons.hotel_rounded,
              size: 40,
              color: Colors.grey[400],
            ),
          ),
        ),
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
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.error_outline_rounded, color: Colors.grey[500], size: 40),
                    SizedBox(height: 8),
                    Text(
                      'Failed to load image',
                      style: TextStyle(color: Colors.grey[600], fontSize: 12),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ],
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

void _showAllFacilitiesBottomSheet(List<String> facilities) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (context) {
      return Container(
        margin: EdgeInsets.only(top: 120),
        decoration: BoxDecoration(
          color: _cardColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(28),
            topRight: Radius.circular(28),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: _primaryColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(28),
                  topRight: Radius.circular(28),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "All Facilities (${facilities.length})",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: Icon(Icons.close_rounded, color: Colors.white),
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(24),
                child: Wrap(
                  spacing: 12,
                  runSpacing: 12,
                  children: facilities.map((facility) {
                    return Container(
                      constraints: BoxConstraints(
                        minWidth: 100,
                        maxWidth: MediaQuery.of(context).size.width * 0.8,
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                      decoration: BoxDecoration(
                        color: _secondaryColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(_getFacilityIcon(facility), color: _secondaryColor, size: 16),
                          SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              facility,
                              style: TextStyle(
                                color: _textPrimary,
                                fontWeight: FontWeight.w500,
                              ),
                              maxLines: 2, // Allow up to 2 lines
                              overflow: TextOverflow.ellipsis, // Show ellipsis if still too long
                              softWrap: true, // Enable text wrapping
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
          ],
        ),
      );
    },
  );
}
  void _showAllAttractionsBottomSheet(List<String> attractions) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          margin: EdgeInsets.only(top: 100),
          decoration: BoxDecoration(
            color: _cardColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(28),
              topRight: Radius.circular(28),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: _primaryColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(28),
                    topRight: Radius.circular(28),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Nearby Attractions (${attractions.length})",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: Icon(Icons.close_rounded, color: Colors.white),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListView.builder(
                  padding: EdgeInsets.all(15),
                  itemCount: attractions.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: EdgeInsets.only(bottom: 12),
                      child: _buildAttractionCard(attractions[index]),
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

  IconData _getFacilityIcon(String facility) {
    final facilityLower = facility.toLowerCase();
    
    if (facilityLower.contains('wifi') || facilityLower.contains('internet')) {
      return Icons.wifi_rounded;
    } else if (facilityLower.contains('pool') || facilityLower.contains('swim')) {
      return Icons.pool_rounded;
    } else if (facilityLower.contains('parking') || facilityLower.contains('car')) {
      return Icons.local_parking_rounded;
    } else if (facilityLower.contains('restaurant') || facilityLower.contains('dining')) {
      return Icons.restaurant_rounded;
    } else if (facilityLower.contains('gym') || facilityLower.contains('fitness')) {
      return Icons.fitness_center_rounded;
    } else if (facilityLower.contains('spa') || facilityLower.contains('massage')) {
      return Icons.spa_rounded;
    } else if (facilityLower.contains('bar') || facilityLower.contains('lounge')) {
      return Icons.local_bar_rounded;
    } else if (facilityLower.contains('room service') || facilityLower.contains('service')) {
      return Icons.room_service_rounded;
    } else if (facilityLower.contains('business') || facilityLower.contains('meeting')) {
      return Icons.business_center_rounded;
    } else if (facilityLower.contains('air conditioning') || facilityLower.contains('ac')) {
      return Icons.ac_unit_rounded;
    } else if (facilityLower.contains('elevator') || facilityLower.contains('lift')) {
      return Icons.elevator_rounded;
    } else if (facilityLower.contains('laundry') || facilityLower.contains('cleaning')) {
      return Icons.local_laundry_service_rounded;
    } else if (facilityLower.contains('tv') || facilityLower.contains('television')) {
      return Icons.tv_rounded;
    } else if (facilityLower.contains('safe') || facilityLower.contains('security')) {
      return Icons.security_rounded;
    } else if (facilityLower.contains('breakfast')) {
      return Icons.free_breakfast_rounded;
    } else if (facilityLower.contains('pet') || facilityLower.contains('animal')) {
      return Icons.pets_rounded;
    } else if (facilityLower.contains('wheelchair') || facilityLower.contains('accessible')) {
      return Icons.accessible_rounded;
    } else if (facilityLower.contains('concierge')) {
      return Icons.help_outline_rounded;
    } else if (facilityLower.contains('library')) {
      return Icons.menu_book_rounded;
    } else if (facilityLower.contains('garden') || facilityLower.contains('terrace')) {
      return Icons.nature_rounded;
    } else {
      return Icons.check_circle_outline_rounded;
    }
  }

  Widget _buildLoadingState() {
    return Scaffold(
      backgroundColor: _backgroundColor,
      appBar: AppBar(
        backgroundColor: _primaryColor,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_rounded, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          widget.hotelName,
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
      ),
      body: _buildShimmerHotelDetails(),
    );
  }

  Widget _buildShimmerHotelDetails() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(24),
      child: Column(
        children: [
          Container(
            height: 240,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          SizedBox(height: 24),
          Container(
            height: 120,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          SizedBox(height: 24),
          Row(
            children: [
              Expanded(
                child: Container(
                  height: 100,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: Container(
                  height: 100,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildErrorState(String error) {
    return Scaffold(
      backgroundColor: _backgroundColor,
      appBar: AppBar(
        backgroundColor: _primaryColor,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_rounded, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          widget.hotelName,
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(24),
          child: Container(
            padding: EdgeInsets.all(32),
            decoration: BoxDecoration(
              color: _cardColor,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    color: Colors.red.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.error_outline_rounded,
                    size: 40,
                    color: Colors.red,
                  ),
                ),
                SizedBox(height: 16),
                Text(
                  'Failed to Load Hotel Details',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: _textPrimary,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  error,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: _textSecondary),
                ),
                SizedBox(height: 20),
                Container(
                  width: 140,
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _hotelDetailsFuture = _apiService.fetchHotelDetails(widget.hotelCode);
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _primaryColor,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      padding: EdgeInsets.symmetric(vertical: 12),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.refresh_rounded, size: 18),
                        SizedBox(width: 8),
                        Text('Try Again'),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Scaffold(
      backgroundColor: _backgroundColor,
      appBar: AppBar(
        backgroundColor: _primaryColor,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_rounded, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          widget.hotelName,
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(24),
          child: Container(
            padding: EdgeInsets.all(32),
            decoration: BoxDecoration(
              color: _cardColor,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    color: _secondaryColor.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.hotel_rounded,
                    size: 50,
                    color: _secondaryColor,
                  ),
                ),
                SizedBox(height: 16),
                Text(
                  'No Hotel Details Found',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: _textPrimary,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Sorry, we couldn\'t find details for this hotel.',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: _textSecondary),
                ),
                SizedBox(height: 20),
                Container(
                  width: 120,
                  child: ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _primaryColor,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      padding: EdgeInsets.symmetric(vertical: 12),
                    ),
                    child: Text('Go Back'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}