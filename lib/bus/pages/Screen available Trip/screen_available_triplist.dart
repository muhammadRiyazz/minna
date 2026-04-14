import 'package:minna/bus/application/busListfetch/bus_list_fetch_bloc.dart';
import 'package:minna/bus/application/busListfetch/bus_list_fetch_state.dart';
import 'package:minna/bus/application/change%20location/location_bloc.dart';
import 'package:minna/bus/infrastructure/time.dart';
import 'package:minna/bus/pages/Screen%20available%20Trip/widgets/trip_container.dart';
import 'package:minna/bus/domain/trips%20list%20modal/trip_list_modal.dart';
import 'package:flutter/material.dart';
import 'package:minna/comman/const/const.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';
import 'package:iconsax/iconsax.dart';

class ScreenAvailableTrips extends StatefulWidget {
  const ScreenAvailableTrips({super.key});

  @override
  State<ScreenAvailableTrips> createState() => _ScreenAvailableTripsState();
}

class _ScreenAvailableTripsState extends State<ScreenAvailableTrips> {
  late FilterState _currentFilterState;

  @override
  void initState() {
    super.initState();
    _currentFilterState = FilterState();
  }

  @override
  Widget build(BuildContext context) {
    final selectedData = context.read<LocationBloc>().state;

    return Scaffold(
      backgroundColor: backgroundColor,
      body: BlocConsumer<BusListFetchBloc, BusListFetchState>(
        listener: (context, state) {
          if (state.availableTrips != null) {
            _updateFilterStateFromBloc(state);
          }
        },
        builder: (context, state) {
          return CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              // Premium Unified Header
              SliverAppBar(
                expandedHeight: 180,
                pinned: true,
                floating: false,
                elevation: 0,
                backgroundColor: maincolor1,
                leading: IconButton(
                  icon: const Icon(
                    Iconsax.arrow_left_2,
                    color: Colors.white,
                    size: 24,
                  ),
                  onPressed: () => Navigator.pop(context),
                ),
                actions: [_buildFilterAction(context, state)],
                flexibleSpace: FlexibleSpaceBar(
                  background: _buildHeaderBackground(selectedData, state),
                ),
              ),

              // Content Section
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
                  child: Row(
                    children: [
                      Icon(Iconsax.bus, color: secondaryColor, size: 18),
                      const SizedBox(width: 8),
                      Text(
                        state.isLoading
                            ? 'Searching buses...'
                            : '${state.availableTrips?.length ?? 0} Buses Available',
                        style: TextStyle(
                          fontSize: 11,
                          color: textPrimary,
                          fontWeight: FontWeight.w800,
                          letterSpacing: -0.2,
                        ),
                      ),
                      const Spacer(),
                      if (_hasActiveFilters())
                        _buildActiveFilterBadge(context, state),
                    ],
                  ),
                ),
              ),

              // Results List
              _buildSliverContent(context, state, selectedData),
            ],
          );
        },
      ),
    );
  }

  Widget _buildHeaderBackground(
    LocationState selectedData,
    BusListFetchState state,
  ) {
    return Container(
      decoration: BoxDecoration(
        color: maincolor1,
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [maincolor1, maincolor1.withOpacity(0.95)],
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 50, 20, 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'FROM',
                          style: TextStyle(
                            fontSize: 9,
                            color: Colors.white.withOpacity(0.5),
                            fontWeight: FontWeight.w900,
                            letterSpacing: 1.5,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          selectedData.from?.name ?? '--',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 11,
                            fontWeight: FontWeight.w800,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.1),
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.white.withOpacity(0.2),
                        ),
                      ),
                      child: const Icon(
                        Iconsax.arrow_swap_horizontal,
                        color: Colors.white,
                        size: 16,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          'TO',
                          style: TextStyle(
                            fontSize: 9,
                            color: Colors.white.withOpacity(0.5),
                            fontWeight: FontWeight.w900,
                            letterSpacing: 1.5,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          selectedData.to?.name ?? '--',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 11,
                            fontWeight: FontWeight.w800,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.white.withOpacity(0.1)),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Iconsax.calendar_1, color: secondaryColor, size: 14),
                    const SizedBox(width: 8),
                    Text(
                      'Search Results for ${selectedData.dateOfJourney.day} ${_getMonth(selectedData.dateOfJourney.month)} ${selectedData.dateOfJourney.year}',
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.9),
                        fontSize: 9,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _getMonth(int month) {
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    return months[month - 1];
  }

  Widget _buildFilterAction(BuildContext context, BusListFetchState state) {
    final hasActiveFilters = _hasActiveFilters();
    return Stack(
      alignment: Alignment.center,
      children: [
        IconButton(
          icon: Icon(
            Iconsax.filter_edit,
            color: hasActiveFilters ? secondaryColor : Colors.white,
            size: 22,
          ),
          onPressed: () => _showFilterBottomSheet(context, state),
        ),
        if (hasActiveFilters)
          Positioned(
            right: 12,
            top: 12,
            child: Container(
              width: 8,
              height: 8,
              decoration: BoxDecoration(
                color: secondaryColor,
                shape: BoxShape.circle,
                border: Border.all(color: maincolor1, width: 1.5),
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildActiveFilterBadge(
    BuildContext context,
    BusListFetchState state,
  ) {
    return GestureDetector(
      onTap: () => _showFilterBottomSheet(context, state),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: secondaryColor.withOpacity(0.1),
          borderRadius: BorderRadius.circular(100),
          border: Border.all(color: secondaryColor.withOpacity(0.3)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Iconsax.filter_tick, size: 12, color: secondaryColor),
            const SizedBox(width: 4),
            Text(
              'Filters Applied',
              style: TextStyle(
                fontSize: 10,
                color: secondaryColor,
                fontWeight: FontWeight.w800,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSliverContent(
    BuildContext context,
    BusListFetchState state,
    LocationState selectedData,
  ) {
    if (state.isLoading) {
      return SliverFillRemaining(child: BusListloadingPage());
    }

    if (state.isError) {
      return SliverToBoxAdapter(
        child: _buildErrorWidget(context, selectedData),
      );
    }

    if (state.notripp! ||
        state.availableTrips == null ||
        state.availableTrips!.isEmpty) {
      return SliverToBoxAdapter(child: _buildNoTripsWidget());
    }

    return SliverList(
      delegate: SliverChildBuilderDelegate((context, index) {
        final trip = state.availableTrips![index];
        final startfare = faredecode(fare: trip.fareDetails);
        final arrivalTime = changetime(time: trip.arrivalTime);
        final departureTime = changetime(time: trip.departureTime);

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: TripCountainer(
            index: index,
            availableTriplist: state.availableTrips!,
            startfare: startfare,
            departureTime: departureTime,
            arrivalTime: arrivalTime,
          ),
        );
      }, childCount: state.availableTrips!.length),
    );
  }

  Widget _buildErrorWidget(BuildContext context, LocationState selectedData) {
    return Container(
      height: 400,
      alignment: Alignment.center,
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: errorColor.withOpacity(0.05),
              shape: BoxShape.circle,
            ),
            child: Icon(Iconsax.danger, color: errorColor, size: 48),
          ),
          const SizedBox(height: 24),
          Text(
            'Something went wrong',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w900,
              color: textPrimary,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'We couldn\'t load the bus list. Please try again.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 13,
              color: textSecondary,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 32),
          ElevatedButton(
            onPressed: () {
              context.read<BusListFetchBloc>().add(
                FetchTrip(
                  dateOfjurny: selectedData.dateOfJourney,
                  destID: selectedData.to!,
                  sourceID: selectedData.from!,
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: maincolor1,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              elevation: 0,
            ),
            child: const Text(
              'Try Again',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w800),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNoTripsWidget() {
    return Container(
      height: 400,
      alignment: Alignment.center,
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: maincolor1.withOpacity(0.05),
              shape: BoxShape.circle,
            ),
            child: Icon(Iconsax.map_1, color: maincolor1, size: 48),
          ),
          const SizedBox(height: 24),
          Text(
            'No Buses Found',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w900,
              color: textPrimary,
            ),
          ),
          const SizedBox(height: 12),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Text(
              'We couldn\'t find any buses for your selected route and date. Try changing your criteria.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 13,
                color: textSecondary,
                fontWeight: FontWeight.w500,
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }

  double faredecode({required dynamic fare}) {
    List<FareDetail> fareList;

    if (fare is List<FareDetail>) {
      fareList = fare;
    } else if (fare is FareDetail) {
      fareList = [fare];
    } else {
      return 0.0;
    }

    if (fareList.isEmpty) return 0.0;

    num smallestValue = double.parse(fareList[0].baseFare);

    for (int i = 1; i < fareList.length; i++) {
      num currentValue = double.parse(fareList[i].baseFare);
      if (currentValue < smallestValue) {
        smallestValue = currentValue;
      }
    }

    return double.parse(smallestValue.toString());
  }

  void _showFilterBottomSheet(BuildContext context, BusListFetchState state) {
    final currentTrips = state.availableTrips ?? [];

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return FilterBottomSheet(
          availableTrips: currentTrips,
          currentFilterState: _currentFilterState,
          onFiltersChanged: (newFilterState) {
            setState(() {
              _currentFilterState = newFilterState;
            });
          },
          primaryColor: maincolor1,
          secondaryColor: secondaryColor,
          backgroundColor: backgroundColor,
          cardColor: cardColor,
          textPrimary: textPrimary,
          textSecondary: textSecondary,
        );
      },
    );
  }

  void _updateFilterStateFromBloc(BusListFetchState state) {
    // This method would need to be implemented based on how your bloc stores filter state
    // For now, we'll keep the current filter state as is
  }

  bool _hasActiveFilters() {
    return _currentFilterState.busTypes.any((element) => element) ||
        _currentFilterState.departureTimes.any((element) => element) ||
        _currentFilterState.arrivalTimes.any((element) => element);
  }
}

// Filter State Class
class FilterState {
  List<bool> busTypes;
  List<bool> departureTimes;
  List<bool> arrivalTimes;

  FilterState({
    List<bool>? busTypes,
    List<bool>? departureTimes,
    List<bool>? arrivalTimes,
  }) : busTypes = busTypes ?? [false, false, false, false],
       departureTimes = departureTimes ?? [false, false, false, false],
       arrivalTimes = arrivalTimes ?? [false, false, false, false];

  FilterState copyWith({
    List<bool>? busTypes,
    List<bool>? departureTimes,
    List<bool>? arrivalTimes,
  }) {
    return FilterState(
      busTypes: busTypes ?? this.busTypes,
      departureTimes: departureTimes ?? this.departureTimes,
      arrivalTimes: arrivalTimes ?? this.arrivalTimes,
    );
  }

  bool get hasActiveFilters {
    return busTypes.any((element) => element) ||
        departureTimes.any((element) => element) ||
        arrivalTimes.any((element) => element);
  }
}

// Filter Bottom Sheet Widget
class FilterBottomSheet extends StatefulWidget {
  final List<AvailableTrip> availableTrips;
  final FilterState currentFilterState;
  final Function(FilterState) onFiltersChanged;
  final Color primaryColor;
  final Color secondaryColor;
  final Color backgroundColor;
  final Color cardColor;
  final Color textPrimary;
  final Color textSecondary;

  const FilterBottomSheet({
    super.key,
    required this.availableTrips,
    required this.currentFilterState,
    required this.onFiltersChanged,
    required this.primaryColor,
    required this.secondaryColor,
    required this.backgroundColor,
    required this.cardColor,
    required this.textPrimary,
    required this.textSecondary,
  });

  @override
  State<FilterBottomSheet> createState() => _FilterBottomSheetState();
}

class _FilterBottomSheetState extends State<FilterBottomSheet> {
  late FilterState _filterState;

  @override
  void initState() {
    super.initState();
    _filterState = widget.currentFilterState.copyWith();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: widget.cardColor,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(32),
          topRight: Radius.circular(32),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 40,
            offset: const Offset(0, -10),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Premium Drag Handle
          const SizedBox(height: 12),
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.3),
              borderRadius: BorderRadius.circular(2),
            ),
          ),

          // Enhanced Header
          Padding(
            padding: const EdgeInsets.fromLTRB(24, 16, 16, 16),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: widget.secondaryColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(Iconsax.filter_edit, color: widget.secondaryColor, size: 20),
                ),
                const SizedBox(width: 16),
                Text(
                  'Filter Buses',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w900,
                    color: widget.textPrimary,
                    letterSpacing: -0.5,
                  ),
                ),
                const Spacer(),
                IconButton(
                  icon: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: widget.backgroundColor.withOpacity(0.5),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(Icons.close_rounded, color: widget.textSecondary, size: 20),
                  ),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
          ),

          const Divider(height: 1),

          Flexible(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Bus Types Section
                  _buildSectionHeader('BUS TYPES', Iconsax.bus),
                  const SizedBox(height: 16),
                  _buildBusTypeChips(),

                  const SizedBox(height: 32),

                  // Departure Time Section
                  _buildSectionHeader('DEPARTURE TIME', Iconsax.timer_1),
                  const SizedBox(height: 16),
                  _buildTimeChips(_filterState.departureTimes, (index, val) {
                    setState(() => _filterState.departureTimes[index] = val);
                  }),

                  const SizedBox(height: 32),

                  // Arrival Time Section
                  _buildSectionHeader('ARRIVAL TIME', Iconsax.timer_start),
                  const SizedBox(height: 16),
                  _buildTimeChips(_filterState.arrivalTimes, (index, val) {
                    setState(() => _filterState.arrivalTimes[index] = val);
                  }),

                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),

          // Multi-Action Buttons
          Container(
            padding: EdgeInsets.fromLTRB(24, 16, 24, 24 + MediaQuery.of(context).padding.bottom),
            decoration: BoxDecoration(
              color: widget.cardColor,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 20,
                  offset: const Offset(0, -5),
                ),
              ],
            ),
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: TextButton(
                    onPressed: () {
                      setState(() => _filterState = FilterState());
                    },
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                    child: Text(
                      'Reset All',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w800,
                        color: widget.textSecondary,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  flex: 3,
                  child: ElevatedButton(
                    onPressed: () => _applyFilters(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: widget.secondaryColor,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      elevation: 0,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(Iconsax.tick_circle, size: 18),
                        SizedBox(width: 8),
                        Text(
                          'Apply Filters',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ],
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

  Widget _buildSectionHeader(String title, IconData icon) {
    return Row(
      children: [
        Icon(icon, size: 14, color: widget.textSecondary.withOpacity(0.5)),
        const SizedBox(width: 8),
        Text(
          title,
          style: TextStyle(
            fontSize: 9,
            fontWeight: FontWeight.w900,
            color: widget.textSecondary.withOpacity(0.6),
            letterSpacing: 1.2,
          ),
        ),
      ],
    );
  }

  Widget _buildBusTypeChips() {
    final types = ['Sleeper', 'Seater', 'AC', 'Non AC'];
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: List.generate(types.length, (index) {
        final isSelected = _filterState.busTypes[index];
        return _buildFilterChip(
          label: types[index],
          isSelected: isSelected,
          onTap: () => setState(() => _filterState.busTypes[index] = !isSelected),
        );
      }),
    );
  }

  Widget _buildTimeChips(List<bool> stateList, Function(int, bool) onChanged) {
    final times = ['6AM', '6-12', '12-6', '6PM'];
    final labels = ['Early Morning', 'Morning', 'Afternoon', 'Evening'];
    final icons = [Iconsax.sun_1, Iconsax.cloud_sunny, Iconsax.cloud, Iconsax.moon];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 2.5,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
      ),
      itemCount: 4,
      itemBuilder: (context, index) {
        final isSelected = stateList[index];
        return GestureDetector(
          onTap: () => onChanged(index, !isSelected),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              color: isSelected ? widget.secondaryColor : widget.backgroundColor.withOpacity(0.3),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: isSelected ? widget.secondaryColor : widget.backgroundColor.withOpacity(0.5),
              ),
            ),
            child: Row(
              children: [
                Icon(
                  icons[index],
                  size: 16,
                  color: isSelected ? Colors.white : widget.textSecondary,
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        times[index],
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w900,
                          color: isSelected ? Colors.white : widget.textPrimary,
                        ),
                      ),
                      Text(
                        labels[index],
                        style: TextStyle(
                          fontSize: 8,
                          fontWeight: FontWeight.w600,
                          color: isSelected ? Colors.white.withOpacity(0.8) : widget.textSecondary,
                        ),
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
  }

  Widget _buildFilterChip({
    required String label,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? widget.secondaryColor : Colors.transparent,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: isSelected ? widget.secondaryColor : widget.textSecondary.withOpacity(0.15),
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 11,
            fontWeight: isSelected ? FontWeight.w900 : FontWeight.w700,
            color: isSelected ? Colors.white : widget.textPrimary,
          ),
        ),
      ),
    );
  }

  void _applyFilters(BuildContext context) {
    widget.onFiltersChanged(_filterState);
    final busBloc = context.read<BusListFetchBloc>();
    busBloc.add(
      FilterConform(
        sleeper: _filterState.busTypes[0],
        seater: _filterState.busTypes[1],
        ac: _filterState.busTypes[2],
        nonAC: _filterState.busTypes[3],
        departureCase1: _filterState.departureTimes[0],
        departureCase2: _filterState.departureTimes[1],
        departureCase3: _filterState.departureTimes[2],
        departureCase4: _filterState.departureTimes[3],
        arrivalCase1: _filterState.arrivalTimes[0],
        arrivalCase2: _filterState.arrivalTimes[1],
        arrivalCase3: _filterState.arrivalTimes[2],
        arrivalCase4: _filterState.arrivalTimes[3],
        availableTrips: widget.availableTrips,
      ),
    );
    Navigator.pop(context);
  }
}

class BusListloadingPage extends StatelessWidget {
  const BusListloadingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(20),
      itemCount: 6,
      itemBuilder: (context, index) {
        return Container(
          margin: const EdgeInsets.only(bottom: 16),
          height: 200,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.03),
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Shimmer.fromColors(
              baseColor: Colors.grey[200]!,
              highlightColor: Colors.grey[50]!,
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        width: 48,
                        height: 48,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 150,
                              height: 16,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(4),
                              ),
                            ),
                            const SizedBox(height: 8),
                            Container(
                              width: 80,
                              height: 12,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(4),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: 60,
                        height: 24,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  Container(
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: 100,
                        height: 30,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(100),
                        ),
                      ),
                      Container(
                        width: 120,
                        height: 40,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
