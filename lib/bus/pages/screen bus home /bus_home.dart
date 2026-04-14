import 'package:minna/bus/application/busListfetch/bus_list_fetch_bloc.dart';
import 'package:minna/bus/application/change%20location/location_bloc.dart';
import 'package:minna/bus/pages/Screen%20available%20Trip/screen_available_triplist.dart';
import 'package:minna/bus/pages/search%20location%20screen/search_location_screen.dart';
import 'package:minna/comman/const/const.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';

class BusHomeTab extends StatelessWidget {
  BusHomeTab({super.key});

  // Color Theme - Consistent with main home page
  final Color _errorColor = const Color(0xFFE53935);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: BlocBuilder<LocationBloc, LocationState>(
        builder: (context, state) {
          return CustomScrollView(
            slivers: [
              // Premium SliverAppBar
              SliverAppBar(
                backgroundColor: maincolor1,
                expandedHeight: 220,
                floating: false,
                pinned: true,
                elevation: 0,
                leading: IconButton(
                  icon: const Icon(
                    Iconsax.arrow_left_2,
                    color: Colors.white,
                    size: 24,
                  ),
                  onPressed: () => Navigator.pop(context),
                ),
                flexibleSpace: FlexibleSpaceBar(
                  centerTitle: true,
                  background: Stack(
                    fit: StackFit.expand,
                    children: [
                      // Hero Background Image - Modern Bus/Travel
                      Image.network(
                        'https://images.unsplash.com/photo-1544620347-c4fd4a3d5957?auto=format&fit=crop&q=80&w=1000',
                        fit: BoxFit.cover,
                      ),
                      // Premium Gradient Overlay
                      Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              maincolor1.withOpacity(0.2),
                              maincolor1.withOpacity(0.6),
                              maincolor1,
                            ],
                            stops: const [0.0, 0.6, 1.0],
                          ),
                        ),
                      ),
                      // Header Content
                      SafeArea(
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(20, 40, 20, 0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const SizedBox(height: 20),
                              Text(
                                "RELIABLE BUS TRAVEL",
                                style: TextStyle(
                                  color: secondaryColor,
                                  fontSize: 11,
                                  fontWeight: FontWeight.w900,
                                  letterSpacing: 2,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                "Your Journey\nRedefined",
                                textAlign: TextAlign.center,
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
                      ),
                    ],
                  ),
                ),
              ),

              // Overlapping Search Layout
              SliverToBoxAdapter(
                child: Transform.translate(
                  offset: const Offset(0, -1),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 13),
                    child: Column(
                      children: [
                        _buildSearchCardsSection(context, state),
                        const SizedBox(height: 20),
                        _buildSearchButton(context, state),
                        const SizedBox(height: 32),
                      ],
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

  Widget _buildSearchCardsSection(BuildContext context, LocationState state) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: cardColor,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: maincolor1.withOpacity(0.12),
              blurRadius: 40,
              offset: const Offset(0, 12),
            ),
          ],
          border: Border.all(color: Colors.white, width: 2),
        ),
        child: Column(
          children: [
            // Location Cards with Route Line
            _buildLocationCards(context, state),
            const SizedBox(height: 16),
            const Divider(height: 1, color: Color(0xFFF1F5F9)),
            const SizedBox(height: 16),
            // Date Selector
            _buildDateSelector(context, state),
          ],
        ),
      ),
    );
  }

  Widget _buildLocationCards(BuildContext context, LocationState state) {
    return SizedBox(
      height: 154, // Total height for two cards + spacing
      child: Stack(
        children: [
          // Vertical Route Line
          Positioned(
            left:
                31, // (10 + 10 + 18)/2 + 14? No, let's calculate based on icon position
            top: 40,
            bottom: 40,
            child: Container(
              width: 1.5,
              color: secondaryColor.withOpacity(0.2),
            ),
          ),
          Column(
            children: [
              // From Location
              _buildLocationCard(
                context: context,
                title: "From",
                subtitle: state.from?.name ?? "Select Departure City",
                icon: Iconsax.bus,
                isFrom: true,
                showDot: true,
              ),
              const SizedBox(height: 14),
              // To Location
              _buildLocationCard(
                context: context,
                title: "To",
                subtitle: state.to?.name ?? "Select Destination City",
                isFrom: false,
                icon: Iconsax.bus4,
                showDot: true,
              ),
            ],
          ),
          // Swap Button - More integrated
          Positioned(
            right: 10,
            top: 0,
            bottom: 0,
            child: Center(
              child: GestureDetector(
                onTap: () => context.read<LocationBloc>().add(SwapLocations()),
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                    border: Border.all(color: const Color(0xFFF1F5F9)),
                  ),
                  child: Icon(Iconsax.arrow_2, color: maincolor1, size: 16),
                ),
              ),
            ),
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
    bool showDot = false,
  }) {
    final bool isSelected =
        subtitle != "Select Departure City" &&
        subtitle != "Select Destination City";

    return GestureDetector(
      onTap: () => showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (context) =>
            LocationSearchPage(fromOrto: isFrom ? 'from' : 'to'),
      ),
      child: Container(
        height: 70, // Fixed height for alignment
        padding: const EdgeInsets.fromLTRB(14, 12, 14, 12),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFF8FAFC) : cardColor,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: isSelected
                ? secondaryColor.withOpacity(0.1)
                : const Color(0xFFF1F5F9),
            width: 1,
          ),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: isSelected
                    ? maincolor1.withOpacity(0.05)
                    : const Color(0xFFF8FAFC),
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                color: isSelected ? maincolor1 : textSecondary,
                size: 18,
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 10,
                      color: maincolor1,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.5,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: isSelected
                          ? FontWeight.w800
                          : FontWeight.w600,
                      color: maincolor1,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Iconsax.arrow_right_3,
              color: maincolor1.withOpacity(0.4),
              size: 14,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDateSelector(BuildContext context, LocationState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 4),
          child: Text(
            "Date of Journey",
            style: TextStyle(
              fontSize: 12,
              color: textSecondary,
              fontWeight: FontWeight.w800,
              letterSpacing: 0.5,
            ),
          ),
        ),
        const SizedBox(height: 12),
        _buildCalendarDatePicker(context, state),
        const SizedBox(height: 16),
        _buildQuickDateOptions(context, state),
      ],
    );
  }

  Widget _buildCalendarDatePicker(BuildContext context, LocationState state) {
    return GestureDetector(
      onTap: () async {
        final pickedDate = await showDatePicker(
          context: context,
          initialDate: state.dateOfJourney,
          firstDate: DateTime.now(),
          lastDate: DateTime(2026, 12, 31),
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
          context.read<LocationBloc>().add(UpdateDate(date: pickedDate));
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        decoration: BoxDecoration(
          color: cardColor,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: secondaryColor.withOpacity(0.15), width: 1),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: secondaryColor.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(Iconsax.calendar_1, color: secondaryColor, size: 18),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Selected Date",
                    style: TextStyle(
                      fontSize: 10,
                      color: textSecondary,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.5,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    DateFormat('dd MMM yyyy').format(state.dateOfJourney),
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w900,
                      color: maincolor1,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Iconsax.arrow_down_1,
              color: secondaryColor.withOpacity(0.5),
              size: 16,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickDateOptions(BuildContext context, LocationState state) {
    final today = DateTime.now();
    final tomorrow = today.add(const Duration(days: 1));
    final isTodaySelected = _isSameDate(state.dateOfJourney, today);
    final isTomorrowSelected = _isSameDate(state.dateOfJourney, tomorrow);

    return Row(
      children: [
        Expanded(
          child: _buildQuickDateButton("Today", isTodaySelected, () {
            context.read<LocationBloc>().add(UpdateDate(date: today));
          }),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _buildQuickDateButton("Tomorrow", isTomorrowSelected, () {
            context.read<LocationBloc>().add(UpdateDate(date: tomorrow));
          }),
        ),
      ],
    );
  }

  Widget _buildQuickDateButton(
    String label,
    bool isSelected,
    VoidCallback onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? secondaryColor : Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: isSelected ? secondaryColor : Colors.grey.shade200,
            width: 1,
          ),
          // boxShadow: isSelected
          //     ? [
          //         BoxShadow(
          //           color: secondaryColor.withOpacity(0.3),
          //           blurRadius: 10,
          //           offset: const Offset(0, 4),
          //         ),
          //       ]
          //     : [],
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              fontSize: 13,
              fontWeight: isSelected ? FontWeight.w900 : FontWeight.w600,
              color: isSelected ? Colors.white : maincolor1,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSearchButton(BuildContext context, LocationState state) {
    final isEnabled = state.from != null && state.to != null;

    return Container(
      width: double.infinity,
      height: 60,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),

        color: isEnabled ? maincolor1 : const Color(0xFFF1F5F9),
        // boxShadow: isEnabled
        //     ? [
        //         BoxShadow(
        //           color: secondaryColor.withOpacity(0.3),
        //           blurRadius: 20,
        //           offset: const Offset(0, 10),
        //         ),
        //       ]
        //     : null,
      ),
      child: ElevatedButton(
        onPressed: isEnabled
            ? () {
                BlocProvider.of<BusListFetchBloc>(context).add(
                  FetchTrip(
                    dateOfjurny: state.dateOfJourney,
                    destID: state.to!,
                    sourceID: state.from!,
                  ),
                );

                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => ScreenAvailableTrips()),
                );
              }
            : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          foregroundColor: Colors.white,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          elevation: 0,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Iconsax.search_normal_1, size: 22, color: Colors.white),
            const SizedBox(width: 12),
            const Text(
              "Search Buses",
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w900,
                letterSpacing: 0.5,
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
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        margin: EdgeInsets.all(16),
        backgroundColor: _errorColor,
        content: Row(
          children: [
            Icon(icon, color: Colors.white, size: 20),
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
                    message,
                    style: TextStyle(fontSize: 12, color: Colors.white),
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

  bool _isSameDate(DateTime date1, DateTime date2) {
    return date1.year == date2.year &&
        date1.month == date2.month &&
        date1.day == date2.day;
  }
}
