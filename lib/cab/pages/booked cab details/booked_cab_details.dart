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
import 'package:minna/cab/domain/cab%20report/cab_driver_model.dart';
import 'package:minna/cab/function/commission_data.dart';
import 'package:minna/comman/core/api.dart';
import 'package:minna/comman/const/const.dart';
import 'package:shimmer/shimmer.dart';
import 'package:iconsax/iconsax.dart';
import 'package:url_launcher/url_launcher.dart';

class BookingDetailsPage extends StatefulWidget {
  final String bookingId;
  final String tableID;

  const BookingDetailsPage({
    super.key,
    required this.bookingId,
    required this.tableID,
  });

  @override
  State<BookingDetailsPage> createState() => _BookingDetailsPageState();
}

class _BookingDetailsPageState extends State<BookingDetailsPage> {
  bool _isCancelling = false;
  late CommissionProvider commissionProvider;
  BuildContext? _parentContext;

  // Theme standardizing: Use global constants directly from const.dart

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
          BookedDetailsBloc()
            ..add(BookedDetailsEvent.fetchDetails(widget.bookingId)),
      child: WillPopScope(
        onWillPop: () async {
          // Refresh booking list when navigating back
          _refreshBookingListOnBack();
          return true;
        },
        child: Scaffold(
          backgroundColor: backgroundColor,
          body: BlocBuilder<BookedDetailsBloc, BookedDetailsState>(
            builder: (context, state) {
              return state.maybeWhen(
                loading: () => _buildShimmerLoading(),
                success: (details, driverInfo) =>
                    _buildSuccessState(context, details, driverInfo),
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
    return Column(
      children: [
        // Rounded Header Shimmer
        Shimmer.fromColors(
          baseColor: maincolor1,
          highlightColor: maincolor1.withOpacity(0.8),
          child: Container(
            height: 180,
            width: double.infinity,
            decoration: const BoxDecoration(
              color: maincolor1,
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(32)),
            ),
          ),
        ),
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                _buildShimmerCard(
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _buildShimmerBox(width: 80, height: 40),
                          _buildShimmerBox(width: 40, height: 40, isCircle: true),
                          _buildShimmerBox(width: 80, height: 40),
                        ],
                      ),
                      const SizedBox(height: 24),
                      _buildShimmerBox(width: double.infinity, height: 60),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                _buildShimmerCard(
                  child: Row(
                    children: [
                      _buildShimmerBox(width: 50, height: 50, isCircle: true),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildShimmerBox(width: 100, height: 12),
                            const SizedBox(height: 8),
                            _buildShimmerBox(width: 150, height: 16),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                _buildShimmerCard(child: _buildShimmerBox(width: double.infinity, height: 100)),
              ],
            ),
          ),
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
          color: cardColor,
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
        color: cardColor,
        borderRadius: isCircle
            ? BorderRadius.circular(height / 2)
            : BorderRadius.circular(4),
      ),
    );
  }

  Widget _buildSuccessState(
    BuildContext context,
    BookingDetails details,
    CabDriverResponse? driverInfo,
  ) {
    final statusLower = details.statusDesc.toLowerCase();
    final isCancelled = statusLower.contains('cancel');

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: maincolor1,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "Trip Report",
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w900,
            letterSpacing: -0.5,
          ),
        ),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Iconsax.arrow_left, color: Colors.white),
        ),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                _buildPremiumHeader(details, isCancelled),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      _buildJourneyCard(details),
                      const SizedBox(height: 16),
                      if (driverInfo != null && driverInfo.driverUpdate != null) ...[
                        _buildDriverInfoCard(driverInfo.driverUpdate!),
                        const SizedBox(height: 16),
                      ],
                      _buildTripInfoCard(details),
                      const SizedBox(height: 16),
                      _buildRoutesCard(details),
                      const SizedBox(height: 16),
                      _buildTravellerCard(details.traveller),
                      const SizedBox(height: 16),
                      _buildCabFareCard(details.cabRate, isCancelled),
                      const SizedBox(height: 120), // Space for button
                    ],
                  ),
                ),
              ],
            ),
          ),
          if (!isCancelled)
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: _buildCancelButton(details),
            ),
        ],
      ),
    );
  }

  Widget _buildPremiumHeader(BookingDetails details, bool isCancelled) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: maincolor1,
        borderRadius: const BorderRadius.vertical(bottom: Radius.circular(32)),
      ),
      padding: const EdgeInsets.fromLTRB(24, 0, 24, 40),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: const Icon(Iconsax.car, size: 40, color: Colors.white),
          ),
          const SizedBox(height: 16),
          Text(
            details.bookingId,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w900,
              color: Colors.white,
              letterSpacing: -0.5,
            ),
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: (isCancelled ? errorColor : successColor).withOpacity(0.2),
              borderRadius: BorderRadius.circular(100),
              border: Border.all(
                color: (isCancelled ? errorColor : successColor).withOpacity(0.3),
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  isCancelled ? Iconsax.close_circle : Iconsax.tick_circle,
                  size: 14,
                  color: isCancelled ? errorColor : Colors.greenAccent,
                ),
                const SizedBox(width: 8),
                Text(
                  details.statusDesc.toUpperCase(),
                  style: TextStyle(
                    color: isCancelled ? errorColor : Colors.greenAccent,
                    fontSize: 12,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 1,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDriverInfoCard(CabDriverUpdate update) {
    return Container(
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: borderSoft),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 15,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: secondaryColor.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Iconsax.personalcard, color: secondaryColor, size: 18),
              ),
              const SizedBox(width: 12),
              const Text(
                'DRIVER INFORMATION',
                style: TextStyle(
                  fontSize: 11,
                  color: textLight,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 1.2,
                ),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: successColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  update.statusDesc.toUpperCase(),
                  style: const TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w900,
                    color: successColor,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: backgroundColor,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Icon(Iconsax.car, color: maincolor1, size: 24),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      update.car.model.toUpperCase(),
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w900,
                        color: maincolor1,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      update.car.number.toUpperCase(),
                      style: const TextStyle(
                        fontSize: 13,
                        color: textSecondary,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                decoration: BoxDecoration(
                  color: maincolor1,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Column(
                  children: [
                    const Text(
                      'OTP',
                      style: TextStyle(color: Colors.white70, fontSize: 9, fontWeight: FontWeight.w800),
                    ),
                    Text(
                      update.otp,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 1.5,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 20),
            child: Divider(height: 1),
          ),
          Row(
            children: [
              CircleAvatar(
                radius: 24,
                backgroundColor: secondaryColor.withOpacity(0.1),
                child: Text(
                  update.driver.name[0],
                  style: const TextStyle(color: secondaryColor, fontWeight: FontWeight.w900, fontSize: 20),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      update.driver.name.toUpperCase(),
                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w900, color: maincolor1),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        const Icon(Icons.star_rounded, color: Colors.orange, size: 16),
                        const SizedBox(width: 4),
                        Text(
                          '${update.driver.rating}',
                          style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w800, color: textSecondary),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () => launchUrl(Uri.parse('tel:${update.driver.contact.fullNumber}')),
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(color: successColor.withOpacity(0.1), shape: BoxShape.circle),
                  child: const Icon(Iconsax.call, color: successColor, size: 20),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildJourneyCard(BookingDetails details) {
    final firstRoute = details.routes.first;
    final lastRoute = details.routes.last;

    return Container(
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: borderSoft),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 15,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'FROM',
                      style: TextStyle(
                        fontSize: 10,
                        color: textLight,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 1.2,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      firstRoute.source.address,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w900,
                        color: maincolor1,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        const Icon(Iconsax.clock, size: 14, color: secondaryColor),
                        const SizedBox(width: 8),
                        Flexible(
                          child: Text(
                            '${_formatDate(firstRoute.startDate)} • ${_formatTimeTo12Hour(firstRoute.startTime)}',
                            style: const TextStyle(
                              fontSize: 12,
                              color: textSecondary,
                              fontWeight: FontWeight.w700,
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
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: secondaryColor.withOpacity(0.1),
                        shape: BoxShape.circle,
                        border: Border.all(color: secondaryColor.withOpacity(0.3), width: 2),
                      ),
                      child: Icon(
                        Icons.local_taxi_rounded,
                        color: secondaryColor,
                        size: 20,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      width: 2,
                      height: 50,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [secondaryColor.withOpacity(0.5), Colors.transparent],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const Text(
                      'TO',
                      style: TextStyle(
                        fontSize: 10,
                        color: textLight,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 1.2,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      lastRoute.destination.address,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w900,
                        color: maincolor1,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.end,
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        const Icon(Iconsax.clock, size: 14, color: secondaryColor),
                        const SizedBox(width: 8),
                        Flexible(
                          child: Text(
                            '${_formatDate(lastRoute.startDate)} • ${_formatTimeTo12Hour(lastRoute.startTime)}',
                            style: const TextStyle(
                              fontSize: 12,
                              color: textSecondary,
                              fontWeight: FontWeight.w700,
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
          const SizedBox(height: 24),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildCompactTripInfoItem('Distance', '${details.tripDistance} KM'),
                Container(width: 1, height: 30, color: Colors.grey.shade300),
                _buildCompactTripInfoItem('Trip Type', details.tripTypeName.toUpperCase()),
                Container(width: 1, height: 30, color: Colors.grey.shade300),
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
          title.toUpperCase(),
          style: const TextStyle(fontSize: 9, color: textLight, fontWeight: FontWeight.w800, letterSpacing: 1),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 6),
        Text(
          value,
          style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w900, color: maincolor1),
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
        color: cardColor,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: borderSoft),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 15,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: secondaryColor.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: const Icon(Iconsax.calendar_1, color: secondaryColor, size: 24),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'PICKUP SCHEDULE',
                  style: TextStyle(
                    fontSize: 11,
                    color: textLight,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 1.2,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '${_formatDate(details.pickupDate)} • ${_formatTimeTo12Hour(details.pickupTime)}',
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w900,
                    color: maincolor1,
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  'Confirmed Schedule',
                  style: TextStyle(
                    fontSize: 12,
                    color: successColor,
                    fontWeight: FontWeight.w700,
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
        color: cardColor,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: borderSoft),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 15,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: secondaryColor.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Iconsax.route_square, color: secondaryColor, size: 18),
              ),
              const SizedBox(width: 12),
              Text(
                details.isMultiCity ? 'ROUTES' : 'ROUTE',
                style: const TextStyle(
                  fontSize: 11,
                  color: textLight,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 1.2,
                ),
              ),
              const Spacer(),
              Text(
                '${details.routes.length} Stops',
                style: const TextStyle(
                  fontSize: 12,
                  color: maincolor1,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          ...details.routes.asMap().entries.map((entry) {
            final index = entry.key;
            final route = entry.value;
            return Container(
              margin: const EdgeInsets.only(bottom: 12),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: backgroundColor,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.grey.shade200),
              ),
              child: IntrinsicHeight(
                child: Row(
                  children: [
                    Column(
                      children: [
                        const Icon(Iconsax.location, color: secondaryColor, size: 16),
                        if (index < details.routes.length - 1)
                          Expanded(
                            child: Container(
                              width: 1.5,
                              margin: const EdgeInsets.symmetric(vertical: 4),
                              color: secondaryColor.withOpacity(0.3),
                            ),
                          ),
                        if (index == details.routes.length - 1)
                          const Icon(Iconsax.flag, color: Colors.green, size: 16),
                      ],
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'From: ${route.source.address}',
                            style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w900, color: maincolor1),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'To: ${route.destination.address}',
                            style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w900, color: maincolor1),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            '${_formatDate(route.startDate)} • ${_formatTimeTo12Hour(route.startTime)}',
                            style: const TextStyle(fontSize: 11, color: textSecondary, fontWeight: FontWeight.w700),
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
        color: cardColor,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: borderSoft),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 15,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: secondaryColor.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Iconsax.user, color: secondaryColor, size: 18),
              ),
              const SizedBox(width: 12),
              const Text(
                'TRAVELLER INFORMATION',
                style: TextStyle(
                  fontSize: 11,
                  color: textLight,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 1.2,
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          _buildTravellerInfoItem('Full Name', traveller.fullName.toUpperCase()),
          _buildTravellerInfoItem('Email Address', traveller.email),
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
              style: const TextStyle(fontWeight: FontWeight.w800, color: textLight, fontSize: 11, letterSpacing: 0.5),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 13, color: maincolor1),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCabFareCard(BookedCabRate cabRate, bool isCancelled) {
    return Container(
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: borderSoft),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 15,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: secondaryColor.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Iconsax.car, color: secondaryColor, size: 18),
              ),
              const SizedBox(width: 12),
              const Text(
                'CAB & FARE DETAILS',
                style: TextStyle(
                  fontSize: 11,
                  color: textLight,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 1.2,
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: backgroundColor,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Icon(Iconsax.car, color: maincolor1, size: 24),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      cabRate.cab.type.toUpperCase(),
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w900,
                        color: maincolor1,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        _buildCabSpecItem(Iconsax.user, '${cabRate.cab.seatingCapacity} SEATS'),
                        const SizedBox(width: 12),
                        _buildCabSpecItem(Iconsax.bag, '${cabRate.cab.bagCapacity} BAGS'),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 24),
            child: Divider(height: 1),
          ),
          const Text(
            'FARE BREAKUP',
            style: TextStyle(
              fontSize: 11,
              color: textLight,
              fontWeight: FontWeight.w800,
              letterSpacing: 1.2,
            ),
          ),
          const SizedBox(height: 16),
          _buildFareItem('Base Fare', cabRate.fare.baseFare.toString()),
          _buildFareItem('Driver Allowance', cabRate.fare.driverAllowance.toString()),
          _buildFareItem('GST', cabRate.fare.gst.toString()),
          if (cabRate.fare.tollTax > 0) _buildFareItem('Toll Tax', cabRate.fare.tollTax.toString()),
          if (cabRate.fare.stateTax > 0) _buildFareItem('State Tax', cabRate.fare.stateTax.toString()),
          if (cabRate.fare.airportFee > 0) _buildFareItem('Airport Fee', cabRate.fare.airportFee.toString()),
          if (cabRate.fare.additionalCharge > 0)
            _buildFareItem('Additional Charges', cabRate.fare.additionalCharge.toString()),

          FutureBuilder<double>(
            future: commissionProvider.calculateAmountWithCommission(cabRate.fare.totalAmount),
            builder: (context, snapshot) {
              if (commissionProvider.isLoading || snapshot.connectionState == ConnectionState.waiting) {
                return const SizedBox();
              }

              final amountWithCommission = snapshot.data ?? cabRate.fare.totalAmount;
              final hasCommission = amountWithCommission > cabRate.fare.totalAmount;

              return Column(
                children: [
                  if (hasCommission)
                    _buildFareItem(
                      "Service Charges & Other",
                      (amountWithCommission - cabRate.fare.totalAmount).toStringAsFixed(0),
                    ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 12),
                    child: Divider(height: 1),
                  ),
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
        Icon(icon, size: 12, color: textSecondary),
        const SizedBox(width: 4),
        Text(
          text,
          style: const TextStyle(fontSize: 10, color: textSecondary, fontWeight: FontWeight.w700),
        ),
      ],
    );
  }

  Widget _buildFareItem(String label, String amount, {bool isTotal = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: isTotal ? 15 : 14,
              color: isTotal ? maincolor1 : textSecondary,
              fontWeight: isTotal ? FontWeight.w900 : FontWeight.w600,
            ),
          ),
          Text(
            '₹$amount',
            style: TextStyle(
              fontSize: isTotal ? 16 : 14,
              color: isTotal ? secondaryColor : maincolor1,
              fontWeight: FontWeight.w900,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCancelButton(BookingDetails details) {
    return Container(
      padding: const EdgeInsets.fromLTRB(24, 16, 24, 32),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
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
              backgroundColor: maincolor1,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 20),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              elevation: 0,
            ),
            onPressed: _isCancelling ? null : () => _onCancelPressed(details.bookingId),
            child: _isCancelling
                ? const SizedBox(
                    height: 24,
                    width: 24,
                    child: CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 2,
                    ),
                  )
                : const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Iconsax.close_circle, size: 20),
                      const SizedBox(width: 12),
                      Text(
                        'CANCEL BOOKING',
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
      final mainUri = Uri.parse('${baseUrl}Cabapi');
      final response = await http
          .post(
            mainUri,
            body: {
              "link": "${cabBaseUrl}api/cpapi/booking/getCancellationList",
              "data": "",
            },
          )
          .timeout(const Duration(seconds: 20));

      if (response.statusCode == 200) {
        final fullDecoded = jsonDecode(response.body);
        final decoded = fullDecoded['message'] ?? fullDecoded;

        if (decoded['success'] == true && decoded['data'] != null) {
          final List<dynamic> cancellationList =
              decoded['data']['cancellationList'] ?? [];
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

  Future<void> _showCancellationBottomSheet(
    String bookingId,
    List<_CancellationReason> reasons,
  ) async {
    String selectedReasonId = reasons.isNotEmpty ? reasons.first.id : '';
    String additionalText = '';
    String placeholder = reasons.isNotEmpty
        ? reasons.first.placeholder
        : 'Additional details';
    bool isModalLoading = false;

    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: cardColor,
      isDismissible: false,
      enableDrag: false,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setModalState) {
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
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        IconButton(
                          onPressed: isModalLoading
                              ? null
                              : () => Navigator.of(context).pop(),
                          icon: Icon(Icons.close, color: textSecondary),
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
                              subtitle: r.placeholder.isNotEmpty
                                  ? Text(r.placeholder)
                                  : null,
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
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              hintText: placeholder.isNotEmpty
                                  ? placeholder
                                  : 'Additional details (optional)',
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
                                          await Future.delayed(
                                            const Duration(milliseconds: 300),
                                          );

                                          // Close modal
                                          if (context.mounted) {
                                            Navigator.of(context).pop();
                                          }

                                          // Start cancellation process
                                          _confirmCancellation(
                                            bookingId: bookingId,
                                            reasonText:
                                                additionalText.isNotEmpty
                                                ? additionalText
                                                : (reasons
                                                      .firstWhere(
                                                        (r) =>
                                                            r.id ==
                                                            selectedReasonId,
                                                      )
                                                      .text),
                                            reasonId: selectedReasonId,
                                          );
                                        },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: errorColor,
                                    foregroundColor: Colors.white,
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 16,
                                    ),
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
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
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
      log('Confirming cancellation via Proxy...');
      final mainUri = Uri.parse('${baseUrl}Cabapi');
      final bodyMap = {
        "bookingId": bookingId,
        "reason": reasonText,
        "reasonId": reasonId,
      };

      final response = await http
          .post(
            mainUri,
            body: {
              "link": "${cabBaseUrl}api/cpapi/booking/cancelBooking",
              "data": jsonEncode(bodyMap),
            },
          )
          .timeout(const Duration(seconds: 20));

      if (response.statusCode == 200) {
        final fullDecoded = jsonDecode(response.body);
        final decoded = fullDecoded['message'] ?? fullDecoded;

        if (decoded['success'] == true && decoded['data'] != null) {
          final data = decoded['data'];
          final refundedAmount = data['refundAmount'] ?? 0;
          final cancellationCharge = data['cancellationCharge'] ?? 0;
          final message = data['message'] ?? 'Booking cancelled successfully';
          final cancelledBookingId = data['bookingId'] ?? bookingId;

          // Calculate rounded commission-inclusive refund amount
          final double baseRefundedAmount = double.parse(
            refundedAmount.toString(),
          );
          final double totalRefundedAmount =
              (await commissionProvider.calculateAmountWithCommission(
                baseRefundedAmount,
              )).roundToDouble();

          await _callCabStatusApi(
            bookingId: widget.tableID,
            type: 'cancel',
            request: jsonEncode(bodyMap),
            response: response.body,
            refundAmount: totalRefundedAmount,
          );

          // Show success dialog
          await showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            backgroundColor: cardColor,
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
                      Icon(Icons.check_circle, color: successColor, size: 60),
                      const SizedBox(height: 12),
                      Text(
                        'Cancellation Successful',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: maincolor1,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        message,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.black87,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 20),
                      _buildCancellationInfoItem(
                        'Booking ID',
                        cancelledBookingId,
                        Icons.confirmation_number_outlined,
                      ),
                      _buildCancellationInfoItem(
                        'Refund Amount',
                        '₹${totalRefundedAmount.toStringAsFixed(0)}',
                        Icons.currency_rupee,
                      ),
                      _buildCancellationInfoItem(
                        'Cancellation Charge',
                        '₹$cancellationCharge',
                        Icons.money_off_csred_outlined,
                      ),
                      const SizedBox(height: 16),
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: warningColor.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: warningColor.withOpacity(0.3),
                          ),
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.info_outline, color: warningColor),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                'Refund will be credited within 5–7 working days.',
                                style: const TextStyle(
                                  fontSize: 13,
                                  color: Colors.black87,
                                ),
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
                          await Future.delayed(
                            const Duration(milliseconds: 300),
                          );
                          // Reload both booking details and booking list after closing success dialog
                          if (mounted) {
                            _reloadBookingDetails();
                            _reloadBookingList();
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: maincolor1,
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
      _showError(
        'Failed to cancel booking. Please check your connection and try again.',
      );
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
        log(
          '🔄 Reloading booking details after cancellation - Booking ID: ${widget.bookingId}',
        );
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
      log(
        '✅ Refreshing booking list after cancellation - Found BookedInfoBloc',
      );
      bookedInfoBloc.add(BookedInfoEvent.fetchList());
    } catch (e, stackTrace) {
      // BookedInfoBloc might not be available in this context
      log(
        '❌ Could not refresh booking list from parent context: $e',
        error: e,
        stackTrace: stackTrace,
      );
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
      leading: Icon(icon, color: textSecondary),
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
        headers: {"Content-Type": "application/x-www-form-urlencoded"},
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
        log(
          'CAB Status API failed with status: ${cabStatusResponse.statusCode}',
        );
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
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        backgroundColor: errorColor,
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
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(28),
            decoration: BoxDecoration(
              color: errorColor.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(Iconsax.cloud_cross, size: 56, color: errorColor),
          ),
          const SizedBox(height: 32),
          Text(
            'Connection Issue',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w900,
              color: maincolor1,
              letterSpacing: -0.5,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            'The server is currently busy or experiencing a technical delay. Your data is safe—please try refreshing.',
            style: TextStyle(
              fontSize: 14,
              color: textSecondary,
              height: 1.5,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 40),
          SizedBox(
            width: double.infinity,
            height: 56,
            child: ElevatedButton(
              onPressed: () {
                context.read<BookedDetailsBloc>().add(
                  BookedDetailsEvent.fetchDetails(widget.bookingId),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: maincolor1,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                elevation: 0,
              ),
              child: const Text(
                'TRY REFRESHING',
                style: TextStyle(
                  fontWeight: FontWeight.w900,
                  letterSpacing: 1,
                  fontSize: 14,
                ),
              ),
            ),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Back to List',
              style: TextStyle(
                color: textSecondary,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInitialState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 45,
            height: 45,
            child: CircularProgressIndicator(
              strokeWidth: 3,
              color: secondaryColor,
              backgroundColor: secondaryColor.withOpacity(0.1),
            ),
          ),
          const SizedBox(height: 24),
          Text(
            'Syncing Booking Details...',
            style: TextStyle(
              fontSize: 14,
              color: textSecondary,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.2,
            ),
          ),
        ],
      ),
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

  _CancellationReason({
    required this.id,
    required this.text,
    required this.placeholder,
  });
}
