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
import 'package:intl/intl.dart';

class FlightBookingTab extends StatefulWidget {
   FlightBookingTab({super.key});

  @override
  State<FlightBookingTab> createState() => _FlightBookingTabState();
}

class _FlightBookingTabState extends State<FlightBookingTab> {
  // Color Theme - Consistent with hotel booking
  final Color _primaryColor = Colors.black;

  final Color _secondaryColor = Color(0xFFD4AF37); 
 // Gold
  final Color _accentColor = Color(0xFFC19B3C); 
 // Darker Gold
  final Color _backgroundColor = Color(0xFFF8F9FA);

  final Color _cardColor = Colors.white;

  final Color _textPrimary = Colors.black;

  final Color _textSecondary = Color(0xFF666666);

  final Color _textLight = Color(0xFF999999);

  final Color _errorColor = Color(0xFFE53935);





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
      backgroundColor: _backgroundColor,
      body: BlocBuilder<SearchDataBloc, SearchDataState>(
        builder: (context, state) {
          return CustomScrollView(
            slivers: [
              // App Bar
              SliverAppBar(
                backgroundColor: _primaryColor,
                expandedHeight: 140,
                floating: false,
                pinned: true,
                elevation: 4,leading: IconButton(
              icon: const Icon(Icons.arrow_back_rounded, color: Colors.white),
              onPressed: () => Navigator.pop(context),
            ),
                shadowColor: Colors.black.withOpacity(0.3),
                surfaceTintColor: Colors.white,
                flexibleSpace: FlexibleSpaceBar(
                  title: Text(
                    'Flight Booking',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  centerTitle: true,
                  background: Container(
                    decoration: BoxDecoration(
                    color: _primaryColor
                    ),
                  ),
                ),
                // shape: RoundedRectangleBorder(
                //   borderRadius: BorderRadius.vertical(
                //     bottom: Radius.circular(20),
                //   ),
                // ),
              ),

              // Main Content
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 17,horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Header Section
                      _buildHeaderSection(),
                      const SizedBox(height: 15),

                      // Search Cards Section
                      _buildSearchCardsSection(context, state),
                      const SizedBox(height: 20),

                      // Search Button
                      _buildSearchButton(context, state),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildHeaderSection() {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
     color: _primaryColor,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: _primaryColor.withOpacity(0.3),
            blurRadius: 15,
            offset: Offset(0, 6),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: _secondaryColor.withOpacity(0.2),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.flight_takeoff_rounded,
              color: _secondaryColor,
              size: 28,
            ),
          ),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Find Your Perfect Flight",
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    height: 1.2,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  "Discover the best flights at amazing prices",
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.white.withOpacity(0.8),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchCardsSection(BuildContext context, SearchDataState state) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: _cardColor,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
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
        color: _backgroundColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _secondaryColor.withOpacity(0.2)),
      ),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () => context.read<SearchDataBloc>().add(
                const SearchDataEvent.oneWayOrRound(
                  oneWayOrRound: 'oneWay',
                ),
              ),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 14),
                decoration: BoxDecoration(
                  color: state.oneWay ? _secondaryColor : Colors.transparent,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(
                  child: Text(
                    'One Way',
                    style: TextStyle(
                      fontSize: 12,
                      color: state.oneWay ? Colors.white : _textPrimary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () => context.read<SearchDataBloc>().add(
                const SearchDataEvent.oneWayOrRound(
                  oneWayOrRound: 'roundTrip',
                ),
              ),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 14),
                decoration: BoxDecoration(
                  color: !state.oneWay ? _secondaryColor : Colors.transparent,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(
                  child: Text(
                    'Round Trip',
                    style: TextStyle(
                      fontSize: 12,
                      color: !state.oneWay ? Colors.white : _textPrimary,
                      fontWeight: FontWeight.w600,
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
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade200),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          // From Location
          _buildLocationCard(
            context: context,
            title: "From",
            subtitle: state.from?.name ?? "Select Departure City",
            icon: Icons.flight_takeoff_rounded,
            isFrom: true,
          ),
          Container(
            height: 1,
            color: Colors.grey.shade100,
          ),
          // To Location
          _buildLocationCard(
            context: context,
            title: "To",
            subtitle: state.to?.name ?? "Select Arrival City",
            icon: Icons.flight_land_rounded,
            isFrom: false,
          ),
        ],
      ),
    );
  }

  Widget _buildLocationCard({
    required BuildContext context,
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
          color: _cardColor,
          borderRadius: BorderRadius.only(
            topLeft: isFrom ? Radius.circular(16) : Radius.zero,
            topRight: isFrom ? Radius.circular(16) : Radius.zero,
            bottomLeft: !isFrom ? Radius.circular(16) : Radius.zero,
            bottomRight: !isFrom ? Radius.circular(16) : Radius.zero,
          ),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: _secondaryColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                icon,
                color: _secondaryColor,
                size: 24,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 12,
                      color: _textSecondary,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: _textPrimary,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios_rounded,
              color: _textLight,
              size: 16,
            ),
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
                primary: _secondaryColor,
                onPrimary: Colors.white,
                onSurface: _primaryColor,
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
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: _backgroundColor,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.shade200),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: _secondaryColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                Icons.calendar_month_rounded,
                color: _secondaryColor,
                size: 15,
              ),
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
                      color: _textSecondary,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    date != null
                        ? DateFormat('dd MMM yyyy').format(date)
                        : "Select date",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: date != null ? _textPrimary : _textLight,
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

  Widget _buildTravelInfo(BuildContext context, SearchDataState state) {
    return Column(
      children: [
        // Travellers
        _buildTravelInfoCard(
          title: "Travellers",
          value:
              "${state.travellers['adults']! + state.travellers['children']! + state.travellers['infants']!} Travellers",
          icon: Icons.people_rounded,
          onTap: () => _showTravellersBottomSheet(context, state),
        ),
        const SizedBox(height: 14),
        // Class
        _buildTravelInfoCard(
          title: "Class",
          value: state.seatClass,
          icon: Icons.airline_seat_recline_normal_rounded,
          onTap: () => _showClassBottomSheet(context, state),
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
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: _cardColor,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.shade200),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: _secondaryColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                icon,
                color: _secondaryColor,
                size: 20,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 10,
                      color: _textSecondary,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    value,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: _textPrimary,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.arrow_drop_down_rounded,
              color: _textLight,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchButton(BuildContext context, SearchDataState state) {
    final isEnabled = state.from != null && state.to != null && 
        (!state.oneWay ? state.returnDate != null : true);

    return Container(
      width: double.infinity,
      height: 56,
      child: ElevatedButton(
        onPressed: isEnabled
            ? () {
                // Validation checks
                if (state.from == null || state.to == null) {
                  _showErrorSnackBar(
                    context,
                    'Please select both origin and destination',
                    Icons.error_outline_rounded,
                  );
                  return;
                }

                if (!state.oneWay && state.returnDate == null) {
                  _showErrorSnackBar(
                    context,
                    'Please select return date for round trip',
                    Icons.calendar_today_rounded,
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
                      travelType: state.from!.countryCode == state.to!.countryCode
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

                      tripType:  state.from!.countryCode == state.to!.countryCode
                          ? 'Domestic'
                          : 'International',
                    ),
                  ),
                );
              }
            : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: isEnabled ? _primaryColor : Colors.grey[400],
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          elevation: 2,
          shadowColor: isEnabled ? _primaryColor.withOpacity(0.3) : Colors.transparent,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.search_rounded,
              size: 20,
            ),
            const SizedBox(width: 12),
            Text(
              "Search Flights",
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showErrorSnackBar(BuildContext context, String message, IconData icon) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
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
                        color: _primaryColor,
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
                      "2-12 years",
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
                              side: BorderSide(color: _secondaryColor),
                            ),
                            child: Text(
                              "Cancel",
                              style: TextStyle(color: _secondaryColor),
                            ),
                          ),
                        ),
                        SizedBox(width: 16),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () => Navigator.pop(context),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: _secondaryColor,
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
                        color: _primaryColor,
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
                        const SearchDataEvent.classChange(seatClass: 'Business'),
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
          color: isSelected ? _secondaryColor.withOpacity(0.1) : Colors.transparent,
          border: Border.all(
            color: isSelected ? _secondaryColor : Colors.grey.shade300,
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
                  color: isSelected ? _secondaryColor : Colors.grey,
                  width: isSelected ? 2 :1,
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
                      color: isSelected ? _secondaryColor : _textPrimary,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    description,
                    style: TextStyle(
                      fontSize: 11,
                      color: _textSecondary,
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
        color: _backgroundColor,
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
                  color: _textPrimary,
                ),
              ),
              SizedBox(height: 4),
              Text(
                description,
                style: TextStyle(
                  fontSize: 12,
                  color: _textSecondary,
                ),
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
                  child: Icon(Icons.remove, size: 18, color: Colors.grey.shade600),
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
                    color: _textPrimary,
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
}