



import 'dart:developer';

import 'package:minna/bus/application/busListfetch/bus_list_fetch_bloc.dart';
import 'package:minna/bus/application/busListfetch/bus_list_fetch_state.dart';
import 'package:minna/bus/application/change%20location/location_bloc.dart';
import 'package:minna/bus/infrastructure/time.dart';
import 'package:minna/bus/pages/Screen%20available%20Trip/widgets/trip_container.dart';
import 'package:minna/bus/presendation/widgets/error_widget.dart';
import 'package:minna/bus/domain/trips%20list%20modal/trip_list_modal.dart';
import 'package:minna/comman/const/const.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';

class ScreenAvailableTrips extends StatefulWidget {
  const ScreenAvailableTrips({super.key});

  @override
  State<ScreenAvailableTrips> createState() => _ScreenAvailableTripsState();
}

class _ScreenAvailableTripsState extends State<ScreenAvailableTrips> {
  // Color Theme - Consistent with flight booking
  final Color _primaryColor = Colors.black;
  final Color _secondaryColor = Color(0xFFD4AF37); // Gold
  final Color _accentColor = Color(0xFFC19B3C); // Darker Gold
  final Color _backgroundColor = Color(0xFFF8F9FA);
  final Color _cardColor = Colors.white;
  final Color _textPrimary = Colors.black;
  final Color _textSecondary = Color(0xFF666666);
  final Color _textLight = Color(0xFF999999);
  final Color _errorColor = Color(0xFFE53935);

  // Filter state
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
      backgroundColor: _backgroundColor,
      appBar: AppBar(
        backgroundColor: _primaryColor,
        iconTheme: IconThemeData(color: Colors.white),
        elevation: 0,
        // title: Text(
        //   'Available Buses',
        //   style: TextStyle(
        //     color: Colors.white,
        //     fontSize: 15,
        //     fontWeight: FontWeight.w600,
        //   ),
        // ),
        actions: [
          // Filter Button
          BlocBuilder<BusListFetchBloc, BusListFetchState>(
            builder: (context, state) {
              final hasActiveFilters = _hasActiveFilters();
              return Stack(
                children: [
                  IconButton(
                    icon: Icon(
                      Icons.filter_alt_rounded, 
                      color: hasActiveFilters ? _secondaryColor : Colors.white
                    ),
                    onPressed: () {
                      _showFilterBottomSheet(context, state);
                    },
                    tooltip: 'Filter',
                  ),
                  if (hasActiveFilters)
                    Positioned(
                      right: 8,
                      top: 8,
                      child: Container(
                        width: 8,
                        height: 8,
                        decoration: BoxDecoration(
                          color: _secondaryColor,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                ],
              );
            },
          ),
       
        ],
      ),
      body: BlocConsumer<BusListFetchBloc, BusListFetchState>(
        listener: (context, state) {
          // Update filter state when filters are applied
          if (state.availableTrips != null) {
            _updateFilterStateFromBloc(state);
          }
        },
        builder: (context, state) {
          if (state.isLoading) {
            return BusListloadingPage();
          }

          if (state.isError) {
            return _buildErrorWidget(context, selectedData);
          }

          if (state.notripp! ||
              state.availableTrips == null ||
              state.availableTrips!.isEmpty) {
            return _buildNoTripsWidget();
          }

          return _buildTripList(context, state, selectedData);
        },
      ),
    );
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
          primaryColor: _primaryColor,
          secondaryColor: _secondaryColor,
          backgroundColor: _backgroundColor,
          cardColor: _cardColor,
          textPrimary: _textPrimary,
          textSecondary: _textSecondary,
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

  Widget _buildErrorWidget(BuildContext context, LocationState selectedData) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: _cardColor,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: Icon(
                Icons.error_outline_rounded,
                color: _errorColor,
                size: 48,
              ),
            ),
            SizedBox(height: 24),
            Text(
              'Something went wrong',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: _textPrimary,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'We couldn\'t load the bus list. Please try again.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: _textSecondary,
              ),
            ),
            SizedBox(height: 24),
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
                backgroundColor: _primaryColor,
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text(
                'Try Again',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNoTripsWidget() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: _cardColor,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: Icon(
                Icons.directions_bus_rounded,
                color: _textLight,
                size: 48,
              ),
            ),
            SizedBox(height: 24),
            Text(
              'No buses found',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: _textPrimary,
              ),
            ),
            SizedBox(height: 12),
            Text(
              'We couldn\'t find any buses for your selected route and date. '
              'Try changing your search criteria or select a different date.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: _textSecondary,
                height: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTripList(BuildContext context, BusListFetchState state, LocationState selectedData) {
    return Column(
      children: [
        // Route Header
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: _primaryColor,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 10,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'FROM',
                      style: TextStyle(
                        fontSize: 10,
                        color: Colors.white.withOpacity(0.7),
                        fontWeight: FontWeight.w500,
                        letterSpacing: 1,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      selectedData.from?.name ?? '--',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: _secondaryColor,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.arrow_forward_rounded,
                        color: Colors.white,
                        size: 16,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      '${state.availableTrips!.length} buses',
                      style: TextStyle(
                        fontSize: 10,
                        color: Colors.white.withOpacity(0.7),
                      ),
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
                        color: Colors.white.withOpacity(0.7),
                        fontWeight: FontWeight.w500,
                        letterSpacing: 1,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      selectedData.to?.name ?? '--',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 16),
        
        // Trip Count and Filter Indicator
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: [
              Icon(
                Icons.directions_bus_rounded,
                color: _secondaryColor,
                size: 16,
              ),
              SizedBox(width: 8),
              Text(
                '${state.availableTrips!.length} buses available',
                style: TextStyle(
                  fontSize: 12,
                  color: _textSecondary,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Spacer(),
              // Active Filters Indicator
              if (_hasActiveFilters())
                GestureDetector(
                  onTap: () {
                    _showFilterBottomSheet(context, state);
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: _secondaryColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: _secondaryColor.withOpacity(0.3)),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.filter_alt_rounded, size: 12, color: _secondaryColor),
                        SizedBox(width: 4),
                        Text(
                          'Filters Active',
                          style: TextStyle(
                            fontSize: 10,
                            color: _secondaryColor,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ),
        SizedBox(height: 12),
        
        // Trip List
        Expanded(
          child: ListView.builder(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            itemCount: state.availableTrips!.length,
            itemBuilder: (context, index) {
              final startfare = faredecode(
                fare: state.availableTrips![index].fareDetails,
              );
              final arrivalTime = changetime(
                time: state.availableTrips![index].arrivalTime,
              );
              final departureTime = changetime(
                time: state.availableTrips![index].departureTime,
              );
              return TripCountainer(
                index: index,
                availableTriplist: state.availableTrips!,
                startfare: startfare,
                departureTime: departureTime,
                arrivalTime: arrivalTime,
              );
            },
          ),
        ),
      ],
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
  })  : busTypes = busTypes ?? [false, false, false, false],
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
    // Initialize with current filter state
    _filterState = widget.currentFilterState.copyWith();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.8,
      decoration: BoxDecoration(
        color: widget.cardColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      child: Column(
        children: [
          // Header
          Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(color: widget.backgroundColor.withOpacity(0.5)),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Filter Buses',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: widget.textPrimary,
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.close_rounded, color: widget.textSecondary),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
          ),
          
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                
                children: [
                  // Bus Types
                  _buildFilterSection(
                    title: 'Bus Types',
                    options: ['Sleeper', 'Seater', 'AC', 'Non AC'],
                    selectedOptions: _filterState.busTypes,
                    onOptionChanged: (index, value) {
                      setState(() {
                        _filterState.busTypes[index] = value;
                      });
                    },
                  ),
                  
                  SizedBox(height: 24),
                  
                  // Departure Times
                  _buildFilterSection(
                    title: 'Departure Times',
                    options: ['Before 6 am', '6 am to 12 pm', '12 pm to 6 pm', 'After 6 pm'],
                    selectedOptions: _filterState.departureTimes,
                    onOptionChanged: (index, value) {
                      setState(() {
                        _filterState.departureTimes[index] = value;
                      });
                    },
                  ),
                  
                  SizedBox(height: 24),
                  
                  // Arrival Times
                  _buildFilterSection(
                    title: 'Arrival Times',
                    options: ['Before 6 am', '6 am to 12 pm', '12 pm to 6 pm', 'After 6 pm'],
                    selectedOptions: _filterState.arrivalTimes,
                    onOptionChanged: (index, value) {
                      setState(() {
                        _filterState.arrivalTimes[index] = value;
                      });
                    },
                  ),
                ],
              ),
            ),
          ),
          
          // Action Buttons
          Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(color: widget.backgroundColor.withOpacity(0.5)),
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      setState(() {
                        _filterState = FilterState();
                      });
                    },
                    style: OutlinedButton.styleFrom(
                      foregroundColor: widget.textSecondary,
                      padding: EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      side: BorderSide(color: widget.textSecondary.withOpacity(0.3)),
                    ),
                    child: Text('Reset All'),
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      _applyFilters(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: widget.secondaryColor,
                      foregroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 2,
                    ),
                    child: Text('Apply Filters'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterSection({
    required String title,
    required List<String> options,
    required List<bool> selectedOptions,
    required Function(int, bool) onOptionChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: widget.textPrimary,
          ),
        ),
        SizedBox(height: 12),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: List.generate(options.length, (index) {
            return FilterChip(
              label: Text(options[index]),
              selected: selectedOptions[index],
              onSelected: (selected) => onOptionChanged(index, selected),
              selectedColor: widget.secondaryColor.withOpacity(0.2),
              checkmarkColor: widget.secondaryColor,
              labelStyle: TextStyle(
                color: selectedOptions[index] ? widget.secondaryColor : widget.textPrimary,
                fontWeight: selectedOptions[index] ? FontWeight.w600 : FontWeight.normal,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
                // side: BorderSide(
                //   color: selectedOptions[index] 
                //       ? widget.secondaryColor 
                //       : widget.textSecondary.withOpacity(0.3),
                // ),
              ),
            );
          }),
        ),
      ],
    );
  }

  void _applyFilters(BuildContext context) {
    // Update the parent widget with new filter state
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

// Rest of the code remains the same (BusListloadingPage, etc.)
class BusListloadingPage extends StatelessWidget {
  BusListloadingPage({super.key});

  final Color _primaryColor = Colors.black;
  final Color _secondaryColor = Color(0xFFD4AF37);
  final Color _backgroundColor = Color(0xFFF8F9FA);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.all(16),
      itemCount: 6,
      itemBuilder: (context, index) {
        return Container(
          margin: EdgeInsets.only(bottom: 16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: Offset(0, 4),
              ),
            ],
          ),
          padding: EdgeInsets.all(16),
          child: Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Column(
              children: [
                // Top section: Bus info and price
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(18),
                      ),
                    ),
                    SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: double.infinity,
                            height: 16,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                          SizedBox(height: 8),
                          Container(
                            width: 120,
                            height: 14,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Container(
                          width: 60,
                          height: 12,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                        SizedBox(height: 6),
                        Container(
                          width: 80,
                          height: 18,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 16),
                
                // Divider
                Container(
                  width: double.infinity,
                  height: 1,
                  color: Colors.white,
                ),
                SizedBox(height: 16),
                
                // Time section
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 50,
                          height: 12,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                        SizedBox(height: 8),
                        Container(
                          width: 70,
                          height: 16,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Container(
                          width: 60,
                          height: 14,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                        SizedBox(height: 8),
                        Row(
                          children: [
                            Container(
                              width: 20,
                              height: 1,
                              color: Colors.white,
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 4),
                              child: Container(
                                width: 16,
                                height: 16,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle,
                                ),
                              ),
                            ),
                            Container(
                              width: 20,
                              height: 1,
                              color: Colors.white,
                            ),
                          ],
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Container(
                          width: 50,
                          height: 12,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                        SizedBox(height: 8),
                        Container(
                          width: 70,
                          height: 16,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 16),
                
                // Divider
                Container(
                  width: double.infinity,
                  height: 1,
                  color: Colors.white,
                ),
                SizedBox(height: 16),
                
                // Bottom section: Seats and button
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: 100,
                      height: 16,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    Container(
                      width: 100,
                      height: 36,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
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