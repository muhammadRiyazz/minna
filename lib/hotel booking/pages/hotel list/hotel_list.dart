import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:iconsax/iconsax.dart';
import 'package:minna/hotel booking/functions/hotel_api.dart';
import 'package:minna/hotel%20booking/domain/hotel%20list/hotel_list.dart';
import 'package:minna/hotel%20booking/pages/hotel%20details/hotel_details_page.dart';

class HotelListPage extends StatefulWidget {
  final String cityId;
  final String cityName;
  final DateTime checkInDate;
  final DateTime checkOutDate;
  final List<Map<String, dynamic>> rooms;

  const HotelListPage({
    super.key,
    required this.cityId,
    required this.cityName,
    required this.checkInDate,
    required this.checkOutDate,
    required this.rooms,
  });

  @override
  State<HotelListPage> createState() => _HotelListPageState();
}

class _HotelListPageState extends State<HotelListPage> {
  List<HotelListItem> hotels = [];
  bool isLoading = true;
  bool hasError = false;
  String errorMessage = '';

  final HotelApiService _apiService = HotelApiService();

  // Minimal Color Theme
  final Color _primaryColor = Color(0xFF000000); // Black
  final Color _secondaryColor = Color(0xFFD4AF37); // Gold
  final Color _backgroundColor = Color(0xFFF8F9FA); // Light gray
  final Color _cardColor = Colors.white;
  final Color _textPrimary = Color(0xFF111827);
  final Color _textSecondary = Color(0xFF6B7280);
  final Color _borderColor = Color(0xFFE5E7EB);
  final Color _priceColor = Color(0xFF059669); // Green for prices

  @override
  void initState() {
    super.initState();
    fetchHotels();
  }

  Future<void> fetchHotels() async {
    try {
      setState(() {
        isLoading = true;
        hasError = false;
        hotels.clear();
      });

      log('🔍 Starting hotel search for city: ${widget.cityName} (${widget.cityId})');

      final response = await _apiService.searchHotels(
        country: 'IN',
        city: widget.cityId,
        checkIn: DateFormat('yyyy-MM-dd').format(widget.checkInDate),
        checkOut: DateFormat('yyyy-MM-dd').format(widget.checkOutDate),
        rooms: widget.rooms,
      );

      if (response.status) {
        log('✅ Search successful! Found ${response.totalHotels} hotels');

        final List<HotelListItem> hotelListItems = [];

        for (final hotelItem in response.hotels) {
          if (hotelItem.hotelSearchDetails.rooms.isNotEmpty) {
            final minPrice = hotelItem.hotelSearchDetails.rooms
                .map((room) => room.totalFare)
                .reduce((a, b) => a < b ? a : b);

            hotelListItems.add(HotelListItem(
              hotelDetails:
                  SimplifiedHotelDetails.fromHotelDetails(hotelItem.hotelDetails),
              startingPrice: minPrice,
              currency: hotelItem.hotelSearchDetails.currency,
              hotelSearchItem: hotelItem,
            ));
          }
        }

        hotelListItems.sort((a, b) => a.startingPrice.compareTo(b.startingPrice));

        setState(() {
          hotels = hotelListItems;
          isLoading = false;
        });
      } else {
        log('❌ Search failed: ${response.message}');
        setState(() {
          isLoading = false;
          hasError = true;
          errorMessage = response.message;
        });
      }
    } on ApiException catch (e) {
      log('❌ API Exception: ${e.message}');
      setState(() {
        isLoading = false;
        hasError = true;
        errorMessage = e.getUserFriendlyMessage();
      });
    } catch (e, stackTrace) {
      log('❌ Unexpected Error: $e');
      log('Stack trace: $stackTrace');
      setState(() {
        isLoading = false;
        hasError = true;
        errorMessage = 'An unexpected error occurred. Please try again.';
      });
    }
  }

  String formatPrice(double price) {
    return '₹${NumberFormat('#,##0').format(price)}';
  }

  String formatDate(DateTime date) {
    return DateFormat('MMM dd').format(date);
  }

  int get totalGuests {
    final totalAdults = widget.rooms.fold(0, (sum, room) => sum + (room['adults'] as int));
    final totalChildren = widget.rooms.fold(0, (sum, room) => sum + (room['children'] as int));
    return totalAdults + totalChildren;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _backgroundColor,
      body: Column(
        children: [
          // Fixed Header
          _buildHeader(),
          
          // Scrollable Content
          Expanded(
            child: _buildContent(),
          ),
        ],
      ),
    );
  }

Widget _buildHeader() {
  return Container(
    decoration: BoxDecoration(
      color: _primaryColor,
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.1),
          blurRadius: 8,
          offset: Offset(0, 2),
        ),
      ],
    ),
    child: SafeArea(
      bottom: false,
      child: Column(
        children: [
          // App Bar
          Padding(
            padding: EdgeInsets.fromLTRB(16, 12, 16, 12),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(
                      Iconsax.arrow_left_2,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Hotels in ${widget.cityName}',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          letterSpacing: -0.3,
                        ),
                      ),
                     
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    // TODO: Filter functionality
                  },
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: _secondaryColor.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: _secondaryColor.withOpacity(0.3),
                        width: 1,
                      ),
                    ),
                    child: Icon(
                      Iconsax.filter_search,
                      color: _secondaryColor,
                      size: 20,
                    ),
                  ),
                ),
              ],
            ),
          ),
          
          // Search Details Section
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.15),
              border: Border(
                top: BorderSide(color: Colors.white.withOpacity(0.08)),
                bottom: BorderSide(color: Colors.white.withOpacity(0.08)),
              ),
            ),
            child: Column(
              children: [
                // Dates Row
                Row(
                  children: [
               
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Check-in / Check-out',
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.7),
                              fontSize: 11,
                              fontWeight: FontWeight.w500,
                              letterSpacing: 0.3,
                            ),
                          ),
                          SizedBox(height: 2),
                          Text(
                            '${formatDate(widget.checkInDate)} - ${formatDate(widget.checkOutDate)}',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                        Container(
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(9),
                      ),
                      child: Icon(
                        Iconsax.calendar_1,
                        size: 18,
                        color: Colors.white.withOpacity(0.9),
                      ),
                    ),
                  ],
                ),
             
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

String _calculateNights() {
  final difference = widget.checkOutDate.difference(widget.checkInDate).inDays;
  return '$difference ${difference == 1 ? 'night' : 'nights'}';
}

// String formatDate(DateTime date) {
//   return DateFormat('MMM dd, yyyy').format(date);
// }

  Widget _buildContent() {
    if (isLoading) {
      return _buildLoading();
    }
    
    if (hasError) {
      return _buildError();
    }
    
    if (hotels.isEmpty) {
      return _buildEmpty();
    }
    
    return _buildHotelList();
  }

  Widget _buildLoading() {
    return ListView.builder(
      padding: EdgeInsets.all(16),
      itemCount: 6,
      itemBuilder: (context, index) {
        return Container(
          margin: EdgeInsets.only(bottom: 16),
          height: 160,
          decoration: BoxDecoration(
            color: _cardColor,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: _borderColor),
          ),
          child: Row(
            children: [
              // Image placeholder
              Container(
                width: 120,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12),
                    bottomLeft: Radius.circular(12),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 16,
                        width: 120,
                        color: Colors.grey[200],
                        margin: EdgeInsets.only(bottom: 8),
                      ),
                      Container(
                        height: 12,
                        width: 80,
                        color: Colors.grey[100],
                        margin: EdgeInsets.only(bottom: 12),
                      ),
                      Spacer(),
                      Container(
                        height: 20,
                        width: 60,
                        color: Colors.grey[200],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildError() {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: Colors.grey[100],
                shape: BoxShape.circle,
              ),
              child: Icon(
                Iconsax.close_circle,
                size: 40,
                color: Colors.grey[500],
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Unable to Load Hotels',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: _textPrimary,
              ),
            ),
            SizedBox(height: 12),
            Text(
              errorMessage,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: _textSecondary,
              ),
            ),
            SizedBox(height: 24),
            ElevatedButton(
              onPressed: fetchHotels,
              style: ElevatedButton.styleFrom(
                backgroundColor: _secondaryColor,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              ),
              child: Text('Retry'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmpty() {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: Colors.grey[100],
                shape: BoxShape.circle,
              ),
              child: Icon(
                Iconsax.building,
                size: 40,
                color: Colors.grey[500],
              ),
            ),
            SizedBox(height: 20),
            Text(
              'No Hotels Found',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: _textPrimary,
              ),
            ),
            SizedBox(height: 12),
            Text(
              'Try adjusting your search criteria',
              style: TextStyle(
                fontSize: 14,
                color: _textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHotelList() {
    return ListView.separated(
      padding: EdgeInsets.all(16),
      itemCount: hotels.length,
      separatorBuilder: (context, index) => SizedBox(height: 16),
      itemBuilder: (context, index) {
        final hotel = hotels[index];
        return 
        
        
        
        _buildHotelCard(hotel);
      },
    );
  }

  Widget _buildHotelCard(HotelListItem hotel) {
    return Container(
      decoration: BoxDecoration(
        color: _cardColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _borderColor),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => HotelDetailsPage(
                  checkInDate: widget.checkInDate,
                  checkOutDate: widget.checkOutDate,
                  rooms: widget.rooms,
                  hotelSearchData: hotel.hotelSearchItem,
                ),
              ),
            );
          },
          borderRadius: BorderRadius.circular(12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Hotel Image
              Container(
                width: 120,
                height: 140,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12),
                    bottomLeft: Radius.circular(12),
                  ),
                  color: Colors.grey[200],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12),
                    bottomLeft: Radius.circular(12),
                  ),
                  child: hotel.hotelDetails.images.isNotEmpty
                      ? Image.network(
                          hotel.hotelDetails.images.first,
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: double.infinity,
                          loadingBuilder: (context, child, loadingProgress) {
                            if (loadingProgress == null) return child;
                            return Center(
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: _secondaryColor,
                              ),
                            );
                          },
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              color: Colors.grey[200],
                              child: Center(
                                child: Icon(
                                  Iconsax.building,
                                  size: 32,
                                  color: Colors.grey[400],
                                ),
                              ),
                            );
                          },
                        )
                      : Container(
                          color: Colors.grey[200],
                          child: Center(
                            child: Icon(
                              Iconsax.building,
                              size: 32,
                              color: Colors.grey[400],
                            ),
                          ),
                        ),
                ),
              ),
              
              // Hotel Details
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Hotel Name
                      Text(
                        hotel.hotelDetails.hotelName,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: _textPrimary,
                          height: 1.3,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 6),
                      
                      // Location
                      Row(
                        children: [
                          Icon(
                            Iconsax.location,
                            size: 12,
                            color: _textSecondary,
                          ),
                          SizedBox(width: 4),
                          Expanded(
                            child: Text(
                              hotel.hotelDetails.cityName,
                              style: TextStyle(
                                fontSize: 12,
                                color: _textSecondary,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 8),
                      
                      // Rating
                      if (hotel.hotelDetails.hotelRating > 0)
                        Row(
                          children: [
                            Icon(
                              Iconsax.star1,
                              size: 13,
                              color: _secondaryColor,
                            ),
                            SizedBox(width: 4),
                            Text(
                              hotel.hotelDetails.hotelRating.toString(),
                              style: TextStyle(
                                fontSize: 12,
                                color: _textPrimary,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                         
                           
                          ],
                        ),
                      
                      // Spacer(),
                      
                      // Price
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Starting from',
                                style: TextStyle(
                                  fontSize: 11,
                                  color: _textSecondary,
                                ),
                              ),
                              SizedBox(height: 2),
                              Text(
                                formatPrice(hotel.startingPrice),
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                  color: _priceColor,
                                ),
                              ),
                              Text(
                                'per night',
                                style: TextStyle(
                                  fontSize: 10,
                                  color: _textSecondary,
                                ),
                              ),
                            ],
                          ),
                          
                          // View Button
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: _secondaryColor.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  'View',
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: _secondaryColor,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                SizedBox(width: 4),
                                Icon(
                                  Iconsax.arrow_right_3,
                                  size: 14,
                                  color: _secondaryColor,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Helper Models
class HotelListItem {
  final SimplifiedHotelDetails hotelDetails;
  final double startingPrice;
  final String currency;
  final HotelSearchItem hotelSearchItem;

  HotelListItem({
    required this.hotelDetails,
    required this.startingPrice,
    required this.currency,
    required this.hotelSearchItem,
  });
}

class SimplifiedHotelDetails {
  final String hotelCode;
  final String hotelName;
  final List<String> images;
  final String cityName;
  final String address;
  final int hotelRating;

  SimplifiedHotelDetails({
    required this.hotelCode,
    required this.hotelName,
    required this.images,
    required this.cityName,
    required this.address,
    required this.hotelRating,
  });

  factory SimplifiedHotelDetails.fromHotelDetails(HotelDetails details) {
    return SimplifiedHotelDetails(
      hotelCode: details.hotelCode,
      hotelName: details.hotelName,
      images: details.images,
      cityName: details.cityName,
      address: details.address,
      hotelRating: details.hotelRating,
    );
  }
}