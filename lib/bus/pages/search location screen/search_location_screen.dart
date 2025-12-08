import 'package:minna/bus/application/change%20location/location_bloc.dart';
import 'package:minna/bus/application/location%20fetch/bus_location_fetch_bloc.dart';
import 'package:minna/bus/domain/location/location_modal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';

class LocationSearchPage extends StatefulWidget {
  final String fromOrto;

  const LocationSearchPage({super.key, required this.fromOrto});

  @override
  State<LocationSearchPage> createState() => _LocationSearchPageState();
}

class _LocationSearchPageState extends State<LocationSearchPage> {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _searchFocusNode = FocusNode();

  // Color Theme - Consistent with flight booking
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
    WidgetsBinding.instance.addPostFrameCallback((_) {
      FocusScope.of(context).requestFocus(_searchFocusNode);
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _searchFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Container(
      height: screenHeight * 0.9,
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      decoration: BoxDecoration(
        color: _backgroundColor,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 20,
            spreadRadius: 2,
            offset: Offset(0, -4),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Drag handle
          Container(
            margin: EdgeInsets.only(top: 12, bottom: 8),
            width: 48,
            height: 4,
            decoration: BoxDecoration(
              color: _textLight.withOpacity(0.3),
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          
          // Header
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Select ${widget.fromOrto == 'from' ? 'Origin' : 'Destination'}',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: _textPrimary,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Choose your ${widget.fromOrto == 'from' ? 'starting point' : 'destination'}',
                      style: TextStyle(
                        fontSize: 12,
                        color: _textSecondary,
                      ),
                    ),
                  ],
                ),
                Container(
                  decoration: BoxDecoration(
                    color: _secondaryColor.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    icon: Icon(Icons.close_rounded, color: _secondaryColor),
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
              ],
            ),
          ),
          
          // const SizedBox(height: 10),

          // Search Bar
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: _buildSearchBar(context),
          ),
          
          const SizedBox(height: 10),

          // Search Results
          Expanded(
            child: BlocBuilder<BusLocationFetchBloc, BusLocationFetchState>(
              builder: (context, state) {
                if (state.isLoading && (state.allCitydata == null)) {
                  return _buildShimmerLoading();
                } else {
                  return _buildSuggestionsList(context, state);
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildShimmerLoading() {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      itemCount: 8,
      itemBuilder: (context, index) {
        return Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: Container(
            margin: EdgeInsets.only(bottom: 12),
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: _cardColor,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 8,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              children: [
                Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                SizedBox(width: 16),
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
                        height: 12,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(4),
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

  Widget _buildSearchBar(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: _cardColor,
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
        controller: _controller,
        focusNode: _searchFocusNode,
        autofocus: true,
        style: TextStyle(
          fontSize: 16,
          color: _textPrimary,
          fontWeight: FontWeight.w500,
        ),
        decoration: InputDecoration(
          hintText: 'Search city, station or location...',
          hintStyle: TextStyle(
            color: _textLight,
            fontSize: 14,
          ),
          prefixIcon: Container(
            padding: EdgeInsets.all(12),
            child: Icon(
              Icons.search_rounded,
              color: _secondaryColor,
              size: 24,
            ),
          ),
          suffixIcon: _controller.text.isNotEmpty
              ? Container(
                  padding: EdgeInsets.all(12),
                  child: IconButton(
                    icon: Icon(
                      Icons.clear_rounded,
                      color: _textLight,
                      size: 20,
                    ),
                    onPressed: () {
                      _controller.clear();
                      context.read<BusLocationFetchBloc>().add(const GetData());
                    },
                  ),
                )
              : null,
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
            borderSide: BorderSide(
              color: _secondaryColor.withOpacity(0.5),
              width: 2,
            ),
          ),
          filled: true,
          fillColor: _cardColor,
          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        ),
        onChanged: (value) {
          context.read<BusLocationFetchBloc>().add(
            SearchLocations(query: value.trim()),
          );
        },
      ),
    );
  }

  Widget _buildSuggestionsList(
    BuildContext context,
    BusLocationFetchState state,
  ) {
    final suggestions = state.filteredCities ?? state.allCitydata?.cities ?? [];

    if (suggestions.isEmpty) {
      return _buildEmptyState();
    }

    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      shrinkWrap: true,
      itemCount: suggestions.length,
      itemBuilder: (context, index) {
        final location = suggestions[index];
        return _buildLocationCard(context, location, index);
      },
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: _secondaryColor.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.location_searching_rounded,
                size: 35,
                color: _secondaryColor,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              _controller.text.isEmpty ? 'Search Locations' : 'No results found',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: _textPrimary,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              _controller.text.isEmpty
                  ? 'Enter a city or station name to search'
                  : 'We couldn\'t find any locations matching "${_controller.text}"',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12,
                color: _textSecondary,
                height: 1.5,
              ),
            ),
            if (_controller.text.isNotEmpty) ...[
              const SizedBox(height: 5),
              ElevatedButton(
                onPressed: () {
                  _controller.clear();
                  context.read<BusLocationFetchBloc>().add(const GetData());
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: _primaryColor,
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  'Clear Search',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildLocationCard(BuildContext context, City location, int index) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 200),
      margin: EdgeInsets.only(bottom: 10),
      child: Material(
        color: _cardColor,
        borderRadius: BorderRadius.circular(16),
        elevation: 0,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () => _handleLocationSelection(context, location),
          splashColor: _secondaryColor.withOpacity(0.1),
          highlightColor: _secondaryColor.withOpacity(0.05),
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: _cardColor,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 8,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: _secondaryColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    Icons.location_on_rounded,
                    color: _secondaryColor,
                    size: 20,
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        location.name,
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: _textPrimary,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 2),
                      Text(
                        location.state,
                        style: TextStyle(
                          fontSize: 12,
                          color: _textSecondary,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      // if (location.countryCode.isNotEmpty) ...[
                      //   const SizedBox(height: 2),
                      //   Text(
                      //     location.countryCode,
                      //     style: TextStyle(
                      //       fontSize: 11,
                      //       color: _textLight,
                      //     ),
                      //   ),
                      // ],
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: _secondaryColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    Icons.arrow_forward_ios_rounded,
                    size: 14,
                    color: _secondaryColor,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _handleLocationSelection(BuildContext context, City location) {
    final locationChangeBloc = context.read<LocationBloc>();
    final currentState = locationChangeBloc.state;

    if (widget.fromOrto == 'from') {
      locationChangeBloc.add(
        LocationEvent.addLocation(location, currentState.to),
      );
    } else {
      locationChangeBloc.add(
        LocationEvent.addLocation(currentState.from, location),
      );
    }

    Navigator.pop(context);
  }
}