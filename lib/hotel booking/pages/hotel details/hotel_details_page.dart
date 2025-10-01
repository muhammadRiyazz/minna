
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
      // Fallback: Open in browser
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
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Open Location',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: maincolor1,
                ),
              ),
              const SizedBox(height: 16),
              ListTile(
                leading: Icon(Icons.map, color: maincolor1),
                title: Text('Google Maps'),
                onTap: () {
                  Navigator.pop(context);
                  launchGoogleMaps(lat, lng, hotelName);
                },
              ),
              ListTile(
                leading: Icon(Icons.map_outlined, color: maincolor1),
                title: Text('Apple Maps'),
                onTap: () {
                  Navigator.pop(context);
                  launchAppleMaps(lat, lng, hotelName);
                },
              ),
              const SizedBox(height: 8),
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text('Cancel', style: TextStyle(color: Colors.grey)),
              ),
            ],
          ),
        );
      },
    );
  }
// GoogleMapController? _mapController;

Widget buildMapSection(HotelDetail hotel) {
  final parts = (hotel.map).split('|');

  // Parse safely
  final latitude = parts.isNotEmpty ? double.tryParse(parts[0]) : null;
  final longitude = parts.length > 1 ? double.tryParse(parts[1]) : null;

  final hasCoordinates = latitude != null && longitude != null;
  if (!hasCoordinates) {
    // Fallback to static map
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Location", style: TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: _buildImageWithShimmer(
            'https://maps.googleapis.com/maps/api/staticmap?center=${Uri.encodeComponent(hotel.address)}&zoom=15&size=600x300&maptype=roadmap&markers=color:red%7C${Uri.encodeComponent(hotel.address)}&key=YOUR_API_KEY',
            height: 150,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  final lat = latitude;
  final lng = longitude;

  final CameraPosition initialCameraPosition = CameraPosition(
    target: LatLng(lat, lng),
    zoom: 15,
  );

  final Marker hotelMarker = Marker(
    markerId: MarkerId(hotel.hotelName),
    position: LatLng(lat, lng),
    infoWindow: InfoWindow(
      title: hotel.hotelName,
      snippet: hotel.address,
    ),
    icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
  );

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("Location", style: TextStyle(fontWeight: FontWeight.bold)),
          GestureDetector(
            onTap: () => showMapOptions(lat, lng, hotel.hotelName),
            child: Row(
              children: [
                Text(
                  "Open in Maps",
                  style: TextStyle(
                    color: maincolor1,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(width: 4),
                Icon(Icons.open_in_new, size: 16, color: maincolor1),
              ],
            ),
          ),
        ],
      ),
      const SizedBox(height: 8),
      GestureDetector(
        onTap: () => showMapOptions(lat, lng, hotel.hotelName),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: SizedBox(
            height: 150,
            width: double.infinity,
            child: GoogleMap(
              onMapCreated: (GoogleMapController controller) {
                mapController = controller; // ✅ store controller
              },
              initialCameraPosition: initialCameraPosition,
              markers: {hotelMarker},
              zoomControlsEnabled: false,
              scrollGesturesEnabled: false,
              zoomGesturesEnabled: false,
              tiltGesturesEnabled: false,
              rotateGesturesEnabled: false,
              myLocationButtonEnabled: false,
              mapToolbarEnabled: false,
            ),
          ),
        ),
      ),
      const SizedBox(height: 8),
      Text(
        hotel.address,
        style: TextStyle(fontSize: 12, color: Colors.grey[600]),
        textAlign: TextAlign.center,
      ),
      const SizedBox(height: 16),
    ],
  );
}

  // Alternative simplified version without Google Maps package
  Widget buildMapSectionSimple(HotelDetail hotel) {
   final parts = (hotel.map).split('|');

// Parse safely
final latitude = parts.isNotEmpty ? double.tryParse(parts[0]) : null;
final longitude = parts.length > 1 ? double.tryParse(parts[1]) : null;

// ✅ Check if hotel has valid coordinates
final hasCoordinates = latitude != null && longitude != null;
    if (!hasCoordinates) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Location",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Container(
            height: 150,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Colors.grey[200],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.location_on, size: 40, color: maincolor1),
                const SizedBox(height: 8),
                Text(hotel.address, textAlign: TextAlign.center),
                const SizedBox(height: 8),
                ElevatedButton.icon(
                  onPressed: () {
                    final query = Uri.encodeComponent('${hotel.hotelName} ${hotel.address}');
                    _launchMaps(query);
                  },
                  icon: Icon(Icons.map, size: 16),
                  label: Text('Open in Maps'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: maincolor1,
                    foregroundColor: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
        ],
      );
    }

    double? lat =latitude ;
    double? lng =longitude ;

    return Column(
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [
    // Header Section
    Container(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Location",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 15,
              color: Colors.grey[800],
            ),
          ),
          GestureDetector(
            onTap: () => showMapOptions(lat, lng, hotel.hotelName),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: maincolor1!.withOpacity(0.1),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: maincolor1!.withOpacity(0.3)),
              ),
              child: Row(
                children: [
                  Text(
                    "Open in Maps",
                    style: TextStyle(
                      color: maincolor1,
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(width: 6),
                  Icon(Icons.open_in_new, size: 16, color: maincolor1),
                ],
              ),
            ),
          ),
        ],
      ),
    ),
    
    const SizedBox(height: 12),
    
    // Location Card
    GestureDetector(
      onTap: () => showMapOptions(lat, lng, hotel.hotelName),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          // boxShadow: [
          //   BoxShadow(
          //     color: Colors.black.withOpacity(0.1),
          //     blurRadius: 8,
          //     offset: const Offset(0, 2),
          //   ),
          // ],
          // border: Border.all(color: Colors.grey[200]!),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              // Icon Container
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [maincolor1!, maincolor1!.withOpacity(0.8)],
                  ),
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    // BoxShadow(
                    //   color: maincolor1!.withOpacity(0.3),
                    //   blurRadius: 6,
                    //   offset: const Offset(0, 2),
                    // ),
                  ],
                ),
                child: Icon(
                  Icons.location_on_outlined,
                  color: Colors.white,
                  size: 24,
                ),
              ),
              
              const SizedBox(width: 16),
              
              // Address Text
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      hotel.address,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 13,
                        color: Colors.grey[800],
                        height: 1.4,
                      ),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "Tap to view on map",
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              
              const SizedBox(width: 8),
              
              // Chevron Icon
              Icon(
                Icons.chevron_right,
                color: Colors.grey[400],
                size: 20,
              ),
            ],
          ),
        ),
      ),
    ),
    
    const SizedBox(height: 20),
  ],
);
  }

  Future<void> _launchMaps(String query) async {
    final googleMapsUrl = 'https://www.google.com/maps/search/?api=1&query=$query';
    final appleMapsUrl = 'https://maps.apple.com/?q=$query';

    try {
      if (await canLaunchUrl(Uri.parse(googleMapsUrl))) {
        await launchUrl(Uri.parse(googleMapsUrl));
      } else if (await canLaunchUrl(Uri.parse(appleMapsUrl))) {
        await launchUrl(Uri.parse(appleMapsUrl));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Could not launch maps application'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error launching maps: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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

    // const mapImage = 'https://www.4x3.net/sites/default/files/field/image/googlemaps_b_4x3_blogpost_banner_1000x556.gif';

    // Parse attractions from the API response
    final attractions = hotel.attractions;

    return Column(
      children: [
        Expanded(
          child: ListView(
            children: [
              // Hotel Image Header
              Stack(
                children: [
                  _buildImageWithShimmer(
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
                        backgroundColor: Colors.white.withOpacity(0.9),
                        child: Icon(Icons.arrow_back, color: Colors.black),
                      ),
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
                      hotel.hotelName,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Icon(Icons.location_on, size: 16, color: maincolor1),
                        const SizedBox(width: 4),
                        Expanded(
                          child: Text(hotel.address),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Icon(Icons.star, color: Colors.amber, size: 20),
                        const SizedBox(width: 4),
                        Text(
                          hotel.hotelRating.toString(),
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          " Star Hotel",
                          style: TextStyle(color: Colors.grey[600]),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    // Gallery Photos
                    if (galleryImages.length > 1) ...[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Gallery Photos",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "${_selectedImageIndex + 1}/${galleryImages.length}",
                            style: TextStyle(color: maincolor1, fontSize: 12),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      SizedBox(
                        height: 80,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: galleryImages.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () => _updateMainImage(galleryImages[index], index),
                              child: Container(
                                margin: const EdgeInsets.only(right: 8),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                    color: _selectedImageIndex == index 
                                        ? maincolor1!
                                        : Colors.transparent,
                                    width: 2,
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(2.0),
                                  child: Container(
                                    width: 80,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(6),
                                      child: _buildImageWithShimmer(
                                        galleryImages[index],
                                        width: 80,
                                        height: 80,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 16),
                    ],

                    // Check-in/Check-out
                    Row(
                      children: [
                        Expanded(
                          child: _infoCard(
                            'Check-in',
                            Icons.login,
                            hotel.checkInTime,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: _infoCard(
                            'Check-out',
                            Icons.logout,
                            hotel.checkOutTime,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    // Description with See More/See Less functionality
                    if (hotel.description.isNotEmpty) ...[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Description",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                       Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            hotel.hotelCode,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      LayoutBuilder(
                        builder: (context, constraints) {
                          final cleanedDescription = _cleanDescription(hotel.description);
                          final textSpan = TextSpan(
                            text: cleanedDescription,
                            style: TextStyle(color: Colors.grey[700], height: 1.4),
                          );
                          
                          final textPainter = TextPainter(
                            text: textSpan,
                            maxLines: _maxDescriptionLines,
                            textDirection: TextDirection.ltr,
                          );
                          
                          textPainter.layout(maxWidth: constraints.maxWidth);
                          
                          final isTextLong = textPainter.didExceedMaxLines;
                          
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              AnimatedCrossFade(
                                duration: const Duration(milliseconds: 300),
                                crossFadeState: _isDescriptionExpanded 
                                    ? CrossFadeState.showSecond 
                                    : CrossFadeState.showFirst,
                                firstChild: Text(
                                  cleanedDescription,
                                  style: TextStyle(
                                    color: Colors.grey[700],
                                    height: 1.4,
                                  ),
                                  maxLines: _maxDescriptionLines,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                secondChild: Text(
                                  cleanedDescription,
                                  style: TextStyle(
                                    color: Colors.grey[700],
                                    height: 1.4,
                                  ),
                                ),
                              ),
                              if (isTextLong) ...[
                                const SizedBox(height: 8),
                                GestureDetector(
                                  onTap: _toggleDescriptionExpansion,
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        _isDescriptionExpanded ? "See Less" : "See More",
                                        style: TextStyle(
                                          color: maincolor1,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 14,
                                        ),
                                      ),
                                      const SizedBox(width: 4),
                                      Icon(
                                        _isDescriptionExpanded 
                                            ? Icons.keyboard_arrow_up 
                                            : Icons.keyboard_arrow_down,
                                        color: maincolor1,
                                        size: 18,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ],
                          );
                        },
                      ),
                      const SizedBox(height: 16),
                    ],

                    // Facilities
                    if (hotel.hotelFacilities.isNotEmpty) ...[
                      Text(
                        "Facilities",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      Wrap(
                        spacing: 12,
                        children: hotel.hotelFacilities.take(8).map((facility) {
                          return Chip(
                            label: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  _getFacilityIcon(facility),
                                  color: maincolor1,
                                  size: 16,
                                ),
                                const SizedBox(width: 5),
                                Text(
                                  facility,
                                  style: TextStyle(fontSize: 12),
                                ),
                              ],
                            ),
                            backgroundColor: maincolor1!.withOpacity(0.1),
                            labelStyle: TextStyle(color: maincolor1),
                            side: BorderSide.none,
                          );
                        }).toList(),
                      ),
                      if (hotel.hotelFacilities.length > 8) ...[
                        const SizedBox(height: 8),
                        GestureDetector(
                          onTap: () {
                            _showAllFacilitiesBottomSheet(hotel.hotelFacilities);
                          },
                          child: Text(
                            "+ ${hotel.hotelFacilities.length - 8} more facilities",
                            style: TextStyle(
                              color: maincolor1,
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                      const SizedBox(height: 16),
                    ],

                    // Nearby Attractions
                    if (attractions.isNotEmpty) ...[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Nearby Attractions",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          if (attractions.length > 3)
                            GestureDetector(
                              onTap: () {
                                _showAllAttractionsBottomSheet(attractions);
                              },
                              child: Text(
                                "View All",
                                style: TextStyle(
                                  color: maincolor1,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 12,
                          mainAxisSpacing: 12,
                          childAspectRatio: 3.8,
                        ),
                        itemCount: attractions.length > 6 ? 6 : attractions.length,
                        itemBuilder: (context, index) {
                          return _buildAttractionCard(attractions[index]);
                        },
                      ),
                      if (attractions.length > 6) ...[
                        const SizedBox(height: 8),
                        GestureDetector(
                          onTap: () {
                            _showAllAttractionsBottomSheet(attractions);
                          },
                          child: Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: maincolor1!.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                color: maincolor1!.withOpacity(0.3),
                                width: 1,
                              ),
                            ),
                            child: Center(
                              child: Text(
                                "+ ${attractions.length - 6} more attractions",
                                style: TextStyle(
                                  color: maincolor1,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                      const SizedBox(height: 16),
                    ],

                    // Contact Information
                    Text(
                      "Contact Information",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    _contactInfo(Icons.phone, hotel.phoneNumber),
                    _contactInfo(Icons.fax, hotel.faxNumber),
                    _contactInfo(Icons.location_on_rounded, '${hotel.cityName}, ${hotel.countryName}'),
                    const SizedBox(height: 16),
                    buildMapSectionSimple(hotel),

                    // // Map
                    // Text(
                    //   "Location",
                    //   style: TextStyle(fontWeight: FontWeight.bold),
                    // ),
                    // const SizedBox(height: 8),
                    // ClipRRect(
                    //   borderRadius: BorderRadius.circular(8),
                    //   child: _buildImageWithShimmer(
                    //     mapImage,
                    //     height: 150,
                    //     width: double.infinity,
                    //     fit: BoxFit.cover,
                    //   ),
                    // ),
                    // const SizedBox(height: 16),
                  ],
                ),
              ),
            ],
          ),
        ),
        // Book Now Button
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => RoomAvailabilityRequestPage(
                     hotel:hotel
                    ),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: maincolor1,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              ),
              child: const Text(
                "Check Room Availability",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildAttractionCard(String attraction) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 2,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        child: Row(
          children: [
            Container(
              width: 25,
              height: 25,
              decoration: BoxDecoration(
                color: maincolor1,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                Icons.location_on_outlined,
                color: Colors.white,
                size: 15,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                attraction,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey[800],
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

  Widget _buildImageWithShimmer(String imageUrl, {
    double? width,
    double? height,
    BoxFit fit = BoxFit.cover,
  }) {
    return Stack(
      children: [
        // Shimmer background
        Container(
          width: width,
          height: height,
          color: Colors.grey[300],
          child: Center(
            child: Icon(
              Icons.hotel,
              size: 40,
              color: Colors.grey[400],
            ),
          ),
        ),
        
        // Actual image
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
                    Icon(Icons.error_outline, color: Colors.grey[500], size: 40),
                    const SizedBox(height: 8),
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

  Widget _infoCard(String title, IconData icon, String value) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: Colors.grey.withOpacity(0.2), width: 1),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: maincolor1, size: 16),
                const SizedBox(width: 6),
                Text(title, style: TextStyle(fontSize: 12, color: Colors.grey[600])),
              ],
            ),
            const SizedBox(height: 6),
            Text(value, style: TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }

  Widget _contactInfo(IconData icon, String text) {
    if (text.isEmpty) return const SizedBox();
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Icon(icon, size: 16, color: maincolor1),
          const SizedBox(width: 8),
          Expanded(child: Text(text, style: TextStyle(fontSize: 14))),
        ],
      ),
    );
  }

  String _cleanDescription(String description) {
    // Remove HTML tags and clean up the description
    return description
        .replaceAll(RegExp(r'<[^>]*>'), '') // Remove HTML tags
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

  // Bottom Sheet for All Facilities
  void _showAllFacilitiesBottomSheet(List<String> facilities) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          margin: const EdgeInsets.only(top: 100),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Header
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: maincolor1,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "All Facilities (${facilities.length})",
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.close, color: Colors.white),
                    ),
                  ],
                ),
              ),
              
              // Facilities List
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: Wrap(
                    spacing: 12,
                    runSpacing: 12,
                    children: facilities.map((facility) {
                      return Chip(
                        label: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              _getFacilityIcon(facility),
                              color: maincolor1,
                              size: 16,
                            ),
                            const SizedBox(width: 6),
                            Flexible(
                              child: Text(
                                facility,
                                style: TextStyle(
                                  fontSize: 12,
                                  color: maincolor1,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                        backgroundColor: maincolor1!.withOpacity(0.1),
                        side: BorderSide.none,
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

  // Bottom Sheet for All Attractions
  void _showAllAttractionsBottomSheet(List<String> attractions) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          margin: const EdgeInsets.only(top: 100),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Header
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: maincolor1,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Nearby Attractions (${attractions.length})",
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.close, color: Colors.white),
                    ),
                  ],
                ),
              ),
              
              // Attractions List
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: attractions.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: const EdgeInsets.only(bottom: 12),
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

  // Helper method to get appropriate icons for facilities
  IconData _getFacilityIcon(String facility) {
    final facilityLower = facility.toLowerCase();
    
    if (facilityLower.contains('wifi') || facilityLower.contains('internet')) {
      return Icons.wifi;
    } else if (facilityLower.contains('pool') || facilityLower.contains('swim')) {
      return Icons.pool;
    } else if (facilityLower.contains('parking') || facilityLower.contains('car')) {
      return Icons.local_parking;
    } else if (facilityLower.contains('restaurant') || facilityLower.contains('dining')) {
      return Icons.restaurant;
    } else if (facilityLower.contains('gym') || facilityLower.contains('fitness')) {
      return Icons.fitness_center;
    } else if (facilityLower.contains('spa') || facilityLower.contains('massage')) {
      return Icons.spa;
    } else if (facilityLower.contains('bar') || facilityLower.contains('lounge')) {
      return Icons.local_bar;
    } else if (facilityLower.contains('room service') || facilityLower.contains('service')) {
      return Icons.room_service;
    } else if (facilityLower.contains('business') || facilityLower.contains('meeting')) {
      return Icons.business_center;
    } else if (facilityLower.contains('air conditioning') || facilityLower.contains('ac')) {
      return Icons.ac_unit;
    } else if (facilityLower.contains('elevator') || facilityLower.contains('lift')) {
      return Icons.elevator;
    } else if (facilityLower.contains('laundry') || facilityLower.contains('cleaning')) {
      return Icons.local_laundry_service;
    } else if (facilityLower.contains('tv') || facilityLower.contains('television')) {
      return Icons.tv;
    } else if (facilityLower.contains('safe') || facilityLower.contains('security')) {
      return Icons.security;
    } else if (facilityLower.contains('breakfast')) {
      return Icons.free_breakfast;
    } else if (facilityLower.contains('pet') || facilityLower.contains('animal')) {
      return Icons.pets;
    } else if (facilityLower.contains('wheelchair') || facilityLower.contains('accessible')) {
      return Icons.accessible;
    } else if (facilityLower.contains('concierge')) {
      return Icons.help_outline;
    } else if (facilityLower.contains('library')) {
      return Icons.menu_book;
    } else if (facilityLower.contains('garden') || facilityLower.contains('terrace')) {
      return Icons.nature;
    } else {
      return Icons.check_circle_outline;
    }
  }

  // Loading State
  Widget _buildLoadingState() {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: maincolor1,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          widget.hotelName,
          style: const TextStyle(color: Colors.white,fontSize: 15),
        ),
      ),
      body: _buildShimmerHotelDetails(),
    );
  }

  Widget _buildShimmerHotelDetails() {
    return Column(
      children: [
        // Shimmer Main Image
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: Container(
            height: 240,
            color: Colors.grey[300],
            // child: Center(
            //   child: CircularProgressIndicator(color: maincolor1),
            // ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Shimmer Title
              Container(
                width: double.infinity,
                height: 28,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              const SizedBox(height: 16),
              
              // Shimmer Location & Rating
              Container(
                width: 200,
                height: 16,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              const SizedBox(height: 16),
              
              // Shimmer Gallery
              Container(
                width: double.infinity,
                height: 80,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              const SizedBox(height: 16),
              
              // Shimmer Check-in/Check-out
              Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 80,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Container(
                      height: 80,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              
              // Shimmer Description
              Container(
                width: double.infinity,
                height: 100,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // Error State
  Widget _buildErrorState(String error) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: maincolor1,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          widget.hotelName,
          style: const TextStyle(color: Colors.white,fontSize: 15),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.error_outline,
                size: 64,
                color: Colors.red[300],
              ),
              const SizedBox(height: 16),
              const Text(
                'Failed to Load Hotel Details',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                error,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey[600]),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    _hotelDetailsFuture = _apiService.fetchHotelDetails(widget.hotelCode);
                  });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: maincolor1,
                ),
                child: const Text('Try Again'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Empty State
  Widget _buildEmptyState() {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: maincolor1,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          widget.hotelName,
          style: const TextStyle(color: Colors.white,fontSize: 15),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.hotel_outlined,
                size: 64,
                color: Colors.grey[300],
              ),
              const SizedBox(height: 16),
              const Text(
                'No Hotel Details Found',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Sorry, we couldn\'t find details for this hotel.',
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: maincolor1,
                ),
                child: const Text('Go Back',style: TextStyle(color: Colors.white),),
              ),
            ],
          ),
        ),
      ),
    );
  }
}