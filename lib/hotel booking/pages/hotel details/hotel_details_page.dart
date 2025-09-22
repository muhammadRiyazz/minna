import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:minna/comman/const/const.dart';
import 'package:minna/hotel%20booking/domain/hotel%20details%20/hotel_details.dart';
import 'package:minna/hotel%20booking/functions/hotel_details.dart';
import 'package:minna/hotel%20booking/pages/RoomAvailabilityRequestPage/RoomAvailabilityRequestPage.dart';

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

    const mapImage = 'https://www.4x3.net/sites/default/files/field/image/googlemaps_b_4x3_blogpost_banner_1000x556.gif';

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

                                decoration: BoxDecoration(                                      borderRadius: BorderRadius.circular(8),
  border: Border.all(
                                      color: _selectedImageIndex == index 
                                          ? maincolor1!
                                          : Colors.transparent,
                                      width: 1,
                                    ),),
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

                    // Description
                    if (hotel.description.isNotEmpty) ...[
                      Text(
                        "Description",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        _cleanDescription(hotel.description),
                        style: TextStyle(color: Colors.grey[700]),
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
        label: Row(mainAxisSize:MainAxisSize.min ,
          children: [
             Icon(
                            _getFacilityIcon(facility),
                            color: maincolor1,
                            size: 16,
                          ),

                          SizedBox(width: 5,),
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
                    // Attractions
                    if (hotel.attractions.isNotEmpty && hotel.attractions != '{}') ...[
                      Text(
                        "Nearby Attractions",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.grey[50],
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          _cleanAttractions(hotel.attractions),
                          style: TextStyle(fontSize: 12, color: Colors.grey[700]),
                        ),
                      ),
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
                    _contactInfo(Icons.email, '$hotel.cityName, $hotel.countryName'),
                    const SizedBox(height: 16),

                    // Map
                    Text(
                      "Location",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: _buildImageWithShimmer(
                        mapImage,
                        height: 150,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(height: 16),
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
                      // hotelCode: widget.hotelCode,
                      // hotelName: hotel.hotelName,
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
              // child: Center(
              //   child: CircularProgressIndicator(
              //     value: loadingProgress.expectedTotalBytes != null
              //         ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
              //         : null,
              //     color: maincolor1,
              //   ),
              // ),
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
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.access_time, color: maincolor1, size: 16),
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
    return description
        .replaceAll('HeadLine :', '')
        .replaceAll('Location :', '')
        .replaceAll('Rooms :', '')
        .replaceAll('Dining :', '')
        .replaceAll(RegExp(r'[\n\r]+'), ' ')
        .trim();
  }

  String _cleanAttractions(String attractions) {
    return attractions
        .replaceAll('Distances are displayed to the nearest 0.1 mile and kilometer.', '')
        .replaceAll(RegExp(r'[\n\r]+'), ' ')
        .replaceAll(RegExp(r'\s+'), ' ')
        .trim();
  }

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
          style: const TextStyle(color: Colors.white),
        ),
      ),
      body: _buildShimmerHotelDetails(),
    );
  }

  Widget _buildShimmerHotelDetails() {
    return Column(
      children: [
        // Shimmer Main Image
        Container(
          height: 240,
          color: Colors.grey[300],
          child: Center(
            child: CircularProgressIndicator(color: maincolor1),
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
          style: const TextStyle(color: Colors.white),
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
          style: const TextStyle(color: Colors.white),
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
                child: const Text('Go Back'),
              ),
            ],
          ),
        ),
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
        margin: const EdgeInsets.only(top: 300),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
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
                    "All Facilities",
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
              child: Padding(
                padding: const EdgeInsets.all(5),
                child:  Wrap(
    spacing: 12,
    runSpacing: 5,
    children: facilities.take(facilities.length).map((facility) {
      return Chip(
        label: Row(mainAxisSize:MainAxisSize.min ,
          children: [
             Icon(
                            _getFacilityIcon(facility),
                            color: maincolor1,
                            size: 16,
                          ),

                          SizedBox(width: 5,),
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
}