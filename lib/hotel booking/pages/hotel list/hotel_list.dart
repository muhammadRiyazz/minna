import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shimmer/shimmer.dart';
import 'package:minna/comman/const/const.dart';
import 'package:minna/hotel booking/functions/hotel_api.dart';
import 'package:minna/hotel booking/functions/hotel_details.dart';
import 'package:minna/hotel%20booking/domain/hotel%20list/hotel_list.dart';
import 'package:minna/hotel%20booking/pages/hotel%20details/hotel_details_page.dart';

class HotelListPage extends StatefulWidget {
  final String cityId;
  final String cityName;
  final DateTime checkInDate;
  final DateTime checkOutDate;
  final List<Map<String, dynamic>> rooms;
  final String guestNationalityCode;

  const HotelListPage({
    super.key,
    required this.cityId,
    required this.cityName,
    required this.checkInDate,
    required this.checkOutDate,
    required this.rooms,
    required this.guestNationalityCode,
  });

  @override
  State<HotelListPage> createState() => _HotelListPageState();
}

class _HotelListPageState extends State<HotelListPage> {
  List<HotelListItem> hotels = [];
  bool isLoading = true;
  bool _isMoreLoading = false;
  bool hasError = false;
  String errorMessage = '';
  int _currentOffset = 0;
  int _totalHotels = 0;
  bool _hasMore = true;

  final HotelApiService _apiService = HotelApiService();
  final ScrollController _scrollController = ScrollController();

  String _selectedSort = 'Recommended';
  final List<String> _sortOptions = [
    'Recommended',
    'Lowest Price',
    'Highest Rating',
  ];

  // Filtering State
  List<HotelListItem> filteredHotels = [];
  double _minPrice = 0;
  double _maxPrice = 100000;
  double? _filterMinPrice;
  double? _filterMaxPrice;
  int? _filterRating;

  // Search State
  bool _isSearching = false;
  String _searchQuery = '';
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    fetchHotels();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (!_scrollController.hasClients) return;
    if (_scrollController.position.pixels >=
            _scrollController.position.maxScrollExtent - 200 &&
        !_isMoreLoading &&
        _hasMore &&
        !isLoading) {
      fetchHotels(isLoadMore: true);
    }
  }

  Future<void> fetchHotels({bool isLoadMore = false}) async {
    if (isLoadMore) {
      if (!_hasMore || _isMoreLoading) return;
      if (mounted) setState(() => _isMoreLoading = true);
    } else {
      if (mounted) {
        setState(() {
          isLoading = true;
          hasError = false;
          hotels.clear();
          _currentOffset = 0;
          _hasMore = true;
        });
      }
    }

    try {
      log('🔍 Searching hotels: ${widget.cityName} | Offset: $_currentOffset');

      final response = await _apiService.searchHotels(
        country: 'IN',
        city: widget.cityId,
        checkIn: DateFormat('yyyy-MM-dd').format(widget.checkInDate),
        checkOut: DateFormat('yyyy-MM-dd').format(widget.checkOutDate),
        rooms: widget.rooms,
        offset: _currentOffset,
        limit: 20,
      );

      if (response.status) {
        _totalHotels = response.totalHotels;
        _currentOffset = response.nextOffset;
        _hasMore =
            response.hotels.isNotEmpty &&
            hotels.length + response.hotels.length < _totalHotels;

        List<String> codes = response.hotels
            .map((h) => h.hotelSearchDetails.hotelCode)
            .where((c) => c.isNotEmpty)
            .toList();

        Map<String, dynamic> detailsMap = {};
        if (codes.isNotEmpty) {
          try {
            final detailsRes = await HotelDetailsApiService().fetchHotelDetails(
              codes.join(','),
            );
            for (var d in detailsRes.hotelDetails) {
              detailsMap[d.hotelCode] = d.toJson();
            }
          } catch (e) {
            log('⚠️ Error fetching details: $e');
          }
        }

        final List<HotelListItem> newItems = [];
        for (final hotelItem in response.hotels) {
          if (hotelItem.hotelSearchDetails.rooms.isNotEmpty) {
            final minPrice = hotelItem.hotelSearchDetails.rooms
                .map((room) => room.totalFare)
                .reduce((a, b) => a < b ? a : b);

            HotelDetails finalDetails = hotelItem.hotelDetails;
            final remoteDetailJson =
                detailsMap[hotelItem.hotelSearchDetails.hotelCode];

            if (remoteDetailJson != null) {
              try {
                finalDetails = HotelDetails.fromJson(remoteDetailJson);
              } catch (e) {
                log('Error parsing HotelDetails: $e');
              }
            }

            newItems.add(
              HotelListItem(
                hotelDetails: SimplifiedHotelDetails.fromHotelDetails(
                  finalDetails,
                ),
                startingPrice: minPrice,
                currency: hotelItem.hotelSearchDetails.currency,
                hotelSearchItem: HotelSearchItem(
                  hotelSearchDetails: hotelItem.hotelSearchDetails,
                  hotelDetails: finalDetails,
                ),
              ),
            );
          }
        }

        if (mounted) {
          setState(() {
            if (isLoadMore) {
              hotels.addAll(newItems);
              _isMoreLoading = false;
            } else {
              hotels = newItems;
              isLoading = false;
              // Reset filters on new search if needed
              _updatePriceRange();
            }
            _applyFilters();
          });
        }
      } else {
        if (mounted) {
          setState(() {
            isLoading = false;
            _isMoreLoading = false;

            // Treat "No hotel codes found" or similar as an empty state, not a hard error
            final lowerMsg = response.message.toLowerCase();
            final isNoResults =
                lowerMsg.contains('no hotel') ||
                lowerMsg.contains('not found') ||
                lowerMsg.contains('empty');

            if (isNoResults && !isLoadMore) {
              hasError = false;
              hotels = [];
              _totalHotels = 0;
            } else {
              hasError = !isLoadMore;
              errorMessage = response.message;
            }
          });
        }
      }
    } catch (e) {
      log('❌ Search Failed: $e');
      if (mounted) {
        setState(() {
          isLoading = false;
          _isMoreLoading = false;
          hasError = !isLoadMore;
          errorMessage = 'Something went wrong. Please check your connection.';
        });
      }
    }
  }

  void _updatePriceRange() {
    if (hotels.isEmpty) return;
    double min = hotels.first.startingPrice;
    double max = hotels.first.startingPrice;
    for (var h in hotels) {
      if (h.startingPrice < min) min = h.startingPrice;
      if (h.startingPrice > max) max = h.startingPrice;
    }
    _minPrice = min;
    _maxPrice = max;
  }

  void _applyFilters() {
    List<HotelListItem> temp = List.from(hotels);

    // Price Filter
    if (_filterMinPrice != null && _filterMaxPrice != null) {
      temp = temp
          .where(
            (h) =>
                h.startingPrice >= _filterMinPrice! &&
                h.startingPrice <= _filterMaxPrice!,
          )
          .toList();
    }

    // Rating Filter
    if (_filterRating != null) {
      temp = temp
          .where((h) => h.hotelDetails.hotelRating >= _filterRating!)
          .toList();
    }

    // Sorting
    if (_selectedSort == 'Lowest Price') {
      temp.sort((a, b) => a.startingPrice.compareTo(b.startingPrice));
    } else if (_selectedSort == 'Highest Rating') {
      temp.sort(
        (a, b) =>
            b.hotelDetails.hotelRating.compareTo(a.hotelDetails.hotelRating),
      );
    }

    // Search Filter
    if (_searchQuery.isNotEmpty) {
      temp = temp.where((h) {
        final query = _searchQuery.toLowerCase();
        final name = h.hotelDetails.hotelName.toLowerCase();
        final city = h.hotelDetails.cityName.toLowerCase();
        return name.contains(query) || city.contains(query);
      }).toList();
    }

    filteredHotels = temp;
  }

  void _showFilterOptions() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => StatefulBuilder(
        builder: (context, setModalState) {
          return Container(
            height: MediaQuery.of(context).size.height * 0.75,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 12),
                Center(
                  child: Container(
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: borderSoft,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(24),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Filters',
                        style: TextStyle(
                          color: textPrimary,
                          fontSize: 24,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          setModalState(() {
                            _filterMinPrice = null;
                            _filterMaxPrice = null;
                            _filterRating = null;
                          });
                        },
                        child: Text(
                          'Clear All',
                          style: TextStyle(
                            color: secondaryColor,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Price Range
                        Text(
                          'Price Range',
                          style: TextStyle(
                            color: textPrimary,
                            fontSize: 16,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        const SizedBox(height: 16),
                        RangeSlider(
                          values: RangeValues(
                            _filterMinPrice ?? _minPrice,
                            _filterMaxPrice ?? _maxPrice,
                          ),
                          min: _minPrice,
                          max: _maxPrice,
                          activeColor: maincolor1,
                          inactiveColor: borderSoft,
                          onChanged: (values) {
                            setModalState(() {
                              _filterMinPrice = values.start;
                              _filterMaxPrice = values.end;
                            });
                          },
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              formatPrice(_filterMinPrice ?? _minPrice),
                              style: TextStyle(
                                color: textSecondary,
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              formatPrice(_filterMaxPrice ?? _maxPrice),
                              style: TextStyle(
                                color: textSecondary,
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 40),
                        // Star Rating
                        Text(
                          'Star Rating',
                          style: TextStyle(
                            color: textPrimary,
                            fontSize: 16,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Wrap(
                          spacing: 12,
                          children: [null, 3, 4, 5].map((rating) {
                            final isSelected = _filterRating == rating;
                            return GestureDetector(
                              onTap: () =>
                                  setModalState(() => _filterRating = rating),
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 20,
                                  vertical: 10,
                                ),
                                decoration: BoxDecoration(
                                  color: isSelected
                                      ? secondaryColor.withOpacity(0.1)
                                      : Colors.white,
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                    color: isSelected
                                        ? secondaryColor
                                        : borderSoft,
                                    width: 1.5,
                                  ),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    if (rating != null) ...[
                                      Icon(
                                        Iconsax.star1,
                                        size: 14,
                                        color: isSelected
                                            ? secondaryColor
                                            : textSecondary,
                                      ),
                                      const SizedBox(width: 6),
                                    ],
                                    Text(
                                      rating == null ? 'All' : '$rating Stars',
                                      style: TextStyle(
                                        color: isSelected
                                            ? secondaryColor
                                            : textSecondary,
                                        fontSize: 13,
                                        fontWeight: isSelected
                                            ? FontWeight.w800
                                            : FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                        const SizedBox(height: 40),
                      ],
                    ),
                  ),
                ),
                // Footer
                Padding(
                  padding: const EdgeInsets.all(24),
                  child: SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() => _applyFilters());
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: maincolor1,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        elevation: 0,
                      ),
                      child: const Text(
                        'Show Results',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).padding.bottom),
              ],
            ),
          );
        },
      ),
    );
  }

  String formatPrice(double price) {
    return '₹${NumberFormat('#,##0').format(price)}';
  }

  String formatDate(DateTime date) {
    return DateFormat('MMM dd').format(date);
  }

  int get totalGuests {
    return widget.rooms.fold(0, (sum, room) {
      final adults = room['Adults'] ?? room['adults'] ?? 0;
      final kids = room['Children'] ?? room['children'] ?? 0;

      int a = adults is int ? adults : int.tryParse(adults.toString()) ?? 0;
      int k = kids is int ? kids : int.tryParse(kids.toString()) ?? 0;

      return sum + a + k;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Column(
        children: [
          _buildHeader(),
          _buildSortBar(),
          if (_isSearching) _buildSearchBar(),
          Expanded(child: _buildContent()),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      decoration: BoxDecoration(
        color: maincolor1,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 20),
          child: Column(
            children: [
              Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.12),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: const Icon(
                        Iconsax.arrow_left_2,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.cityName,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.w900,
                            letterSpacing: -0.2,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Row(
                          children: [
                            Icon(
                              Iconsax.calendar_1,
                              color: Colors.white.withOpacity(0.6),
                              size: 12,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              '${formatDate(widget.checkInDate)} - ${formatDate(widget.checkOutDate)}',
                              style: TextStyle(
                                color: Colors.white.withOpacity(0.6),
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Container(
                              width: 3,
                              height: 3,
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.3),
                                shape: BoxShape.circle,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Icon(
                              Iconsax.user,
                              color: Colors.white.withOpacity(0.6),
                              size: 12,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              '$totalGuests Guests',
                              style: TextStyle(
                                color: Colors.white.withOpacity(0.6),
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        if (_isSearching) {
                          _isSearching = false;
                          _searchQuery = '';
                          _searchController.clear();
                          _applyFilters();
                        } else {
                          _isSearching = true;
                        }
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: secondaryColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: secondaryColor.withOpacity(0.2),
                          width: 1,
                        ),
                      ),
                      child: Icon(
                        _isSearching
                            ? Iconsax.close_circle
                            : Iconsax.search_normal_1,
                        color: secondaryColor,
                        size: 18,
                      ),
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

  Widget _buildSearchBar() {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 12),
      color: Colors.white,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: borderSoft, width: 1),
        ),
        child: TextField(
          controller: _searchController,
          autofocus: true,
          style: TextStyle(
            color: textPrimary,
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
          decoration: InputDecoration(
            hintText: 'Search hotel or location...',
            hintStyle: TextStyle(color: textSecondary, fontSize: 13),
            icon: Icon(Iconsax.search_normal, size: 18, color: secondaryColor),
            border: InputBorder.none,
            suffixIcon: _searchQuery.isNotEmpty
                ? IconButton(
                    icon: Icon(
                      Iconsax.close_circle,
                      size: 18,
                      color: textSecondary,
                    ),
                    onPressed: () {
                      setState(() {
                        _searchQuery = '';
                        _searchController.clear();
                        _applyFilters();
                      });
                    },
                  )
                : null,
          ),
          onChanged: (value) {
            setState(() {
              _searchQuery = value;
              _applyFilters();
            });
          },
        ),
      ),
    );
  }

  Widget _buildSortBar() {
    return Container(
      height: 58,
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(bottom: BorderSide(color: borderSoft)),
      ),
      child: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        scrollDirection: Axis.horizontal,
        children: [
          // Filter Button
          GestureDetector(
            onTap: _showFilterOptions,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
                border: Border.all(color: secondaryColor, width: 1.5),
              ),
              child: Row(
                children: [
                  Icon(Iconsax.filter, size: 16, color: secondaryColor),
                  const SizedBox(width: 8),
                  Text(
                    'Filter',
                    style: TextStyle(
                      color: secondaryColor,
                      fontSize: 12,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  if (_filterRating != null || _filterMinPrice != null)
                    Container(
                      margin: const EdgeInsets.only(left: 6),
                      width: 6,
                      height: 6,
                      decoration: BoxDecoration(
                        color: secondaryColor,
                        shape: BoxShape.circle,
                      ),
                    ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 12),
          // Sort Options
          ..._sortOptions.map((option) {
            final isSelected = _selectedSort == option;
            return Padding(
              padding: const EdgeInsets.only(right: 12),
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedSort = option;
                    _applyFilters();
                  });
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                    color: isSelected ? maincolor1 : Colors.white,
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(
                      color: isSelected ? maincolor1 : borderSoft,
                      width: 1.5,
                    ),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    option,
                    style: TextStyle(
                      color: isSelected ? Colors.white : textSecondary,
                      fontSize: 10,
                      fontWeight: isSelected
                          ? FontWeight.w600
                          : FontWeight.w500,
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildContent() {
    if (isLoading) return _buildLoading();
    if (hasError) return _buildError();
    if (filteredHotels.isEmpty) return _buildEmpty();
    return _buildHotelList();
  }

  Widget _buildLoading() {
    return ListView.builder(
      padding: const EdgeInsets.all(20),
      itemCount: 5,
      itemBuilder: (context, index) => _buildShimmerCard(),
    );
  }

  Widget _buildShimmerCard() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[200]!,
      highlightColor: Colors.white,
      child: Container(
        margin: const EdgeInsets.only(bottom: 20),
        height: 150, // Match _buildHotelCard height
        decoration: BoxDecoration(
          color: cardColor,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: borderSoft),
        ),
        child: Row(
          children: [
            // Image Section Skeleton
            Container(
              width: 140,
              height: 150,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(24),
                  bottomLeft: Radius.circular(24),
                ),
              ),
            ),
            // Details Section Skeleton
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 14,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    const SizedBox(height: 6),
                    Container(
                      height: 14,
                      width: 100,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Container(
                          height: 12,
                          width: 12,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 6),
                        Container(
                          height: 10,
                          width: 80,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: 8,
                              width: 60,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(4),
                              ),
                            ),
                            const SizedBox(height: 4),
                            Container(
                              height: 16,
                              width: 80,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(4),
                              ),
                            ),
                          ],
                        ),
                        Container(
                          height: 38,
                          width: 38,
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
          ],
        ),

      ),
    );
  }

  Widget _buildError() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(28),
              decoration: BoxDecoration(
                color: const Color(0xFFFFF1F2),
                shape: BoxShape.circle,
                border: Border.all(color: const Color(0xFFFFE4E6), width: 8),
              ),
              child: const Icon(
                Iconsax.info_circle,
                size: 50,
                color: Color(0xFFE11D48),
              ),
            ),
            const SizedBox(height: 32),
            Text(
              'Search Failed',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w900,
                color: textPrimary,
                letterSpacing: -0.5,
              ),
            ),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: borderSoft),
              ),
              child: Text(
                errorMessage,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  color: textSecondary,
                  height: 1.5,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            const SizedBox(height: 40),
            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                onPressed: fetchHotels,
                style: ElevatedButton.styleFrom(
                  backgroundColor: maincolor1,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  elevation: 0,
                ),
                child: const Text(
                  'RETRY SEARCH',
                  style: TextStyle(
                    fontWeight: FontWeight.w900,
                    letterSpacing: 1,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmpty() {
    final bool isFiltered =
        _filterMinPrice != null ||
        _filterMaxPrice != null ||
        _filterRating != null;
    final bool isSearching = _searchQuery.isNotEmpty;

    return SingleChildScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(40, 80, 40, 40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Icon with decorative background circles
              Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    width: 140,
                    height: 140,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color:
                          (isFiltered || isSearching
                                  ? secondaryColor
                                  : maincolor1)
                              .withOpacity(0.04),
                    ),
                  ),
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color:
                          (isFiltered || isSearching
                                  ? secondaryColor
                                  : maincolor1)
                              .withOpacity(0.08),
                    ),
                  ),
                  Icon(
                    isSearching
                        ? Iconsax.search_status
                        : (isFiltered
                              ? Iconsax.filter_remove
                              : Iconsax.building),
                    size: 60,
                    color: isFiltered || isSearching
                        ? secondaryColor
                        : maincolor1,
                  ),
                ],
              ),
              const SizedBox(height: 40),
              Text(
                isSearching
                    ? 'No Results Found'
                    : (isFiltered ? 'No Matches Found' : 'No Hotels Found'),
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w900,
                  color: textPrimary,
                  letterSpacing: -0.5,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                isSearching
                    ? 'We couldn\'t find any hotels matching "$_searchQuery". Try a different name.'
                    : (isFiltered
                          ? 'None of your selected filters match our current hotel list in this city.'
                          : 'Currently, there are no available hotels matching your search criteria in ${widget.cityName}.'),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 15,
                  color: textSecondary,
                  height: 1.5,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 48),

              // Action Buttons
              if (isSearching || isFiltered)
                SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        if (isSearching) {
                          _searchQuery = '';
                          _searchController.clear();
                        }
                        if (isFiltered) {
                          _filterMinPrice = null;
                          _filterMaxPrice = null;
                          _filterRating = null;
                        }
                        _applyFilters();
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: maincolor1,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      elevation: 0,
                    ),
                    child: Text(
                      isSearching ? 'CLEAR SEARCH' : 'CLEAR ALL FILTERS',
                      style: const TextStyle(
                        fontWeight: FontWeight.w900,
                        letterSpacing: 1,
                      ),
                    ),
                  ),
                )
              else
                SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: OutlinedButton(
                    onPressed: () => Navigator.pop(context),
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(color: maincolor1, width: 1.5),
                      foregroundColor: maincolor1,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    child: const Text(
                      'MODIFY SEARCH',
                      style: TextStyle(
                        fontWeight: FontWeight.w900,
                        letterSpacing: 1,
                      ),
                    ),
                  ),
                ),
              const SizedBox(height: 16),
              if (!isSearching && !isFiltered)
                TextButton(
                  onPressed: fetchHotels,
                  child: Text(
                    'RETRY',
                    style: TextStyle(
                      color: textSecondary,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 1,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHotelList() {
    return ListView.separated(
      controller: _scrollController,
      padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
      itemCount: filteredHotels.length + (_isMoreLoading ? 1 : 0),
      separatorBuilder: (context, index) => const SizedBox(height: 20),
      itemBuilder: (context, index) {
        if (index < filteredHotels.length)
          return _buildHotelCard(filteredHotels[index]);
        return _buildShimmerCard();
      },
    );
  }

  Widget _buildHotelCard(HotelListItem hotel) {
    return Container(
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: maincolor1.withOpacity(0.04),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
        border: Border.all(color: borderSoft),
      ),
      height:
          150, // Fixed height resolves layout constraints for the Expanded Column
      child: InkWell(
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => HotelDetailsPage(
              checkInDate: widget.checkInDate,
              checkOutDate: widget.checkOutDate,
              rooms: widget.rooms,
              hotelSearchData: hotel.hotelSearchItem,
              guestNationalityCode: widget.guestNationalityCode,
            ),
          ),
        ),
        borderRadius: BorderRadius.circular(24),
        child: Row(
          children: [
            // Image Section
            Container(
              width: 140,
              height: 180,
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(24),
                      bottomLeft: Radius.circular(24),
                    ),
                    child: hotel.hotelDetails.images.isNotEmpty
                        ? Image.network(
                            hotel.hotelDetails.images.first,
                            fit: BoxFit.cover,
                            width: 140,
                            height: 180,
                          )
                        : Center(
                            child: Container(
                              // color: Colors.grey[200],
                              child: const Icon(
                                Iconsax.image,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                  ),
                  if (hotel.hotelDetails.hotelRating > 0)
                    Positioned(
                      top: 12,
                      left: 12,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.7),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(
                              Iconsax.star1,
                              color: Colors.amber,
                              size: 12,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              hotel.hotelDetails.hotelRating.toString(),
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  // Refundable Badge
                  if (hotel.hotelSearchItem.hotelSearchDetails.rooms.any(
                    (r) => r.isRefundable,
                  ))
                    Positioned(
                      bottom: 12,
                      left: 12,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: successColor.withOpacity(0.9),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: const Text(
                          'Refundable',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 9,
                            fontWeight: FontWeight.w800,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
            // Details Section
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      hotel.hotelDetails.hotelName,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: textPrimary,
                        fontSize: 13,
                        fontWeight: FontWeight.w900,
                        height: 1.3,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Row(
                      children: [
                        Icon(
                          Iconsax.location5,
                          color: secondaryColor,
                          size: 14,
                        ),
                        const SizedBox(width: 4),
                        Expanded(
                          child: Text(
                            hotel.hotelDetails.cityName,
                            style: TextStyle(
                              color: textSecondary,
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'STARTING FROM',
                              style: TextStyle(
                                color: textSecondary,
                                fontSize: 8,
                                fontWeight: FontWeight.w800,
                                letterSpacing: 1,
                              ),
                            ),
                            Text(
                              formatPrice(hotel.startingPrice),
                              style: TextStyle(
                                color: successColor,
                                fontSize: 16,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                            Text(
                              'per night',
                              style: TextStyle(
                                color: textSecondary,
                                fontSize: 10,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: maincolor1,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Icon(
                            Iconsax.arrow_right_3,
                            color: Colors.white,
                            size: 18,
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
    );
  }
}

class HotelListItem {
  final SimplifiedHotelDetails hotelDetails;
  final double startingPrice;
  final String currency;
  final HotelSearchItem hotelSearchItem;

  HotelListItem({
    required this.hotelDetails,
    required this.startingPrice,
    required this.currency,
    required this.hotelSearchItem,
  });
}

class SimplifiedHotelDetails {
  final String hotelCode;
  final String hotelName;
  final int hotelRating;
  final String cityName;
  final List<String> images;

  SimplifiedHotelDetails({
    required this.hotelCode,
    required this.hotelName,
    required this.hotelRating,
    required this.cityName,
    required this.images,
  });

  factory SimplifiedHotelDetails.fromHotelDetails(HotelDetails details) {
    return SimplifiedHotelDetails(
      hotelCode: details.hotelCode,
      hotelName: details.hotelName,
      hotelRating: details.hotelRating,
      cityName: details.cityName,
      images: details.images,
    );
  }
}
