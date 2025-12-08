import 'package:flutter/material.dart';
import 'package:minna/comman/const/const.dart';
import 'package:minna/hotel%20booking/domain/hotel%20list/hotel_list.dart';
import 'package:minna/hotel%20booking/functions/get_hotel_list.dart';
import 'package:minna/hotel%20booking/pages/hotel%20details/hotel_details_page.dart';

class HotelListPage extends StatefulWidget {
  final String cityCode;
  final String cityName;

  const HotelListPage({super.key, required this.cityCode, required this.cityName});

  @override
  State<HotelListPage> createState() => _HotelListPageState();
}

class _HotelListPageState extends State<HotelListPage> {
  late Future<List<Hotel>> _hotelsFuture;
  final HotelApiService apiService = HotelApiService();
  final TextEditingController _searchController = TextEditingController();
  List<Hotel> _filteredHotels = [];
  List<Hotel> _allHotels = [];

  // Color Theme - Consistent throughout
  final Color _primaryColor = Colors.black;
  final Color _secondaryColor = Color(0xFFD4AF37); // Gold
  final Color _accentColor = Color(0xFFC19B3C); // Darker Gold
  final Color _backgroundColor = Color(0xFFF8F9FA);
  final Color _cardColor = Colors.white;
  final Color _textPrimary = Colors.black;
  final Color _textSecondary = Color(0xFF666666);
  final Color _textLight = Color(0xFF999999);

  @override
  void initState() {
    super.initState();
    _hotelsFuture = apiService.fetchHotels(widget.cityCode).then((hotels) {
      _allHotels = hotels;
      _filteredHotels = hotels;
      return hotels;
    });
  }

  void _filterHotels(String query) {
    setState(() {
      if (query.isEmpty) {
        _filteredHotels = _allHotels;
      } else {
        _filteredHotels = _allHotels.where((hotel) {
          return hotel.hotelName.toLowerCase().contains(query.toLowerCase()) ||
                 hotel.address.toLowerCase().contains(query.toLowerCase()) ||
                 hotel.cityName.toLowerCase().contains(query.toLowerCase());
        }).toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _backgroundColor,
      body: CustomScrollView(
        slivers: [
          // App Bar
          SliverAppBar(
            backgroundColor: _primaryColor,
            expandedHeight: 120,
            floating: false,
            pinned: true,
            elevation: 4,leading: IconButton(
              icon: const Icon(Icons.arrow_back_rounded, color: Colors.white),
              onPressed: () => Navigator.pop(context),
            ),
            shadowColor: Colors.black.withOpacity(0.3),
            surfaceTintColor: Colors.white,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                'Hotels in ${widget.cityName}',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
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
            // shape: RoundedRectangleBorder(
            //   borderRadius: BorderRadius.vertical(
            //     bottom: Radius.circular(20),
            //   ),
            // ),
          ),

          // Search Section
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  // Search Bar
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 10,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    child: TextField(
                      controller: _searchController,
                      onChanged: _filterHotels,
                      decoration: InputDecoration(
                        hintText: 'Search hotels by name, address or city...',
                        hintStyle: TextStyle(color: _textLight),
                        prefixIcon: Icon(Icons.search_rounded, color: _secondaryColor),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: BorderSide.none,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: BorderSide.none,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: BorderSide(color: _secondaryColor, width: 2),
                        ),
                        filled: true,
                        fillColor: _cardColor,
                        contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                        suffixIcon: _searchController.text.isNotEmpty
                            ? IconButton(
                                icon: Icon(Icons.clear_rounded, color: _textLight),
                                onPressed: () {
                                  _searchController.clear();
                                  _filterHotels('');
                                },
                              )
                            : null,
                      ),
                    ),
                  ),
                                                        if (_searchController.text.isNotEmpty)
 SizedBox(height: 16),
                                          if (_searchController.text.isNotEmpty)

                  // Results Count
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    decoration: BoxDecoration(
                      color: _cardColor,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.03),
                          blurRadius: 6,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                         '${_filteredHotels.length} hotels found',
                          style: TextStyle(
                            color: _textSecondary,
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                          ),
                        ),
                          GestureDetector(
                            onTap: () {
                              _searchController.clear();
                              _filterHotels('');
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                              decoration: BoxDecoration(
                                color: _secondaryColor.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                'Clear',
                                style: TextStyle(
                                  color: _secondaryColor,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 12,
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
          ),

          // Hotel List
          SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: 12),
            sliver: FutureBuilder<List<Hotel>>(
              future: _hotelsFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) => _buildShimmerHotelCard(),
                      childCount: 6,
                    ),
                  );
                } else if (!snapshot.hasData || _filteredHotels.isEmpty ) {
                  return SliverToBoxAdapter(child: _buildEmptyState());
                } else if (snapshot.hasError) {
                  return SliverToBoxAdapter(child: _buildErrorState(snapshot.error.toString()));
                } else {
                  return SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        final hotel = _filteredHotels[index];
                        return _buildHotelCard(hotel);
                      },
                      childCount: _filteredHotels.length,
                    ),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildShimmerHotelCard() {
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        elevation: 0,
        color: _cardColor,
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Hotel Image Placeholder
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.grey[300],
                ),
              ),
              SizedBox(width: 16),
              
              // Content Placeholders
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: double.infinity,
                      height: 20,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        color: Colors.grey[300],
                      ),
                    ),
                    SizedBox(height: 12),
                    
                    Row(
                      children: [
                        Container(
                          width: 16,
                          height: 16,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Colors.grey[300],
                          ),
                        ),
                        SizedBox(width: 6),
                        Container(
                          width: 60,
                          height: 16,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            color: Colors.grey[300],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 12),
                    
                    Container(
                      width: double.infinity,
                      height: 14,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        color: Colors.grey[300],
                      ),
                    ),
                    SizedBox(height: 6),
                    Container(
                      width: 200,
                      height: 14,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        color: Colors.grey[300],
                      ),
                    ),
                    SizedBox(height: 12),
                    
                    Container(
                      width: 120,
                      height: 16,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        color: Colors.grey[300],
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

  Widget _buildErrorState(String error) {
    return Container(
      margin: EdgeInsets.all(20),
      padding: EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: _cardColor,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: Colors.red.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.error_outline_rounded,
              size: 40,
              color: Colors.red,
            ),
          ),
          SizedBox(height: 16),
          Text(
            'Oops! Something went wrong',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: _textPrimary,
            ),
          ),
          SizedBox(height: 8),
          Text(
            error,
            textAlign: TextAlign.center,
            style: TextStyle(color: _textSecondary),
          ),
          SizedBox(height: 20),
          SizedBox(
            width: 140,
            child: ElevatedButton(
              onPressed: () {
                setState(() {
                  _hotelsFuture = apiService.fetchHotels(widget.cityCode).then((hotels) {
                    _allHotels = hotels;
                    _filteredHotels = hotels;
                    return hotels;
                  });
                });
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: _primaryColor,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: EdgeInsets.symmetric(vertical: 12),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.refresh_rounded, size: 18),
                  SizedBox(width: 8),
                  Text('Try Again'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Container(
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(25),
      decoration: BoxDecoration(
        color: _cardColor,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              color: _secondaryColor.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.hotel_rounded,
              size: 50,
              color: _secondaryColor,
            ),
          ),
          SizedBox(height: 16),
          Text(
            _searchController.text.isEmpty ? 'No hotels available' : 'No hotels found',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: _textPrimary,
            ),
          ),
          SizedBox(height: 12),
          Text(
            _searchController.text.isEmpty
                ? 'There are no hotels available in ${widget.cityName} at the moment.'
                : 'No hotels match your search for "${_searchController.text}"',
            textAlign: TextAlign.center,
            style: TextStyle(color: _textSecondary, height: 1.4),
          ),
        ],
      ),
    );
  }

  Widget _buildHotelCard(Hotel hotel) {
    return Container(
      margin: EdgeInsets.only(bottom: 14),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        elevation: 0,
        color: _cardColor,
        shadowColor: Colors.black.withOpacity(0.1),
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => HotelDetailsPage(
                  hotelCode: hotel.hotelCode,
                  hotelName: hotel.hotelName,
                ),
              ),
            );
          },
          child: Padding(
            padding: EdgeInsets.all(15),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Hotel Image
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: _secondaryColor.withOpacity(0.1),
                  ),
                  child: Icon(
                    Icons.hotel_rounded,
                    size: 30,
                    color: _secondaryColor,
                  ),
                ),
                SizedBox(width: 15),
                
                // Hotel Details
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Text(
                              hotel.hotelName,
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: _textPrimary,
                                height: 1.2,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          // Container(
                          //   padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          //   decoration: BoxDecoration(
                          //     color: _secondaryColor.withOpacity(0.1),
                          //     borderRadius: BorderRadius.circular(8),
                          //     border: Border.all(color: _secondaryColor.withOpacity(0.3)),
                          //   ),
                          //   child: Row(
                          //     mainAxisSize: MainAxisSize.min,
                          //     children: [
                          //       Icon(Icons.star_rounded, color: _secondaryColor, size: 14),
                          //       SizedBox(width: 4),
                          //       Text(
                          //         hotel.hotelRating,
                          //         style: TextStyle(
                          //           fontSize: 12,
                          //           fontWeight: FontWeight.bold,
                          //           color: _secondaryColor,
                          //         ),
                          //       ),
                          //     ],
                          //   ),
                          // ),
                        ],
                      ),
                      SizedBox(height: 8),
                      Row(crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 3),
                            child: Icon(Icons.location_on_rounded, size: 14, color: _secondaryColor,),
                          ),
                          SizedBox(width: 6),
                          Expanded(
                            child: Text(
                              hotel.address,
                              style: TextStyle(fontSize: 13, color: _textSecondary),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 6),
                      Text(
                        '${hotel.cityName}, ${hotel.countryName}',
                        style: TextStyle(fontSize: 12, color: _textLight),
                      ),
                      SizedBox(height: 12),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: _primaryColor.withOpacity(0.05),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          'View Details',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: _primaryColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}