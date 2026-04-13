import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../application/home_data/destination_model.dart';

class AllDestinationsPage extends StatefulWidget {
  final List<DestinationModel> destinations;
  final Color primaryColor;
  final Color secondaryColor;
  final Color backgroundColor;
  final Color cardColor;
  final Color textPrimary;
  final Color textSecondary;
  final Color textLight;

  const AllDestinationsPage({
    super.key,
    required this.destinations,
    required this.primaryColor,
    required this.secondaryColor,
    required this.backgroundColor,
    required this.cardColor,
    required this.textPrimary,
    required this.textSecondary,
    required this.textLight,
  });

  @override
  State<AllDestinationsPage> createState() => _AllDestinationsPageState();
}

class _AllDestinationsPageState extends State<AllDestinationsPage> {
  late List<DestinationModel> filteredDestinations;
  String searchQuery = "";

  @override
  void initState() {
    super.initState();
    filteredDestinations = widget.destinations;
  }

  void _filterDestinations(String query) {
    setState(() {
      searchQuery = query;
      filteredDestinations = widget.destinations
          .where((d) =>
              d.title.toLowerCase().contains(query.toLowerCase()) ||
              d.location.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: widget.backgroundColor,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          _buildSliverAppBar(),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 24, 20, 8),
              child: Row(
                children: [
                  Container(
                    width: 4,
                    height: 20,
                    decoration: BoxDecoration(
                      color: widget.secondaryColor,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Browse Destinations',
                    style: TextStyle(
                      color: widget.primaryColor,
                      fontSize: 18,
                      fontWeight: FontWeight.w900,
                      letterSpacing: -0.5,
                    ),
                  ),
                ],
              ),
            ),
          ),
          filteredDestinations.isEmpty
              ? SliverFillRemaining(child: _buildNoResults())
              : SliverPadding(
                  padding: const EdgeInsets.fromLTRB(16, 8, 16, 32),
                  sliver: SliverGrid(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.82,
                      mainAxisSpacing: 16,
                      crossAxisSpacing: 16,
                    ),
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        return _buildDestinationGridCard(filteredDestinations[index]);
                      },
                      childCount: filteredDestinations.length,
                    ),
                  ),
                ),
        ],
      ),
    );
  }

  Widget _buildSliverAppBar() {
    return SliverAppBar(
      expandedHeight: 140,
      pinned: true,
      backgroundColor: widget.primaryColor,
      elevation: 0,
      leading: IconButton(
        icon: const Icon(Iconsax.arrow_left_2, color: Colors.white),
        onPressed: () => Navigator.pop(context),
      ),
      flexibleSpace: FlexibleSpaceBar(
        background: Stack(
          fit: StackFit.expand,
          children: [
            Container(color: widget.primaryColor),
            Positioned(
              right: -30,
              top: -30,
              child: Container(
                width: 150,
                height: 150,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.05),
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ],
        ),
      ),
      title: const Text(
        'Popular Destinations',
        style: TextStyle(
          color: Colors.white,
          fontSize: 18,
          fontWeight: FontWeight.w800,
          letterSpacing: -0.5,
        ),
      ),
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: Container(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
          child: Container(
            height: 54,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 15,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: TextField(
              onChanged: _filterDestinations,
              style: TextStyle(color: widget.textPrimary, fontSize: 14),
              decoration: InputDecoration(
                hintText: 'Where do you want to go?',
                hintStyle: TextStyle(
                  color: widget.textLight,
                  fontSize: 14,
                ),
                prefixIcon: Icon(Iconsax.search_normal, color: widget.primaryColor, size: 18),
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(vertical: 18),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDestinationGridCard(DestinationModel destination) {
    return GestureDetector(
      onTap: () => _showDestinationDetailsBottomSheet(context, destination),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(24),
          child: Stack(
            fit: StackFit.expand,
            children: [
              Image.network(
                destination.image,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  color: Colors.grey[100],
                  child: Icon(Iconsax.image, color: Colors.grey[300]),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.black.withOpacity(0.0),
                      Colors.black.withOpacity(0.2),
                      Colors.black.withOpacity(0.85),
                    ],
                    stops: const [0.3, 0.6, 1.0],
                  ),
                ),
              ),
              Positioned(
                top: 10,
                left: 10,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Text(
                    'TRENDING',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 8,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 1,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 12,
                right: 12,
                bottom: 12,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      destination.location.isNotEmpty
                          ? destination.location
                          : destination.title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                        fontWeight: FontWeight.w800,
                        height: 1.2,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        const Text(
                          "INR ",
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 8,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          destination.priceToShow,
                          style: TextStyle(
                            color: widget.secondaryColor,
                            fontSize: 12,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ],
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

  Widget _buildNoResults() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Iconsax.search_status, size: 64, color: widget.textLight.withOpacity(0.2)),
          const SizedBox(height: 20),
          Text(
            'No destinations found',
            style: TextStyle(
              color: widget.textPrimary,
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Try searching for something else',
            style: TextStyle(color: widget.textSecondary, fontSize: 13),
          ),
        ],
      ),
    );
  }

  void _showDestinationDetailsBottomSheet(BuildContext context, DestinationModel destination) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => _buildDestinationDetailsSheet(context, destination),
    );
  }

  Widget _buildDestinationDetailsSheet(BuildContext context, DestinationModel destination) {
    String duration = "Flexible";
    if (destination.title.contains('Nights') || destination.title.contains('Days')) {
      final parts = destination.title.split('\u2013')[0].trim();
      duration = parts.replaceAll(' Nights', 'N').replaceAll(' Days', 'D');
    }

    return Container(
      height: MediaQuery.of(context).size.height * 0.92,
      decoration: BoxDecoration(
        color: widget.backgroundColor,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(40)),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Container(
              width: 50,
              height: 5,
              decoration: BoxDecoration(
                color: widget.textLight.withOpacity(0.2),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          Expanded(
            child: CustomScrollView(
              physics: const BouncingScrollPhysics(),
              slivers: [
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(32),
                          child: Stack(
                            children: [
                              Image.network(
                                destination.image,
                                height: 320,
                                width: double.infinity,
                                fit: BoxFit.cover,
                              ),
                              Positioned(
                                top: 20,
                                right: 20,
                                child: IconButton(
                                  onPressed: () => Navigator.pop(context),
                                  icon: const Icon(Icons.close, color: Colors.white, size: 20),
                                  style: IconButton.styleFrom(
                                    backgroundColor: Colors.black45,
                                    padding: const EdgeInsets.all(12),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 28),
                        Text(
                          destination.title,
                          style: TextStyle(
                            color: widget.primaryColor,
                            fontSize: 26,
                            fontWeight: FontWeight.w900,
                            letterSpacing: -1,
                            height: 1.1,
                          ),
                        ),
                        const SizedBox(height: 20),
                        _buildQuickInfo(duration),
                        const SizedBox(height: 28),
                        Container(
                          padding: const EdgeInsets.all(24),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [widget.primaryColor, widget.primaryColor.withOpacity(0.8)],
                            ),
                            borderRadius: BorderRadius.circular(24),
                            boxShadow: [
                              BoxShadow(
                                color: widget.primaryColor.withOpacity(0.3),
                                blurRadius: 20,
                                offset: const Offset(0, 10),
                              ),
                            ],
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'TOTAL PACKAGE PRICE',
                                      style: TextStyle(
                                        color: Colors.white.withOpacity(0.7),
                                        fontSize: 9,
                                        fontWeight: FontWeight.w800,
                                        letterSpacing: 1,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    FittedBox(
                                      fit: BoxFit.scaleDown,
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        "₹ ${destination.price}",
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 22,
                                          fontWeight: FontWeight.w900,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 16),
                              ElevatedButton(
                                onPressed: () => _launchWhatsApp(),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.white,
                                  foregroundColor: widget.primaryColor,
                                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                                  elevation: 0,
                                ),
                                child: const Text(
                                  'Book Now',
                                  style: TextStyle(fontWeight: FontWeight.w900, fontSize: 14),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 32),
                        if (destination.hotelDetails.isNotEmpty) ...[
                          _buildDetailSection(Iconsax.building_3, 'Premium Accommodation', destination.hotelDetails),
                          const SizedBox(height: 24),
                        ],
                        if (destination.inclusions.isNotEmpty) ...[
                          _buildDetailSection(Iconsax.tick_circle, 'Inclusions', destination.inclusions),
                        ],
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickInfo(String duration) {
    return Row(
      children: [
        _buildInfoChip(Iconsax.clock, duration),
        const SizedBox(width: 12),
        _buildInfoChip(Iconsax.routing, 'Holiday Package'),
      ],
    );
  }

  Widget _buildInfoChip(IconData icon, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: widget.secondaryColor.withOpacity(0.08),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: widget.secondaryColor.withOpacity(0.1)),
      ),
      child: Row(
        children: [
          Icon(icon, size: 16, color: widget.secondaryColor),
          const SizedBox(width: 8),
          Text(
            label,
            style: TextStyle(
              color: widget.secondaryColor,
              fontSize: 12,
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailSection(IconData icon, String title, String content) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: widget.primaryColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, size: 18, color: widget.primaryColor),
            ),
            const SizedBox(width: 12),
            Text(
              title,
              style: TextStyle(
                color: widget.primaryColor,
                fontSize: 17,
                fontWeight: FontWeight.w800,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.black.withOpacity(0.03)),
          ),
          child: Text(
            content,
            style: TextStyle(
              color: widget.textPrimary.withOpacity(0.8),
              fontSize: 14,
              height: 1.6,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }

  void _launchWhatsApp() {
    const String supportNumber = "917511100557";
    final Uri whatsappUri = Uri.parse("https://wa.me/$supportNumber");
    launchUrl(whatsappUri, mode: LaunchMode.externalApplication);
  }
}
