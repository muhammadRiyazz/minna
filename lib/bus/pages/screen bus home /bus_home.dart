import 'package:minna/bus/application/busListfetch/bus_list_fetch_bloc.dart';
import 'package:minna/bus/application/change%20location/location_bloc.dart';
import 'package:minna/bus/domain/location/location_modal.dart';
import 'package:minna/bus/pages/Screen%20available%20Trip/screen_available_triplist.dart';
import 'package:minna/bus/pages/search%20location%20screen/search_location_screen.dart';
import 'package:minna/comman/const/const.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class BusHomeTab extends StatelessWidget {
   BusHomeTab({super.key});

  // Color Theme - Consistent with other booking pages
  final Color _primaryColor = Colors.black;
  final Color _secondaryColor = Color(0xFFD4AF37); // Gold
  final Color _accentColor = Color(0xFFC19B3C); // Darker Gold
  final Color _backgroundColor = Color(0xFFF8F9FA);
  final Color _cardColor = Colors.white;
  final Color _textPrimary = Colors.black;
  final Color _textSecondary = Color(0xFF666666);
  final Color _textLight = Color(0xFF999999);
  final Color _errorColor = Color(0xFFE53935);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _backgroundColor,
      body: CustomScrollView(
        slivers: [
          // App Bar
          SliverAppBar(
            backgroundColor: _primaryColor,
            expandedHeight: 140,
            floating: false,
            pinned: true,
            elevation: 4,
            shadowColor: Colors.black.withOpacity(0.3),
            surfaceTintColor: Colors.white,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                'Bus Booking',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              centerTitle: true,
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [_primaryColor, Color(0xFF2D2D2D)],
                  ),
                ),
              ),
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(20),
              ),
            ),
          ),

          // Main Content
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header Section
                  _buildHeaderSection(),
                  const SizedBox(height: 32),

                  // Search Cards Section
                  _buildSearchCardsSection(context),
                  const SizedBox(height: 32),

                  // Search Button
                  _buildSearchButton(context),
                  
                  // Features Section
                  _buildFeaturesSection(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeaderSection() {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [_primaryColor, Color(0xFF2D2D2D)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
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
              Icons.directions_bus_rounded,
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
                  "Find Your Perfect Bus",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    height: 1.2,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  "Discover comfortable bus journeys at great prices",
                  style: TextStyle(
                    fontSize: 14,
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

  Widget _buildSearchCardsSection(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
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
          // Location Selector
          _buildLocationSelector(context),
          const SizedBox(height: 20),

          // Date Selector
          _buildDateSelector(context),
        ],
      ),
    );
  }

  Widget _buildLocationSelector(BuildContext context) {
    return BlocBuilder<LocationBloc, LocationState>(
      builder: (context, state) {
        return Stack(
          children: [
            Container(
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
                    location: state.from,
                    placeholderText: "Select departure city",
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
                    location: state.to,
                    placeholderText: "Select destination city",
                    isFrom: false,
                  ),
                ],
              ),
            ),
            // Swap Button
            Positioned(
              right: 20,
              top: 70,
              child: GestureDetector(
                onTap: () => context.read<LocationBloc>().add(SwapLocations()),
                child: Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: _secondaryColor,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: _secondaryColor.withOpacity(0.3),
                        blurRadius: 8,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Icon(
                    Icons.swap_vert_rounded,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildLocationCard({
    required BuildContext context,
    required String title,
    required City? location,
    required String placeholderText,
    required bool isFrom,
  }) {
    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          backgroundColor: Colors.transparent,
          builder: (context) => LocationSearchPage(fromOrto: isFrom ? 'from' : 'to'),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(20),
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
                isFrom ? Icons.place_rounded : Icons.flag_rounded,
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
                    location?.name ?? placeholderText,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: location != null ? _textPrimary : _textLight,
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

  Widget _buildDateSelector(BuildContext context) {
    return BlocBuilder<LocationBloc, LocationState>(
      builder: (context, state) {
        return Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade200),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Journey Date",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: _textPrimary,
                ),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  // Quick Date Buttons
                  Expanded(
                    child: Row(
                      children: [
                        _buildQuickDateButton(
                          label: "Today",
                          date: DateTime.now(),
                          state: state,
                        ),
                        const SizedBox(width: 12),
                        _buildQuickDateButton(
                          label: "Tomorrow",
                          date: DateTime.now().add(Duration(days: 1)),
                          state: state,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 16),
                  // Calendar Button
                  _buildCalendarButton(context, state),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildQuickDateButton({
    required String label,
    required DateTime date,
    required LocationState state,
  }) {
    final isSelected = _isSameDate(state.dateOfJourney, date);
    
    return Expanded(
      child: GestureDetector(
        onTap: () {}
        ,
        
        
        //  context.read<LocationBloc>().add(UpdateDate(date: date)),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
          decoration: BoxDecoration(
            color: isSelected ? _secondaryColor : _backgroundColor,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isSelected ? _secondaryColor : Colors.grey.shade300,
            ),
          ),
          child: Column(
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: isSelected ? Colors.white : _textPrimary,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                DateFormat('dd MMM').format(date),
                style: TextStyle(
                  fontSize: 10,
                  color: isSelected ? Colors.white.withOpacity(0.9) : _textSecondary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCalendarButton(BuildContext context, LocationState state) {
    return GestureDetector(
      onTap: () async {
        final pickedDate = await showDatePicker(
          context: context,
          initialDate: state.dateOfJourney,
          firstDate: DateTime.now(),
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
          context.read<LocationBloc>().add(UpdateDate(date: pickedDate));
        }
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: _backgroundColor,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.shade200),
        ),
        child: Column(
          children: [
            Icon(
              Icons.calendar_month_rounded,
              color: _secondaryColor,
              size: 20,
            ),
            const SizedBox(height: 4),
            Text(
              "Calendar",
              style: TextStyle(
                fontSize: 10,
                color: _textSecondary,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  bool _isSameDate(DateTime date1, DateTime date2) {
    return date1.year == date2.year &&
        date1.month == date2.month &&
        date1.day == date2.day;
  }

  Widget _buildSearchButton(BuildContext context) {
    return BlocBuilder<LocationBloc, LocationState>(
      builder: (context, state) {
        final isEnabled = state.from != null && state.to != null;
        
        return Container(
          width: double.infinity,
          height: 56,
          child: ElevatedButton(
            onPressed: isEnabled
                ? () {
                    if (state.from == null || state.to == null) {
                      _showLocationErrorSnackbar(context);
                      return;
                    }

                    BlocProvider.of<BusListFetchBloc>(context).add(
                      FetchTrip(
                        dateOfjurny: state.dateOfJourney,
                        destID: state.to!,
                        sourceID: state.from!,
                      ),
                    );

                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const ScreenAvailableTrips()),
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
                  "Search Buses",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildFeaturesSection() {
    final features = [
      {
        'icon': Icons.safety_check_rounded,
        'title': 'Safe Travel',
        'subtitle': 'Verified bus partners'
      },
      {
        'icon': Icons.schedule_rounded,
        'title': 'On Time',
        'subtitle': 'Live tracking available'
      },
      {
        'icon': Icons.currency_rupee_rounded,
        'title': 'Best Price',
        'subtitle': 'Guaranteed lowest fares'
      },
      {
        'icon': Icons.confirmation_number_rounded,
        'title': 'Easy Booking',
        'subtitle': 'Instant confirmation'
      },
    ];

    return Container(
      margin: EdgeInsets.only(top: 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Why Travel With Us",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: _textPrimary,
            ),
          ),
          SizedBox(height: 16),
          GridView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 2.5,
            ),
            itemCount: features.length,
            itemBuilder: (context, index) {
              final feature = features[index];
              return Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: _cardColor,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.03),
                      blurRadius: 8,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: _secondaryColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(
                        feature['icon'] as IconData,
                        color: _secondaryColor,
                        size: 18,
                      ),
                    ),
                    SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            feature['title'] as String,
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: _textPrimary,
                            ),
                          ),
                          SizedBox(height: 2),
                          Text(
                            feature['subtitle'] as String,
                            style: TextStyle(
                              fontSize: 10,
                              color: _textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  void _showLocationErrorSnackbar(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        margin: EdgeInsets.all(16),
        backgroundColor: _errorColor,
        content: Row(
          children: [
            Icon(Icons.location_on_rounded, color: Colors.white, size: 20),
            SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Location Missing',
                    style: TextStyle(
                      fontWeight: FontWeight.bold, 
                      fontSize: 14,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 2),
                  Text(
                    'Please select both departure and destination',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.white,
                    ),
                  ),
                ],
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
}