import 'dart:developer';

import 'package:minna/comman/const/const.dart';
import 'package:minna/flight/application/fare%20request/fare_request_bloc.dart';
import 'package:minna/flight/application/nationality/nationality_bloc.dart';
import 'package:minna/flight/application/search%20data/search_data_bloc.dart';
import 'package:minna/flight/application/trip%20request/trip_request_bloc.dart';
import 'package:minna/flight/domain/trip%20resp/trip_respo.dart';
import 'package:minna/flight/infrastracture/commission/commission_service.dart';
import 'package:minna/flight/presendation/booking%20page/booking_flight.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';

class FlightSearchPage extends StatelessWidget {
  final String tripType;
  FlightSearchPage({super.key, required this.tripType});

  // Color Theme - Consistent with home page
  // Colors are now used from minna/comman/const/const.dart

  @override
  Widget build(BuildContext context) {
    final searchState = context.read<SearchDataBloc>().state;

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: maincolor1,
        elevation: 0,
        toolbarHeight: 70,
        centerTitle: false,
        iconTheme: const IconThemeData(color: Colors.white, size: 22),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Text(
                  searchState.from?.code ?? '---',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w900,
                    color: Colors.white,
                    letterSpacing: 1,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Icon(
                    Iconsax.arrow_right_1,
                    color: secondaryColor,
                    size: 14,
                  ),
                ),
                Text(
                  searchState.to?.code ?? '---',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w900,
                    color: Colors.white,
                    letterSpacing: 1,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 2),
            Text(
              '${DateFormat('MMM dd').format(searchState.departureDate)}${searchState.returnDate != null ? ' - ${DateFormat('MMM dd').format(searchState.returnDate!)}' : ''} • ${searchState.travellers.values.reduce((a, b) => a + b)} Traveller${searchState.travellers.values.reduce((a, b) => a + b) > 1 ? 's' : ''}',
              style: TextStyle(
                fontSize: 11,
                color: Colors.white.withOpacity(0.8),
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(Iconsax.filter_edit, color: Colors.white, size: 22),
            onPressed: () {
              // Add filter functionality
            },
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: SafeArea(
        child: BlocConsumer<TripRequestBloc, TripRequestState>(
          listener: (context, state) {
            if (state.getdata == 1) {
              if (searchState.from != null && searchState.to != null) {
                context.read<TripRequestBloc>().add(
                  TripRequestEvent.getFlightinfo(
                    fromAirportinfo: searchState.from!,
                    toAirportinfo: searchState.to!,
                  ),
                );
              }
            }
          },
          builder: (context, state) {
            final flightOptions = state.respo ?? [];

            return state.isLoading
                ? _buildLoadingPage()
                : flightOptions.isNotEmpty
                ? _buildFlightList(context, flightOptions, state, tripType)
                : _buildNoFlightsWidget(context);
          },
        ),
      ),
    );
  }

  Widget _buildFlightList(
    BuildContext context,
    List<FlightOptionElement> flights,
    TripRequestState state,
    String tripType,
  ) {
    return Column(
      children: [
        // Results Header
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          color: cardColor,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${flights.length} Flights Found',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: textPrimary,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: secondaryColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: secondaryColor.withOpacity(0.3)),
                ),
                child: Text(
                  'Best Price',
                  style: TextStyle(
                    fontSize: 12,
                    color: secondaryColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        Expanded(
          child: ListView.separated(
            itemCount: flights.length,
            separatorBuilder: (context, index) => const SizedBox(height: 12),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            itemBuilder: (context, index) {
              final option = flights[index];
              return FlightCard(
                tripType: tripType,
                flightOption: option,
                isLoading: state.isflightLoading,
                primaryColor: maincolor1,
                secondaryColor: secondaryColor,
                backgroundColor: backgroundColor,
                cardColor: cardColor,
                textPrimary: textPrimary,
                textSecondary: textSecondary,
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildNoFlightsWidget(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 160,
            height: 160,
            decoration: BoxDecoration(
              color: maincolor1.withOpacity(0.05),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Iconsax.airplane,
              size: 60,
              color: maincolor1.withOpacity(0.2),
            ),
          ),
          const SizedBox(height: 32),
          Text(
            'No Flights Found',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w900,
              color: maincolor1,
              letterSpacing: -0.5,
            ),
          ),
          const SizedBox(height: 12),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Text(
              'We couldn\'t find any flights matching your criteria. Please try different dates or airports.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: textSecondary,
                height: 1.5,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          const SizedBox(height: 32),
          SizedBox(
            width: 220,
            height: 54,
            child: ElevatedButton(
              onPressed: () => Navigator.pop(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: maincolor1,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                elevation: 0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Iconsax.search_status, size: 20, color: Colors.white),
                  const SizedBox(width: 10),
                  Text(
                    'Modify Search',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLoadingPage() {
    return ListView.builder(
      itemCount: 6,
      padding: const EdgeInsets.all(16),
      itemBuilder: (context, index) {
        return Container(
          margin: const EdgeInsets.only(bottom: 16),
          decoration: BoxDecoration(
            color: cardColor,
            borderRadius: BorderRadius.circular(16),
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
            child: Column(
              children: [
                // Airline and price shimmer
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Shimmer.fromColors(
                      baseColor: Colors.grey[300]!,
                      highlightColor: Colors.grey[100]!,
                      child: Container(
                        width: 100,
                        height: 20,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                    Shimmer.fromColors(
                      baseColor: Colors.grey[300]!,
                      highlightColor: Colors.grey[100]!,
                      child: Container(
                        width: 80,
                        height: 24,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                // Flight route shimmer
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Shimmer.fromColors(
                          baseColor: Colors.grey[300]!,
                          highlightColor: Colors.grey[100]!,
                          child: Container(
                            width: 60,
                            height: 16,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Shimmer.fromColors(
                          baseColor: Colors.grey[300]!,
                          highlightColor: Colors.grey[100]!,
                          child: Container(
                            width: 100,
                            height: 20,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                        ),
                      ],
                    ),

                    // Duration and plane
                    Column(
                      children: [
                        Shimmer.fromColors(
                          baseColor: Colors.grey[300]!,
                          highlightColor: Colors.grey[100]!,
                          child: Container(
                            width: 70,
                            height: 14,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Shimmer.fromColors(
                          baseColor: Colors.grey[300]!,
                          highlightColor: Colors.grey[100]!,
                          child: Container(
                            width: 24,
                            height: 24,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),
                      ],
                    ),

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Shimmer.fromColors(
                          baseColor: Colors.grey[300]!,
                          highlightColor: Colors.grey[100]!,
                          child: Container(
                            width: 60,
                            height: 16,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Shimmer.fromColors(
                          baseColor: Colors.grey[300]!,
                          highlightColor: Colors.grey[100]!,
                          child: Container(
                            width: 100,
                            height: 20,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                // Button shimmer
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Shimmer.fromColors(
                      baseColor: Colors.grey[300]!,
                      highlightColor: Colors.grey[100]!,
                      child: Container(
                        width: 100,
                        height: 16,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                    ),
                    Shimmer.fromColors(
                      baseColor: Colors.grey[300]!,
                      highlightColor: Colors.grey[100]!,
                      child: Container(
                        width: 120,
                        height: 40,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class FlightCard extends StatelessWidget {
  final FlightOptionElement flightOption;
  final bool isLoading;
  // Theme colors are now used from minna/comman/const/const.dart
  final Color primaryColor;
  final Color secondaryColor;
  final Color backgroundColor;
  final Color cardColor;
  final Color textPrimary;
  final String tripType;
  final Color textSecondary;

  const FlightCard({
    super.key,
    required this.tripType,
    required this.flightOption,
    required this.isLoading,
    required this.primaryColor,
    required this.secondaryColor,
    required this.backgroundColor,
    required this.cardColor,
    required this.textPrimary,
    required this.textSecondary,
  });

  // Helper method to determine travel type (Domestic/International)
  String _getTravelType(String tripType) {
    return tripType; // or 'International'
  }

  @override
  Widget build(BuildContext context) {
    final onwardLegs = flightOption.onwardLegs ?? [];
    final firstOnwardLeg = onwardLegs.firstOrNull;
    final lastOnwardLeg = onwardLegs.lastOrNull;

    final returnLegs = flightOption.returnLegs ?? [];
    final firstReturnLeg = returnLegs.firstOrNull;
    final lastReturnLeg = returnLegs.lastOrNull;

    // Calculate times and durations for onward journey
    final onwardDepartureTime = firstOnwardLeg?.departureTime != null
        ? DateTime.parse(firstOnwardLeg!.departureTime!)
        : DateTime.now();
    final onwardArrivalTime = lastOnwardLeg?.arrivalTime != null
        ? DateTime.parse(lastOnwardLeg!.arrivalTime!)
        : DateTime.now();
    final onwardDuration = onwardArrivalTime.difference(onwardDepartureTime);
    final onwardStops = (onwardLegs.length) - 1;

    // Calculate times and durations for return journey (if exists)
    DateTime? returnDepartureTime;
    DateTime? returnArrivalTime;
    Duration? returnDuration;
    int? returnStops;

    if (returnLegs.isNotEmpty) {
      returnDepartureTime = firstReturnLeg?.departureTime != null
          ? DateTime.parse(firstReturnLeg!.departureTime!)
          : DateTime.now();
      returnArrivalTime = lastReturnLeg?.arrivalTime != null
          ? DateTime.parse(lastReturnLeg!.arrivalTime!)
          : DateTime.now();
      returnDuration = returnArrivalTime.difference(returnDepartureTime);
      returnStops = (returnLegs.length) - 1;
    }

    final price = flightOption.selectedFare?.aprxTotalAmount ?? 0;
    final travelType = _getTravelType(tripType);

    return Container(
      margin: const EdgeInsets.only(bottom: 4),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey.shade100, width: 1),
        boxShadow: [
          BoxShadow(
            color: maincolor1.withOpacity(0.04),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Airline header with price
            _buildAirlineHeader(context, price, travelType),
            const SizedBox(height: 20),

            // Flight route
            _buildFlightRoute(
              firstLeg: firstOnwardLeg,
              lastLeg: lastOnwardLeg,
              departureTime: onwardDepartureTime,
              arrivalTime: onwardArrivalTime,
              duration: onwardDuration,
              stops: onwardStops,
            ),

            // Return journey if exists
            if (returnLegs.isNotEmpty) ...[
              const SizedBox(height: 16),
              _buildReturnIndicator(),
              const SizedBox(height: 16),
              _buildFlightRoute(
                firstLeg: firstReturnLeg,
                lastLeg: lastReturnLeg,
                departureTime: returnDepartureTime!,
                arrivalTime: returnArrivalTime!,
                duration: returnDuration!,
                stops: returnStops!,
              ),
            ],
            const SizedBox(height: 20),

            // Action buttons
            _buildActionButtons(context),
          ],
        ),
      ),
    );
  }

  Widget _buildAirlineHeader(
    BuildContext context,
    double price,
    String travelType,
  ) {
    // Calculate commission and total amount
    final commissionService = FlightCommissionService();
    double commission = 0;
    double totalWithCommission = price;

    try {
      commission = commissionService.calculateCommission(
        actualAmount: price,
        travelType: travelType,
      );
      totalWithCommission = commissionService.getTotalAmountWithCommission(
        actualAmount: price,
        travelType: travelType,
      );
    } catch (e) {
      log('Error calculating commission: $e');
      // Use fallback values if commission calculation fails
      commission = 0;
      totalWithCommission = price;
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Row(
            children: [
              // Airline Logo
              if (isLoading)
                Shimmer.fromColors(
                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.grey[100]!,
                  child: Container(
                    width: 50,
                    height: 35,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                )
              else
                Container(
                  width: 50,
                  height: 35,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.grey.shade200),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Image.network(
                        flightOption.flightimg ?? "",
                        fit: BoxFit.contain,
                        errorBuilder: (context, error, stackTrace) => Container(
                          color: backgroundColor,
                          child: Icon(Iconsax.airplane, color: textSecondary),
                        ),
                      ),
                    ),
                  ),
                ),

              const SizedBox(width: 12),

              // Airline Info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (isLoading)
                      Shimmer.fromColors(
                        baseColor: Colors.grey[300]!,
                        highlightColor: Colors.grey[100]!,
                        child: Container(
                          height: 16,
                          width: 120,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                      )
                    else
                      Text(
                        flightOption.flightName ?? '---',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          color: textPrimary,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    const SizedBox(height: 4),
                    if (isLoading)
                      Shimmer.fromColors(
                        baseColor: Colors.grey[300]!,
                        highlightColor: Colors.grey[100]!,
                        child: Container(
                          height: 12,
                          width: 80,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                      )
                    else
                      Text(
                        flightOption.ticketingCarrier ?? '---',
                        style: TextStyle(
                          fontSize: 12,
                          color: textSecondary,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),

        // Price and More Fare
        if (isLoading)
          Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  height: 20,
                  width: 80,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                const SizedBox(height: 6),
                Container(
                  height: 28,
                  width: 90,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
              ],
            ),
          )
        else
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '₹${totalWithCommission.toStringAsFixed(0)}',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              const SizedBox(height: 2),
              // Text(
              //   'incl. ₹${commission.toStringAsFixed(0)} service charge',
              //   style: TextStyle(
              //     fontSize: 10,
              //     color: textSecondary,
              //   ),
              // ),
              Text(
                'Incl. taxes',
                style: TextStyle(fontSize: 10, color: textSecondary),
              ),

              const SizedBox(height: 6),
              if (flightOption.flightFares != null &&
                  flightOption.flightFares!.isNotEmpty)
                InkWell(
                  onTap: () {
                    _showFareOptionsBottomSheet(context, flightOption);
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: secondaryColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: secondaryColor.withOpacity(0.3),
                      ),
                    ),
                    child: Text(
                      'More Fares',
                      style: TextStyle(
                        fontSize: 8,
                        color: secondaryColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
            ],
          ),
      ],
    );
  }

  Widget _buildFlightRoute({
    required FlightLeg? firstLeg,
    required FlightLeg? lastLeg,
    required DateTime departureTime,
    required DateTime arrivalTime,
    required Duration duration,
    required int stops,
  }) {
    return Row(
      children: [
        // Departure
        Expanded(
          flex: 2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                DateFormat('HH:mm').format(departureTime),
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w900,
                  color: maincolor1,
                  letterSpacing: -0.5,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                firstLeg?.origin ?? '--',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: textPrimary,
                ),
              ),
            ],
          ),
        ),

        // Route Line
        Expanded(
          flex: 3,
          child: Column(
            children: [
              Text(
                '${duration.inHours}h ${duration.inMinutes.remainder(60)}m',
                style: TextStyle(
                  fontSize: 10,
                  color: textSecondary,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 4),
              Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    height: 1.5,
                    width: double.infinity,
                    color: Colors.grey.shade200,
                  ),
                  Positioned(
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.grey.shade200),
                      ),
                      child: Icon(
                        Iconsax.airplane,
                        size: 12,
                        color: secondaryColor,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Text(
                stops == 0 ? 'Non-stop' : '$stops Stop${stops > 1 ? 's' : ''}',
                style: TextStyle(
                  fontSize: 10,
                  color: stops == 0
                      ? Colors.green.shade600
                      : Colors.orange.shade700,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),

        // Arrival
        Expanded(
          flex: 2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                DateFormat('HH:mm').format(arrivalTime),
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w900,
                  color: maincolor1,
                  letterSpacing: -0.5,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                lastLeg?.destination ?? '--',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: textPrimary,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildReturnIndicator() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: secondaryColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.swap_horiz_rounded, size: 16, color: secondaryColor),
          const SizedBox(width: 8),
          Text(
            'Return Flight',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: secondaryColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return Row(
      children: [
        if (isLoading)
          Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Container(
              width: 100,
              height: 16,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          )
        else
          TextButton(
            onPressed: () {
              _showFlightDetails(context, flightOption);
            },
            style: TextButton.styleFrom(
              padding: EdgeInsets.zero,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            child: Row(
              children: [
                Icon(
                  Icons.info_outline_rounded,
                  size: 16,
                  color: textSecondary,
                ),
                const SizedBox(width: 6),
                Text(
                  'Flight Details',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: textSecondary,
                  ),
                ),
              ],
            ),
          ),

        const Spacer(),

        if (isLoading)
          Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Container(
              width: 120,
              height: 40,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          )
        else
          SizedBox(
            height: 42,
            child: ElevatedButton(
              onPressed: () {
                _handleBookNow(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryColor,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 2,
                padding: const EdgeInsets.symmetric(horizontal: 20),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.airplane_ticket_rounded, size: 16),
                  const SizedBox(width: 6),
                  Text(
                    'Book Now',
                    style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }

  void _handleBookNow(BuildContext context) {
    context.read<NationalityBloc>().add(NationalityEvent.getList());

    final tripState = context.read<TripRequestBloc>().state;
    final searchData = context.read<SearchDataBloc>().state;

    context.read<FareRequestBloc>().add(
      FareRequestEvent.getFareRequestApi(
        token: tripState.token ?? '',
        flightTrip: flightOption,
        tripMode: searchData.oneWay ? 'O' : 'S',
      ),
    );

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FlightBookingPage(triptype: tripType),
      ),
    );
  }

  void _showFareOptionsBottomSheet(
    BuildContext context,
    FlightOptionElement flight,
  ) {
    final List<FreeBaggage> baggageList =
        flight.flightLegs?.firstOrNull?.freeBaggages ?? [];
    final travelType = _getTravelType(tripType);

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.85,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
          ),
          child: Column(
            children: [
              // Header
              Container(
                padding: const EdgeInsets.fromLTRB(24, 16, 24, 24),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(24),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: maincolor1.withOpacity(0.05),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Container(
                      width: 40,
                      height: 4,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Select Your Fare",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w900,
                                color: maincolor1,
                                letterSpacing: -0.5,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              "Choose your preferred travel class",
                              style: TextStyle(
                                fontSize: 13,
                                color: textSecondary,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        GestureDetector(
                          onTap: () => Navigator.pop(context),
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: backgroundColor,
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Iconsax.close_circle,
                              color: textSecondary,
                              size: 20,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              Expanded(
                child: ListView.separated(
                  padding: const EdgeInsets.all(16),
                  itemCount: flight.flightFares?.length ?? 0,
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 12),
                  itemBuilder: (context, index) {
                    final fare = flight.flightFares?[index];
                    final baggageInfo = baggageList.firstWhere(
                      (baggage) => baggage.fid == fare?.fid,
                      orElse: () => FreeBaggage(),
                    );

                    return _buildFareOptionCard(
                      context,
                      fare,
                      baggageInfo,
                      flight,
                      travelType,
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

  Widget _buildFareOptionCard(
    BuildContext context,
    FlightFare? fare,
    FreeBaggage baggageInfo,
    FlightOptionElement flight,
    String travelType,
  ) {
    final isSelected = flight.selectedFare == fare;
    final commissionService = FlightCommissionService();

    // Calculate commission and total for this fare
    double actualAmount = fare?.totalAmount ?? 0;
    double commission = 0;
    double totalWithCommission = actualAmount;

    try {
      commission = commissionService.calculateCommission(
        actualAmount: actualAmount,
        travelType: travelType,
      );
      totalWithCommission = commissionService.getTotalAmountWithCommission(
        actualAmount: actualAmount,
        travelType: travelType,
      );
    } catch (e) {
      print('Error calculating commission for fare: $e');
    }
    return GestureDetector(
      onTap: () {
        if (fare != null) {
          context.read<TripRequestBloc>().add(
            TripRequestEvent.changeFare(
              selectedFare: fare,
              selectedTrip: flight,
            ),
          );
          Navigator.pop(context);
        }
      },
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: isSelected ? maincolor1.withOpacity(0.02) : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? maincolor1 : Colors.grey.shade100,
            width: isSelected ? 2 : 1.5,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: maincolor1.withOpacity(0.05),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ]
              : [],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(
                      isSelected ? Iconsax.tick_circle5 : Iconsax.record,
                      color: isSelected ? maincolor1 : Colors.grey.shade300,
                      size: 22,
                    ),
                    const SizedBox(width: 12),
                    Text(
                      fare?.fareName ?? 'Standard',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w900,
                        color: maincolor1,
                      ),
                    ),
                  ],
                ),
                Text(
                  '₹${totalWithCommission.toStringAsFixed(0)}',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w900,
                    color: maincolor1,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: backgroundColor,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  _buildFareBenefitRow(
                    Iconsax.bag_2,
                    'Check-in: ${baggageInfo.adtBaggage ?? 'Not Specified'}',
                    maincolor1,
                  ),
                  const SizedBox(height: 8),
                  _buildFareBenefitRow(
                    Iconsax.briefcase,
                    'Cabin: ${baggageInfo.adtHandBaggage ?? 'Not Specified'}',
                    maincolor1,
                  ),
                  const SizedBox(height: 8),
                  _buildFareBenefitRow(
                    Iconsax.verify,
                    'Cancellation: As per airline policy',
                    secondaryColor,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFareBenefitRow(IconData icon, String text, Color color) {
    return Row(
      children: [
        Icon(icon, size: 14, color: color),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: textPrimary,
            ),
          ),
        ),
      ],
    );
  }

  void _showFlightDetails(BuildContext context, FlightOptionElement option) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return FlightDetailsBottomSheet(
          tripType: tripType,
          flightOption: option,
          primaryColor: primaryColor,
          secondaryColor: secondaryColor,
          backgroundColor: backgroundColor,
          cardColor: cardColor,
          textPrimary: textPrimary,
          textSecondary: textSecondary,
        );
      },
    );
  }
}

class FlightDetailsBottomSheet extends StatelessWidget {
  final FlightOptionElement flightOption;
  final Color primaryColor;
  final Color secondaryColor;
  final Color backgroundColor;
  final Color cardColor;
  final Color textPrimary;
  final Color textSecondary;
  final String tripType;
  const FlightDetailsBottomSheet({
    super.key,
    required this.flightOption,
    required this.primaryColor,
    required this.secondaryColor,
    required this.backgroundColor,
    required this.cardColor,
    required this.textPrimary,
    required this.tripType,
    required this.textSecondary,
  });

  // Helper method to determine travel type
  String _getTravelType(String travelType) {
    // Implement your logic to determine domestic/international
    return travelType; // or 'International'
  }

  @override
  Widget build(BuildContext context) {
    final travelType = _getTravelType(tripType);
    final commissionService = FlightCommissionService();

    // Calculate commission and total
    double actualAmount = flightOption.selectedFare?.aprxTotalAmount ?? 0;
    double commission = 0;
    double totalWithCommission = actualAmount;

    try {
      commission = commissionService.calculateCommission(
        actualAmount: actualAmount,
        travelType: travelType,
      );
      totalWithCommission = commissionService.getTotalAmountWithCommission(
        actualAmount: actualAmount,
        travelType: travelType,
      );
    } catch (e) {
      log('Error calculating commission in details: $e');
    }

    return Container(
      height: MediaQuery.of(context).size.height * 0.9,
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        children: [
          // Header
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: cardColor,
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(24),
              ),
              boxShadow: [
                BoxShadow(
                  color: maincolor1.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Flight Details',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w900,
                        color: maincolor1,
                        letterSpacing: -0.5,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Complete itinerary & fare details',
                      style: TextStyle(
                        fontSize: 13,
                        color: textSecondary,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: backgroundColor,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Iconsax.close_circle,
                      color: textSecondary,
                      size: 20,
                    ),
                  ),
                ),
              ],
            ),
          ),

          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Flight Summary
                  _buildFlightSummary(
                    actualAmount,
                    commission,
                    totalWithCommission,
                  ),
                  const SizedBox(height: 24),

                  // Flight Legs
                  _buildFlightLegs(),
                  const SizedBox(height: 24),

                  // Fare Breakdown
                  // _buildFareBreakdownWithCommission(actualAmount,commission,totalWithCommission),
                ],
              ),
            ),
          ),

          // Book Button
          // Container(
          //   padding: const EdgeInsets.all(20),
          //   decoration: BoxDecoration(
          //     color: cardColor,
          //     border: Border(
          //       top: BorderSide(color: Colors.grey.shade200),
          //     ),
          //   ),
          //   child: SizedBox(
          //     width: double.infinity,
          //     height: 50,
          //     child: ElevatedButton(
          //       onPressed: () {
          //         Navigator.pop(context);
          //         // Handle booking
          //       },
          //       style: ElevatedButton.styleFrom(
          //         backgroundColor: primaryColor,
          //         foregroundColor: Colors.white,
          //         shape: RoundedRectangleBorder(
          //           borderRadius: BorderRadius.circular(12),
          //         ),
          //         elevation: 2,
          //       ),
          //       child: Text(
          //         'Book This Flight',
          //         style: TextStyle(
          //           fontSize: 16,
          //           fontWeight: FontWeight.w600,
          //         ),
          //       ),
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }

  Widget _buildFlightSummary(
    double actualAmount,
    double commission,
    double totalWithCommission,
  ) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Container(
            width: 50,
            height: 35,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.grey.shade300),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                flightOption.flightimg ?? "",
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) => Container(
                  color: backgroundColor,
                  child: Icon(Icons.airlines_rounded, color: textSecondary),
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  flightOption.flightName ?? '---',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: textPrimary,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  flightOption.ticketingCarrier ?? '---',
                  style: TextStyle(fontSize: 12, color: textSecondary),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '₹${totalWithCommission.toStringAsFixed(0)}',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Text(
                'Incl. taxes',
                style: TextStyle(fontSize: 10, color: textSecondary),
              ),
              // Text(
              //   'incl. ₹${commission.toStringAsFixed(0)} service',
              //   style: TextStyle(
              //     fontSize: 10,
              //     color: textSecondary,
              //   ),
              // ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFlightLegs() {
    final onwardLegs = flightOption.onwardLegs ?? [];
    final returnLegs = flightOption.returnLegs ?? [];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (onwardLegs.isNotEmpty) ...[
          _buildLegSection('Onward Flight', onwardLegs),
          if (returnLegs.isNotEmpty) const SizedBox(height: 24),
        ],
        if (returnLegs.isNotEmpty)
          _buildLegSection('Return Flight', returnLegs),
      ],
    );
  }

  Widget _buildLegSection(String title, List<FlightLeg> legs) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: textPrimary,
          ),
        ),
        const SizedBox(height: 12),
        ...legs.map((leg) => _buildLegCard(leg)),
      ],
    );
  }

  Widget _buildLegCard(FlightLeg leg) {
    final departureTime = leg.departureTime != null
        ? DateTime.parse(leg.departureTime!)
        : DateTime.now();
    final arrivalTime = leg.arrivalTime != null
        ? DateTime.parse(leg.arrivalTime!)
        : DateTime.now();
    final duration = arrivalTime.difference(departureTime);

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey.shade100, width: 1.5),
        boxShadow: [
          BoxShadow(
            color: maincolor1.withOpacity(0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      DateFormat('HH:mm').format(departureTime),
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: textPrimary,
                      ),
                    ),
                    Text(
                      leg.origin ?? '--',
                      style: TextStyle(fontSize: 14, color: textPrimary),
                    ),
                    Text(
                      leg.originName ?? '--',
                      style: TextStyle(fontSize: 12, color: textSecondary),
                    ),
                  ],
                ),
              ),
              Column(
                children: [
                  Text(
                    '${duration.inHours}h ${duration.inMinutes.remainder(60)}m',
                    style: TextStyle(fontSize: 12, color: textSecondary),
                  ),
                  const SizedBox(height: 8),
                  Icon(Icons.flight_rounded, color: primaryColor, size: 20),
                ],
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      DateFormat('HH:mm').format(arrivalTime),
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: textPrimary,
                      ),
                    ),
                    Text(
                      leg.destination ?? '--',
                      style: TextStyle(fontSize: 14, color: textPrimary),
                    ),
                    Text(
                      leg.destinationName ?? '--',
                      style: TextStyle(fontSize: 12, color: textSecondary),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Divider(color: Colors.grey.shade300),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Flight ${leg.airlineCode} ${leg.flightNo}',
                style: TextStyle(fontSize: 12, color: textSecondary),
              ),
              Text(
                'Terminal ${leg.departureTerminal ?? '-'}',
                style: TextStyle(fontSize: 12, color: textSecondary),
              ),
            ],
          ),

          // Baggage & Extras
          if ((leg.freeBaggages != null && leg.freeBaggages!.isNotEmpty) ||
              (flightOption.selectedFare != null &&
                  flightOption.selectedFare!.fareName != null)) ...[
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: backgroundColor,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey.shade200),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Baggage & Extras',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: primaryColor,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      if (flightOption.selectedFare != null &&
                          flightOption.selectedFare!.fareName != null)
                        _buildInfoBadge(
                          Icons.airplane_ticket_rounded,
                          'Fare: ${flightOption.selectedFare!.fareName}',
                          primaryColor,
                        ),
                      if (leg.freeBaggages != null &&
                          leg.freeBaggages!.isNotEmpty) ...[
                        if (leg.freeBaggages!.first.adtBaggage != null &&
                            leg.freeBaggages!.first.adtBaggage!.isNotEmpty)
                          _buildInfoBadge(
                            Icons.work_rounded,
                            'Check-in: ${leg.freeBaggages!.first.adtBaggage}',
                            secondaryColor,
                          ),
                        if (leg.freeBaggages!.first.adtHandBaggage != null &&
                            leg.freeBaggages!.first.adtHandBaggage!.isNotEmpty)
                          _buildInfoBadge(
                            Icons.business_center_rounded,
                            'Cabin: ${leg.freeBaggages!.first.adtHandBaggage}',
                            secondaryColor,
                          ),
                      ],
                    ],
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildInfoBadge(IconData icon, String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.06),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: color.withOpacity(0.15)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: color),
          const SizedBox(width: 6),
          Text(
            text,
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w700,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFareBreakdownWithCommission(
    double actualAmount,
    double commission,
    double totalWithCommission,
  ) {
    final selectedFare = flightOption.selectedFare;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Fare Breakdown',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: textPrimary,
            ),
          ),
          const SizedBox(height: 16),

          // Base fare breakdown
          if (selectedFare?.fares != null)
            ...selectedFare!.fares!.map((fare) => _buildFareRow(fare)),

          // Commission row
          _buildCommissionRow(commission + selectedFare!.aprxTotalTax!),

          const SizedBox(height: 12),
          Divider(color: Colors.grey.shade400),
          const SizedBox(height: 12),

          // Total amount
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total Amount',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: textPrimary,
                ),
              ),
              Text(
                '₹${totalWithCommission.toStringAsFixed(0)}',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFareRow(Fare fare) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '${fare.ptc} Passenger',
            style: TextStyle(fontSize: 14, color: textPrimary),
          ),
          Text(
            '₹${fare.baseFare?.toStringAsFixed(0) ?? '0'}',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: textPrimary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCommissionRow(double totalTax) {
    return Container(
      // padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Tax & Fees',
            style: TextStyle(fontSize: 14, color: textPrimary),
          ),
          Text(
            '₹${totalTax.toStringAsFixed(0)}',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: textPrimary,
            ),
          ),
        ],
      ),
    );
  }
}
