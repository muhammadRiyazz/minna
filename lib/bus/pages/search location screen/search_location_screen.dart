import 'dart:developer';
import 'package:minna/bus/application/change%20location/location_bloc.dart';
import 'package:minna/bus/application/location%20fetch/bus_location_fetch_bloc.dart';
import 'package:minna/bus/domain/location/location_modal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minna/bus/presendation/widgets/error_widget.dart';
import 'package:shimmer/shimmer.dart'; // Add this import for shimmer effect

class LocationSearchPage extends StatefulWidget {
  final String fromOrto;

  const LocationSearchPage({super.key, required this.fromOrto});

  @override
  State<LocationSearchPage> createState() => _LocationSearchPageState();
}

class _LocationSearchPageState extends State<LocationSearchPage> {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _searchFocusNode = FocusNode();

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
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final screenHeight = MediaQuery.of(context).size.height;

    return Container(
      height: screenHeight * 1, // 90% of screen height
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: 30),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  ' Select ${widget.fromOrto == 'from' ? 'Origin' : 'Destination'}',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ),
          SizedBox(height: 5),

          // Search Bar
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: _buildSearchBar(context, theme, colorScheme),
          ),
          const SizedBox(height: 8),
          // Search Results
          Expanded(
            child: BlocBuilder<BusLocationFetchBloc, BusLocationFetchState>(
              builder: (context, state) {
                if (state.isLoading && (state.allCitydata == null)) {
                  return _buildShimmerLoading(theme, colorScheme);
                } else {
                  return _buildSuggestionsList(
                    context,
                    state,
                    theme,
                    colorScheme,
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildShimmerLoading(ThemeData theme, ColorScheme colorScheme) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemCount: 6, // Number of shimmer items
      itemBuilder: (context, index) {
        return Shimmer.fromColors(
          baseColor: colorScheme.surfaceContainerHighest.withOpacity(0.5),
          highlightColor: colorScheme.surfaceContainerHighest.withOpacity(0.2),
          child: Card(
            margin: const EdgeInsets.only(bottom: 8),
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Container(
              height: 72,
              decoration: BoxDecoration(
                color: colorScheme.surfaceContainerHighest,
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildSearchBar(
    BuildContext context,
    ThemeData theme,
    ColorScheme colorScheme,
  ) {
    return TextField(
      controller: _controller,
      focusNode: _searchFocusNode,
      autofocus: true,
      decoration: InputDecoration(
        hintText: 'Search city or station...',
        prefixIcon: const Icon(Icons.search),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        suffixIcon: _controller.text.isNotEmpty
            ? IconButton(
                icon: Icon(Icons.clear, color: Colors.grey),
                onPressed: () {
                  _controller.clear();
                  context.read<BusLocationFetchBloc>().add(const GetData());
                },
              )
            : null,
      ),
      onChanged: (value) {
        context.read<BusLocationFetchBloc>().add(
          SearchLocations(query: value.trim()),
        );
      },
    );
  }

  Widget _buildSuggestionsList(
    BuildContext context,
    BusLocationFetchState state,
    ThemeData theme,
    ColorScheme colorScheme,
  ) {
    final suggestions = state.filteredCities ?? state.allCitydata?.cities ?? [];

    if (suggestions.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.location_searching,
              size: 64,
              color: colorScheme.primary.withOpacity(0.5),
            ),
            const SizedBox(height: 16),
            Text(
              'No locations found',
              style: theme.textTheme.titleMedium?.copyWith(
                color: colorScheme.onSurface.withOpacity(0.7),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              _controller.text.isEmpty
                  ? 'Loading available locations...'
                  : 'Try a different search term',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: colorScheme.onSurface.withOpacity(0.5),
              ),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      shrinkWrap: true,
      itemCount: suggestions.length,
      itemBuilder: (context, index) {
        final location = suggestions[index];
        return Card(
          margin: const EdgeInsets.only(bottom: 8),
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: InkWell(
            borderRadius: BorderRadius.circular(12),
            onTap: () => _handleLocationSelection(context, location),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: colorScheme.primary.withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(Icons.location_on, color: colorScheme.primary),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          location.name,
                          style: theme.textTheme.bodyLarge?.copyWith(
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                          ),
                        ),
                        ...[
                          // const SizedBox(height: 4),
                          Text(
                            location.state,
                            style: theme.textTheme.bodySmall?.copyWith(
                              fontSize: 12,
                              color: colorScheme.onSurface.withOpacity(0.5),
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                  Icon(
                    Icons.chevron_right,
                    color: colorScheme.onSurface.withOpacity(0.3),
                  ),
                ],
              ),
            ),
          ),
        );
      },
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
