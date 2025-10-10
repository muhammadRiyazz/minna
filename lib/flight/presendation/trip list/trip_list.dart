import 'package:minna/comman/const/const.dart';
import 'package:minna/flight/application/fare%20request/fare_request_bloc.dart';
import 'package:minna/flight/application/nationality/nationality_bloc.dart';
import 'package:minna/flight/application/search%20data/search_data_bloc.dart';
import 'package:minna/flight/application/trip%20request/trip_request_bloc.dart';
import 'package:minna/flight/domain/trip%20resp/trip_respo.dart';
import 'package:minna/flight/presendation/booking%20page/booking_flight.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';
import 'package:dotted_line/dotted_line.dart';

class FlightSearchPage extends StatelessWidget {
   FlightSearchPage({super.key});

  // Color Theme - Consistent with home page
  final Color _primaryColor = Colors.black;
  final Color _secondaryColor = Color(0xFFD4AF37); // Gold
  final Color _accentColor = Color(0xFFC19B3C); // Darker Gold
  final Color _backgroundColor = Color(0xFFF8F9FA);
  final Color _cardColor = Colors.white;
  final Color _textPrimary = Colors.black;
  final Color _textSecondary = Color(0xFF666666);
  final Color _textLight = Color(0xFF999999);

  @override
  Widget build(BuildContext context) {
    final searchState = context.read<SearchDataBloc>().state;

    return Scaffold(
      backgroundColor: _backgroundColor,
      appBar: AppBar(
        backgroundColor: _primaryColor,
        elevation: 0,
        toolbarHeight: 80,
        iconTheme: const IconThemeData(color: Colors.white),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${searchState.from?.name ?? 'From'} → ${searchState.to?.name ?? 'To'}',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              searchState.returnDate != null
                  ? '${DateFormat('MMM dd, yyyy').format(searchState.departureDate)} → ${DateFormat('MMM dd, yyyy').format(searchState.returnDate!)}'
                  : '${DateFormat('MMM dd, yyyy').format(searchState.departureDate)} • One-way',
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[300],
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: IconButton(
              icon: Icon(Icons.filter_list_rounded, color: Colors.white),
              onPressed: () {
                // Add filter functionality
              },
            ),
          ),
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
                    ? _buildFlightList(context, flightOptions, state)
                    : _buildNoFlightsWidget(context);
          },
        ),
      ),
    );
  }

  Widget _buildFlightList(BuildContext context, List<FlightOptionElement> flights, TripRequestState state) {
    return Column(
      children: [
        // Results Header
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          color: _cardColor,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${flights.length} Flights Found',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: _textPrimary,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: _secondaryColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: _secondaryColor.withOpacity(0.3)),
                ),
                child: Text(
                  'Best Price',
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
        const SizedBox(height: 8),
        Expanded(
          child: ListView.separated(
            itemCount: flights.length,
            separatorBuilder: (context, index) => const SizedBox(height: 12),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            itemBuilder: (context, index) {
              final option = flights[index];
              return FlightCard(
                flightOption: option,
                isLoading: state.isflightLoading,
                primaryColor: _primaryColor,
                secondaryColor: _secondaryColor,
                backgroundColor: _backgroundColor,
                cardColor: _cardColor,
                textPrimary: _textPrimary,
                textSecondary: _textSecondary,
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
            width: 180,
            height: 180,
            decoration: BoxDecoration(
              color: _cardColor,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: Icon(
              Icons.airplanemode_inactive_rounded,
              size: 80,
              color: _textLight,
            ),
          ),
          const SizedBox(height: 32),
          Text(
            'No Flights Available',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: _textPrimary,
            ),
          ),
          const SizedBox(height: 12),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Text(
              'We couldn\'t find any flights matching your search criteria. Try adjusting your dates or route.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: _textSecondary,
                height: 1.5,
              ),
            ),
          ),
          const SizedBox(height: 32),
          Container(
            width: 200,
            height: 50,
            child: ElevatedButton(
              onPressed: () => Navigator.pop(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: _primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 2,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.search_rounded, size: 20, color: Colors.white),
                  const SizedBox(width: 8),
                  Text(
                    'Search Again',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
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
            color: _cardColor,
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
  final Color primaryColor;
  final Color secondaryColor;
  final Color backgroundColor;
  final Color cardColor;
  final Color textPrimary;
  final Color textSecondary;

  const FlightCard({
    super.key,
    required this.flightOption,
    required this.isLoading,
    required this.primaryColor,
    required this.secondaryColor,
    required this.backgroundColor,
    required this.cardColor,
    required this.textPrimary,
    required this.textSecondary,
  });

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

    return Container(
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 15,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            // Airline header with price
            _buildAirlineHeader(context, price),
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

  Widget _buildAirlineHeader(BuildContext context, double price) {
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
                    child: Image.network(
                      flightOption.flightimg ?? "",
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) =>
                          Container(
                            color: backgroundColor,
                            child: Icon(Icons.airlines_rounded, color: textSecondary),
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
                          fontSize: 14,
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
                '₹${price.toStringAsFixed(0)}',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              const SizedBox(height: 6),
              if (flightOption.flightFares != null && flightOption.flightFares!.isNotEmpty)
                InkWell(
                  onTap: () {
                    _showFareOptionsBottomSheet(context, flightOption);
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: secondaryColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: secondaryColor.withOpacity(0.3)),
                    ),
                    child: Text(
                      'More Fares',
                      style: TextStyle(
                        fontSize: 10,
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
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          // Time and airports
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
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: textPrimary,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      firstLeg?.origin ?? '--',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: textPrimary,
                      ),
                    ),
                    Text(
                      firstLeg?.originName ?? '--',
                      style: TextStyle(
                        fontSize: 11,
                        color: textSecondary,
                      ),
                    ),
                  ],
                ),
              ),

              // Duration and stops
              Column(
                children: [
                  Text(
                    '${duration.inHours}h ${duration.inMinutes.remainder(60)}m',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: textSecondary,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        height: 1,
                        width: 80,
                        color: textSecondary.withOpacity(0.3),
                      ),
                      Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: primaryColor,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.flight_rounded,
                          size: 14,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '${stops == 0 ? 'Non-stop' : '$stops ${stops == 1 ? 'stop' : 'stops'}'}',
                    style: TextStyle(
                      fontSize: 10,
                      color: stops == 0 ? secondaryColor : textSecondary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      DateFormat('HH:mm').format(arrivalTime),
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: textPrimary,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      lastLeg?.destination ?? '--',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: textPrimary,
                      ),
                    ),
                    Text(
                      lastLeg?.destinationName ?? '--',textAlign: TextAlign.end,
                      style: TextStyle(
                        
                        fontSize: 11,
                        color: textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
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
                Icon(Icons.info_outline_rounded, size: 16, color: textSecondary),
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
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                    ),
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
      MaterialPageRoute(builder: (context) => FlightBookingPage()),
    );
  }

  void _showFareOptionsBottomSheet(BuildContext context, FlightOptionElement flight) {
    final List<FreeBaggage> baggageList = flight.flightLegs?.firstOrNull?.freeBaggages ?? [];

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
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 10,
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Center(
                      child: Container(
                        width: 40,
                        height: 4,
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      "Select Your Fare",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: textPrimary,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "Choose the fare that suits your travel needs",
                      style: TextStyle(
                        fontSize: 14,
                        color: textSecondary,
                      ),
                    ),
                  ],
                ),
              ),

              Expanded(
                child: ListView.separated(
                  padding: const EdgeInsets.all(16),
                  itemCount: flight.flightFares?.length ?? 0,
                  separatorBuilder: (context, index) => const SizedBox(height: 12),
                  itemBuilder: (context, index) {
                    final fare = flight.flightFares?[index];
                    final baggageInfo = baggageList.firstWhere(
                      (baggage) => baggage.fid == fare?.fid,
                      orElse: () => FreeBaggage(),
                    );

                    return _buildFareOptionCard(context, fare, baggageInfo, flight);
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildFareOptionCard(BuildContext context, FlightFare? fare, FreeBaggage baggageInfo, FlightOptionElement flight) {
    final isSelected = flight.selectedFare == fare;
    
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
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected ? secondaryColor.withOpacity(0.05) : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? secondaryColor : Colors.grey.shade200,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  fare?.fareName ?? 'Standard',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: textPrimary,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: isSelected ? secondaryColor : Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    '₹${fare?.totalAmount ?? '0'}',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: isSelected ? Colors.white : textPrimary,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            
            // Baggage info
            if (_formatBaggage(baggageInfo.adtBaggage).isNotEmpty)
              _buildBaggageRow('Adult', _formatBaggage(baggageInfo.adtBaggage)),
            if (_formatBaggage(baggageInfo.chdBaggage).isNotEmpty)
              _buildBaggageRow('Child', _formatBaggage(baggageInfo.chdBaggage)),
            if (_formatBaggage(baggageInfo.infBaggage).isNotEmpty)
              _buildBaggageRow('Infant', _formatBaggage(baggageInfo.infBaggage)),
          ],
        ),
      ),
    );
  }

  Widget _buildBaggageRow(String type, String baggage) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '$type Baggage',
            style: TextStyle(
              fontSize: 12,
              color: textSecondary,
            ),
          ),
          Text(
            baggage,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: textPrimary,
            ),
          ),
        ],
      ),
    );
  }

  String _formatBaggage(String? baggage) {
    if (baggage == null || baggage.isEmpty) return '';
    return baggage.replaceAll('Kilograms', 'kg').replaceAll('Kilogram', 'kg');
  }

  void _showFlightDetails(BuildContext context, FlightOptionElement option) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return FlightDetailsBottomSheet(
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

  const FlightDetailsBottomSheet({
    super.key,
    required this.flightOption,
    required this.primaryColor,
    required this.secondaryColor,
    required this.backgroundColor,
    required this.cardColor,
    required this.textPrimary,
    required this.textSecondary,
  });

  @override
  Widget build(BuildContext context) {
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
              borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 10,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Flight Details',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: textPrimary,
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.close_rounded, color: textSecondary),
                  onPressed: () => Navigator.pop(context),
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
                  _buildFlightSummary(),
                  const SizedBox(height: 24),
                  
                  // Flight Legs
                  _buildFlightLegs(),
                  const SizedBox(height: 24),
                  
                  // Fare Breakdown
                  _buildFareBreakdown(),
                ],
              ),
            ),
          ),
          
          // Book Button
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: cardColor,
              border: Border(
                top: BorderSide(color: Colors.grey.shade200),
              ),
            ),
            child: SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  // Handle booking
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryColor,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 2,
                ),
                child: Text(
                  'Book This Flight',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFlightSummary() {
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
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) =>
                    Container(
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
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: textPrimary,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  flightOption.ticketingCarrier ?? '---',
                  style: TextStyle(
                    fontSize: 14,
                    color: textSecondary,
                  ),
                ),
              ],
            ),
          ),
          Text(
            '₹${flightOption.selectedFare?.aprxTotalAmount?.toStringAsFixed(0) ?? '0'}',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
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
        ...legs.map((leg) => _buildLegCard(leg)).toList(),
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
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
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
                      style: TextStyle(
                        fontSize: 14,
                        color: textPrimary,
                      ),
                    ),
                    Text(
                      leg.originName ?? '--',
                      style: TextStyle(
                        fontSize: 12,
                        color: textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                children: [
                  Text(
                    '${duration.inHours}h ${duration.inMinutes.remainder(60)}m',
                    style: TextStyle(
                      fontSize: 12,
                      color: textSecondary,
                    ),
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
                      style: TextStyle(
                        fontSize: 14,
                        color: textPrimary,
                      ),
                    ),
                    Text(
                      leg.destinationName ?? '--',
                      style: TextStyle(
                        fontSize: 12,
                        color: textSecondary,
                      ),
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
                style: TextStyle(
                  fontSize: 12,
                  color: textSecondary,
                ),
              ),
              Text(
                'Terminal ${leg.departureTerminal ?? '-'}',
                style: TextStyle(
                  fontSize: 12,
                  color: textSecondary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFareBreakdown() {
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
          if (selectedFare?.fares != null)
            ...selectedFare!.fares!.map((fare) => _buildFareRow(fare)).toList(),
          const SizedBox(height: 12),
          Divider(color: Colors.grey.shade400),
          const SizedBox(height: 12),
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
                '₹${selectedFare?.aprxTotalAmount?.toStringAsFixed(0) ?? '0'}',
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
            style: TextStyle(
              fontSize: 14,
              color: textPrimary,
            ),
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
}