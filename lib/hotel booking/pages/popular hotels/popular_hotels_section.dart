import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shimmer/shimmer.dart';
import 'package:minna/comman/const/const.dart';
import 'package:minna/hotel%20booking/domain/models/popular_hotel_model.dart';
import 'package:minna/hotel%20booking/functions/hotel_details.dart';
import 'package:minna/hotel%20booking/functions/popular_hotels_service.dart';
import 'package:minna/hotel%20booking/pages/holel%20home%20page/home_page_hotel.dart';

class PopularHotelsSection extends StatefulWidget {
  const PopularHotelsSection({super.key});

  @override
  State<PopularHotelsSection> createState() => _PopularHotelsSectionState();
}

class _PopularHotelsSectionState extends State<PopularHotelsSection> {
  final PopularHotelsService _service = PopularHotelsService();
  final HotelDetailsApiService _detailsService = HotelDetailsApiService();

  List<PopularHotelsByCity> _citiesData = [];
  bool _isLoading = true;
  int _selectedCityIndex = 0;

  // Cache fetched images: hotelCode -> imageUrl
  final Map<String, String> _imageCache = {};
  final Set<String> _fetchingCodes = {};

  @override
  void initState() {
    super.initState();
    _loadHotels();
  }

  Future<void> _loadHotels() async {
    final data = await _service.fetchPopularHotels();
    if (mounted) {
      setState(() {
        _citiesData = data;
        _isLoading = false;
      });
      // Eagerly fetch images for first city
      if (data.isNotEmpty) {
        _fetchImagesForCity(0);
      }
    }
  }

  Future<void> _fetchImagesForCity(int cityIndex) async {
    if (cityIndex >= _citiesData.length) return;
    final hotels = _citiesData[cityIndex].hotels;
    for (final hotel in hotels) {
      if (hotel.image.isEmpty &&
          !_imageCache.containsKey(hotel.hotelCode) &&
          !_fetchingCodes.contains(hotel.hotelCode)) {
        _fetchingCodes.add(hotel.hotelCode);
        _fetchHotelImage(hotel);
      }
    }
  }

  Future<void> _fetchHotelImage(PopularHotel hotel) async {
    try {
      final details = await _detailsService.fetchHotelDetails(hotel.hotelCode);
      String imageUrl = 'none';
      if (details.hotelDetails.isNotEmpty &&
          details.hotelDetails.first.images.isNotEmpty) {
        imageUrl = details.hotelDetails.first.images.first;
      }
      if (mounted) {
        setState(() {
          _imageCache[hotel.hotelCode] = imageUrl;
          hotel.image = imageUrl;
        });
      }
    } catch (e) {
      log('Image fetch error for ${hotel.hotelCode}: $e');
      if (mounted) {
        setState(() {
          _imageCache[hotel.hotelCode] = 'none';
        });
      }
    } finally {
      _fetchingCodes.remove(hotel.hotelCode);
    }
  }

  void _onCitySelected(int index) {
    setState(() => _selectedCityIndex = index);
    _fetchImagesForCity(index);
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) return _buildShimmer();
    if (_citiesData.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ── Section Header ──────────────────────────────
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'POPULAR HOTELS',
                    style: GoogleFonts.lato(
                      color: secondaryColor.withValues(alpha: 0.85),
                      fontSize: 10,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 2,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Top Stays by City',
                    style: TextStyle(
                      color: maincolor1,
                      fontSize: 18,
                      fontWeight: FontWeight.w900,
                      letterSpacing: -0.5,
                    ),
                  ),
                ],
              ),
              GestureDetector(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const HotelBookingHome()),
                ),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: maincolor1,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    'View All',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // ── City Tabs ────────────────────────────────────
        SizedBox(
          height: 34,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            itemCount: _citiesData.length,
            separatorBuilder: (_, __) => const SizedBox(width: 8),
            itemBuilder: (context, index) {
              final isSelected = index == _selectedCityIndex;
              return GestureDetector(
                onTap: () => _onCitySelected(index),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 250),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: isSelected ? maincolor1 : Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: isSelected
                          ? maincolor1
                          : Colors.grey.withValues(alpha: 0.25),
                    ),
                    boxShadow: isSelected
                        ? [
                            BoxShadow(
                              color: maincolor1.withValues(alpha: 0.25),
                              blurRadius: 8,
                              offset: const Offset(0, 3),
                            ),
                          ]
                        : [],
                  ),
                  child: Text(
                    _citiesData[index].cityName,
                    style: TextStyle(
                      color: isSelected ? Colors.white : textSecondary,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 14),

        // ── Hotel Cards ──────────────────────────────────
        SizedBox(
          height: 220,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            itemCount: _citiesData[_selectedCityIndex].hotels.length,
            separatorBuilder: (_, __) => const SizedBox(width: 14),
            itemBuilder: (context, index) {
              final hotel = _citiesData[_selectedCityIndex].hotels[index];
              final imageUrl = _imageCache[hotel.hotelCode] ?? hotel.image;
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: _HotelCard(hotel: hotel, imageUrl: imageUrl),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildShimmer() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Shimmer.fromColors(
            baseColor: Colors.grey[200]!,
            highlightColor: Colors.grey[100]!,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 110,
                  height: 10,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  width: 170,
                  height: 18,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 14),
        // City tab shimmer
        SizedBox(
          height: 34,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            itemCount: 5,
            separatorBuilder: (_, __) => const SizedBox(width: 8),
            itemBuilder: (_, __) => Shimmer.fromColors(
              baseColor: Colors.grey[200]!,
              highlightColor: Colors.grey[100]!,
              child: Container(
                width: 70,
                height: 34,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 14),
        // Cards shimmer
        SizedBox(
          height: 210,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            itemCount: 4,
            separatorBuilder: (_, __) => const SizedBox(width: 14),
            itemBuilder: (_, __) => Shimmer.fromColors(
              baseColor: Colors.grey[200]!,
              highlightColor: Colors.grey[100]!,
              child: Container(
                width: 160,
                height: 210,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

// ── Individual Hotel Card ─────────────────────────────────────────────────────

class _HotelCard extends StatelessWidget {
  final PopularHotel hotel;
  final String imageUrl;

  const _HotelCard({required this.hotel, required this.imageUrl});

  static const List<List<Color>> _fallbackGradients = [
    [Color(0xFF003875), Color(0xFF0062B1)],
    [Color(0xFF1A6B4A), Color(0xFF2E9E6F)],
    [Color(0xFF7B3F00), Color(0xFFBD6B1E)],
    [Color(0xFF2C2C54), Color(0xFF474787)],
    [Color(0xFF6A0572), Color(0xFFAA18AA)],
  ];

  List<Color> get _gradient =>
      _fallbackGradients[hotel.hotelCode.hashCode.abs() %
          _fallbackGradients.length];

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const HotelBookingHome()),
      ),
      child: Container(
        width: 160,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.08),
              blurRadius: 14,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Image with overlay badges ──────────────────
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(18),
                  ),
                  child: SizedBox(
                    height: 125,
                    width: double.infinity,
                    child: _buildImageWidget(imageUrl),
                  ),
                ),
                // Star rating badge — bottom-left
                Positioned(
                  bottom: 8,
                  left: 8,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 7,
                      vertical: 3,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha: 0.55),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.star_rounded,
                          color: Color(0xFFFFC107),
                          size: 11,
                        ),
                        const SizedBox(width: 3),
                        Text(
                          '${hotel.starCount} Star',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 9,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            // ── Info section ───────────────────────────────
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(11, 9, 11, 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      hotel.hotelName,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Color(0xFF003875),
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        height: 1.35,
                      ),
                    ),
                    const SizedBox(height: 6),
                    // Location row
                    Row(
                      children: [
                        Icon(
                          Iconsax.location,
                          size: 11,
                          color: maincolor1.withValues(alpha: 0.7),
                        ),
                        const SizedBox(width: 4),
                        Expanded(
                          child: Text(
                            hotel.cityName,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: textSecondary,
                              fontSize: 10,
                              fontWeight: FontWeight.w500,
                            ),
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

  Widget _buildImageWidget(String url) {
    if (url.isEmpty) {
      return Shimmer.fromColors(
        baseColor: Colors.grey[200]!,
        highlightColor: Colors.grey[100]!,
        child: Container(color: Colors.white),
      );
    }
    if (url == 'none') return _buildFallbackImage();
    return Image.network(
      url,
      fit: BoxFit.cover,
      errorBuilder: (_, __, ___) => _buildFallbackImage(),
      loadingBuilder: (context, child, progress) {
        if (progress == null) return child;
        return Shimmer.fromColors(
          baseColor: Colors.grey[200]!,
          highlightColor: Colors.grey[100]!,
          child: Container(color: Colors.white),
        );
      },
    );
  }

  Widget _buildFallbackImage() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: _gradient,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Center(
        child: Icon(Iconsax.building, color: Colors.white38, size: 38),
      ),
    );
  }
}
