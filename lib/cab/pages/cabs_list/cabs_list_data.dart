import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minna/cab/application/fetch%20cab/fetch_cabs_bloc.dart';
import 'package:minna/cab/application/fetch%20cab/fetch_cabs_state.dart';
import 'package:minna/cab/domain/cab%20list%20model/cab_list_data.dart';
import 'package:minna/cab/function/commission_data.dart';
import 'package:minna/cab/pages/booking_hold/booking_hold_input.dart';
import 'package:minna/comman/const/const.dart';
import 'package:iconsax/iconsax.dart';

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
  final Color _backgroundColor = backgroundColor;
  final Color _cardColor = cardColor;
  final Color _textPrimary = textPrimary;
  final Color _textSecondary = textSecondary;
  final Color _textLight = textLight;
  final Color _errorColor = errorColor;
  final Color _successColor = successColor;

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
      if (mounted) {
        await commissionProvider.getCommission();
      }
    } catch (e) {
      log('Commission pre-calculation error: $e');
    }
  }

  String? _getRouteSummary() {
    final source = widget.requestData['source']?['address'];
    final destination = widget.requestData['destination']?['address'];

    if (source == null || destination == null) return null;

    final sourceShort = source.toString().split(',').first.trim();
    final destinationShort = destination.toString().split(',').first.trim();

    if (sourceShort.isEmpty || destinationShort.isEmpty) return null;
    if (sourceShort == 'Unknown Source' ||
        destinationShort == 'Unknown Destination')
      return null;

    return '$sourceShort → $destinationShort';
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          FetchCabsBloc()
            ..add(FetchCabsEvent.fetchCabs(requestData: widget.requestData)),
      child: Scaffold(
        backgroundColor: _backgroundColor,
        body: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            SliverAppBar(
              expandedHeight: 120.0,
              floating: false,
              pinned: true,
              backgroundColor: _primaryColor,
              elevation: 0,
              leading: IconButton(
                icon: const Icon(
                  Iconsax.arrow_left_2,
                  color: Colors.white,
                  size: 22,
                ),
                onPressed: () => Navigator.pop(context),
              ),
              flexibleSpace: FlexibleSpaceBar(
                centerTitle: true,
                title: LayoutBuilder(
                  builder: (context, constraints) {
                    final isCollapsed =
                        constraints.maxHeight <= kToolbarHeight + 40;
                    final summary = _getRouteSummary();
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Available Cabs',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: isCollapsed ? 14 : 16,
                            fontWeight: FontWeight.w900,
                            letterSpacing: 0.5,
                          ),
                        ),
                        if (!isCollapsed)
                          Padding(
                            padding: const EdgeInsets.only(top: 2),
                            child: Text(
                              'Premium vehicles for your journey',
                              style: TextStyle(
                                color: Colors.white.withOpacity(0.7),
                                fontSize: 9,
                                fontWeight: FontWeight.w500,
                                letterSpacing: 0.2,
                              ),
                            ),
                          ),
                        if (!isCollapsed && summary != null)
                          Padding(
                            padding: const EdgeInsets.only(
                              top: 6,
                              left: 30,
                              right: 30,
                            ),
                            child: Text(
                              summary,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: _secondaryColor.withOpacity(0.95),
                                fontSize: 10,
                                fontWeight: FontWeight.w900,
                                letterSpacing: 0.8,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                      ],
                    );
                  },
                ),
                background: Stack(
                  fit: StackFit.expand,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            _primaryColor,
                            _primaryColor.withOpacity(0.9),
                            _primaryColor.withOpacity(0.85),
                          ],
                          stops: const [0.0, 0.6, 1.0],
                        ),
                      ),
                    ),
                    Positioned(
                      top: -40,
                      right: -40,
                      child: Container(
                        width: 160,
                        height: 160,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white.withOpacity(0.04),
                          border: Border.all(
                            color: Colors.white.withOpacity(0.02),
                            width: 2,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 40,
                      left: -50,
                      child: Container(
                        width: 180,
                        height: 180,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: _secondaryColor.withOpacity(0.03),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            BlocBuilder<FetchCabsBloc, FetchCabsState>(
              builder: (context, state) {
                if (state is FetchCabsLoading) {
                  return SliverToBoxAdapter(child: _buildShimmerLoading());
                } else if (state is FetchCabsError) {
                  return SliverFillRemaining(
                    child: _buildErrorState(state.message),
                  );
                } else if (state is FetchCabsSuccess) {
                  return _buildCabList(state.data, commissionProvider);
                } else {
                  return SliverFillRemaining(child: _buildInitialState());
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
            padding: const EdgeInsets.all(28),
            decoration: BoxDecoration(
              color: _secondaryColor.withOpacity(0.08),
              shape: BoxShape.circle,
            ),
            child: Icon(Iconsax.car, size: 56, color: _secondaryColor),
          ),
          const SizedBox(height: 24),
          Text(
            "Finding Your Ride",
            style: TextStyle(
              fontSize: 20,
              color: _textPrimary,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            "Comparing the best available cabs for you",
            style: TextStyle(
              fontSize: 14,
              color: _textSecondary,
              fontWeight: FontWeight.w600,
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
                color: _errorColor.withOpacity(0.08),
                shape: BoxShape.circle,
              ),
              child: Icon(Iconsax.info_circle, size: 56, color: _errorColor),
            ),
            const SizedBox(height: 24),
            Text(
              "Search Interrupted",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w900,
                color: _textPrimary,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              message,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: _textSecondary,
                height: 1.5,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 32),
            SizedBox(
              width: 200,
              height: 52,
              child: ElevatedButton(
                onPressed: () {
                  context.read<FetchCabsBloc>().add(
                    FetchCabsEvent.fetchCabs(requestData: widget.requestData),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: _primaryColor,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  elevation: 4,
                  shadowColor: _primaryColor.withOpacity(0.3),
                ),
                child: const Text(
                  "Try Again",
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w800),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCabList(
    CabResponse cabResponse,
    CommissionProvider commissionProvider,
  ) {
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
                  padding: const EdgeInsets.all(28),
                  decoration: BoxDecoration(
                    color: _textLight.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Iconsax.search_status,
                    size: 56,
                    color: _textLight,
                  ),
                ),
                const SizedBox(height: 24),
                Text(
                  "No Cabs Available",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w900,
                    color: _textPrimary,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  "We couldn't find any vehicles matching your search criteria. Try adjusting your trip options.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    color: _textSecondary,
                    height: 1.5,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }

    return SliverPadding(
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 40),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate((context, index) {
          final cabData = cabRateList[index];
          final cab = cabData.cab;
          final fare = cabData.fare;
          final originalAmount = fare.totalAmount ?? 0;

          return Container(
            margin: const EdgeInsets.only(bottom: 10),
            decoration: BoxDecoration(
              color: _cardColor,
              borderRadius: BorderRadius.circular(30),
              boxShadow: [
                BoxShadow(
                  color: _primaryColor.withOpacity(0.08),
                  blurRadius: 30,
                  offset: const Offset(0, 12),
                ),
                BoxShadow(
                  color: Colors.black.withOpacity(0.01),
                  blurRadius: 2,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Upper Section: Category & Model
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 19, 20, 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 7,
                            vertical: 5,
                          ),
                          decoration: BoxDecoration(
                            color: _secondaryColor.withOpacity(0.12),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            cab.category.toUpperCase(),
                            style: TextStyle(
                              fontSize: 8,
                              fontWeight: FontWeight.w900,
                              color: _secondaryColor,
                              letterSpacing: 1.2,
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          cab.model,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w900,
                            color: _primaryColor,
                            letterSpacing: -0.5,
                            height: 1.1,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.visible,
                        ),
                      ],
                    ),
                  ),

                  // Middle Section: Image & Specs Row
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      children: [
                        // Large Car Image
                        Expanded(
                          flex: 2,
                          child: Container(
                            height: 100,
                            decoration: BoxDecoration(
                              color: _backgroundColor,
                              borderRadius: BorderRadius.circular(22),
                              border: Border.all(
                                color: _primaryColor.withOpacity(0.03),
                              ),
                            ),
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                if (cab.image.isNotEmpty)
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(22),
                                    child: Image.network(
                                      cab.image,
                                      fit: BoxFit.contain,
                                      errorBuilder:
                                          (context, error, stackTrace) => Icon(
                                            Iconsax.car,
                                            size: 40,
                                            color: _secondaryColor.withOpacity(
                                              0.4,
                                            ),
                                          ),
                                    ),
                                  )
                                else
                                  Icon(
                                    Iconsax.car,
                                    size: 40,
                                    color: _secondaryColor.withOpacity(0.4),
                                  ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(width: 20),
                        // Vertical Amenities/Specs
                        Expanded(
                          flex: 2,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildAmenityRow(
                                Iconsax.user,
                                "${cab.seatingCapacity} Seater",
                              ),
                              const SizedBox(height: 10),
                              _buildAmenityRow(
                                Iconsax.briefcase,
                                "${cab.bagCapacity} Luggage",
                              ),
                              const SizedBox(height: 10),
                              _buildAmenityRow(
                                Iconsax.gas_station,
                                cab.fuelType?.split(' ').first ?? 'Petrol',
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 10),

                  // // Policy Section (Chips)
                  // Padding(
                  //   padding: const EdgeInsets.symmetric(horizontal: 20),
                  //   child: Wrap(
                  //     spacing: 10,
                  //     runSpacing: 10,
                  //     children: [
                  //       _buildPolicyPill(
                  //         cabData.cancellationPolicy.contains('Free')
                  //             ? 'Free Cancellation'
                  //             : cabData.cancellationPolicy,
                  //         _successColor,
                  //         Iconsax.verify,
                  //       ),
                  //       _buildPolicyPill(
                  //         "Instant Booking",
                  //         _primaryColor,
                  //         Iconsax.flash_1,
                  //       ),
                  //     ],
                  //   ),
                  // ),

                  // const SizedBox(height: 20),

                  // Unified Action Bar (Price & Button)
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: _backgroundColor.withOpacity(0.6),
                      border: Border(
                        top: BorderSide(color: _primaryColor.withOpacity(0.05)),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        FutureBuilder<double>(
                          future: commissionProvider
                              .calculateAmountWithCommission(originalAmount),
                          builder: (context, snapshot) {
                            if (commissionProvider.isLoading ||
                                snapshot.connectionState ==
                                    ConnectionState.waiting) {
                              return _buildAmountShimmer();
                            }
                            final amount = snapshot.data ?? originalAmount;
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Total Fare".toUpperCase(),
                                  style: TextStyle(
                                    fontSize: 9,
                                    color: _textSecondary,
                                    fontWeight: FontWeight.w900,
                                    letterSpacing: 0.5,
                                  ),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  "₹${amount.toStringAsFixed(0)}",
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w900,
                                    color: _primaryColor,
                                    letterSpacing: -1,
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                        GestureDetector(
                          onTap: () {
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
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 16,
                            ),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  _primaryColor,
                                  const Color(0xFF004D9D),
                                ],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                              borderRadius: BorderRadius.circular(18),
                              // boxShadow: [
                              //   BoxShadow(
                              //     color: _primaryColor.withOpacity(0.25),
                              //     blurRadius: 15,
                              //     offset: const Offset(0, 8),
                              //   ),
                              // ],
                            ),
                            child: Row(
                              children: const [
                                Text(
                                  "BOOK NOW",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w900,
                                    letterSpacing: 1,
                                  ),
                                ),
                                SizedBox(width: 10),
                                Icon(
                                  Iconsax.arrow_right_3,
                                  color: Colors.white,
                                  size: 18,
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
            ),
          );
        }, childCount: cabRateList.length),
      ),
    );
  }

  Widget _buildAmenityRow(IconData icon, String label) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: _secondaryColor.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, size: 14, color: _secondaryColor),
        ),
        const SizedBox(width: 10),
        Flexible(
          child: Text(
            label,
            style: TextStyle(
              fontSize: 11,
              color: _textPrimary.withOpacity(0.8),
              fontWeight: FontWeight.w800,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  Widget _buildPolicyPill(String label, Color color, IconData icon) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: color.withOpacity(0.06),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.12), width: 1),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: color),
          const SizedBox(width: 8),
          Text(
            label,
            style: TextStyle(
              color: color,
              fontSize: 10,
              fontWeight: FontWeight.w800,
              letterSpacing: 0.1,
            ),
          ),
        ],
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
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        const SizedBox(height: 6),
        Container(
          width: 40,
          height: 10,
          decoration: BoxDecoration(
            color: Colors.grey[100],
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
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 20),
      itemBuilder: (context, index) => Container(
        margin: const EdgeInsets.only(bottom: 24),
        height: 180,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(28),
          border: Border.all(color: Colors.grey.withOpacity(0.08)),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(18),
              child: Row(
                children: [
                  Container(
                    width: 100,
                    height: 90,
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 50,
                          height: 14,
                          decoration: BoxDecoration(
                            color: Colors.grey[100],
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Container(
                          width: 120,
                          height: 18,
                          decoration: BoxDecoration(
                            color: Colors.grey[100],
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                        const SizedBox(height: 12),
                        Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: List.generate(
                            3,
                            (i) => Container(
                              width: 40,
                              height: 24,
                              decoration: BoxDecoration(
                                color: Colors.grey[50],
                                borderRadius: BorderRadius.circular(8),
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
            const Spacer(),
            Container(
              width: double.infinity,
              height: 50,
              decoration: BoxDecoration(
                color: Colors.grey[50],
                borderRadius: const BorderRadius.vertical(
                  bottom: Radius.circular(28),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
