import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minna/comman/application/home_data/home_data_bloc.dart';
import 'package:minna/comman/application/home_data/home_data_event.dart';
import 'package:minna/comman/application/home_data/home_data_state.dart';
import 'package:minna/comman/application/home_data/visa_model.dart';
import 'package:shimmer/shimmer.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:minna/comman/const/const.dart';
import 'package:iconsax/iconsax.dart';

class VisaPage extends StatefulWidget {
  const VisaPage({super.key});

  @override
  State<VisaPage> createState() => _VisaPageState();
}

class _VisaPageState extends State<VisaPage> {
  final TextEditingController _searchController = TextEditingController();
  final String _supportPhoneNumber =
      '+919876543210'; // Replace with actual support number

  List<VisaModel> _allVisas = [];
  List<VisaModel> _filteredVisas = [];

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
    context.read<HomeDataBloc>().add(const FetchVisaCountries());
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    setState(() {
      final query = _searchController.text.toLowerCase();
      if (query.isEmpty) {
        _filteredVisas = List.from(_allVisas);
      } else {
        _filteredVisas = _allVisas.where((visa) {
          return visa.name.toLowerCase().contains(query);
        }).toList();
      }
    });
  }

  Future<void> _makePhoneCall() async {
    final Uri phoneUri = Uri(scheme: 'tel', path: _supportPhoneNumber);
    try {
      if (await canLaunchUrl(phoneUri)) {
        await launchUrl(phoneUri);
      } else {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Could not make phone call'),
              backgroundColor: errorColor,
            ),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e'), backgroundColor: errorColor),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          // Premium Sliver App Bar
          SliverAppBar(
            expandedHeight: 150.0,
            floating: false,
            pinned: true,
            backgroundColor: maincolor1,
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
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Image.network(
                    'https://images.unsplash.com/photo-1436491865332-7a61a109cc05?auto=format&fit=crop&q=80&w=1000',
                    fit: BoxFit.cover,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          maincolor1.withOpacity(0.2),
                          maincolor1.withOpacity(0.4),
                          maincolor1,
                        ],
                        stops: const [0.0, 0.5, 1.0],
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 70,
                    left: 20,
                    right: 20,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "GLOBAL ACCESS",
                          style: TextStyle(
                            color: secondaryColor,
                            fontSize: 10,
                            fontWeight: FontWeight.w900,
                            letterSpacing: 2,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          "Apply for Visa Online",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.w900,
                            shadows: [
                              Shadow(
                                color: Colors.black.withOpacity(0.3),
                                offset: const Offset(0, 2),
                                blurRadius: 4,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          // // Floating Search Bar Section
          // SliverToBoxAdapter(
          //   child: Transform.translate(
          //     offset: const Offset(0, -0),
          //     child: Padding(
          //       padding: const EdgeInsets.symmetric(horizontal: 20),
          //       child: Container(
          //         decoration: BoxDecoration(
          //           color: cardColor,
          //           borderRadius: BorderRadius.circular(24),
          //           boxShadow: [
          //             BoxShadow(
          //               color: maincolor1.withOpacity(0.12),
          //               blurRadius: 30,
          //               offset: const Offset(0, 15),
          //             ),
          //           ],
          //           border: Border.all(
          //             color: Colors.grey.withOpacity(0.05),
          //             width: 1.5,
          //           ),
          //         ),
          //         child: TextField(
          //           controller: _searchController,
          //           style: const TextStyle(
          //             color: textPrimary,
          //             fontWeight: FontWeight.w700,
          //             fontSize: 16,
          //           ),
          //           decoration: InputDecoration(
          //             hintText: 'Where are you going?',
          //             hintStyle: TextStyle(
          //               color: textLight.withOpacity(0.6),
          //               fontWeight: FontWeight.w500,
          //             ),
          //             prefixIcon: const Icon(
          //               Iconsax.search_normal_1,
          //               color: secondaryColor,
          //               size: 20,
          //             ),
          //             border: InputBorder.none,
          //             contentPadding: const EdgeInsets.symmetric(
          //               horizontal: 16,
          //               vertical: 18,
          //             ),
          //           ),
          //         ),
          //       ),
          //     ),
          //   ),
          // ),
          // Trust Highlights Section
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  SizedBox(height: 20),
                  SizedBox(height: 20),

                  Row(
                    children: [
                      _buildFeatureChip(Iconsax.verify, "99.3% Approval Rate"),
                      const SizedBox(width: 12),
                      _buildFeatureChip(Iconsax.headphone, "24x7 Assistance"),
                    ],
                  ),
                ],
              ),
            ),
          ),

          const SliverToBoxAdapter(child: SizedBox(height: 24)),

          // Visas Available Header
          SliverToBoxAdapter(
            child: BlocBuilder<HomeDataBloc, HomeDataState>(
              builder: (context, state) {
                if (state.visaCountries != null &&
                    _searchController.text.isEmpty) {
                  _allVisas = state.visaCountries!;
                  _filteredVisas = List.from(_allVisas);
                }

                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'AVAILABLE VISAS',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w900,
                          color: textLight,
                          letterSpacing: 1,
                        ),
                      ),
                      Text(
                        '${_filteredVisas.length} countries',
                        style: const TextStyle(
                          color: secondaryColor,
                          fontSize: 12,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),

          const SliverToBoxAdapter(child: SizedBox(height: 16)),

          // Countries List
          BlocBuilder<HomeDataBloc, HomeDataState>(
            builder: (context, state) {
              if (state.isVisaLoading) {
                return SliverPadding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  sliver: SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) => _buildShimmerCard(),
                      childCount: 3,
                    ),
                  ),
                );
              }

              if (_filteredVisas.isEmpty) {
                return SliverFillRemaining(
                  hasScrollBody: false,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(24),
                          decoration: BoxDecoration(
                            color: secondaryColor.withOpacity(0.08),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Iconsax.search_status,
                            size: 56,
                            color: secondaryColor,
                          ),
                        ),
                        const SizedBox(height: 20),
                        const Text(
                          'No visas found',
                          style: TextStyle(
                            color: textSecondary,
                            fontSize: 16,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }

              return SliverPadding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) =>
                        _buildCountryCard(_filteredVisas[index]),
                    childCount: _filteredVisas.length,
                  ),
                ),
              );
            },
          ),

          const SliverToBoxAdapter(child: SizedBox(height: 40)),
        ],
      ),
    );
  }

  Widget _buildFeatureChip(IconData icon, String label) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        decoration: BoxDecoration(
          color: secondaryColor.withOpacity(0.08),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: secondaryColor.withOpacity(0.15)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: secondaryColor, size: 16),
            const SizedBox(width: 8),
            Flexible(
              child: Text(
                label,
                style: const TextStyle(
                  color: maincolor1,
                  fontSize: 10,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 0.2,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildShimmerCard() {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      height: 180,
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(28),
        border: Border.all(color: borderSoft),
      ),
      child: Shimmer.fromColors(
        baseColor: Colors.grey[200]!,
        highlightColor: Colors.grey[100]!,
        child: Column(
          children: [
            Container(
              height: 80,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(16),
              child: Row(
                children: [
                  CircleAvatar(radius: 20, backgroundColor: Colors.white),
                  SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      children: [
                        Container(height: 12, color: Colors.white),
                        SizedBox(height: 6),
                        Container(height: 10, color: Colors.white),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCountryCard(VisaModel visa) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: maincolor1.withOpacity(0.06),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
          BoxShadow(
            color: Colors.black.withOpacity(0.01),
            blurRadius: 1,
            offset: const Offset(0, 1),
          ),
        ],
        border: Border.all(color: Colors.grey.withOpacity(0.05)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Country Header Row
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                // Flag Container
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: secondaryColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Text(
                    visa.flag.isNotEmpty ? visa.flag : '🌐',
                    style: const TextStyle(fontSize: 24),
                  ),
                ),
                const SizedBox(width: 16),
                // Titles
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        visa.name.toUpperCase(),
                        style: const TextStyle(
                          color: maincolor1,
                          fontSize: 14,
                          fontWeight: FontWeight.w900,
                          letterSpacing: 0.5,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          const Icon(
                            Iconsax.calendar_tick,
                            size: 12,
                            color: secondaryColor,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            'Delivery by ${visa.deliveryDate}',
                            style: const TextStyle(
                              color: textSecondary,
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                // Visa Type Badge
                if (visa.visaType.isNotEmpty)
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: maincolor1,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      visa.visaType.toUpperCase(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 8,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
              ],
            ),
          ),

          // Info Badges
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                if (visa.highlight.isNotEmpty)
                  _buildBadge(Iconsax.shield_tick, visa.highlight),
                if (visa.stats.isNotEmpty)
                  _buildBadge(Iconsax.people, visa.stats),
              ],
            ),
          ),

          const SizedBox(height: 20),

          // Pricing & Action Bar
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: backgroundColor.withOpacity(0.6),
              borderRadius: const BorderRadius.vertical(
                bottom: Radius.circular(28),
              ),
              border: Border(
                top: BorderSide(color: maincolor1.withOpacity(0.05)),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "TOTAL PRICE",
                      style: TextStyle(
                        fontSize: 8,
                        color: textSecondary,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 1,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Builder(
                      builder: (context) {
                        double total =
                            (double.tryParse(visa.price) ?? 0) +
                            (double.tryParse(visa.serviceFee) ?? 0);
                        return Text(
                          "₹${total.toStringAsFixed(0)}",
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w900,
                            color: maincolor1,
                            letterSpacing: -0.5,
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 2),
                    Text(
                      "Visa: ₹${visa.price} • Fee: ₹${visa.serviceFee}",
                      style: const TextStyle(
                        color: textLight,
                        fontSize: 9,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                GestureDetector(
                  onTap: _makePhoneCall,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 16,
                    ),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [maincolor1, Color(0xFF004D9D)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(18),
                      boxShadow: [
                        BoxShadow(
                          color: maincolor1.withOpacity(0.3),
                          blurRadius: 15,
                          offset: const Offset(0, 8),
                        ),
                      ],
                    ),
                    child: Row(
                      children: const [
                        // Text(
                        //   "CONNECT",
                        //   style: TextStyle(
                        //     color: Colors.white,
                        //     fontSize: 12,
                        //     fontWeight: FontWeight.w900,
                        //     letterSpacing: 1,
                        //   ),
                        // ),
                        // const SizedBox(width: 8),
                        const Icon(
                          Iconsax.call_calling,
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
    );
  }

  Widget _buildBadge(IconData icon, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: secondaryColor.withOpacity(0.06),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: secondaryColor.withOpacity(0.12)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 12, color: secondaryColor),
          const SizedBox(width: 6),
          Text(
            label,
            style: const TextStyle(
              color: maincolor1,
              fontSize: 10,
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
    );
  }
}
