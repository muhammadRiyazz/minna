import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:minna/comman/const/const.dart';
import 'package:minna/hotel%20booking/domain/authentication/authendication.dart';
import 'package:minna/hotel%20booking/domain/hotel%20details%20/hotel_details.dart';
import 'package:minna/hotel%20booking/domain/rooms/rooms.dart'
    show HotelRoomResult, Room, HotelSearchRequest;
import 'package:minna/hotel%20booking/functions/auth.dart' hide ApiResult;
import 'package:minna/hotel%20booking/functions/preBook.dart';
import 'package:minna/hotel%20booking/functions/pre_book_store.dart';
import 'package:minna/hotel%20booking/pages/PassengerInputPage/PassengerInputPage.dart';

class RoomAvailabilityResultsPage extends StatefulWidget {
  final List<HotelRoomResult> hotelRoomResult;
  final HotelSearchRequest hotelSearchRequest;
  final HotelDetail hotel;

  const RoomAvailabilityResultsPage({
    super.key,
    required this.hotelRoomResult,
    required this.hotelSearchRequest,
    required this.hotel,
  });

  @override
  State<RoomAvailabilityResultsPage> createState() => _RoomAvailabilityResultsPageState();
}

class _RoomAvailabilityResultsPageState extends State<RoomAvailabilityResultsPage> {
  // Theme colors
  final Color _primaryColor = Colors.black;
  final Color _secondaryColor = const Color(0xFFD4AF37);
  final Color _backgroundColor = const Color(0xFFF8F9FA);
  final Color _cardColor = Colors.white;
  final Color _textPrimary = Colors.black;
  final Color _textSecondary = const Color(0xFF666666);
  final Color _textLight = const Color(0xFF999999);

  final AuthApiService _apiService = AuthApiService();
  final Map<String, bool> _loadingRooms = {}; // Use bookingCode as key
  String? _errorMessage;

  // Helper method to get number of rooms in a room combination
  int _getNumberOfRoomsInCombination(Room room) {
    return room.name.length;
  }

  // Helper method to check if a specific room is loading
  bool _isRoomLoading(Room room) {
    return _loadingRooms[room.bookingCode] == true;
  }

  // Helper method to set loading state for a specific room
  void _setRoomLoading(Room room, bool loading) {
    setState(() {
      _loadingRooms[room.bookingCode] = loading;
    });
  }

  // Check if any room is loading
  bool get _isAnyRoomLoading {
    return _loadingRooms.values.any((loading) => loading);
  }

  // Show loading dialog
  void _showLoadingDialog(String message) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const CircularProgressIndicator(),
            const SizedBox(height: 16),
            Text(message),
          ],
        ),
      ),
    );
  }

  // Hide loading dialog
  void _hideLoadingDialog() {
    Navigator.of(context, rootNavigator: true).pop();
  }

  // Show error dialog
  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Error'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  // Show success dialog
  void _showSuccessDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Success'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  // Main booking flow

  // Main booking flow with Prebook Callback API
  Future<void> _handleBooking(Room room) async {
    try {
      _setRoomLoading(room, true);
      _errorMessage = null;

      // Step 1: Authenticate
      final authResult = await _apiService.authenticate();

      if (!authResult.isSuccess) {
        _setRoomLoading(room, false);
        _showErrorDialog(authResult.error!);
        return;
      }

      // Step 2: Check wallet balance
      final hasSufficientBalance = await _apiService.checkSufficientBalance(room.totalFare);
      
      if (!hasSufficientBalance) {
        _setRoomLoading(room, false);
        _showErrorDialog('Insufficient wallet balance for this booking');
        return;
      }

      // Step 3: Pre-book room
      final preBookResult = await _apiService.preBookRoom(
        bookingCode: room.bookingCode,
      );

      if (!preBookResult.isSuccess) {
        _setRoomLoading(room, false);
        _showErrorDialog(preBookResult.error!);
        return;
      }

      // Step 4: Call Prebook Callback API
      final callbackResult = await _callPrebookCallback(
        room: room,
        preBookResponse: preBookResult.data!,
      );

      _setRoomLoading(room, false);

      if (callbackResult.isSuccess) {
        // Success - navigate to passenger input page with prebookId
        _navigateToPassengerInput(
          room, 
          preBookResult.data!, 
          callbackResult.data!
        );
      } else {
        _showErrorDialog(callbackResult.error!);
      }
    } catch (e) {
      _setRoomLoading(room, false);
      _showErrorDialog('An unexpected error occurred: $e');
    }
  }
  // Call Prebook Callback API
  Future<ApiResult<PrebookCallbackResponse>> _callPrebookCallback({
    required Room room,
    required PreBookResponse preBookResponse,
  }) async {
    try {
      final response = await PreBookService().callPrebookCallback(
        bookingCode: room.bookingCode,
        noOfRooms: room.name.length,
        hotelCode: widget.hotel.hotelCode,
        response:   preBookResponse.toJson(), // Convert to JSON string
        serviceCharge: 0.0, // Adjust as per your business logic
        amount: room.totalFare,
      );

      if (response['status'] == 'SUCCESS') {
        final prebookCallbackResponse = PrebookCallbackResponse.fromJson(response);
        return ApiResult.success(prebookCallbackResponse);
      } else {
        return ApiResult.error(response['statusDesc'] ?? 'Callback API failed');
      }
    } catch (e) {
      return ApiResult.error('Callback API error: $e');
    }
  }

  void _navigateToPassengerInput(Room room, PreBookResponse preBookResponse, PrebookCallbackResponse callbackResponse) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PassengerInputPage(
          hotel: widget.hotel,
          hotelSearchRequest: widget.hotelSearchRequest,
          room: room,
          preBookResponse: preBookResponse,
          prebookId: callbackResponse.prebookId.toString(), // Pass prebookId to next page
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _backgroundColor,
      body: CustomScrollView(
        slivers: [
          // App Bar
          SliverAppBar(
            backgroundColor: _primaryColor,
            expandedHeight: 160,
            floating: false,
            pinned: true,
            elevation: 4,
            shadowColor: Colors.black.withOpacity(0.3),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_rounded, color: Colors.white),
              onPressed: _isAnyRoomLoading ? null : () => Navigator.pop(context),
            ),
            title: const Text(
              'Available Rooms',
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600,fontSize: 16),
            ),
            centerTitle: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [_primaryColor, Colors.black87],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 16, left: 20, right: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.hotel.hotelName,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        '${widget.hotelSearchRequest.paxRooms.length} Room${widget.hotelSearchRequest.paxRooms.length > 1 ? 's' : ''}',
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

          // Error Message
          if (_errorMessage != null)
            SliverToBoxAdapter(
              child: Container(
                margin: const EdgeInsets.all(16),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.red[50],
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.red[200]!),
                ),
                child: Row(
                  children: [
                    Icon(Icons.error_outline, color: Colors.red[700]),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        _errorMessage!,
                        style: TextStyle(color: Colors.red[700]),
                      ),
                    ),
                  ],
                ),
              ),
            ),

          // Room List
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final hotelResult = widget.hotelRoomResult[index];
                return Column(
                  children: hotelResult.rooms
                      .map((room) =>
                          _buildRoomCard(context, room, hotelResult.currency))
                      .toList(),
                );
              },
              childCount: widget.hotelRoomResult.length,
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 30)),
        ],
      ),
    );
  }

  // --- ROOM CARD ---
  Widget _buildRoomCard(BuildContext context, Room room, String currency) {
    final currencyFormat = NumberFormat.currency(symbol: '₹ ', decimalDigits: 0);
    final isRefundable = room.isRefundable;
    final totalFare = room.totalFare;
    final numberOfRooms = _getNumberOfRoomsInCombination(room);
    
    final roomNames = room.name;
    final primaryRoomName = roomNames.isNotEmpty ? roomNames[0] : 'Standard Room';
    final isRoomLoading = _isRoomLoading(room);

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: _cardColor,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Room Header
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    Container(
                      width: 65,
                      height: 65,
                      decoration: BoxDecoration(
                        color: _secondaryColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Icon(
                        numberOfRooms > 1 ? Icons.king_bed_outlined : Icons.king_bed_rounded,
                        color: _secondaryColor,
                        size: 28,
                      ),
                    ),
                    if (numberOfRooms > 1)
                      Positioned(
                        right: -2,
                        top: -2,
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                          decoration: BoxDecoration(
                            color: _secondaryColor,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            '$numberOfRooms',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        numberOfRooms > 1 
                            ? '$numberOfRooms Rooms Package' 
                            : primaryRoomName,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: _textPrimary,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 6),
                      Text(
                        primaryRoomName,
                        style: TextStyle(
                          color: _textSecondary,
                          fontSize: 13,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 14),

            // Promotions
            if (room.roomPromotion.isNotEmpty)
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: room.roomPromotion.take(3).map((promo) {
                  return Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: _secondaryColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.local_offer_rounded, color: _secondaryColor, size: 14),
                        const SizedBox(width: 6),
                        Text(
                          promo,
                          style: TextStyle(
                            color: _secondaryColor,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            if (room.roomPromotion.isNotEmpty) const SizedBox(height: 14),

            // Price Section
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: _backgroundColor,
                borderRadius: BorderRadius.circular(14),
              ),
              child: Column(
                children: [
                  // Price Row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            numberOfRooms > 1 ? 'Total for all rooms' : 'Total for stay',
                            style: TextStyle(color: _textSecondary, fontSize: 13),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            currencyFormat.format(totalFare),
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: _primaryColor,
                            ),
                          ),
                          if (numberOfRooms > 1)
                            Padding(
                              padding: const EdgeInsets.only(top: 4),
                              child: Text(
                                '${numberOfRooms} rooms × ${currencyFormat.format(totalFare / numberOfRooms)}',
                                style: TextStyle(
                                  color: _textLight,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(
                          color: isRefundable
                              ? Colors.green.withOpacity(0.1)
                              : Colors.red.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              isRefundable
                                  ? Icons.check_circle_rounded
                                  : Icons.cancel_rounded,
                              color: isRefundable ? Colors.green : Colors.redAccent,
                              size: 14,
                            ),
                            const SizedBox(width: 5),
                            Text(
                              isRefundable ? 'Refundable' : 'Non-refundable',
                              style: TextStyle(
                                  color: isRefundable ? Colors.green : Colors.redAccent,
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),

                  // Buttons
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: isRoomLoading ? null : () => _showRoomDetails(context, room, currency),
                          style: OutlinedButton.styleFrom(
                            foregroundColor: _primaryColor,
                            side: BorderSide(color: _primaryColor.withOpacity(0.3)),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 12),
                          ),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.info_outline_rounded, size: 16),
                              SizedBox(width: 8),
                              Text('Details', style: TextStyle(fontWeight: FontWeight.w600,fontSize: 12)),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: isRoomLoading ? null : () => _handleBooking(room),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: _primaryColor,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            elevation: 2,
                          ),
                          child: isRoomLoading
                              ? const SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                                  ),
                                )
                              : Text(
                                numberOfRooms > 1 ? 'Book ${numberOfRooms} Rooms' : 'Book Now',
                                style: const TextStyle(
                                    fontWeight: FontWeight.w600, fontSize: 12),
                              ),
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

  void _showRoomDetails(BuildContext context, Room room, String currency) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => _buildRoomDetailsSheet(context, room, currency),
    );
  }

  Widget _buildRoomDetailsSheet(BuildContext context, Room room, String currency) {
    final currencyFormat = NumberFormat.currency(symbol: '₹ ', decimalDigits: 0);
    final isRefundable = room.isRefundable;
    final numberOfRooms = _getNumberOfRoomsInCombination(room);
    final roomNames = room.name;
    final primaryRoomName = roomNames.isNotEmpty ? roomNames[0] : 'Standard Room';
    final isRoomLoading = _isRoomLoading(room);

    return Container(
      margin: const EdgeInsets.only(top: 60),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: _cardColor,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(26),
          topRight: Radius.circular(26),
        ),
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Handle
            Center(
              child: Container(
                width: 48,
                height: 4,
                margin: const EdgeInsets.only(bottom: 22),
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            
            // Title based on number of rooms
            Text(
              numberOfRooms > 1 ? '$numberOfRooms Rooms Package' : primaryRoomName,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: _textPrimary,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              numberOfRooms > 1 ? 'Complete room package details' : 'Room Details & Pricing',
              style: TextStyle(color: _textSecondary, fontSize: 16),
            ),
            const SizedBox(height: 22),

            // Room List (for multiple rooms)
            if (numberOfRooms > 1)
              _buildDetailSection(
                'Rooms in this Package',
                Icons.room_service_rounded,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    for (int i = 0; i < roomNames.length; i++)
                      Container(
                        margin: const EdgeInsets.only(bottom: 12),
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: _backgroundColor,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 32,
                              height: 32,
                              decoration: BoxDecoration(
                                color: _secondaryColor.withOpacity(0.1),
                                shape: BoxShape.circle,
                              ),
                              child: Icon(Icons.king_bed_rounded, 
                                  color: _secondaryColor, size: 16),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Room ${i + 1}',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: _textPrimary,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    roomNames[i],
                                    style: TextStyle(
                                      color: _textSecondary,
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
              ),

            // Room Features
            _buildDetailSection(
              numberOfRooms > 1 ? 'Package Features' : 'Room Features',
              Icons.king_bed_rounded,
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  _buildFeatureChip(Icons.king_bed_rounded, 'Comfortable Bed'),
                  _buildFeatureChip(Icons.wifi_rounded, 'Free WiFi'),
                  _buildFeatureChip(Icons.ac_unit_rounded, 'AC Room'),
                  _buildFeatureChip(Icons.tv_rounded, 'Flat-screen TV'),
                  if (room.inclusion.isNotEmpty)
                    ...room.inclusion
                        .split(',')
                        .take(3)
                        .map((e) => _buildFeatureChip(
                            Icons.check_circle_rounded, e.trim())),
                ],
              ),
            ),

            // Cancellation Policy
            _buildDetailSection(
              'Cancellation Policy',
              Icons.assignment_return_rounded,
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: isRefundable
                      ? Colors.green.withOpacity(0.1)
                      : Colors.red.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    Icon(
                      isRefundable
                          ? Icons.check_circle_rounded
                          : Icons.cancel_rounded,
                      color: isRefundable ? Colors.green : Colors.red,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        isRefundable
                            ? 'Free cancellation before 24 hours of check-in'
                            : 'Non-refundable room booking.',
                        style: TextStyle(
                          color: isRefundable ? Colors.green : Colors.redAccent,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Price Breakdown
            _buildDetailSection(
              'Price Breakdown',
              Icons.attach_money_rounded,
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: _backgroundColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    if (numberOfRooms > 1) ...[
                      for (int i = 0; i < numberOfRooms; i++)
                        _buildPriceRow('Room ${i + 1}', (room.totalFare - room.totalTax) / numberOfRooms),
                      const SizedBox(height: 8),
                      _buildPriceRow('Taxes & fees', room.totalTax),
                      const Divider(height: 20),
                      _buildPriceRow('Total for $numberOfRooms rooms', room.totalFare, isTotal: true),
                    ] else ...[
                      _buildPriceRow('Room rate', room.totalFare - room.totalTax),
                      const SizedBox(height: 8),
                      _buildPriceRow('Taxes & fees', room.totalTax),
                      const Divider(height: 20),
                      _buildPriceRow('Total', room.totalFare, isTotal: true),
                    ],
                  ],
                ),
              ),
            ),
            const SizedBox(height: 28),

            // Book Now Button
            SizedBox(
              width: double.infinity,
              height: 54,
              child: ElevatedButton(
                onPressed: isRoomLoading ? null : () {
                  Navigator.pop(context);
                  _handleBooking(room);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: _primaryColor,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                child: isRoomLoading
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                        ),
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            numberOfRooms > 1 ? Icons.room_service_rounded : Icons.credit_card_rounded, 
                            size: 18
                          ),
                          const SizedBox(width: 10),
                          Text(
                            numberOfRooms > 1 ? 'Book $numberOfRooms Rooms' : 'Book This Room',
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
              ),
            ),
            const SizedBox(height: 18),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailSection(String title, IconData icon, Widget content) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: _secondaryColor.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: _secondaryColor, size: 18),
            ),
            const SizedBox(width: 10),
            Text(title,
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: _textPrimary)),
          ],
        ),
        const SizedBox(height: 10),
        content,
        const SizedBox(height: 24),
      ],
    );
  }

  Widget _buildFeatureChip(IconData icon, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: _secondaryColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: _secondaryColor, size: 14),
          const SizedBox(width: 6),
          Text(label,
              style: TextStyle(
                  color: _secondaryColor,
                  fontSize: 12,
                  fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }

  Widget _buildPriceRow(String label, double amount, {bool isTotal = false}) {
    final currencyFormat = NumberFormat.currency(symbol: '₹ ', decimalDigits: 0);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label,
            style: TextStyle(
                color: _textSecondary,
                fontWeight: isTotal ? FontWeight.bold : FontWeight.normal)),
        Text(
          currencyFormat.format(amount),
          style: TextStyle(
              color: isTotal ? _primaryColor : _textPrimary,
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
              fontSize: isTotal ? 16 : 14),
        ),
      ],
    );
  }
}