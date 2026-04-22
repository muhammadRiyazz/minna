import 'dart:developer';

import 'package:minna/comman/const/const.dart';
import 'package:minna/flight/application/search%20data/search_data_bloc.dart';
import 'package:minna/flight/application/trip%20request/trip_request_bloc.dart';
import 'package:minna/flight/domain/triplist%20request/search_request.dart';
import 'package:minna/flight/infrastracture/commission/commission_service.dart';
import 'package:minna/flight/presendation/screen%20flight/widget/airport_bottom.dart';
import 'package:minna/flight/presendation/trip%20list/trip_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';

class FlightBookingTab extends StatefulWidget {
  const FlightBookingTab({super.key});

  @override
  State<FlightBookingTab> createState() => _FlightBookingTabState();
}

class _FlightBookingTabState extends State<FlightBookingTab> {
  final Color _errorColor = const Color(0xFFE53935);

  final FlightCommissionService _commissionService = FlightCommissionService();

  @override
  void initState() {
    super.initState();
    _initializeCommissionData();
  }

  Future<void> _initializeCommissionData() async {
    try {
      await _commissionService.fetchCommissionRules();

      log('Commission data initialized successfully');
    } catch (e) {
      log(e.toString());
      _retryCommissionInitialization();
    }
  }

  Future<void> _retryCommissionInitialization() async {
    await _initializeCommissionData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: BlocBuilder<SearchDataBloc, SearchDataState>(
        builder: (context, state) {
          return CustomScrollView(
            slivers: [
              // Enhanced App Bar with Image
              SliverAppBar(
                expandedHeight: 210,
                floating: false,
                pinned: true,
                elevation: 0,
                leading: IconButton(
                  icon: const Icon(Iconsax.arrow_left, color: Colors.white),
                  onPressed: () => Navigator.pop(context),
                ),
                backgroundColor: maincolor1,
                flexibleSpace: FlexibleSpaceBar(
                  background: Stack(
                    fit: StackFit.expand,
                    children: [
                      Image.asset(
                        'asset/flight/header_bg.png',
                        fit: BoxFit.cover,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.black.withOpacity(0.3),
                              maincolor1.withOpacity(0.8),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 40,
                        left: 20,
                        right: 20,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              "Where to next?",
                              style: TextStyle(
                                color: secondaryColor,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1.2,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              "Find Your Perfect Flight",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.w900,
                                height: 1.2,
                                shadows: [
                                  Shadow(
                                    color: Colors.black.withOpacity(0.3),
                                    offset: const Offset(0, 2),
                                    blurRadius: 4,
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

              // Main Content with Layered Effect
              SliverToBoxAdapter(
                child: Transform.translate(
                  offset: Offset(0, -30),
                  child: Padding(
                    padding: EdgeInsetsGeometry.only(top: 45),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Search Cards Section (The Floating Layer)
                          _buildSearchCardsSection(context, state),
                          const SizedBox(height: 24),

                          // Search Button
                          _buildSearchButton(context, state),
                          // const SizedBox(height: 32),

                          // Promotional Section
                          // _buildPromotionalSection(),
                          const SizedBox(
                            height: 100,
                          ), // Extra space for scrolling
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildSearchCardsSection(BuildContext context, SearchDataState state) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: maincolor1.withOpacity(0.08),
            blurRadius: 25,
            offset: const Offset(0, 10),
          ),
        ],
        border: Border.all(color: Colors.grey.shade100, width: 1.5),
      ),
      child: Column(
        children: [
          // // Header Accent
          // Container(
          //   height: 4,
          //   width: 40,
          //   margin: const EdgeInsets.only(bottom: 15),
          //   decoration: BoxDecoration(
          //     color: secondaryColor.withOpacity(0.3),
          //     borderRadius: BorderRadius.circular(2),
          //   ),
          // ),
          // Trip Type Selector
          _buildTripTypeSelector(context, state),
          const SizedBox(height: 14),

          // Location Cards
          _buildLocationCards(context, state),
          const SizedBox(height: 20),

          // Date Selectors
          _buildDateSelectors(context, state),
          const SizedBox(height: 20),

          // Travel Info
          _buildTravelInfo(context, state),
        ],
      ),
    );
  }

  Widget _buildTripTypeSelector(BuildContext context, SearchDataState state) {
    return Container(
      padding: EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(12),
        // border: Border.all(color: secondaryColor.withOpacity(0.2)),
      ),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () => context.read<SearchDataBloc>().add(
                const SearchDataEvent.oneWayOrRound(oneWayOrRound: 'oneWay'),
              ),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 14),
                decoration: BoxDecoration(
                  color: state.oneWay ? secondaryColor : Colors.transparent,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(
                  child: Text(
                    'One Way',
                    style: TextStyle(
                      fontSize: 11,
                      color: state.oneWay ? maincolor1 : textPrimary,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () => context.read<SearchDataBloc>().add(
                const SearchDataEvent.oneWayOrRound(oneWayOrRound: 'roundTrip'),
              ),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 14),
                decoration: BoxDecoration(
                  color: !state.oneWay ? secondaryColor : Colors.transparent,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(
                  child: Text(
                    'Round Trip',
                    style: TextStyle(
                      fontSize: 11,
                      color: !state.oneWay ? maincolor1 : textPrimary,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLocationCards(BuildContext context, SearchDataState state) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          decoration: BoxDecoration(
            color: backgroundColor,
            // border: Border.all(color: Colors.grey.shade100),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            children: [
              // From Location
              Expanded(
                child: _buildLocationCard(
                  context: context,
                  state: state,
                  title: "FROM",
                  subtitle: state.from?.name ?? "Select Departure",
                  icon: Iconsax.airplane,
                  isFrom: true,
                ),
              ),
              Container(height: 60, width: 1, color: Colors.grey.shade200),
              // To Location
              Expanded(
                child: _buildLocationCard(
                  context: context,
                  state: state,
                  title: "TO",
                  subtitle: state.to?.name ?? "Select Arrival",
                  icon: Iconsax.airplane_square,
                  isFrom: false,
                ),
              ),
            ],
          ),
        ),
        // Swap Button
        // GestureDetector(
        //   onTap: () {
        //     // Swap state logic if needed, or just visual feedback for now
        //   },
        //   child: Container(
        //     padding: const EdgeInsets.all(8),
        //     decoration: BoxDecoration(
        //       color: maincolor1,
        //       shape: BoxShape.circle,
        //       border: Border.all(color: Colors.white, width: 3),
        //       boxShadow: [
        //         BoxShadow(
        //           color: maincolor1.withOpacity(0.3),
        //           blurRadius: 10,
        //           offset: const Offset(0, 4),
        //         ),
        //       ],
        //     ),
        //     child: Icon(Iconsax.arrow_2, color: secondaryColor, size: 22),
        //   ),
        // ),
      ],
    );
  }

  Widget _buildLocationCard({
    required BuildContext context,
    required SearchDataState state,
    required String title,
    required String subtitle,
    required IconData icon,
    required bool isFrom,
  }) {
    return GestureDetector(
      onTap: () => showAirportBottomSheet(context, isFrom: isFrom),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          // color: cardColor,
          // borderRadius: BorderRadius.only(
          //   topLeft: isFrom ? Radius.circular(16) : Radius.zero,
          //   topRight: isFrom ? Radius.circular(16) : Radius.zero,
          //   bottomLeft: !isFrom ? Radius.circular(16) : Radius.zero,
          //   bottomRight: !isFrom ? Radius.circular(16) : Radius.zero,
          // ),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (isFrom ? state.from != null : state.to != null) ...[
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      alignment: Alignment.centerLeft,
                      child: Text(
                        isFrom
                            ? (state.from?.code ?? "")
                            : (state.to?.code ?? ""),
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w900,
                          color: maincolor1,
                          letterSpacing: -1,
                        ),
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      subtitle,
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                        color: textSecondary,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ] else ...[
                    const SizedBox(height: 8),
                    Text(
                      isFrom ? "FROM" : "TO",
                      style: TextStyle(
                        fontSize: 10,
                        color: textSecondary,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 1.2,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      isFrom ? "Select Origin" : "Select Destination",
                      style: TextStyle(
                        fontSize: 8,
                        fontWeight: FontWeight.w600,
                        color: maincolor1.withOpacity(0.3),
                      ),
                    ),
                  ],
                ],
              ),
            ),
            const SizedBox(width: 8),
            Icon(icon, color: secondaryColor.withOpacity(0.35), size: 28),
          ],
        ),
      ),
    );
  }

  Widget _buildDateSelectors(BuildContext context, SearchDataState state) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Departure Date
        Expanded(
          child: _buildDateSelector(
            context: context,
            title: "Departure Date",
            date: state.departureDate,
            isDeparture: true,
            state: state,
          ),
        ),
        if (!state.oneWay) const SizedBox(width: 16),
        if (!state.oneWay)
          Expanded(
            child: _buildDateSelector(
              context: context,
              title: "Return Date",
              date: state.returnDate,
              isDeparture: false,
              state: state,
            ),
          ),
      ],
    );
  }

  Widget _buildDateSelector({
    required BuildContext context,
    required String title,
    required DateTime? date,
    required bool isDeparture,
    required SearchDataState state,
  }) {
    return GestureDetector(
      onTap: () async {
        final currentState = context.read<SearchDataBloc>().state;
        final pickedDate = await showDatePicker(
          context: context,
          initialDate: isDeparture
              ? currentState.departureDate
              : currentState.returnDate ?? currentState.departureDate,
          firstDate: isDeparture ? DateTime.now() : currentState.departureDate,
          lastDate: DateTime(2101),
          builder: (context, child) => Theme(
            data: Theme.of(context).copyWith(
              colorScheme: ColorScheme.light(
                primary: secondaryColor,
                onPrimary: Colors.white,
                onSurface: maincolor1,
              ),
            ),
            child: child!,
          ),
        );

        if (pickedDate != null) {
          if (isDeparture) {
            context.read<SearchDataBloc>().add(
              SearchDataEvent.departureDateChange(departureDate: pickedDate),
            );

            // If return date exists and is before new departure date, update it
            if (!currentState.oneWay &&
                currentState.returnDate != null &&
                currentState.returnDate!.isBefore(pickedDate)) {
              context.read<SearchDataBloc>().add(
                SearchDataEvent.returnDateChange(returnDate: pickedDate),
              );
            }
          } else {
            context.read<SearchDataBloc>().add(
              SearchDataEvent.returnDateChange(returnDate: pickedDate),
            );
          }
        }
      },
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(16),
          // border: Border.all(color: Colors.grey.shade200),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 9,
                color: textSecondary,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.5,
              ),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              textBaseline: TextBaseline.alphabetic,
              children: [
                if (date != null)
                  Text(
                    DateFormat('dd MMM').format(date),
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w900,
                      color: maincolor1,
                    ),
                  ),
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        date != null
                            ? DateFormat('yyyy').format(date)
                            : "Select",
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          color: textPrimary,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        date != null ? DateFormat('EEEE').format(date) : "Date",
                        style: TextStyle(
                          fontSize: 9,
                          color: textSecondary,
                          fontWeight: FontWeight.w500,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTravelInfo(BuildContext context, SearchDataState state) {
    return Row(
      children: [
        // Travellers
        Expanded(
          child: _buildTravelInfoCard(
            title: "TRAVELLERS",
            value:
                "${state.travellers['adults']! + state.travellers['children']! + state.travellers['infants']!} PAX",
            icon: Iconsax.user_add,
            onTap: () => _showTravellersBottomSheet(context, state),
          ),
        ),
        const SizedBox(width: 16),
        // Class
        Expanded(
          child: _buildTravelInfoCard(
            title: "CABIN CLASS",
            value: state.seatClass,
            icon: Iconsax.favorite_chart,
            onTap: () => _showClassBottomSheet(context, state),
          ),
        ),
      ],
    );
  }

  Widget _buildTravelInfoCard({
    required String title,
    required String value,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(16),
          // border: Border.all(color: Colors.grey.shade200),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: secondaryColor.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: secondaryColor, size: 15),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 8,
                      color: textSecondary,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.5,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    value,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: maincolor1,
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

  Widget _buildSearchButton(BuildContext context, SearchDataState state) {
    final isEnabled =
        state.from != null &&
        state.to != null &&
        (!state.oneWay ? state.returnDate != null : true);

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      width: double.infinity,
      height: 60,
      decoration: BoxDecoration(
        color: isEnabled ? maincolor1 : maincolor1.withOpacity(0.1),
        borderRadius: BorderRadius.circular(18),
        boxShadow: isEnabled
            ? [
                BoxShadow(
                  color: maincolor1.withOpacity(0.3),
                  blurRadius: 15,
                  offset: const Offset(0, 8),
                ),
              ]
            : [],
        gradient: isEnabled
            ? LinearGradient(
                colors: [maincolor1, maincolor1.withOpacity(0.9)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              )
            : null,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: isEnabled
              ? () {
                  // Validation checks
                  if (state.from == null || state.to == null) {
                    _showErrorSnackBar(
                      context,
                      'Please select both origin and destination',
                      Iconsax.info_circle,
                    );
                    return;
                  }

                  if (!state.oneWay && state.returnDate == null) {
                    _showErrorSnackBar(
                      context,
                      'Please select return date for round trip',
                      Iconsax.calendar_1,
                    );
                    return;
                  }

                  // Proceed with flight search if validation passes
                  context.read<TripRequestBloc>().add(
                    GetTripList(
                      flightRequestData: FlightSearchRequest(
                        origin: state.from!.code,
                        destination: state.to!.code,
                        onwardDate: state.departureDate,
                        returnDate: state.returnDate ?? state.departureDate,
                        adult: state.travellers['adults']!,
                        child: state.travellers['children']!,
                        infant: state.travellers['infants']!,
                        tripMode: state.oneWay ? 'O' : 'R',
                        travelType:
                            state.from!.countryCode == state.to!.countryCode
                            ? 'D'
                            : 'I',
                        userId: 'userId',
                        password: 'password',
                        destinationNation: state.to!.countryCode,
                        originNation: state.from!.countryCode,
                        classes: state.seatClass,
                      ),
                    ),
                  );

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => FlightSearchPage(
                        tripType:
                            state.from!.countryCode == state.to!.countryCode
                            ? 'Domestic'
                            : 'International',
                      ),
                    ),
                  );
                }
              : null,
          borderRadius: BorderRadius.circular(18),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Iconsax.search_normal_1,
                  color: isEnabled ? Colors.white : maincolor1.withOpacity(0.2),
                  size: 22,
                ),
                const SizedBox(width: 12),
                Text(
                  'Search Flights',
                  style: TextStyle(
                    color: isEnabled
                        ? Colors.white
                        : maincolor1.withOpacity(0.2),
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

  void _showErrorSnackBar(BuildContext context, String message, IconData icon) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        margin: EdgeInsets.all(16),
        backgroundColor: _errorColor,
        content: Row(
          children: [
            Icon(icon, color: Colors.white, size: 20),
            SizedBox(width: 12),
            Expanded(
              child: Text(
                message,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
        duration: Duration(seconds: 3),
        action: SnackBarAction(
          label: 'OK',
          textColor: Colors.white,
          onPressed: () {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
          },
        ),
      ),
    );
  }

  void _showTravellersBottomSheet(BuildContext context, SearchDataState state) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          margin: EdgeInsets.only(top: 60),
          padding: EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(28),
              topRight: Radius.circular(28),
            ),
          ),
          child: BlocProvider.value(
            value: context.read<SearchDataBloc>(),
            child: BlocBuilder<SearchDataBloc, SearchDataState>(
              builder: (context, state) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Drag handle
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

                    // Title
                    Text(
                      "Travellers",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: maincolor1,
                      ),
                    ),
                    SizedBox(height: 24),

                    // Passenger Types
                    _buildPassengerType(
                      context,
                      "Adults",
                      "12+ years",
                      state.travellers['adults']!,
                      (value) => context.read<SearchDataBloc>().add(
                        SearchDataEvent.passengers(
                          travellers: {
                            'adults': value,
                            'children': state.travellers['children']!,
                            'infants': state.travellers['infants']!,
                          },
                        ),
                      ),
                      min: 1,
                    ),
                    SizedBox(height: 20),
                    _buildPassengerType(
                      context,
                      "Children",
                      "2-11 years",
                      state.travellers['children']!,
                      (value) => context.read<SearchDataBloc>().add(
                        SearchDataEvent.passengers(
                          travellers: {
                            'adults': state.travellers['adults']!,
                            'children': value,
                            'infants': state.travellers['infants']!,
                          },
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    _buildPassengerType(
                      context,
                      "Infants",
                      "0-2 years",
                      state.travellers['infants']!,
                      (value) => context.read<SearchDataBloc>().add(
                        SearchDataEvent.passengers(
                          travellers: {
                            'adults': state.travellers['adults']!,
                            'children': state.travellers['children']!,
                            'infants': value,
                          },
                        ),
                      ),
                      max: state.travellers['adults'],
                    ),
                    SizedBox(height: 32),

                    // Buttons
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton(
                            onPressed: () => Navigator.pop(context),
                            style: OutlinedButton.styleFrom(
                              padding: EdgeInsets.symmetric(vertical: 15),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              side: BorderSide(color: secondaryColor),
                            ),
                            child: Text(
                              "Cancel",
                              style: TextStyle(color: secondaryColor),
                            ),
                          ),
                        ),
                        SizedBox(width: 16),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () => Navigator.pop(context),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: secondaryColor,
                              padding: EdgeInsets.symmetric(vertical: 15),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: Text(
                              "Done",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                );
              },
            ),
          ),
        );
      },
    );
  }

  void _showClassBottomSheet(BuildContext context, SearchDataState state) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          margin: EdgeInsets.only(top: 60),
          padding: EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(28),
              topRight: Radius.circular(28),
            ),
          ),
          child: BlocProvider.value(
            value: context.read<SearchDataBloc>(),
            child: BlocBuilder<SearchDataBloc, SearchDataState>(
              builder: (context, state) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Drag handle
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

                    // Title
                    Text(
                      "Select Class",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: maincolor1,
                      ),
                    ),
                    SizedBox(height: 24),

                    // Class Options
                    _buildClassOption(
                      context,
                      "Economy",
                      "Standard seating with essential services",
                      state.seatClass == 'Economy',
                      () => context.read<SearchDataBloc>().add(
                        const SearchDataEvent.classChange(seatClass: 'Economy'),
                      ),
                    ),
                    SizedBox(height: 16),
                    _buildClassOption(
                      context,
                      "Business",
                      "Premium seating with enhanced services",
                      state.seatClass == 'Business',
                      () => context.read<SearchDataBloc>().add(
                        const SearchDataEvent.classChange(
                          seatClass: 'Business',
                        ),
                      ),
                    ),
                    SizedBox(height: 32),
                  ],
                );
              },
            ),
          ),
        );
      },
    );
  }

  Widget _buildClassOption(
    BuildContext context,
    String title,
    String description,
    bool isSelected,
    VoidCallback onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: isSelected
              ? secondaryColor.withOpacity(0.1)
              : Colors.transparent,
          border: Border.all(
            color: isSelected ? secondaryColor : Colors.grey.shade300,
            width: 1.5,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected ? secondaryColor : Colors.grey,
                  width: isSelected ? 2 : 1,
                ),
              ),
            ),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: isSelected ? secondaryColor : textPrimary,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    description,
                    style: TextStyle(fontSize: 11, color: textSecondary),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPassengerType(
    BuildContext context,
    String title,
    String description,
    int count,
    Function(int) onChanged, {
    int min = 0,
    int? max,
  }) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: textPrimary,
                ),
              ),
              SizedBox(height: 4),
              Text(
                description,
                style: TextStyle(fontSize: 12, color: textSecondary),
              ),
            ],
          ),
          Row(
            children: [
              IconButton(
                icon: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade400),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    Icons.remove,
                    size: 18,
                    color: Colors.grey.shade600,
                  ),
                ),
                onPressed: count > min ? () => onChanged(count - 1) : null,
                padding: EdgeInsets.zero,
              ),
              Container(
                width: 40,
                alignment: Alignment.center,
                child: Text(
                  count.toString(),
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: textPrimary,
                  ),
                ),
              ),
              IconButton(
                icon: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade400),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(Icons.add, size: 18, color: Colors.grey.shade600),
                ),
                onPressed: max == null || count < max
                    ? () => onChanged(count + 1)
                    : null,
                padding: EdgeInsets.zero,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPromotionalSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Trending Destinations",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: maincolor1,
                ),
              ),
              Text(
                "See All",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: secondaryColor,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 220,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              _buildPromoCard(
                "Dubai",
                "From \$450",
                "https://images.unsplash.com/photo-1512453979798-5ea266f8880c?q=80&w=500&auto=format&fit=crop",
              ),
              _buildPromoCard(
                "London",
                "From \$620",
                "https://images.unsplash.com/photo-1513635269975-59663e0ac1ad?q=80&w=500&auto=format&fit=crop",
              ),
              _buildPromoCard(
                "Paris",
                "From \$580",
                "https://images.unsplash.com/photo-1502602898657-3e91760cbb34?q=80&w=500&auto=format&fit=crop",
              ),
              _buildPromoCard(
                "New York",
                "From \$750",
                "https://images.unsplash.com/photo-1496442226666-8d4d0e62e6e9?q=80&w=500&auto=format&fit=crop",
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildPromoCard(String title, String price, String imageUrl) {
    return Container(
      width: 160,
      margin: const EdgeInsets.only(right: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
            child: Image.network(
              imageUrl,
              height: 120,
              width: 160,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
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
                const SizedBox(height: 4),
                Text(
                  price,
                  style: TextStyle(
                    fontSize: 14,
                    color: secondaryColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
