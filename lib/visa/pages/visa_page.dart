import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minna/comman/application/home_data/home_data_bloc.dart';
import 'package:minna/comman/application/home_data/home_data_event.dart';
import 'package:minna/comman/application/home_data/home_data_state.dart';
import 'package:minna/comman/application/home_data/visa_model.dart';
import 'package:shimmer/shimmer.dart';
import 'package:url_launcher/url_launcher.dart';

class VisaPage extends StatefulWidget {
  const VisaPage({super.key});

  @override
  State<VisaPage> createState() => _VisaPageState();
}

class _VisaPageState extends State<VisaPage> {
  // Theme Colors - Matching home.dart (106-115)
  final Color _primaryColor = Colors.black;
  final Color _secondaryColor = Color(0xFFD4AF37); // Gold
  final Color _accentColor = Color(0xFFC19B3C); // Darker Gold
  final Color _backgroundColor = Color(0xFFF8F9FA);
  final Color _cardColor = Colors.white;
  final Color _textPrimary = Colors.black;
  final Color _textSecondary = Color(0xFF666666);

  final TextEditingController _searchController = TextEditingController();
  final String _supportPhoneNumber =
      '+919876543210'; // Replace with actual support number

  List<VisaModel> _allVisas = [];
  List<VisaModel> _filteredVisas = [];

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
    // Explicitly fetch if not already loaded, though it's likely loaded by main home
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
            SnackBar(
              content: Text('Could not make phone call'),
              backgroundColor: Colors.red,
            ),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e'), backgroundColor: Colors.red),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _backgroundColor,
      appBar: AppBar(
        backgroundColor: _primaryColor,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          'Apply for Visa Online',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: false,
      ),
      body: Column(
        children: [
          // Search Bar
          Padding(
            padding: EdgeInsets.all(16),
            child: Container(
              decoration: BoxDecoration(
                color: _cardColor,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'Where are you going?',
                  hintStyle: TextStyle(color: _textSecondary),
                  prefixIcon: Icon(Icons.search, color: _textSecondary),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 10,
                  ),
                ),
              ),
            ),
          ),

          // Service Highlights
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 6, horizontal: 6),
                    decoration: BoxDecoration(
                      color: _secondaryColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.check_circle,
                          color: _secondaryColor,
                          size: 18,
                        ),
                        SizedBox(width: 8),
                        Flexible(
                          child: Text(
                            '99.3% Approval Rate',
                            style: TextStyle(
                              color: _textPrimary,
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 6, horizontal: 6),
                    decoration: BoxDecoration(
                      color: _secondaryColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.check_circle,
                          color: _secondaryColor,
                          size: 18,
                        ),
                        SizedBox(width: 8),
                        Flexible(
                          child: Text(
                            '24x7 Customer Service',
                            style: TextStyle(
                              color: _textPrimary,
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: 10),

          // Most-visited Countries Title
          BlocBuilder<HomeDataBloc, HomeDataState>(
            builder: (context, state) {
              if (state.isVisaLoading) {
                return _buildShimmerTitle();
              }

              // Only update source if we have new data and aren't searching
              if (state.visaCountries != null &&
                  _searchController.text.isEmpty) {
                _allVisas = state.visaCountries!;
                _filteredVisas = List.from(_allVisas);
              }

              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Visas Available',
                      style: TextStyle(
                        color: _textPrimary,
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '${_filteredVisas.length} countries',
                      style: TextStyle(color: _textSecondary, fontSize: 14),
                    ),
                  ],
                ),
              );
            },
          ),

          SizedBox(height: 10),

          // Countries List
          Expanded(
            child: BlocBuilder<HomeDataBloc, HomeDataState>(
              builder: (context, state) {
                if (state.isVisaLoading) {
                  return ListView.builder(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    itemCount: 5,
                    itemBuilder: (context, index) {
                      return _buildShimmerCard();
                    },
                  );
                }

                if (_filteredVisas.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.search_off, size: 60, color: _textSecondary),
                        SizedBox(height: 16),
                        Text(
                          'No visas found',
                          style: TextStyle(color: _textSecondary, fontSize: 16),
                        ),
                      ],
                    ),
                  );
                }

                return ListView.builder(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  itemCount: _filteredVisas.length,
                  itemBuilder: (context, index) {
                    return _buildCountryCard(_filteredVisas[index]);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildShimmerTitle() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Shimmer.fromColors(
            baseColor: Colors.grey.shade300,
            highlightColor: Colors.grey.shade100,
            child: Container(height: 16, width: 120, color: Colors.white),
          ),
          Shimmer.fromColors(
            baseColor: Colors.grey.shade300,
            highlightColor: Colors.grey.shade100,
            child: Container(height: 16, width: 80, color: Colors.white),
          ),
        ],
      ),
    );
  }

  Widget _buildShimmerCard() {
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      height: 150,
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.04), // subtle gray
        borderRadius: BorderRadius.circular(16),
      ),
      child: Shimmer.fromColors(
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.grey.shade100,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
          ),
        ),
      ),
    );
  }

  Widget _buildCountryCard(VisaModel visa) {
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: _cardColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 12,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Country Header
            Row(
              children: [
                // Flag
                if (visa.flag.isNotEmpty)
                  Container(
                    padding: EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: _backgroundColor,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(visa.flag, style: TextStyle(fontSize: 24)),
                  ),
                if (visa.flag.isNotEmpty) SizedBox(width: 10),
                // Country Name
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        visa.name,
                        style: TextStyle(
                          color: _textPrimary,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 4),
                      Text(
                        'Get your visa by ${visa.deliveryDate}',
                        style: TextStyle(
                          color: _secondaryColor,
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                // Visa Type Badge
                if (visa.visaType.isNotEmpty)
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                    decoration: BoxDecoration(
                      color: _secondaryColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: _secondaryColor.withOpacity(0.3),
                        width: 1,
                      ),
                    ),
                    child: Text(
                      visa.visaType,
                      style: TextStyle(
                        color: _secondaryColor,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
              ],
            ),

            SizedBox(height: 8),

            // Highlights
            Wrap(
              spacing: 8,
              runSpacing: 6,
              children: [
                if (visa.highlight.isNotEmpty)
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: _backgroundColor,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.shield, size: 12, color: _secondaryColor),
                        SizedBox(width: 4),
                        Text(
                          visa.highlight,
                          style: TextStyle(
                            color: _textPrimary,
                            fontSize: 11,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                if (visa.stats.isNotEmpty)
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: _backgroundColor,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.people, size: 12, color: _secondaryColor),
                        SizedBox(width: 4),
                        Text(
                          visa.stats,
                          style: TextStyle(
                            color: _textPrimary,
                            fontSize: 11,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),

            SizedBox(height: 12),

            // Pricing and Button Row
            Row(
              children: [
                // Pricing Info
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Total Price',
                        style: TextStyle(color: _textSecondary, fontSize: 12),
                      ),
                      SizedBox(height: 2),
                      Builder(
                        builder: (context) {
                          double basePrice = double.tryParse(visa.price) ?? 0;
                          double serviceFee =
                              double.tryParse(visa.serviceFee) ?? 0;
                          double total = basePrice + serviceFee;
                          return Text(
                            '₹ $total',
                            style: TextStyle(
                              color: _textPrimary,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          );
                        },
                      ),
                      SizedBox(height: 2),
                      Text(
                        'Visa: ₹${visa.price} + Fees: ₹${visa.serviceFee}',
                        style: TextStyle(color: _textSecondary, fontSize: 10),
                      ),
                    ],
                  ),
                ),

                // Connect Button - Smaller size
                SizedBox(
                  width: 140,
                  child: ElevatedButton.icon(
                    onPressed: _makePhoneCall,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _primaryColor,
                      foregroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 12,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      elevation: 2,
                    ),
                    icon: Icon(Icons.phone_rounded, size: 16),
                    label: Text(
                      'Connect',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
