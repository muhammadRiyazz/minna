import 'package:minna/comman/const/const.dart';
import 'package:minna/flight/application/fare%20request/fare_request_bloc.dart';
import 'package:minna/flight/application/nationality/nationality_bloc.dart';
import 'package:minna/flight/application/search%20data/search_data_bloc.dart';
import 'package:minna/flight/application/trip%20request/trip_request_bloc.dart';
import 'package:minna/flight/domain/trip%20resp/trip_respo.dart';
import 'package:minna/flight/presendation/booking%20page/bookiong_flight.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';
import 'package:dotted_line/dotted_line.dart';

class FlightSearchPage extends StatelessWidget {
  const FlightSearchPage({
    super.key,
    // required this.fromAirportinfo,required this.toAirportinfo
  });

  // final Airport fromAirportinfo;
  // final Airport toAirportinfo;

  @override
  Widget build(BuildContext context) {
    final searchState = context.read<SearchDataBloc>().state;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: maincolor1!,
        elevation: 3,
        toolbarHeight: 72,
        iconTheme: const IconThemeData(color: Colors.white),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${searchState.from?.name ?? 'From'} → ${searchState.to?.name ?? 'To'}',
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              searchState.returnDate != null
                  ? '${DateFormat('MMM dd, yyyy').format(searchState.departureDate)} → ${DateFormat('MMM dd, yyyy').format(searchState.returnDate!)}'
                  : '${DateFormat('MMM dd, yyyy').format(searchState.departureDate)} · One-way',
              style: TextStyle(
                fontSize: 11,
                color: Colors.grey[200],
                fontStyle: FontStyle.italic,
              ),
            ),
          ],
        ),
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
                ? loadingPage()
                : flightOptions.isNotEmpty
                ? ListView.builder(
                    itemCount: flightOptions.length,
                    itemBuilder: (context, index) {
                      final option = flightOptions[index];
                      return FlightCard(
                        flightOption: option,
                        isLoading: state.isflightLoading,
                      );
                    },
                  )
                : Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 15),
                          child: Image.asset(
                            'asset/Nodata.png', // Update with your image path
                            height: 180,
                          ),
                        ),
                        const SizedBox(height: 17),
                        const Text(
                          'No Flights Available',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 5),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 30.0),
                          child: Text(
                            'We couldn’t find any flights for your selected route or date',
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 14, color: Colors.grey),
                          ),
                        ),
                        const SizedBox(height: 40),
                      ],
                    ),
                  );
          },
        ),
      ),
    );
  }
}

class loadingPage extends StatelessWidget {
  const loadingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 6,
      itemBuilder: (context, index) {
        return Container(
          margin: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(8),
          ),
          padding: EdgeInsets.all(12),
          child: Column(
            children: [
              // Airline logo and flight code
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Shimmer.fromColors(
                    baseColor: Colors.grey[300]!,
                    highlightColor: Colors.grey[100]!,
                    child: Container(
                      width: 80,
                      height: 30,
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
                      width: 100,
                      height: 30,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: 16),

              // Flight route and timing
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
                          width: 120,
                          height: 20,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                      ),
                      SizedBox(height: 8),
                      Shimmer.fromColors(
                        baseColor: Colors.grey[300]!,
                        highlightColor: Colors.grey[100]!,
                        child: Container(
                          width: 80,
                          height: 16,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                      ),
                    ],
                  ),

                  // Duration and plane icon
                  Column(
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
                      SizedBox(height: 8),
                      Shimmer.fromColors(
                        baseColor: Colors.grey[300]!,
                        highlightColor: Colors.grey[100]!,
                        child: Icon(Icons.airplanemode_active, size: 24),
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
                          width: 120,
                          height: 20,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                      ),
                      SizedBox(height: 8),
                      Shimmer.fromColors(
                        baseColor: Colors.grey[300]!,
                        highlightColor: Colors.grey[100]!,
                        child: Container(
                          width: 80,
                          height: 16,
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

              SizedBox(height: 16),

              // Price and buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Shimmer.fromColors(
                    baseColor: Colors.grey[300]!,
                    highlightColor: Colors.grey[100]!,
                    child: Container(
                      width: 80,
                      height: 24,
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
                      width: 100,
                      height: 36,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

class FlightCard extends StatelessWidget {
  final FlightOptionElement flightOption;
  final bool isLoading;

  const FlightCard({
    super.key,
    required this.flightOption,
    required this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    // Onward journey (type '0')
    final onwardLegs = flightOption.onwardLegs ?? [];
    final firstOnwardLeg = onwardLegs.firstOrNull;
    final lastOnwardLeg = onwardLegs.lastOrNull;

    // Return journey (type '1')
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
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(.1),
            spreadRadius: 1,
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        child: Column(
          children: [
            // Airline header with price
            Row(
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
                            width: 45,
                            height: 30,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                        )
                      else
                        Container(
                          width: 45,
                          height: 40,
                          decoration: BoxDecoration(
                            // color: const Color.fromARGB(255, 219, 245, 255),
                            // borderRadius: BorderRadius.circular(5),
                          ),
                          child: Center(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(5),
                              child: Image.network(
                                fit: BoxFit.fill,
                                flightOption.flightimg ?? "",
                                errorBuilder: (context, error, stackTrace) =>
                                    Container(color: Colors.grey[200]),
                              ),
                            ),
                          ),
                        ),

                      const SizedBox(width: 12),

                      // Airline Name
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (isLoading)
                              Shimmer.fromColors(
                                baseColor: Colors.grey[300]!,
                                highlightColor: Colors.grey[100]!,
                                child: Container(
                                  height: 12,
                                  width: 100,
                                  color: Colors.white,
                                ),
                              )
                            else
                              Text(
                                flightOption.flightName ?? '---',
                                style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
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
                                  height: 10,
                                  width: 80,
                                  color: Colors.white,
                                ),
                              )
                            else
                              Text(
                                flightOption.ticketingCarrier ?? '---',
                                style: const TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.black54,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                // Price and More Fare button
                if (isLoading)
                  Shimmer.fromColors(
                    baseColor: Colors.grey[300]!,
                    highlightColor: Colors.grey[100]!,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Container(height: 14, width: 60, color: Colors.white),
                        const SizedBox(height: 6),
                        Container(height: 20, width: 70, color: Colors.white),
                      ],
                    ),
                  )
                else
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '₹${price.toStringAsFixed(0)}',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: maincolor1!,
                        ),
                      ),
                      const SizedBox(height: 2),

                      flightOption.flightFares == null ||
                              flightOption.flightFares!.isEmpty
                          ? SizedBox()
                          : InkWell(
                              onTap: () {
                                _showFareOptionsBottomSheet(
                                  context,
                                  flightOption,
                                );
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border.all(color: maincolor1!),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 8,
                                    vertical: 3,
                                  ),
                                  child: Text(
                                    'More Fare',
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: maincolor1!,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                    ],
                  ),
              ],
            ),
            SizedBox(height: 14),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: DottedLine(dashColor: Colors.grey.shade400),
            ),
            // Onward Journey Section
            _buildFlightLegSection(
              firstLeg: firstOnwardLeg,
              lastLeg: lastOnwardLeg,
              departureTime: onwardDepartureTime,
              arrivalTime: onwardArrivalTime,
              duration: onwardDuration,
              stops: onwardStops,
            ),

            // Return Journey Section (if exists)
            if (returnLegs.isNotEmpty) ...[
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 15),
                child: DottedLine(
                  direction: Axis.horizontal,
                  lineLength: double.infinity,
                  lineThickness: 1.0,
                  dashLength: 4.0,
                  dashColor: Colors.grey,
                  dashGapLength: 4.0,
                ),
              ),

              _buildFlightLegSection(
                firstLeg: firstReturnLeg,
                lastLeg: lastReturnLeg,
                departureTime: returnDepartureTime!,
                arrivalTime: returnArrivalTime!,
                duration: returnDuration!,
                stops: returnStops!,
              ),
            ],
            SizedBox(height: 10),

            // More details and book button
            // Text((flightOption.availableSeat.toString())),
            Row(
              children: [
                if (isLoading)
                  Shimmer.fromColors(
                    baseColor: Colors.grey[300]!,
                    highlightColor: Colors.grey[100]!,
                    child: Container(
                      width: 80, // Adjust width as needed
                      height: 20, // Adjust height as needed
                      color: Colors.white,
                    ),
                  )
                else
                  TextButton(
                    style: ButtonStyle(
                      padding: WidgetStateProperty.all(EdgeInsets.zero),
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    onPressed: () {
                      _showFlightDetails(context, flightOption);
                    },
                    child: const Text(
                      ' Flight Details',
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                const Spacer(),

                if (isLoading)
                  Shimmer.fromColors(
                    baseColor: Colors.grey[300]!,
                    highlightColor: Colors.grey[100]!,
                    child: Container(
                      width: 70, // Adjust width as needed
                      height: 22, // Adjust height as needed
                      decoration: BoxDecoration(color: Colors.white),
                    ),
                  )
                else
                  SizedBox(
                    child: ElevatedButton(
                      onPressed: () {
                        context.read<NationalityBloc>().add(
                          NationalityEvent.getList(),
                        );

                        final tripState = context.read<TripRequestBloc>().state;
                        final saerchData = context.read<SearchDataBloc>().state;

                        context.read<FareRequestBloc>().add(
                          FareRequestEvent.getFareRequestApi(
                            token: tripState.token ?? '',
                            flightTrip: flightOption,
                            tripMode: saerchData.oneWay ? 'O' : 'S',
                          ),
                        );
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return FlightBookingPage();
                            },
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: maincolor1!,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Text(
                        'Book Now',
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showFareOptionsBottomSheet(
    BuildContext context,
    FlightOptionElement flight,
  ) {
    final List<FreeBaggage> baggageList =
        flight.flightLegs?.firstOrNull?.freeBaggages ?? [];

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.90,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Column(
            children: [
              // Draggable handle with better visibility
              Center(
                child: Container(
                  width: 60,
                  height: 5,
                  decoration: BoxDecoration(
                    color: Colors.grey[400],
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Improved header with icon
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.airplane_ticket, size: 18, color: maincolor1!),
                  const SizedBox(width: 8),
                  Text(
                    "Select Your Fare",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: Colors.grey[800],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Text(
                "Choose the fare that suits your travel needs",
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey[600],
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 20),

              // Fare options list
              Expanded(
                child: ListView.separated(
                  itemCount: flight.flightFares?.length ?? 0,
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 16),
                  itemBuilder: (context, index) {
                    final fare = flight.flightFares?[index];
                    final baggageInfo = baggageList.firstWhere(
                      (baggage) => baggage.fid == fare?.fid,
                      orElse: () => FreeBaggage(),
                    );

                    // Convert "Kilograms" to "kg" and check if baggage exists
                    final adultBaggage = _formatBaggage(baggageInfo.adtBaggage);
                    final childBaggage = _formatBaggage(baggageInfo.chdBaggage);
                    final infantBaggage = _formatBaggage(
                      baggageInfo.infBaggage,
                    );

                    return GestureDetector(
                      onTap: () {
                        context.read<TripRequestBloc>().add(
                          TripRequestEvent.changeFare(
                            selectedFare: fare!,
                            selectedTrip: flight,
                          ),
                        );
                        Navigator.pop(context);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: flight.selectedFare == fare
                              ? maincolor1!.withOpacity(0.05)
                              : Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: flight.selectedFare == fare
                                ? maincolor1!
                                : Colors.grey.shade200,
                            width: 1.5,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.1),
                              spreadRadius: 1,
                              blurRadius: 8,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Fare header with improved styling
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    fare?.fareName ?? '--',
                                    style: TextStyle(
                                      overflow: TextOverflow.ellipsis,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.grey[800],
                                    ),
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 10,
                                    vertical: 4,
                                  ),
                                  decoration: BoxDecoration(
                                    // ignore: deprecated_member_use
                                    color: maincolor1!.withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Text(
                                    '₹${fare?.totalAmount ?? '--'}',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: maincolor1!,
                                    ),
                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(height: 16),
                            Divider(height: 1, color: Colors.grey[300]),
                            const SizedBox(height: 16),

                            // Fare breakdown with improved spacing
                            _buildFareDetailRow(
                              "Base Fare",
                              "₹${fare?.aprxTotalBaseFare ?? '--'}",
                            ),
                            const SizedBox(height: 10),
                            _buildFareDetailRow(
                              "Taxes & Fees",
                              "₹${fare?.aprxTotalTax ?? '--'}",
                            ),

                            const SizedBox(height: 16),
                            Divider(height: 1, color: Colors.grey[300]),
                            const SizedBox(height: 16),

                            // Baggage information - only show if available
                            if (adultBaggage.isNotEmpty)
                              _buildBaggageInfoRow(
                                icon: Icons.person,
                                label: "Adult",
                                value: adultBaggage,
                              ),
                            if (childBaggage.isNotEmpty) ...[
                              const SizedBox(height: 10),
                              _buildBaggageInfoRow(
                                icon: Icons.child_care,
                                label: "Child",
                                value: childBaggage,
                              ),
                            ],
                            if (infantBaggage.isNotEmpty) ...[
                              const SizedBox(height: 10),
                              _buildBaggageInfoRow(
                                icon: Icons.child_friendly,
                                label: "Infant",
                                value: infantBaggage,
                              ),
                            ],
                          ],
                        ),
                      ),
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

  // Helper function to format baggage string
  String _formatBaggage(String? baggage) {
    if (baggage == null || baggage.isEmpty) return '';
    return baggage.replaceAll('Kilograms', 'kg').replaceAll('Kilogram', 'kg');
  }

  // Improved baggage info row with icons
  Widget _buildBaggageInfoRow({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Row(
      children: [
        Icon(icon, size: 16, color: Colors.grey[600]),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey[600],
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            value,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: Colors.grey[800],
            ),
          ),
        ),
      ],
    );
  }

  // Improved fare detail row
  Widget _buildFareDetailRow(String label, String value) {
    return Row(
      children: [
        Expanded(
          child: Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey[600],
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: Colors.grey[800],
          ),
        ),
      ],
    );
  }

  Widget _buildTaxDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(fontSize: 12, color: Colors.grey[600])),
          Text(value, style: TextStyle(fontSize: 12, color: Colors.grey[800])),
        ],
      ),
    );
  }

  Widget _buildFlightLegSection({
    required FlightLeg? firstLeg,
    required FlightLeg? lastLeg,
    required DateTime departureTime,
    required DateTime arrivalTime,
    required Duration duration,
    required int stops,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: const Color.fromARGB(176, 227, 242, 253),

        // borderRadius: BorderRadius.circular(5),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Departure Info
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        DateFormat('HH:mm').format(departureTime),
                        style: const TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        firstLeg?.origin ?? '--',
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),

                // Flight Duration and Icon
                Expanded(
                  child: Column(
                    children: [
                      Text(
                        '${duration.inHours}h ${duration.inMinutes.remainder(60)}m',
                        style: TextStyle(
                          fontSize: 10,
                          color: Colors.grey.shade600,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 5),
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 30),
                            child: Container(
                              height: 1,
                              width: double.infinity,
                              color: Colors.grey.shade300,
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: maincolor1!,
                            ),
                            padding: const EdgeInsets.all(6),
                            child: Icon(
                              Icons.flight,
                              size: 13,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                // Arrival Info
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        DateFormat('HH:mm').format(arrivalTime),
                        style: const TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        lastLeg?.destination ?? '--',
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 5),
            Text(
              '${stops.toString()} ${stops == 1 ? 'STOP' : 'STOPS'}',
              style: TextStyle(fontSize: 8, color: maincolor1!),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: DottedLine(dashColor: Colors.grey.shade400),
            ),
            // Terminal and Date Info
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        firstLeg?.originName ?? '--',
                        style: TextStyle(
                          fontSize: 10,
                          color: Colors.grey.shade600,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        DateFormat('MMM dd, yyyy').format(departureTime),
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey.shade600,
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
                        lastLeg?.destinationName ?? '--',
                        style: TextStyle(
                          fontSize: 10,
                          color: Colors.grey.shade600,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        DateFormat('MMM dd, yyyy').format(arrivalTime),
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey.shade600,
                        ),
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

  void _showFlightDetails(BuildContext context, FlightOptionElement option) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return FlightDetailsBottomSheet(flightOption: option);
      },
    );
  }
}

class FlightDetailsBottomSheet extends StatelessWidget {
  final FlightOptionElement flightOption;

  const FlightDetailsBottomSheet({super.key, required this.flightOption});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      padding: const EdgeInsets.all(16),
      height: MediaQuery.of(context).size.height * 0.94,
      child: DefaultTabController(
        length: 3,
        child: Column(
          children: [
            // Header with close button
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Flight Details',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),

            // Tab bar
            Container(
              margin: const EdgeInsets.only(bottom: 5),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(8),
                  topLeft: Radius.circular(8),
                ),
              ),
              child: TabBar(
                isScrollable: false,
                indicatorPadding: EdgeInsets.zero,
                labelPadding: EdgeInsets.zero,
                indicatorSize: TabBarIndicatorSize.tab,
                labelStyle: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                ),
                unselectedLabelStyle: TextStyle(
                  fontSize: 9,
                  fontWeight: FontWeight.w500,
                ),
                indicator: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(8),
                    topLeft: Radius.circular(8),
                  ),
                  color: maincolor1!,
                ),
                labelColor: Colors.white,
                unselectedLabelColor: Colors.grey.shade700,
                tabs: [
                  Container(
                    width: double.infinity,
                    alignment: Alignment.center,
                    child: const Tab(text: 'Flight Info'),
                  ),
                  Container(
                    width: double.infinity,
                    alignment: Alignment.center,
                    child: const Tab(text: 'Fare Summary'),
                  ),
                  Container(
                    width: double.infinity,
                    alignment: Alignment.center,
                    child: const Tab(text: 'Baggage'),
                  ),
                ],
              ),
            ),

            // Tab content
            Expanded(
              child: TabBarView(
                children: [
                  // Flight Info Tab
                  _buildFlightInfoTab(context),

                  // Fare Summary Tab
                  _buildFareSummaryTab(),

                  // Baggage Tab
                  _buildBaggageTab(flightOption),
                ],
              ),
            ),

            // Book Now Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  // Add booking logic here
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: maincolor1!,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text(
                  'Book Now',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFlightInfoTab(BuildContext context) {
    final onwardLegs = flightOption.onwardLegs ?? [];
    final returnLegs = flightOption.returnLegs ?? [];

    return SingleChildScrollView(
      child: Column(
        children: [
          // Onward Flight Section
          if (onwardLegs.isNotEmpty) ...[
            Padding(
              padding: const EdgeInsets.only(top: 15, bottom: 15),
              child: Container(
                decoration: BoxDecoration(color: maincolor1!),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 8,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Onward Flight',
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        '${onwardLegs.first.origin} - ${onwardLegs.last.destination}',
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            _buildLegsList(context, onwardLegs),
          ],

          // Return Flight Section (only if there are return legs)
          if (returnLegs.isNotEmpty) ...[
            Padding(
              padding: const EdgeInsets.only(top: 15, bottom: 15),
              child: Container(
                decoration: BoxDecoration(color: maincolor1!),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 8,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Return Flight',
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        '${returnLegs.first.origin} - ${returnLegs.last.destination}',
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            _buildLegsList(context, returnLegs),
          ],
        ],
      ),
    );
  }

  Widget _buildLegsList(BuildContext context, List<FlightLeg> legs) {
    return ListView.separated(
      separatorBuilder: (context, index) {
        if (index < legs.length - 1) {
          final currentArrival = DateTime.parse(legs[index].arrivalTime!);
          final nextDeparture = DateTime.parse(legs[index + 1].departureTime!);
          final layoverDuration = nextDeparture.difference(currentArrival);
          final hours = layoverDuration.inHours;
          final minutes = layoverDuration.inMinutes.remainder(60);

          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: Container(
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 238, 248, 255),
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: Column(
                    children: [
                      Text(
                        'Layover of ${hours}h ${minutes}m',
                        style: TextStyle(color: maincolor1!, fontSize: 10),
                      ),
                      Text(
                        'At ${legs[index].destinationName}',
                        style: TextStyle(color: maincolor1!, fontSize: 8),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        }
        return const SizedBox.shrink();
      },
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: legs.length,
      itemBuilder: (context, index) {
        final leg = legs[index];
        final departureTime = leg.departureTime != null
            ? DateTime.parse(leg.departureTime!)
            : DateTime.now();
        final arrivalTime = leg.arrivalTime != null
            ? DateTime.parse(leg.arrivalTime!)
            : DateTime.now();
        final duration = arrivalTime.difference(departureTime);

        return Container(
          padding: const EdgeInsets.all(12),
          // margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(.1),
                spreadRadius: 1,
                blurRadius: 6,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            children: [
              // Airline info
              Row(
                children: [
                  Container(
                    width: 45,
                    height: 30,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 219, 245, 255),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Center(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(5),
                        child: Image.network(flightOption.flightimg ?? ""),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        leg.flightName ?? '--',
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '${leg.airlineCode} ${leg.flightNo}',
                        style: TextStyle(
                          fontSize: 9,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ),
                ],
              ),

              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Departure
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        DateFormat('HH:mm').format(departureTime),
                        style: const TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        leg.origin ?? '',
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  // Flight duration and path
                  Expanded(
                    child: Column(
                      children: [
                        Text(
                          '${duration.inHours}h ${duration.inMinutes.remainder(60)}m',
                          style: TextStyle(
                            fontSize: 10,
                            color: Colors.grey.shade600,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 30,
                              ),
                              child: Container(
                                height: 1,
                                width: double.infinity,
                                color: Colors.grey.shade300,
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: maincolor1!,
                              ),
                              padding: const EdgeInsets.all(6),
                              child: Icon(
                                Icons.flight,
                                size: 13,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  // Arrival
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        DateFormat('HH:mm').format(arrivalTime),
                        style: const TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        leg.destination ?? '',
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              // Terminal and date info
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Terminal ${leg.departureTerminal ?? '-'}',
                        style: TextStyle(
                          fontSize: 9,
                          color: Colors.grey.shade600,
                        ),
                      ),
                      Text(
                        leg.originName ?? '--',
                        style: TextStyle(
                          fontSize: 10,
                          color: Colors.grey.shade700,
                        ),
                      ),
                      Text(
                        DateFormat('MMM dd, yyyy').format(departureTime),
                        style: TextStyle(
                          fontSize: 11,
                          color: Colors.grey.shade900,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        'Terminal ${leg.arrivalTerminal ?? '-'}',
                        style: TextStyle(
                          fontSize: 9,
                          color: Colors.grey.shade600,
                        ),
                      ),
                      Text(
                        leg.destinationName ?? '--',
                        style: TextStyle(
                          fontSize: 10,
                          color: Colors.grey.shade700,
                        ),
                      ),
                      Text(
                        DateFormat('MMM dd, yyyy').format(arrivalTime),
                        style: TextStyle(
                          fontSize: 11,
                          color: Colors.grey.shade900,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildFareSummaryTab() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.black38),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                spreadRadius: 1,
                blurRadius: 6,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Price Breakdown',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Divider(),
              SizedBox(height: 10),
              ...?flightOption.selectedFare?.fares?.map((fare) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '${fare.ptc} Passenger',
                          style: const TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 13,
                          ),
                        ),
                        Text(
                          '₹ ${fare.baseFare?.toStringAsFixed(0)}',
                          style: const TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Base Fare',
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 10,
                              ),
                            ),
                            Text(
                              '₹ ${fare.baseFare?.toStringAsFixed(0)}',
                              style: TextStyle(fontSize: 10),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Taxes & Fees',
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 10,
                              ),
                            ),
                            Text(
                              '₹ ${fare.tax?.toStringAsFixed(0)}',
                              style: TextStyle(fontSize: 10),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                  ],
                );
              }),

              const Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Total Base Fare',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    '₹${flightOption.selectedFare?.aprxTotalBaseFare?.toStringAsFixed(0)}',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: maincolor1!,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Total Tax',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w400,
                      color: Colors.grey,
                    ),
                  ),
                  Text(
                    '₹${flightOption.selectedFare?.aprxTotalTax?.toStringAsFixed(0)}',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w400,
                      color: maincolor1!,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Total Discount',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w400,
                      color: Colors.grey,
                    ),
                  ),
                  Text(
                    '₹${flightOption.selectedFare?.totalDiscount?.toStringAsFixed(0)}',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w400,
                      color: maincolor1!,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 5),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Total Price',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '₹${flightOption.selectedFare?.aprxTotalAmount?.toStringAsFixed(0)}',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: maincolor1!,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBaggageTab(FlightOptionElement flight) {
    // Get the selected fare's FID
    final selectedFareFid = flight.selectedFare?.fid;

    // Find matching baggage info for the selected fare
    FreeBaggage? selectedBaggage;
    if (selectedFareFid != null) {
      selectedBaggage = flight.flightLegs?.firstOrNull?.freeBaggages
          ?.firstWhere(
            (baggage) => baggage.fid == selectedFareFid,
            orElse: () => FreeBaggage(),
          );
    }

    final hasBaggageInfo =
        selectedBaggage != null &&
        (selectedBaggage.adtBaggage != null ||
            selectedBaggage.chdBaggage != null ||
            selectedBaggage.infBaggage != null);

    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: 10),
          // Baggage Allowance Card
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade200),
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  spreadRadius: 1,
                  blurRadius: 6,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Baggage Allowance',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: Divider(),
                ),
                // Checked Baggage - Only for selected fare
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.work_outline, size: 17, color: maincolor1!),
                        const SizedBox(width: 12),
                        Text(
                          'Cabin Baggage',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: hasBaggageInfo
                                ? Colors.black87
                                : Colors.grey,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    hasBaggageInfo
                        ? SizedBox()
                        : Padding(
                            padding: const EdgeInsets.only(left: 36),
                            child: Text(
                              'No baggage included',
                              style: TextStyle(
                                color: hasBaggageInfo
                                    ? Colors.grey
                                    : Colors.grey[400],
                              ),
                            ),
                          ),
                  ],
                ),

                if (hasBaggageInfo) ...[
                  const SizedBox(height: 8),
                  if (selectedBaggage.adtBaggage?.isNotEmpty ?? false)
                    buildBaggageDetailRow('Adult', selectedBaggage.adtBaggage!),
                  if (selectedBaggage.chdBaggage?.isNotEmpty ?? false)
                    buildBaggageDetailRow('Child', selectedBaggage.chdBaggage!),
                  if (selectedBaggage.infBaggage?.isNotEmpty ?? false)
                    buildBaggageDetailRow(
                      'Infant',
                      selectedBaggage.infBaggage!,
                    ),
                ],
              ],
            ),
          ),

          const SizedBox(height: 10),

          // Additional Baggage Purchase
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade200),
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  spreadRadius: 1,
                  blurRadius: 6,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'Need More Baggage or Meals?',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Additional baggage and meals can be purchased during booking.',
                  style: TextStyle(color: Colors.grey, fontSize: 11),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Helper widget for baggage detail rows
  Widget buildBaggageDetailRow(String type, String baggage) {
    final formattedBaggage = baggage
        .replaceAll('Kilograms', 'kg')
        .replaceAll('Kilogram', 'kg');

    return Padding(
      padding: const EdgeInsets.only(left: 0, bottom: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            type,
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 12,
              fontWeight: FontWeight.w400,
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
            decoration: BoxDecoration(
              color: maincolor1!.withOpacity(0.1),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              formattedBaggage,
              style: TextStyle(
                color: maincolor1!,
                fontSize: 11,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Helper widget for baggage items
Widget _buildBaggageItem({
  required IconData icon,
  required String label,
  required String value,
  required bool isIncluded,
}) {
  return Expanded(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              icon,
              size: 13,
              color: isIncluded ? Colors.green : Colors.grey,
            ),
            const SizedBox(width: 4),
            Text(
              label,
              style: TextStyle(fontSize: 10, color: Colors.grey[600]),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Text(
          isIncluded ? value : 'Not included',
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: isIncluded ? Colors.black : Colors.grey,
          ),
        ),
      ],
    ),
  );
}

// First, create a model for your fare options
class FareOption {
  final String type;
  final double price;
  final String handBaggage;
  final String checkInBaggage;
  final List<String> features;

  FareOption({
    required this.type,
    required this.price,
    required this.handBaggage,
    required this.checkInBaggage,
    required this.features,
  });
}
