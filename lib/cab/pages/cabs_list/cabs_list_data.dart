import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minna/cab/application/fetch%20cab/fetch_cabs_bloc.dart';
import 'package:minna/cab/application/fetch%20cab/fetch_cabs_state.dart';
import 'package:minna/cab/domain/cab%20list%20model/cab_list_data.dart';
import 'package:minna/cab/function/commission_data.dart';
import 'package:minna/cab/pages/booking_hold/booking_hold_input.dart';

class CabsListPage extends StatefulWidget {
  final Map<String, dynamic> requestData;

  const CabsListPage({super.key, required this.requestData});

  @override
  State<CabsListPage> createState() => _CabsListPageState();
}

class _CabsListPageState extends State<CabsListPage> {
  late CommissionProvider commissionProvider;
  
  final Color _primaryColor = Colors.black;
  final Color _secondaryColor = Color(0xFFD4AF37); // Gold
  final Color _accentColor = Color(0xFFC19B3C); // Darker Gold
  final Color _backgroundColor = Color(0xFFF8F9FA);
  final Color _cardColor = Colors.white;
  final Color _textPrimary = Colors.black;
  final Color _textSecondary = Color(0xFF666666);
  final Color _textLight = Color(0xFF999999);
  final Color _errorColor = Color(0xFFE53935);
  final Color _successColor = Color(0xFF00C853);

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _preCalculateCommissions();
    });
  }

  Future<void> _preCalculateCommissions() async {
    commissionProvider = context.read<CommissionProvider>();
    try {
      await commissionProvider.getCommission();
    } catch (e) {
      log('Commission pre-calculation error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FetchCabsBloc()..add(FetchCabsEvent.fetchCabs(requestData: widget.requestData)),
      child: Scaffold(
        backgroundColor: _backgroundColor,
        body: CustomScrollView(
          slivers: [
            // Sliver App Bar
            SliverAppBar(
              backgroundColor: _primaryColor,
              expandedHeight: 120,
              floating: false,
              pinned: true,
  elevation: 4,leading: IconButton(
              icon: const Icon(Icons.arrow_back_rounded, color: Colors.white),
              onPressed: () => Navigator.pop(context),
            ),              shadowColor: Colors.black.withOpacity(0.3),
              surfaceTintColor: Colors.white,
              flexibleSpace: FlexibleSpaceBar(
                title: Text(
                  'Available Cabs',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                centerTitle: true,
                background: Container(
                  decoration: BoxDecoration(
                    color: _primaryColor,
                  ),
                ),
              ),
            ),

            // Main Content
            BlocBuilder<FetchCabsBloc, FetchCabsState>(
              builder: (context, state) {
                if (state is FetchCabsLoading) {
                  return SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) => _buildShimmerLoading(),
                      childCount: 1,
                    ),
                  );
                } else if (state is FetchCabsError) {
                  return SliverFillRemaining(
                    child: _buildErrorState(state.message),
                  );
                } else if (state is FetchCabsSuccess) {
                  return _buildCabList(state.data, commissionProvider);
                } else {
                  return SliverFillRemaining(
                    child: _buildInitialState(),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInitialState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: _secondaryColor.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.directions_car_rounded,
              size: 64,
              color: _secondaryColor,
            ),
          ),
          SizedBox(height: 20),
          Text(
            "Finding the best cabs for you...",
            style: TextStyle(
              fontSize: 18,
              color: _textPrimary,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 8),
          Text(
            "Please wait while we search available rides",
            style: TextStyle(
              fontSize: 14,
              color: _textLight,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorState(String message) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: _errorColor.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.error_outline_rounded,
                size: 64,
                color: _errorColor,
              ),
            ),
            SizedBox(height: 20),
            Text(
              "Something went wrong",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: _textPrimary,
              ),
            ),
            SizedBox(height: 12),
            Text(
              message,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: _textSecondary,
              ),
            ),
            SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                context.read<FetchCabsBloc>().add(FetchCabsEvent.fetchCabs(requestData: widget.requestData));
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: _secondaryColor,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              ),
              child: Text(
                "Try Again",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCabList(CabResponse cabResponse, CommissionProvider commissionProvider) {
    final cabRateList = cabResponse.data.cabRate;
    
    if (cabRateList.isEmpty) {
      return SliverFillRemaining(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: _textLight.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.search_off_rounded,
                    size: 64,
                    color: _textLight,
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  "No cabs available",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: _textPrimary,
                  ),
                ),
                SizedBox(height: 12),
                Text(
                  "Try changing your search parameters or location",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: _textSecondary,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }
    
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          final cabData = cabRateList[index];
          final cab = cabData.cab;
          final fare = cabData.fare;
          final originalAmount = fare.totalAmount ?? 0;

          return Container(
            margin: const EdgeInsets.fromLTRB(16, 8, 16, 8),
            decoration: BoxDecoration(
              color: _cardColor,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Cab Type + Fare
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Car Image
                      Container(
                        decoration: BoxDecoration(
                          color: _backgroundColor,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.grey.shade200),
                        ),
                        height: 80,
                        width: 90,
                        child: cab.image.isNotEmpty
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: Image.network(
                                  cab.image,
                                  fit: BoxFit.contain,
                                  errorBuilder: (context, error, stackTrace) {
                                    return Icon(
                                      Icons.directions_car_rounded,
                                      size: 40,
                                      color: _secondaryColor,
                                    );
                                  },
                                ),
                              )
                            : Icon(
                                Icons.directions_car_rounded,
                                size: 40,
                                color: _secondaryColor,
                              ),
                      ),
                      const SizedBox(width: 12),

                      // Cab Info
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              cab.category,
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: _textPrimary,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              cab.model,
                              style: TextStyle(
                                fontSize: 12,
                                color: _textSecondary,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                Icon(
                                  Icons.event_seat_rounded,
                                  size: 12,
                                  color: _secondaryColor,
                                ),
                                SizedBox(width: 4),
                                Text(
                                  "${cab.seatingCapacity} seats",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: _textSecondary,
                                  ),
                                ),
                                SizedBox(width: 10),
                                Icon(
                                  Icons.work_rounded,
                                  size: 12,
                                  color: _secondaryColor,
                                ),
                                SizedBox(width: 4),
                                Text(
                                  "${cab.bagCapacity} bags",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: _textSecondary,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),

                      // Fare Section
                      FutureBuilder<double>(
                        future: commissionProvider.calculateAmountWithCommission(originalAmount),
                        builder: (context, snapshot) {
                          if (commissionProvider.isLoading || snapshot.connectionState == ConnectionState.waiting) {
                            return _buildAmountShimmer();
                          }

                          final amountWithCommission = snapshot.data ?? originalAmount;
                          final hasCommission = amountWithCommission > originalAmount;

                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                            
                              Text(
                                "₹${amountWithCommission.toStringAsFixed(0)}",
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: _secondaryColor,
                                ),
                              ),
                              Text(
                                "Total fare",
                                style: TextStyle(
                                  fontSize: 10,
                                  color: _textLight,
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),
                  Divider(height: 1, color: Colors.grey.shade300),
                  const SizedBox(height: 12),

                  // Extra Info Row
                  Row(
                    children: [
                      Icon(
                        Icons.local_gas_station_rounded,
                        size: 16,
                        color: _secondaryColor,
                      ),
                      SizedBox(width: 6),
                      Text(
                        cab.fuelType ?? "Petrol",
                        style: TextStyle(
                          fontSize: 14,
                          color: _textSecondary,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Spacer(),
                      Text(
                        "Policy: ${cabData.cancellationPolicy}",
                        style: TextStyle(
                          color: _successColor,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 12),

                  // Instructions
                  if (cab.instructions.isNotEmpty)
                    Wrap(
                      spacing: 8,
                      runSpacing: 6,
                      children: List.generate(
                        cab.instructions.length,
                        (i) => Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                          decoration: BoxDecoration(
                            color: _secondaryColor.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: _secondaryColor.withOpacity(0.2),
                              width: 1,
                            ),
                          ),
                          child: Text(
                            cab.instructions[i],
                            style: TextStyle(
                              fontSize: 11,
                              color: _secondaryColor,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ),

                  if (cab.instructions.isNotEmpty) const SizedBox(height: 16),

                  // Book Button
                  Align(alignment: AlignmentGeometry.bottomRight,
                    child: SizedBox(
                      // width: 2,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => BookingPage(
                                selectedCab: cabData,
                                requestData: widget.requestData,
                              ),
                            ),
                          );
                          log(cabData.toJson().toString());
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: _primaryColor, // Gold button
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          elevation: 2,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 50),
                          child: Text(
                            "Book Now",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
        childCount: cabRateList.length,
      ),
    );
  }

  // Small shimmer for amount loading
  Widget _buildAmountShimmer() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Container(
          width: 80,
          height: 16,
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        SizedBox(height: 6),
        Container(
          width: 90,
          height: 24,
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadius.circular(6),
          ),
        ),
        SizedBox(height: 4),
        Container(
          width: 60,
          height: 12,
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadius.circular(4),
          ),
        ),
      ],
    );
  }

  Widget _buildShimmerLoading() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: List.generate(4, (index) => _buildShimmerCard()),
      ),
    );
  }

  Widget _buildShimmerCard() {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: _cardColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Cab Type + Fare (Shimmer)
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Car Image Shimmer
                Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  height: 80,
                  width: 90,
                ),
                const SizedBox(width: 12),

                // Cab Info Shimmer
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: double.infinity,
                        height: 20, // Increased size
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(6),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Container(
                        width: 140, // Increased size
                        height: 16, // Increased size
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                      const SizedBox(height: 12),
                      // Row(
                      //   children: [
                      //     Container(
                      //       width: 80, // Increased size
                      //       height: 16, // Increased size
                      //       decoration: BoxDecoration(
                      //         color: Colors.grey[300],
                      //         borderRadius: BorderRadius.circular(4),
                      //       ),
                      //     ),
                      //     SizedBox(width: 20),
                      //     Container(
                      //       width: 80, // Increased size
                      //       height: 16, // Increased size
                      //       decoration: BoxDecoration(
                      //         color: Colors.grey[300],
                      //         borderRadius: BorderRadius.circular(4),
                      //       ),
                      //     ),
                      //   ],
                      // ),
                    ],
                  ),
                ),

                // Fare Shimmer
                _buildAmountShimmer(),
              ],
            ),

            const SizedBox(height: 16),
            Container(
              width: double.infinity,
              height: 1,
              color: Colors.grey[300],
            ),
            const SizedBox(height: 12),

            Row(
              children: [
                Container(
                  width: 100, // Increased size
                  height: 16, // Increased size
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                Spacer(),
                Container(
                  width: 140, // Increased size
                  height: 16, // Increased size
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),

            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: List.generate(
                2,
                (i) => Container(
                  width: 100, // Increased size
                  height: 32, // Increased size
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 16),

            Container(
              width: double.infinity,
              height: 52, // Increased size
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ],
        ),
      ),
    );
  }
}