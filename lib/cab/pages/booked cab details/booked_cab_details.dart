// lib/cab/presentation/booking_details_page.dart
import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:minna/cab/application/booked%20details/booked_details_bloc.dart';
import 'package:minna/cab/application/booked%20info%20list/booked_info_bloc.dart';
import 'package:minna/cab/domain/cab%20list%20model/cab_booked_details.dart';
import 'package:minna/cab/function/commission_data.dart';
import 'package:minna/comman/core/api.dart';
import 'package:shimmer/shimmer.dart';

class BookingDetailsPage extends StatefulWidget {
  final String bookingId;
  final String tableID;

  const BookingDetailsPage({super.key, required this.bookingId, required this.tableID});

  @override
  State<BookingDetailsPage> createState() => _BookingDetailsPageState();
}

class _BookingDetailsPageState extends State<BookingDetailsPage> {
  bool _isCancelling = false;
  final String _baseUrl = 'http://gozotech2.ddns.net:5192/api/cpapi/booking';
  final String _authorization = 'Basic ZjA2MjljNTIxZjE2MjU0NTA2YmIyMDQzNWI4MTJmMmE=';
  late CommissionProvider commissionProvider;
  BuildContext? _parentContext;

  // New color scheme
  final Color _primaryColor = Colors.black;
  final Color _secondaryColor = Color(0xFFD4AF37); // Gold
  final Color _backgroundColor = Color(0xFFF8F9FA);
  final Color _cardColor = Colors.white;
  final Color _textPrimary = Colors.black;
  final Color _textSecondary = Color(0xFF666666);
  final Color _textLight = Color(0xFF999999);
  final Color _errorColor = Color(0xFFE53935);
  final Color _successColor = Color(0xFF4CAF50);
  final Color _warningColor = Color(0xFFFF9800);

  @override
  void initState() {
    super.initState();
    commissionProvider = context.read<CommissionProvider>();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _preCalculateCommissions();
    });
  }

  Future<void> _preCalculateCommissions() async {
    try {
      await commissionProvider.getCommission();
    } catch (e) {
      log('Commission pre-calculation error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    // Store parent context before creating local BlocProvider
    _parentContext = context;
    
    return BlocProvider(
      create: (context) =>
          BookedDetailsBloc()..add(BookedDetailsEvent.fetchDetails(widget.bookingId)),
      child: WillPopScope(
        onWillPop: () async {
          // Refresh booking list when navigating back
          _refreshBookingListOnBack();
          return true;
        },
        child: Scaffold(
          backgroundColor: _backgroundColor,
          body: BlocBuilder<BookedDetailsBloc, BookedDetailsState>(
            builder: (context, state) {
              return state.maybeWhen(
                loading: () => _buildShimmerLoading(),
                success: (details) => _buildSuccessState(context, details),
                error: (message) => _buildErrorState(context, message),
                orElse: () => _buildInitialState(),
              );
            },
          ),
        ),
      ),
    );
  }

  /// Refresh booking list when navigating back
  void _refreshBookingListOnBack() {
    // Use the parent context we stored
    final parentCtx = _parentContext;
    if (parentCtx == null || !parentCtx.mounted) {
      log('Parent context not available for refreshing booking list on back');
      return;
    }
    
    try {
      final bookedInfoBloc = parentCtx.read<BookedInfoBloc>();
      log('Refreshing booking list on back navigation');
      bookedInfoBloc.add(BookedInfoEvent.fetchList());
    } catch (e) {
      // Silently fail if bloc is not available
      log('Could not refresh booking list on back: $e');
    }
  }

  Widget _buildShimmerLoading() {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          backgroundColor: _primaryColor,
          expandedHeight: 200.0,
          pinned: true,
          floating: true,
          elevation: 0,
          flexibleSpace: FlexibleSpaceBar(
            background: Shimmer.fromColors(
              baseColor: Colors.grey[300]!,
              highlightColor: Colors.grey[100]!,
              child: Container(
                color: _primaryColor,
              ),
            ),
          ),
        ),
        SliverList(
          delegate: SliverChildListDelegate([
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: _buildShimmerCard(
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildShimmerBox(width: 40, height: 14),
                              const SizedBox(height: 12),
                              _buildShimmerBox(width: double.infinity, height: 20),
                              const SizedBox(height: 8),
                              _buildShimmerBox(width: 200, height: 16),
                            ],
                          ),
                        ),
                        Column(
                          children: [
                            _buildShimmerBox(width: 40, height: 40, isCircle: true),
                          ],
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              _buildShimmerBox(width: 40, height: 14),
                              const SizedBox(height: 12),
                              _buildShimmerBox(width: double.infinity, height: 20),
                              const SizedBox(height: 8),
                              _buildShimmerBox(width: 200, height: 16),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ]),
        ),
      ],
    );
  }

  Widget _buildShimmerCard({required Widget child}) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        decoration: BoxDecoration(
          color: _cardColor,
          borderRadius: BorderRadius.circular(20),
        ),
        padding: const EdgeInsets.all(24),
        child: child,
      ),
    );
  }

  Widget _buildShimmerBox({
    required double width,
    required double height,
    bool isCircle = false,
  }) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: _cardColor,
        borderRadius: isCircle
            ? BorderRadius.circular(height / 2)
            : BorderRadius.circular(4),
      ),
    );
  }

  Widget _buildSuccessState(BuildContext context, BookingDetails details) {
    // Check multiple ways the status might indicate cancellation
    final statusLower = details.statusDesc.toLowerCase();
    final isCancelled = statusLower.contains('cancel') || 
                        statusLower.contains('cancelled') ||
                        statusLower == 'cancel';
    
    log('📊 Building success state - Status: ${details.statusDesc}, isCancelled: $isCancelled');

    return Stack(
      children: [
        CustomScrollView(
          slivers: [
            // Sliver App Bar
            SliverAppBar(
              backgroundColor: _primaryColor,
              expandedHeight: 200.0,
              pinned: true,
              floating: true,
              elevation: 0,
              iconTheme: IconThemeData(color: Colors.white),
              title: Text(
                'Booking Details',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              centerTitle: true,
              flexibleSpace: FlexibleSpaceBar(
                background: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [_primaryColor, _primaryColor.withOpacity(0.8)],
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Booking ID',
                                  style: TextStyle(
                                    color: Colors.white.withOpacity(0.8),
                                    fontSize: 12,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  details.bookingId,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 8,
                              ),
                              decoration: BoxDecoration(
                                color: isCancelled
                                    ? _errorColor.withOpacity(0.2)
                                    : _successColor.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                  color: isCancelled ? _errorColor : _successColor,
                                  width: 1,
                                ),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    isCancelled ? Icons.cancel : Icons.check_circle,
                                    size: 12,
                                    color: isCancelled ? _errorColor : _successColor,
                                  ),
                                  const SizedBox(width: 6),
                                  Text(
                                    details.statusDesc,
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      color: isCancelled ? _errorColor : _successColor,
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
              ),
            ),

            // Booking Content
            SliverList(
              delegate: SliverChildListDelegate([
                // Journey Details Card
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: _buildJourneyCard(details),
                ),

                // Trip Information Card
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: _buildTripInfoCard(details),
                ),

                const SizedBox(height: 16),

                // Routes Information
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: _buildRoutesCard(details),
                ),

                const SizedBox(height: 16),

                // Traveller Information
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: _buildTravellerCard(details.traveller),
                ),

                const SizedBox(height: 16),

                // Cab & Fare Information
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: _buildCabFareCard(details.cabRate, isCancelled),
                ),

                const SizedBox(height: 100),
              ]),
            ),
          ],
        ),

        // Cancel Button positioned at bottom
        if (!isCancelled)
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: _buildCancelButton(details),
          ),
      ],
    );
  }

Widget _buildJourneyCard(BookingDetails details) {
  final firstRoute = details.routes.first;
  final lastRoute = details.routes.last;

  return Container(
    decoration: BoxDecoration(
      color: _cardColor,
      borderRadius: BorderRadius.circular(20),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.08),
          blurRadius: 20,
          offset: const Offset(0, 8),
        ),
      ],
    ),
    padding: const EdgeInsets.all(16),
    child: Column(
      children: [
        // Route Information
        Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'FROM',
                    style: TextStyle(
                      fontSize: 10,
                      color: _textSecondary,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 1.0,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    firstRoute.source.address,
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      Icon(Icons.access_time, size: 12, color: _secondaryColor),
                      const SizedBox(width: 6),
                      Flexible(
                        child: Text(
                          '${_formatDate(firstRoute.startDate)} • ${_formatTimeTo12Hour(firstRoute.startTime)}',
                          style: TextStyle(
                            fontSize: 12,
                            color: _textSecondary,
                            fontWeight: FontWeight.w500,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: _secondaryColor.withOpacity(0.1),
                      shape: BoxShape.circle,
                      border: Border.all(color: _secondaryColor.withOpacity(0.3), width: 2),
                    ),
                    child: Icon(
                      Icons.arrow_forward_rounded,
                      color: _secondaryColor,
                      size: 15,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    width: 2,
                    height: 40,
                    color: _secondaryColor.withOpacity(0.3),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    'TO',
                    style: TextStyle(
                      fontSize: 10,
                      color: _textSecondary,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 1.0,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    lastRoute.destination.address,
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.end,
                  ),
                  const SizedBox(height: 6),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Icon(Icons.access_time, size: 12, color: _secondaryColor),
                      const SizedBox(width: 6),
                      Flexible(
                        child: Text(
                          '${_formatDate(lastRoute.startDate)} • ${_formatTimeTo12Hour(lastRoute.startTime)}',
                          style: TextStyle(
                            fontSize: 12,
                            color: _textSecondary,
                            fontWeight: FontWeight.w500,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.end,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        
        // Trip Information - Grid layout for better space management
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: _backgroundColor,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: [
              // First row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: _buildCompactTripInfoItem('Distance', '${details.tripDistance} km'),
                  ),
                  Container(
                    width: 1,
                    height: 40,
                    color: _textLight.withOpacity(0.3),
                  ),
                  Expanded(
                    child: _buildCompactTripInfoItem('Trip Type', details.tripTypeName),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Container(
                width: double.infinity,
                height: 1,
                color: _textLight.withOpacity(0.3),
              ),
              const SizedBox(height: 12),
              // Second row - centered single item
              _buildCompactTripInfoItem('Booked On', _formatDate(details.bookingDate)),
            ],
          ),
        ),
      ],
    ),
  );
}

// Compact version for the trip info items
Widget _buildCompactTripInfoItem(String title, String value) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Text(
        title,
        style: TextStyle(
          fontSize: 10, 
          color: _textSecondary,
          fontWeight: FontWeight.w600,
        ),
        textAlign: TextAlign.center,
      ),
      const SizedBox(height: 4),
      Text(
        value,
        style: const TextStyle(
          fontSize: 12, 
          fontWeight: FontWeight.w700,
        ),
        textAlign: TextAlign.center,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
    ],
  );
}
 

  Widget _buildTripInfoCard(BookingDetails details) {
    return Container(
      decoration: BoxDecoration(
        color: _cardColor,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      padding: const EdgeInsets.all(16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: _secondaryColor.withOpacity(0.1),
              shape: BoxShape.circle,
              border: Border.all(color: _secondaryColor.withOpacity(0.3), width: 2),
            ),
            child: Icon(Icons.calendar_today_rounded, color: _secondaryColor, size: 20),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Pickup Schedule',
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  '${_formatDate(details.pickupDate)} • ${_formatTimeTo12Hour(details.pickupTime)}',
                  style: TextStyle(
                    fontSize: 12,
                    color: _textSecondary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  decoration: BoxDecoration(
                    color: _secondaryColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    'Confirmed Schedule',
                    style: TextStyle(
                      fontSize: 12,
                      color: _secondaryColor,
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

  Widget _buildRoutesCard(BookingDetails details) {
    return Container(
      decoration: BoxDecoration(
        color: _cardColor,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: _secondaryColor.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.route_rounded, color: _secondaryColor, size: 12),
              ),
              const SizedBox(width: 12),
              Text(
                details.isMultiCity ? 'ROUTES' : 'ROUTE',
                style: TextStyle(
                  fontSize: 13,
                  color: _textSecondary,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: _backgroundColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  '${details.routes.length}',
                  style: TextStyle(
                    fontSize: 14,
                    color: _secondaryColor,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          ...details.routes.asMap().entries.map((entry) {
            final index = entry.key;
            final route = entry.value;
            return Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: Container(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: _backgroundColor,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.grey.shade200),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      children: [
                        Icon(Icons.location_on, color: _secondaryColor, size: 16),
                        if (index < details.routes.length - 1)
                          Container(
                            width: 2,
                            height: 40,
                            color: _secondaryColor.withOpacity(0.3),
                          ),
                        if (index == details.routes.length - 1)
                          Icon(Icons.flag, color: Colors.green, size: 16),
                      ],
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'From: ${route.source.address}',
                            style: const TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'To: ${route.destination.address}',
                            style: const TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            '${_formatDate(route.startDate)} • ${_formatTimeTo12Hour(route.startTime)}',
                            style: TextStyle(
                              fontSize: 12,
                              color: _textSecondary,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildTravellerCard(BookedTraveller traveller) {
    return Container(
      decoration: BoxDecoration(
        color: _cardColor,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: _secondaryColor.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.person_rounded, color: _secondaryColor, size: 12),
              ),
              const SizedBox(width: 12),
              Text(
                'TRAVELLER INFORMATION',
                style: TextStyle(
                  fontSize: 13,
                  color: _textSecondary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          _buildTravellerInfoItem('Full Name', traveller.fullName),
          _buildTravellerInfoItem('Email', traveller.email),
          _buildTravellerInfoItem('Primary Contact', traveller.primaryContact.fullNumber),
          if (traveller.alternateContact.number.isNotEmpty)
            _buildTravellerInfoItem('Alternate Contact', traveller.alternateContact.fullNumber),
        ],
      ),
    );
  }

  Widget _buildTravellerInfoItem(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              label,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: _textSecondary,
                fontSize: 13,
              ),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 13,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCabFareCard(BookedCabRate cabRate, bool isCancelled) {
    return Container(
      decoration: BoxDecoration(
        color: _cardColor,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: _secondaryColor.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.directions_car_rounded, color: _secondaryColor, size: 12),
              ),
              const SizedBox(width: 12),
              Text(
                'CAB & FARE DETAILS',
                style: TextStyle(
                  fontSize: 13,
                  color: _textSecondary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          // Cab Details
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: _secondaryColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(Icons.directions_car_filled, color: _secondaryColor, size: 24),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      cabRate.cab.type,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        _buildCabSpecItem(Icons.people, '${cabRate.cab.seatingCapacity} Seats'),
                        const SizedBox(width: 12),
                        _buildCabSpecItem(Icons.luggage, '${cabRate.cab.bagCapacity} Bags'),
                        if (cabRate.cab.isAssured) ...[
                          const SizedBox(width: 12),
                          _buildCabSpecItem(Icons.verified, 'Assured'),
                        ],
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          // Fare Breakdown
          Text(
            'FARE BREAKUP',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: _textSecondary,
            ),
          ),
          const SizedBox(height: 12),
          _buildFareItem('Base Fare', cabRate.fare.baseFare.toString()),
          _buildFareItem('Driver Allowance', cabRate.fare.driverAllowance.toString()),
          _buildFareItem('GST', cabRate.fare.gst.toString()),
          if (cabRate.fare.tollTax > 0)
            _buildFareItem('Toll Tax', cabRate.fare.tollTax.toString()),
          if (cabRate.fare.stateTax > 0)
            _buildFareItem('State Tax', cabRate.fare.stateTax.toString()),
          if (cabRate.fare.airportFee > 0)
            _buildFareItem('Airport Fee', cabRate.fare.airportFee.toString()),
          if (cabRate.fare.additionalCharge > 0)
            _buildFareItem('Additional Charges', cabRate.fare.additionalCharge.toString()),
          
          FutureBuilder<double>(
            future: commissionProvider.calculateAmountWithCommission(cabRate.fare.totalAmount),
            builder: (context, snapshot) {
              if (commissionProvider.isLoading || snapshot.connectionState == ConnectionState.waiting) {
                return SizedBox();
              }

              final amountWithCommission = snapshot.data ?? cabRate.fare.totalAmount;
              final hasCommission = amountWithCommission > cabRate.fare.totalAmount;

              return Column(
                children: [
                  if (hasCommission)
                    _buildFareItem(
                      "Service Charges & Other",
                      (amountWithCommission - cabRate.fare.totalAmount).toStringAsFixed(0)),
                  
                  const SizedBox(height: 8),
                  const Divider(height: 1),
                  const SizedBox(height: 8),

                  _buildFareItem(
                    'Total Amount',
                    amountWithCommission.toStringAsFixed(0),
                    isTotal: true,
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildCabSpecItem(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 14, color: _textSecondary),
        const SizedBox(width: 4),
        Text(
          text,
          style: TextStyle(fontSize: 12, color: _textSecondary),
        ),
      ],
    );
  }

  Widget _buildFareItem(String label, String amount, {bool isTotal = false}) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 14,
              color: isTotal ? _textPrimary : _textSecondary,
              fontWeight: isTotal ? FontWeight.w600 : FontWeight.normal,
            ),
          ),
          Text(
            '₹$amount',
            style: TextStyle(
              fontSize: 14,
              color: isTotal ? _secondaryColor : _textPrimary,
              fontWeight: isTotal ? FontWeight.w700 : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCancelButton(BookingDetails details) {
    return Container(
      padding: const EdgeInsets.only(bottom: 12, right: 10,left: 10),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        color: _cardColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 20,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: _isCancelling ? _warningColor : _primaryColor,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 18),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              elevation: 4,
              shadowColor: _primaryColor.withOpacity(0.3),
            ),
            onPressed: _isCancelling ? null : () => _onCancelPressed(details.bookingId),
            child: _isCancelling
                ? SizedBox(
                    height: 24,
                    width: 24,
                    child: CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 2,
                    ),
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.cancel_rounded, size: 20),
                      const SizedBox(width: 12),
                      Text(
                        'CANCEL BOOKING',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }

  // ... Rest of your existing methods (_onCancelPressed, _showCancellationBottomSheet, 
  // _confirmCancellation, _callCabStatusApi, _showError, etc.) remain the same
  // Only the UI components have been updated above

  Future<void> _onCancelPressed(String bookingId) async {
    setState(() {
      _isCancelling = true;
    });

    try {
      final uri = Uri.parse('$_baseUrl/getCancellationList');
      final response = await http.post(
        uri,
        headers: {
          'Authorization': _authorization,
        },
        body: '',
      ).timeout(const Duration(seconds: 20));

      if (response.statusCode == 200) {
        final decoded = jsonDecode(response.body);
        if (decoded['success'] == true && decoded['data'] != null) {
          final List<dynamic> cancellationList = decoded['data']['cancellationList'] ?? [];
          final reasons = cancellationList.map((e) {
            return _CancellationReason(
              id: e['id']?.toString() ?? '',
              text: e['text'] ?? '',
              placeholder: e['placeholder'] ?? '',
            );
          }).toList();

          setState(() {
            _isCancelling = false;
          });

          await _showCancellationBottomSheet(bookingId, reasons);
        } else {
          setState(() {
            _isCancelling = false;
          });
          _showError('Failed to load cancellation reasons');
        }
      } else {
        setState(() {
          _isCancelling = false;
        });
        _showError('Error fetching reasons: ${response.statusCode}');
      }
    } catch (e) {
      setState(() {
        _isCancelling = false;
      });
      _showError('Failed to fetch cancellation reasons. Please try again.');
    }
  }

  Future<void> _showCancellationBottomSheet(String bookingId, List<_CancellationReason> reasons) async {
    String selectedReasonId = reasons.isNotEmpty ? reasons.first.id : '';
    String additionalText = '';
    String placeholder = reasons.isNotEmpty ? reasons.first.placeholder : 'Additional details';
    bool isModalLoading = false;

    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: _cardColor,
      isDismissible: false,
      enableDrag: false,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return StatefulBuilder(builder: (context, setModalState) {
          return Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: Container(
              constraints: BoxConstraints(
                maxHeight: MediaQuery.of(context).size.height * 0.8,
              ),
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      const Expanded(
                        child: Text(
                          'Cancel Booking',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ),
                      IconButton(
                        onPressed: isModalLoading
                            ? null
                            : () => Navigator.of(context).pop(),
                        icon: Icon(Icons.close, color: _textSecondary),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  const Divider(),
                  const SizedBox(height: 8),
                  Expanded(
                    child: ListView(
                      shrinkWrap: true,
                      children: [
                        const Text(
                          'Select a reason',
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(height: 12),
                        ...reasons.map((r) {
                          return ListTile(
                            contentPadding: EdgeInsets.zero,
                            title: Text(r.text),
                            subtitle: r.placeholder.isNotEmpty ? Text(r.placeholder) : null,
                            leading: Radio<String>(
                              value: r.id,
                              groupValue: selectedReasonId,
                              onChanged: isModalLoading
                                  ? null
                                  : (val) {
                                      setModalState(() {
                                        selectedReasonId = val ?? '';
                                        placeholder = r.placeholder;
                                      });
                                    },
                            ),
                            onTap: isModalLoading
                                ? null
                                : () {
                                    setModalState(() {
                                      selectedReasonId = r.id;
                                      placeholder = r.placeholder;
                                    });
                                  },
                          );
                        }),
                        const SizedBox(height: 16),
                        TextField(
                          enabled: !isModalLoading,
                          minLines: 1,
                          maxLines: 5,
                          onChanged: (val) => additionalText = val,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                            hintText: placeholder.isNotEmpty ? placeholder : 'Additional details (optional)',
                          ),
                        ),
                        const SizedBox(height: 20),
                        Row(
                          children: [
                            Expanded(
                              child: ElevatedButton(
                                onPressed: isModalLoading
                                    ? null
                                    : () async {
                                        // Show loading in modal
                                        setModalState(() {
                                          isModalLoading = true;
                                        });
                                        
                                        // Wait a brief moment to show loading state
                                        await Future.delayed(const Duration(milliseconds: 300));
                                        
                                        // Close modal
                                        if (context.mounted) {
                                          Navigator.of(context).pop();
                                        }
                                        
                                        // Start cancellation process
                                        _confirmCancellation(
                                          bookingId: bookingId,
                                          reasonText: additionalText.isNotEmpty
                                              ? additionalText
                                              : (reasons.firstWhere((r) => r.id == selectedReasonId).text),
                                          reasonId: selectedReasonId,
                                        );
                                      },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: _errorColor,
                                  foregroundColor: Colors.white,
                                  padding: const EdgeInsets.symmetric(vertical: 16),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                child: isModalLoading
                                    ? const SizedBox(
                                        width: 20,
                                        height: 20,
                                        child: CircularProgressIndicator(
                                          strokeWidth: 2,
                                          color: Colors.white,
                                        ),
                                      )
                                    : const Text('Confirm Cancellation'),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        });
      },
    );
  }

  Future<void> _confirmCancellation({
    required String bookingId,
    required String reasonText,
    required String reasonId,
  }) async {
    // Set loading state for the cancel button
    if (mounted) {
      setState(() {
        _isCancelling = true;
      });
    }

    try {
      final uri = Uri.parse('$_baseUrl/cancelBooking');
      final bodyMap = {
        "bookingId": bookingId,
        "reason": reasonText,
        "reasonId": reasonId
      };

      final response = await http.post(
        uri,
        headers: {
          'Authorization': _authorization,
          'Content-Type': 'application/json',
        },
        body: jsonEncode(bodyMap),
      ).timeout(const Duration(seconds: 20));

      if (response.statusCode == 200) {
        final decoded = jsonDecode(response.body);
        if (decoded['success'] == true && decoded['data'] != null) {
          final data = decoded['data'];
          final refundedAmount = data['refundAmount'] ?? 0;
          final cancellationCharge = data['cancellationCharge'] ?? 0;
          final message = data['message'] ?? 'Booking cancelled successfully';
          final cancelledBookingId = data['bookingId'] ?? bookingId;

          await _callCabStatusApi(
            bookingId: widget.tableID,
            type: 'cancel',
            request: jsonEncode(bodyMap),
            response: response.body,
            refundAmount: double.parse(refundedAmount.toString()),
          );

          // Show success dialog
          await showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            backgroundColor: _cardColor,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            ),
            builder: (context) {
              return Padding(
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom,
                ),
                child: Container(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 50,
                        height: 5,
                        margin: const EdgeInsets.only(bottom: 16),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      Icon(Icons.check_circle, color: _successColor, size: 60),
                      const SizedBox(height: 12),
                      Text(
                        'Cancellation Successful',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: _primaryColor,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        message,
                        style: const TextStyle(fontSize: 14, color: Colors.black87),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 20),
                      _buildCancellationInfoItem('Booking ID', cancelledBookingId, Icons.confirmation_number_outlined),
                      _buildCancellationInfoItem('Refund Amount', '₹$refundedAmount', Icons.currency_rupee),
                      _buildCancellationInfoItem('Cancellation Charge', '₹$cancellationCharge', Icons.money_off_csred_outlined),
                      const SizedBox(height: 16),
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: _warningColor.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: _warningColor.withOpacity(0.3)),
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.info_outline, color: _warningColor),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                'Refund will be credited within 5–7 working days.',
                                style: const TextStyle(fontSize: 13, color: Colors.black87),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton.icon(
                        onPressed: () async {
                          Navigator.of(context).pop();
                          // Wait a moment for dialog to close
                          await Future.delayed(const Duration(milliseconds: 300));
                          // Reload both booking details and booking list after closing success dialog
                          if (mounted) {
                            _reloadBookingDetails();
                            _reloadBookingList();
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: _primaryColor,
                          foregroundColor: Colors.white,
                          minimumSize: const Size.fromHeight(48),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        icon: const Icon(Icons.done_all),
                        label: const Text("OK, Got it"),
                      ),
                      const SizedBox(height: 10),
                    ],
                  ),
                ),
              );
            },
          );
        } else {
          if (mounted) {
            setState(() {
              _isCancelling = false;
            });
          }
          _showError('Cancellation failed. Please try again.');
        }
      } else {
        if (mounted) {
          setState(() {
            _isCancelling = false;
          });
        }
        _showError('Cancellation failed: ${response.statusCode}');
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isCancelling = false;
        });
      }
      _showError('Failed to cancel booking. Please check your connection and try again.');
    }
  }

  /// Reload booking details after cancellation
  void _reloadBookingDetails() {
    if (!mounted) return;
    
    // Reset loading states
    setState(() {
      _isCancelling = false;
    });
    
    // Wait a moment then fetch updated booking details to ensure backend has processed cancellation
    Future.delayed(const Duration(milliseconds: 1000), () {
      if (mounted) {
        log('🔄 Reloading booking details after cancellation - Booking ID: ${widget.bookingId}');
        context.read<BookedDetailsBloc>().add(
          BookedDetailsEvent.fetchDetails(widget.bookingId),
        );
      }
    });
  }

  /// Reload booking list after cancellation
  void _reloadBookingList() {
    if (!mounted) return;
    
    // Use the parent context we stored before creating local BlocProvider
    final parentCtx = _parentContext;
    if (parentCtx == null || !parentCtx.mounted) {
      log('Parent context not available for refreshing booking list');
      _tryRefreshBookingListAlternative();
      return;
    }
    
    try {
      // Access BookedInfoBloc from parent context (above our local BlocProvider)
      final bookedInfoBloc = parentCtx.read<BookedInfoBloc>();
      log('✅ Refreshing booking list after cancellation - Found BookedInfoBloc');
      bookedInfoBloc.add(BookedInfoEvent.fetchList());
    } catch (e, stackTrace) {
      // BookedInfoBloc might not be available in this context
      log('❌ Could not refresh booking list from parent context: $e', error: e, stackTrace: stackTrace);
      // Try alternative approach
      _tryRefreshBookingListAlternative();
    }
  }

  /// Alternative method to refresh booking list
  void _tryRefreshBookingListAlternative() {
    if (!mounted) return;
    
    try {
      // Walk up the widget tree to find BookedInfoBloc using current context
      BookedInfoBloc? bookedInfoBloc;
      context.visitAncestorElements((element) {
        try {
          bookedInfoBloc = element.read<BookedInfoBloc>();
          return false; // Stop walking
        } catch (e) {
          return true; // Continue walking
        }
      });
      
      if (bookedInfoBloc != null) {
        log('Found BookedInfoBloc using alternative method, refreshing list');
        bookedInfoBloc!.add(BookedInfoEvent.fetchList());
      } else {
        log('BookedInfoBloc not found in widget tree using alternative method');
      }
    } catch (e) {
      log('Alternative refresh method also failed: $e');
    }
  }

  Widget _buildCancellationInfoItem(String title, String value, IconData icon) {
    return ListTile(
      leading: Icon(icon, color: _textSecondary),
      title: Text(title),
      subtitle: Text(value),
    );
  }

  Future<void> _callCabStatusApi({
    required String bookingId,
    required String type,
    required String request,
    required String response,
    required double refundAmount,
  }) async {
    try {
      final cabStatusUri = Uri.parse('${baseUrl}cab-status');
      final cabStatusBody = {
        "booking_id": bookingId,
        "type": type,
        "request": request,
        "response": response,
        if (type == 'cancel') "refund_amount": refundAmount.toString(),
      };

      final cabStatusResponse = await http.post(
        cabStatusUri,
        headers: {
          "Content-Type": "application/x-www-form-urlencoded",
        },
        body: cabStatusBody,
      );

      if (cabStatusResponse.statusCode == 200) {
        final cabStatusDecoded = jsonDecode(cabStatusResponse.body);
        if (cabStatusDecoded['status'] == 'success') {
          log('CAB Status updated successfully: $type');
        } else {
          log('CAB Status API returned error: ${cabStatusDecoded['message']}');
        }
      } else {
        log('CAB Status API failed with status: ${cabStatusResponse.statusCode}');
      }
    } catch (e) {
      log('Error calling CAB Status API: $e');
    }
  }

  void _showError(String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        backgroundColor: _errorColor,
        content: Row(
          children: [
            Icon(Icons.error, color: Colors.white),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                message,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
        duration: const Duration(seconds: 3),
      ),
    );
  }

  Widget _buildErrorState(BuildContext context, String message) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.error_outline, size: 64, color: _errorColor),
          const SizedBox(height: 16),
          Text(
            message,
            style: const TextStyle(fontSize: 16, color: Colors.red),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              context.read<BookedDetailsBloc>().add(
                    BookedDetailsEvent.fetchDetails(widget.bookingId),
                  );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: _primaryColor,
              foregroundColor: Colors.white,
            ),
            child: const Text('Retry'),
          ),
        ],
      ),
    );
  }

  Widget _buildInitialState() {
    return const Center(
      child: Text('Loading booking details...'),
    );
  }

  String _formatDate(String date) {
    try {
      final parsedDate = DateTime.parse(date);
      return DateFormat('dd MMM yyyy').format(parsedDate);
    } catch (e) {
      return date;
    }
  }

  String _formatTimeTo12Hour(String time24) {
    try {
      final timeParts = time24.split(':');
      if (timeParts.length >= 2) {
        int hour = int.parse(timeParts[0]);
        int minute = int.parse(timeParts[1]);

        String period = hour >= 12 ? 'PM' : 'AM';
        hour = hour % 12;
        hour = hour == 0 ? 12 : hour;

        return '${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')} $period';
      }
      return time24;
    } catch (e) {
      return time24;
    }
  }
}

class _CancellationReason {
  final String id;
  final String text;
  final String placeholder;

  _CancellationReason({required this.id, required this.text, required this.placeholder});
}