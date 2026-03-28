import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minna/cab/application/fetch%20cab/fetch_cabs_bloc.dart';
import 'package:minna/cab/application/fetch%20cab/fetch_cabs_state.dart';
import 'package:minna/cab/domain/cab%20list%20model/cab_list_data.dart';
import 'package:minna/cab/function/commission_data.dart';
import 'package:minna/cab/pages/booking_hold/booking_hold_input.dart';
import 'package:minna/comman/const/const.dart';

class CabsListPage extends StatefulWidget {
  final Map<String, dynamic> requestData;

  const CabsListPage({super.key, required this.requestData});

  @override
  State<CabsListPage> createState() => _CabsListPageState();
}

class _CabsListPageState extends State<CabsListPage> {
  late CommissionProvider commissionProvider;
  
  final Color _primaryColor = maincolor1;
  final Color _secondaryColor = secondaryColor; 
  final Color _accentColor = accentColor;
  final Color _backgroundColor = backgroundColor;
  final Color _cardColor = cardColor;
  final Color _textPrimary = textPrimary;
  final Color _textSecondary = textSecondary;
  final Color _textLight = textLight;
  final Color _errorColor = errorColor;
  final Color _successColor = const Color(0xFF0D9488);

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
          physics: const BouncingScrollPhysics(),
          slivers: [
            // Premium Sliver App Bar
            SliverAppBar(
              expandedHeight: 140.0,
              floating: false,
              pinned: true,
              backgroundColor: _primaryColor,
              elevation: 4,
              shadowColor: Colors.black.withOpacity(0.2),
              leading: IconButton(
                icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white, size: 20),
                onPressed: () => Navigator.pop(context),
              ),
              flexibleSpace: FlexibleSpaceBar(
                centerTitle: true,
                title: const Text(
                  'Available Cabs',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 0.5,
                  ),
                ),
                background: Stack(
                  fit: StackFit.expand,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [_primaryColor, _primaryColor.withOpacity(0.8)],
                        ),
                      ),
                    ),
                    Positioned(
                      top: -40,
                      right: -40,
                      child: Container(
                        width: 150,
                        height: 150,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: _secondaryColor.withOpacity(0.08),
                        ),
                      ),
                    ),
                  ],
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
            padding: const EdgeInsets.all(24),
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
          const SizedBox(height: 24),
          Text(
            "Finding the best rides...",
            style: TextStyle(
              fontSize: 20,
              color: _textPrimary,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            "Searching available cabs for your route",
            style: TextStyle(
              fontSize: 14,
              color: _textSecondary,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorState(String message) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(24),
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
            const SizedBox(height: 24),
            Text(
              "Something went wrong",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w800,
                color: _textPrimary,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              message,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 15,
                color: _textSecondary,
                height: 1.5,
              ),
            ),
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              height: 54,
              child: ElevatedButton(
                onPressed: () {
                  context.read<FetchCabsBloc>().add(FetchCabsEvent.fetchCabs(requestData: widget.requestData));
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: _primaryColor,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  elevation: 0,
                ),
                child: const Text(
                  "Try Again",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
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
            padding: const EdgeInsets.all(32.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: _textLight.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.search_off_rounded,
                    size: 64,
                    color: _textLight.withOpacity(0.5),
                  ),
                ),
                const SizedBox(height: 24),
                Text(
                  "No cabs found",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                    color: _textPrimary,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  "No vehicles match your search or area. Try another route.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 15,
                    color: _textSecondary,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }
    
    return SliverPadding(
      padding: const EdgeInsets.only(top: 16, bottom: 32),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            final cabData = cabRateList[index];
            final cab = cabData.cab;
            final fare = cabData.fare;
            final originalAmount = fare.totalAmount ?? 0;

            return Container(
              margin: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              decoration: BoxDecoration(
                color: _cardColor,
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.04),
                    blurRadius: 20,
                    offset: const Offset(0, 4),
                  ),
                ],
                border: Border.all(color: Colors.grey.shade100),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Car Image
                        Container(
                          decoration: BoxDecoration(
                            color: _backgroundColor,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          height: 85,
                          width: 100,
                          child: cab.image.isNotEmpty
                              ? ClipRRect(
                                  borderRadius: BorderRadius.circular(16),
                                  child: Image.network(
                                    cab.image,
                                    fit: BoxFit.contain,
                                    errorBuilder: (context, error, stackTrace) => 
                                        Icon(Icons.directions_car_rounded, size: 40, color: _secondaryColor),
                                  ),
                                )
                              : Icon(Icons.directions_car_rounded, size: 40, color: _secondaryColor),
                        ),
                        const SizedBox(width: 16),

                        // Cab Info
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                cab.category.toUpperCase(),
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w800,
                                  color: _secondaryColor,
                                  letterSpacing: 1,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                cab.model,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w800,
                                  color: _textPrimary,
                                ),
                              ),
                              const SizedBox(height: 12),
                              Row(
                                children: [
                                  _buildAmenityTag(Icons.person_outline_rounded, "${cab.seatingCapacity} Seats"),
                                  const SizedBox(width: 8),
                                  _buildAmenityTag(Icons.work_outline_rounded, "${cab.bagCapacity} Bags"),
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

                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  "₹${amountWithCommission.toStringAsFixed(0)}",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w900,
                                    color: _textPrimary,
                                  ),
                                ),
                                Text(
                                  "inc. GST",
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: _textLight,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      ],
                    ),

                    const SizedBox(height: 20),
                    
                    // Policy & Fuel
                    Row(
                      children: [
                        Row(
                          children: [
                            Icon(Icons.local_gas_station_rounded, size: 14, color: _textLight),
                            const SizedBox(width: 6),
                            Text(
                              cab.fuelType ?? "Petrol",
                              style: TextStyle(
                                fontSize: 12, 
                                color: _textSecondary, 
                                fontWeight: FontWeight.w600
                              ),
                            ),
                          ],
                        ),
                        const Spacer(),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: _successColor.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            cabData.cancellationPolicy,
                            style: TextStyle(
                              color: _successColor, 
                              fontSize: 11, 
                              fontWeight: FontWeight.w800
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 20),

                    // Book Button
                    SizedBox(
                      width: double.infinity,
                      height: 52,
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
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: _primaryColor,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                          elevation: 0,
                        ),
                        child: const Text(
                          "SELECT CAR",
                          style: TextStyle(
                            fontSize: 14, 
                            fontWeight: FontWeight.w800, 
                            letterSpacing: 1.5
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
      ),
    );
  }

  Widget _buildAmountShimmer() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Container(
          width: 70,
          height: 22,
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(6),
          ),
        ),
        const SizedBox(height: 6),
        Container(
          width: 40,
          height: 12,
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(4),
          ),
        ),
      ],
    );
  }

  Widget _buildShimmerLoading() {
    return ListView.builder(
      itemCount: 4,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.all(16),
      itemBuilder: (context, index) => _buildShimmerCard(),
    );
  }

  Widget _buildShimmerCard() {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: _cardColor,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.grey.shade100),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 100,
                height: 85,
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(width: 60, height: 12, color: Colors.grey[100]),
                    const SizedBox(height: 8),
                    Container(width: 120, height: 16, color: Colors.grey[100]),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Container(width: 50, height: 20, color: Colors.grey[100]),
                        const SizedBox(width: 8),
                        Container(width: 50, height: 20, color: Colors.grey[100]),
                      ],
                    ),
                  ],
                ),
              ),
              Container(width: 60, height: 24, color: Colors.grey[100]),
            ],
          ),
          const SizedBox(height: 20),
          Container(width: double.infinity, height: 52, decoration: BoxDecoration(
            color: Colors.grey[50], 
            borderRadius: BorderRadius.circular(16)
          )),
        ],
      ),
    );
  }

  Widget _buildAmenityTag(IconData icon, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: _backgroundColor,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade100),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: _textSecondary),
          const SizedBox(width: 6),
          Text(
            label,
            style: TextStyle(
              fontSize: 11,
              color: _textSecondary,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}