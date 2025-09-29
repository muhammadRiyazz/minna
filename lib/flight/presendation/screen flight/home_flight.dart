import 'package:minna/comman/const/const.dart';
import 'package:minna/flight/application/search%20data/search_data_bloc.dart';
import 'package:minna/flight/application/trip%20request/trip_request_bloc.dart';

import 'package:minna/flight/domain/triplist%20request/search_request.dart';
import 'package:minna/flight/presendation/screen%20flight/widget/airport_bottom.dart';
import 'package:minna/flight/presendation/trip%20list/trip_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class FlightBookingTab extends StatelessWidget {
  const FlightBookingTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          'Flight Booking',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        backgroundColor: maincolor1,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(16)),
        ),
      ),
      body: BlocBuilder<SearchDataBloc, SearchDataState>(
        builder: (context, state) {
          return SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SizedBox(
                  // color: Colors.amberAccent,
                  height: 170,
                  child: Align(
                    alignment: Alignment.center,
                    child: Image.asset(
                      'asset/flight/Airport.png',
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                // SizedBox(height: 20),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Text(
                    'Flight Tickets   ',
                    style: const TextStyle(
                      fontSize: 19,
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const Text(
                        'Book domestic and international flights',
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.grey,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      const SizedBox(height: 25),
                      // Trip Type Selector
                      Row(
                        children: [
                          Expanded(
                            child: GestureDetector(
                              onTap: () => context.read<SearchDataBloc>().add(
                                const SearchDataEvent.oneWayOrRound(
                                  oneWayOrRound: 'oneWay',
                                ),
                              ),
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 12,
                                ),
                                decoration: BoxDecoration(
                                  color: state.oneWay
                                      ? maincolor1!
                                      : Colors.grey.shade200,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Center(
                                  child: Text(
                                    'One Way',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: state.oneWay
                                          ? Colors.white
                                          : Colors.black87,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: GestureDetector(
                              onTap: () => context.read<SearchDataBloc>().add(
                                const SearchDataEvent.oneWayOrRound(
                                  oneWayOrRound: 'roundTrip',
                                ),
                              ),
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 12,
                                ),
                                decoration: BoxDecoration(
                                  color: !state.oneWay
                                      ? maincolor1!
                                      : Colors.grey.shade200,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Center(
                                  child: Text(
                                    'Round Trip',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: !state.oneWay
                                          ? Colors.white
                                          : Colors.black87,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 15),
                      // Location Selector
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black26),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          children: [
                            // From Location
                            InkWell(
                              onTap: () =>
                                  showAirportBottomSheet(context, isFrom: true),
                              child: ListTile(
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 4,
                                ),
                                title: Text(
                                  'From',
                                  style: const TextStyle(
                                    fontSize: 10,
                                    color: Colors.grey,
                                  ),
                                ),
                                subtitle: Text(
                                  state.from?.name ?? 'Select Departure City',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.black,

                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                leading: Icon(
                                  Icons.flight_takeoff,
                                  color: maincolor1!,
                                  size: 30,
                                ),
                              ),
                            ),
                            const Divider(height: 0),
                            InkWell(
                              onTap: () => showAirportBottomSheet(
                                context,
                                isFrom: false,
                              ),
                              child: ListTile(
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 4,
                                ),
                                title: Text(
                                  'To',
                                  style: const TextStyle(
                                    fontSize: 10,
                                    color: Colors.grey,
                                  ),
                                ),
                                subtitle: Text(
                                  state.to?.name ?? 'Select Arrival City',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.black,

                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                leading: Icon(
                                  Icons.flight_land,
                                  color: maincolor1!,
                                  size: 30,
                                ),
                              ),
                            ),
                            const Divider(height: 0),
                            // Date Selectors
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  // Departure Date
                                  Expanded(
                                    child: InkWell(
                                      onTap: () async {
                                        final pickedDate = await showDatePicker(
                                          context: context,
                                          initialDate: DateTime.now(),
                                          firstDate: DateTime.now(),
                                          lastDate: DateTime(2101),
                                          builder: (context, child) => Theme(
                                            data: Theme.of(context).copyWith(
                                              colorScheme: ColorScheme.light(
                                                primary: maincolor1!,
                                                onPrimary: Colors.white,
                                                onSurface: maincolor1!,
                                              ),
                                            ),
                                            child: child!,
                                          ),
                                        );
                                        if (pickedDate != null) {
                                          context.read<SearchDataBloc>().add(
                                            SearchDataEvent.departureDateChange(
                                              departureDate: pickedDate,
                                            ),
                                          );

                                          // If return date exists and is before new departure date, update it
                                          final currentState = context
                                              .read<SearchDataBloc>()
                                              .state;
                                          if (!currentState.oneWay &&
                                              currentState.returnDate != null &&
                                              currentState.returnDate!.isBefore(
                                                pickedDate,
                                              )) {
                                            context.read<SearchDataBloc>().add(
                                              SearchDataEvent.returnDateChange(
                                                returnDate: pickedDate,
                                              ),
                                            );
                                          }
                                        }
                                      },
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons.calendar_month_outlined,
                                            color: maincolor1!,
                                            size: 32,
                                          ),
                                          const SizedBox(width: 5),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              const SizedBox(height: 2),
                                              const Text(
                                                "Departure Date",
                                                style: TextStyle(
                                                  fontSize: 8,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ),
                                              Text(
                                                DateFormat(
                                                  'dd MMM yyyy',
                                                ).format(state.departureDate),
                                                style: const TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.black87,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  if (!state.oneWay) const SizedBox(width: 10),
                                  if (!state.oneWay)
                                    Expanded(
                                      child: InkWell(
                                        onTap: () async {
                                          final currentState = context
                                              .read<SearchDataBloc>()
                                              .state;
                                          final pickedDate = await showDatePicker(
                                            context: context,
                                            initialDate:
                                                currentState.returnDate ??
                                                currentState.departureDate,
                                            firstDate: currentState
                                                .departureDate, // Allow same date as departure
                                            lastDate: DateTime(2101),
                                            builder: (context, child) => Theme(
                                              data: Theme.of(context).copyWith(
                                                colorScheme: ColorScheme.light(
                                                  primary: maincolor1!,
                                                  onPrimary: Colors.white,
                                                  onSurface: maincolor1!,
                                                ),
                                              ),
                                              child: child!,
                                            ),
                                          );
                                          if (pickedDate != null) {
                                            context.read<SearchDataBloc>().add(
                                              SearchDataEvent.returnDateChange(
                                                returnDate: pickedDate,
                                              ),
                                            );
                                          }
                                        },
                                        child: Row(
                                          children: [
                                            Icon(
                                              Icons.calendar_month_outlined,
                                              color: maincolor1!,
                                              size: 32,
                                            ),
                                            const SizedBox(width: 5),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                const SizedBox(height: 2),
                                                const Text(
                                                  "Return Date",
                                                  style: TextStyle(
                                                    fontSize: 8,
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                ),
                                                Text(
                                                  state.returnDate != null
                                                      ? DateFormat(
                                                          'dd MMM yyyy',
                                                        ).format(
                                                          state.returnDate!,
                                                        )
                                                      : "Select date",
                                                  style: TextStyle(
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w500,
                                                    color:
                                                        state.returnDate != null
                                                        ? Colors.black87
                                                        : Colors.grey,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            ),
                            const Divider(height: 0),
                            // Travel Info Section
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              child: Row(
                                children: [
                                  // Travellers
                                  InkWell(
                                    onTap: () {
                                      showModalBottomSheet(
                                        context: context,
                                        isScrollControlled: true,
                                        builder: (context) {
                                          return BlocProvider.value(
                                            value: context
                                                .read<SearchDataBloc>(),
                                            child: BlocBuilder<SearchDataBloc, SearchDataState>(
                                              builder: (context, state) {
                                                return Container(
                                                  padding: const EdgeInsets.all(
                                                    20,
                                                  ),
                                                  height:
                                                      MediaQuery.of(
                                                        context,
                                                      ).size.height *
                                                      0.5,
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      const Text(
                                                        "Travellers",
                                                        style: TextStyle(
                                                          fontSize: 18,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                        height: 20,
                                                      ),
                                                      _buildPassengerType(
                                                        context,
                                                        "Adults",
                                                        "12+ years",
                                                        state
                                                            .travellers['adults']!,
                                                        (
                                                          value,
                                                        ) => context.read<SearchDataBloc>().add(
                                                          SearchDataEvent.passengers(
                                                            travellers: {
                                                              'adults': value,
                                                              'children': state
                                                                  .travellers['children']!,
                                                              'infants': state
                                                                  .travellers['infants']!,
                                                            },
                                                          ),
                                                        ),
                                                        min: 1,
                                                      ),
                                                      const SizedBox(
                                                        height: 15,
                                                      ),
                                                      _buildPassengerType(
                                                        context,
                                                        "Children",
                                                        "2-12 years",
                                                        state
                                                            .travellers['children']!,
                                                        (value) => context
                                                            .read<
                                                              SearchDataBloc
                                                            >()
                                                            .add(
                                                              SearchDataEvent.passengers(
                                                                travellers: {
                                                                  'adults': state
                                                                      .travellers['adults']!,
                                                                  'children':
                                                                      value,
                                                                  'infants': state
                                                                      .travellers['infants']!,
                                                                },
                                                              ),
                                                            ),
                                                      ),
                                                      const SizedBox(
                                                        height: 15,
                                                      ),
                                                      _buildPassengerType(
                                                        context,
                                                        "Infants",
                                                        "0-2 years",
                                                        state
                                                            .travellers['infants']!,
                                                        (
                                                          value,
                                                        ) => context.read<SearchDataBloc>().add(
                                                          SearchDataEvent.passengers(
                                                            travellers: {
                                                              'adults': state
                                                                  .travellers['adults']!,
                                                              'children': state
                                                                  .travellers['children']!,
                                                              'infants': value,
                                                            },
                                                          ),
                                                        ),
                                                        max: state
                                                            .travellers['adults'],
                                                      ),
                                                      const Spacer(),
                                                      Row(
                                                        children: [
                                                          Expanded(
                                                            child: TextButton(
                                                              onPressed: () =>
                                                                  Navigator.pop(
                                                                    context,
                                                                  ),
                                                              style: TextButton.styleFrom(
                                                                padding:
                                                                    const EdgeInsets.symmetric(
                                                                      vertical:
                                                                          15,
                                                                    ),
                                                                shape: RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius.circular(
                                                                        8,
                                                                      ),
                                                                  side: BorderSide(
                                                                    color:
                                                                        maincolor1!,
                                                                  ),
                                                                ),
                                                              ),
                                                              child: Text(
                                                                "Cancel",
                                                                style: TextStyle(
                                                                  color:
                                                                      maincolor1!,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                          const SizedBox(
                                                            width: 15,
                                                          ),
                                                          Expanded(
                                                            child: TextButton(
                                                              onPressed: () {
                                                                Navigator.pop(
                                                                  context,
                                                                );
                                                              },
                                                              style: TextButton.styleFrom(
                                                                backgroundColor:
                                                                    maincolor1!,
                                                                padding:
                                                                    const EdgeInsets.symmetric(
                                                                      vertical:
                                                                          15,
                                                                    ),
                                                                shape: RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius.circular(
                                                                        8,
                                                                      ),
                                                                ),
                                                              ),
                                                              child: const Text(
                                                                "Done",
                                                                style: TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                );
                                              },
                                            ),
                                          );
                                        },
                                      );
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        border: Border.all(
                                          color: Colors.black26,
                                        ),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                          vertical: 5,
                                          horizontal: 15,
                                        ),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const Text(
                                              "Travellers",
                                              style: TextStyle(
                                                fontSize: 10,
                                                fontWeight: FontWeight.w400,
                                                color: Colors.black38,
                                              ),
                                            ),
                                            Text(
                                              "${state.travellers['adults']! + state.travellers['children']! + state.travellers['infants']!} Travellers",
                                              style: const TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w500,
                                                color: Colors.black87,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  // Class Selector
                                  InkWell(
                                    onTap: () {
                                      showModalBottomSheet(
                                        context: context,
                                        builder: (context) {
                                          return BlocProvider.value(
                                            value: context
                                                .read<SearchDataBloc>(),
                                            child: BlocBuilder<SearchDataBloc, SearchDataState>(
                                              builder: (context, state) {
                                                return Container(
                                                  padding: const EdgeInsets.all(
                                                    20,
                                                  ),
                                                  child: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      const Text(
                                                        "Select Class",
                                                        style: TextStyle(
                                                          fontSize: 18,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                        height: 20,
                                                      ),
                                                      InkWell(
                                                        onTap: () => context
                                                            .read<
                                                              SearchDataBloc
                                                            >()
                                                            .add(
                                                              const SearchDataEvent.classChange(
                                                                seatClass:
                                                                    'Economy',
                                                              ),
                                                            ),
                                                        child: Container(
                                                          padding:
                                                              const EdgeInsets.all(
                                                                12,
                                                              ),
                                                          decoration: BoxDecoration(
                                                            color:
                                                                state.seatClass ==
                                                                    'Economy'
                                                                ? maincolor1!
                                                                      .withOpacity(
                                                                        0.1,
                                                                      )
                                                                : Colors
                                                                      .transparent,
                                                            border: Border.all(
                                                              color:
                                                                  state.seatClass ==
                                                                      'Economy'
                                                                  ? maincolor1!
                                                                  : Colors
                                                                        .grey
                                                                        .shade300,
                                                            ),
                                                            borderRadius:
                                                                BorderRadius.circular(
                                                                  8,
                                                                ),
                                                          ),
                                                          child: Row(
                                                            children: [
                                                              Container(
                                                                width: 20,
                                                                height: 20,
                                                                decoration: BoxDecoration(
                                                                  shape: BoxShape
                                                                      .circle,
                                                                  border: Border.all(
                                                                    color:
                                                                        state.seatClass ==
                                                                            'Economy'
                                                                        ? maincolor1!
                                                                        : Colors
                                                                              .grey,
                                                                    width:
                                                                        state.seatClass ==
                                                                            'Economy'
                                                                        ? 6
                                                                        : 2,
                                                                  ),
                                                                ),
                                                              ),
                                                              const SizedBox(
                                                                width: 15,
                                                              ),
                                                              Column(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Text(
                                                                    "Economy",
                                                                    style: TextStyle(
                                                                      fontSize:
                                                                          16,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500,
                                                                      color:
                                                                          state.seatClass ==
                                                                              'Economy'
                                                                          ? maincolor1!
                                                                          : Colors.black87,
                                                                    ),
                                                                  ),
                                                                  const Text(
                                                                    "Standard seating with essential services",
                                                                    style: TextStyle(
                                                                      fontSize:
                                                                          12,
                                                                      color: Colors
                                                                          .grey,
                                                                    ),
                                                                    maxLines:
                                                                        2, // Allow text to wrap
                                                                    overflow:
                                                                        TextOverflow
                                                                            .ellipsis,
                                                                  ),
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                        height: 15,
                                                      ),
                                                      InkWell(
                                                        onTap: () => context
                                                            .read<
                                                              SearchDataBloc
                                                            >()
                                                            .add(
                                                              const SearchDataEvent.classChange(
                                                                seatClass:
                                                                    'Business',
                                                              ),
                                                            ),
                                                        child: Container(
                                                          padding:
                                                              const EdgeInsets.all(
                                                                12,
                                                              ),
                                                          decoration: BoxDecoration(
                                                            color:
                                                                state.seatClass ==
                                                                    'Business'
                                                                ? maincolor1!
                                                                      .withOpacity(
                                                                        0.1,
                                                                      )
                                                                : Colors
                                                                      .transparent,
                                                            border: Border.all(
                                                              color:
                                                                  state.seatClass ==
                                                                      'Business'
                                                                  ? maincolor1!
                                                                  : Colors
                                                                        .grey
                                                                        .shade300,
                                                            ),
                                                            borderRadius:
                                                                BorderRadius.circular(
                                                                  8,
                                                                ),
                                                          ),
                                                          child: Row(
                                                            children: [
                                                              Container(
                                                                width: 20,
                                                                height: 20,
                                                                decoration: BoxDecoration(
                                                                  shape: BoxShape
                                                                      .circle,
                                                                  border: Border.all(
                                                                    color:
                                                                        state.seatClass ==
                                                                            'Business'
                                                                        ? maincolor1!
                                                                        : Colors
                                                                              .grey,
                                                                    width:
                                                                        state.seatClass ==
                                                                            'Business'
                                                                        ? 6
                                                                        : 2,
                                                                  ),
                                                                ),
                                                              ),
                                                              const SizedBox(
                                                                width: 15,
                                                              ),
                                                              Column(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Text(
                                                                    "Business",
                                                                    style: TextStyle(
                                                                      fontSize:
                                                                          16,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500,
                                                                      color:
                                                                          state.seatClass ==
                                                                              'Business'
                                                                          ? maincolor1!
                                                                          : Colors.black87,
                                                                    ),
                                                                  ),
                                                                  const Text(
                                                                    "Premium seating with enhanced services",
                                                                    style: TextStyle(
                                                                      fontSize:
                                                                          12,
                                                                      color: Colors
                                                                          .grey,
                                                                    ),
                                                                    maxLines:
                                                                        2, // Allow text to wrap
                                                                    overflow:
                                                                        TextOverflow
                                                                            .ellipsis,
                                                                  ),
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                        height: 25,
                                                      ),
                                                    ],
                                                  ),
                                                );
                                              },
                                            ),
                                          );
                                        },
                                      );
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        border: Border.all(
                                          color: Colors.black26,
                                        ),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                          vertical: 5,
                                          horizontal: 15,
                                        ),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const Text(
                                              "Class",
                                              style: TextStyle(
                                                fontSize: 10,
                                                fontWeight: FontWeight.w400,
                                                color: Colors.black38,
                                              ),
                                            ),
                                            Text(
                                              state.seatClass,
                                              style: const TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w500,
                                                color: Colors.black87,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 15),
                      // Search Button
                      SizedBox(
                        height: 50,
                        width: double.infinity,
                        child: TextButton(
                          onPressed: () {
                            // Validation checks
                            if (state.from == null || state.to == null) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  behavior: SnackBarBehavior.floating,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  margin: EdgeInsets.all(10),
                                  backgroundColor: Colors.redAccent,
                                  content: Row(
                                    children: [
                                      Icon(
                                        Icons.error_outline,
                                        color: Colors.white,
                                      ),
                                      SizedBox(width: 10),
                                      Expanded(
                                        child: Text(
                                          'Please select both origin and destination',
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
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
                                      ScaffoldMessenger.of(
                                        context,
                                      ).hideCurrentSnackBar();
                                    },
                                  ),
                                ),
                              );
                              return;
                            }

                            if (!state.oneWay && state.returnDate == null) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  behavior: SnackBarBehavior.floating,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  margin: EdgeInsets.all(10),
                                  backgroundColor: Colors.redAccent,
                                  content: Row(
                                    children: [
                                      Icon(
                                        Icons.calendar_today,
                                        color: Colors.white,
                                      ),
                                      SizedBox(width: 10),
                                      Expanded(
                                        child: Text(
                                          'Please select return date for round trip',
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  duration: Duration(seconds: 4),
                                  action: SnackBarAction(
                                    label: 'OK',
                                    textColor: Colors.white,
                                    onPressed: () {
                                      ScaffoldMessenger.of(
                                        context,
                                      ).hideCurrentSnackBar();
                                    },
                                  ),
                                ),
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
                                  returnDate:
                                      state.returnDate ?? state.departureDate,
                                  adult: state.travellers['adults']!,
                                  child: state.travellers['children']!,
                                  infant: state.travellers['infants']!,
                                  tripMode: state.oneWay ? 'O' : 'R',
                                  travelType:
                                      state.from!.countryCode ==
                                          state.to!.countryCode
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
                                builder: (context) => FlightSearchPage(),
                              ),
                            );
                          },
                          style: TextButton.styleFrom(
                            backgroundColor: maincolor1!,
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.flight_takeoff_rounded,
                                color: Colors.white,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                'SEARCH FLIGHTS',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: 0.5,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
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
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
            Text(
              description,
              style: const TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ],
        ),
        Row(
          children: [
            IconButton(
              icon: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: const Icon(Icons.remove, size: 18),
              ),
              onPressed: count > min ? () => onChanged(count - 1) : null,
              padding: EdgeInsets.zero,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Text(
                count.toString(),
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            IconButton(
              icon: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: const Icon(Icons.add, size: 18),
              ),
              onPressed: max == null || count < max
                  ? () => onChanged(count + 1)
                  : null,
              padding: EdgeInsets.zero,
            ),
          ],
        ),
      ],
    );
  }
}
