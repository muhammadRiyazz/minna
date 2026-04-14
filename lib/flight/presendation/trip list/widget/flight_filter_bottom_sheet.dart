import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:minna/comman/const/const.dart';
import 'package:minna/flight/domain/trip%20resp/trip_respo.dart';

class FlightFilterBottomSheet extends StatefulWidget {
  final List<FlightOptionElement> allFlights;
  final Function(double? min, double? max, List<int> stops, List<String> airlines, List<int> times) onApply;
  final VoidCallback onReset;

  const FlightFilterBottomSheet({
    super.key,
    required this.allFlights,
    required this.onApply,
    required this.onReset,
  });

  @override
  State<FlightFilterBottomSheet> createState() => _FlightFilterBottomSheetState();
}

class _FlightFilterBottomSheetState extends State<FlightFilterBottomSheet> {
  late double _minPrice;
  late double _maxPrice;
  late double _currentMinPrice;
  late double _currentMaxPrice;

  final List<int> _selectedStops = [];
  final List<String> _selectedAirlines = [];
  final List<int> _selectedTimes = [];
  late List<String> _availableAirlines;

  @override
  void initState() {
    super.initState();
    _calculateInitialValues();
  }

  void _calculateInitialValues() {
    if (widget.allFlights.isEmpty) {
      _minPrice = 0;
      _maxPrice = 100000;
      _availableAirlines = [];
    } else {
      final prices = widget.allFlights.map((f) => f.selectedFare?.aprxTotalAmount ?? 0).toList();
      _minPrice = prices.reduce((a, b) => a < b ? a : b);
      _maxPrice = prices.reduce((a, b) => a > b ? a : b);
      _availableAirlines = widget.allFlights.map((f) => f.ticketingCarrier ?? '').where((c) => c.isNotEmpty).toSet().toList();
    }
    _currentMinPrice = _minPrice;
    _currentMaxPrice = _maxPrice;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 12),
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.3),
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(24, 16, 16, 16),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: secondaryColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(Iconsax.filter_edit, color: secondaryColor, size: 20),
                ),
                const SizedBox(width: 16),
                Text(
                  'Filter Flights',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w900,
                    color: maincolor1,
                    letterSpacing: -0.5,
                  ),
                ),
                const Spacer(),
                IconButton(
                  icon: Icon(Icons.close_rounded, color: textSecondary, size: 20),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
          ),
          const Divider(height: 1),
          Flexible(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSectionHeader('PRICE RANGE', Iconsax.money_send),
                  const SizedBox(height: 24),
                  RangeSlider(
                    values: RangeValues(_currentMinPrice, _currentMaxPrice),
                    min: _minPrice,
                    max: _maxPrice == _minPrice ? _maxPrice + 1 : _maxPrice,
                    activeColor: secondaryColor,
                    inactiveColor: secondaryColor.withOpacity(0.1),
                    onChanged: (values) {
                      setState(() {
                        _currentMinPrice = values.start;
                        _currentMaxPrice = values.end;
                      });
                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('₹${_currentMinPrice.toStringAsFixed(0)}', style: _valueStyle),
                      Text('₹${_currentMaxPrice.toStringAsFixed(0)}', style: _valueStyle),
                    ],
                  ),
                  const SizedBox(height: 32),
                  _buildSectionHeader('STOPS', Iconsax.grammerly),
                  const SizedBox(height: 16),
                  Wrap(
                    spacing: 12,
                    children: [
                      _buildFilterChip('Non-stop', 0, _selectedStops),
                      _buildFilterChip('1 Stop', 1, _selectedStops),
                      _buildFilterChip('2+ Stops', 2, _selectedStops),
                    ],
                  ),
                  const SizedBox(height: 32),
                  _buildSectionHeader('DEPARTURE TIME', Iconsax.timer_1),
                  const SizedBox(height: 16),
                  GridView.count(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: 2,
                    childAspectRatio: 2.5,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                    children: [
                      _buildTimeOption('Early Morning', '00-06', Iconsax.sun_1, 0),
                      _buildTimeOption('Morning', '06-12', Iconsax.cloud_sunny, 1),
                      _buildTimeOption('Afternoon', '12-18', Iconsax.cloud, 2),
                      _buildTimeOption('Evening/Night', '18-24', Iconsax.moon, 3),
                    ],
                  ),
                  const SizedBox(height: 32),
                  _buildSectionHeader('AIRLINES', Iconsax.airplane),
                  const SizedBox(height: 16),
                  Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: _availableAirlines.map((airline) => _buildAirlineChip(airline)).toList(),
                  ),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(24, 16, 24, 24 + MediaQuery.of(context).padding.bottom),
            decoration: BoxDecoration(
              color: cardColor,
              boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 20, offset: const Offset(0, -5))],
            ),
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: TextButton(
                    onPressed: () {
                      widget.onReset();
                      Navigator.pop(context);
                    },
                    child: Text('Reset All', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w800, color: textSecondary)),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  flex: 3,
                  child: ElevatedButton(
                    onPressed: () {
                      widget.onApply(_currentMinPrice, _currentMaxPrice, _selectedStops, _selectedAirlines, _selectedTimes);
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: secondaryColor,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                      elevation: 0,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(Iconsax.tick_circle, size: 18),
                        SizedBox(width: 8),
                        Text('Apply Filters', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w900)),
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

  Widget _buildSectionHeader(String title, IconData icon) {
    return Row(
      children: [
        Icon(icon, size: 14, color: textSecondary.withOpacity(0.5)),
        const SizedBox(width: 8),
        Text(
          title,
          style: TextStyle(fontSize: 9, fontWeight: FontWeight.w900, color: textSecondary.withOpacity(0.6), letterSpacing: 1.2),
        ),
      ],
    );
  }

  TextStyle get _valueStyle => TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: maincolor1);

  Widget _buildFilterChip(String label, int value, List<int> group) {
    bool isSelected = group.contains(value);
    return GestureDetector(
      onTap: () => setState(() => isSelected ? group.remove(value) : group.add(value)),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? secondaryColor : Colors.transparent,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: isSelected ? secondaryColor : textSecondary.withOpacity(0.15)),
        ),
        child: Text(
          label,
          style: TextStyle(fontSize: 11, fontWeight: isSelected ? FontWeight.w900 : FontWeight.w700, color: isSelected ? Colors.white : maincolor1),
        ),
      ),
    );
  }

  Widget _buildAirlineChip(String airline) {
    bool isSelected = _selectedAirlines.contains(airline);
    return GestureDetector(
      onTap: () => setState(() => isSelected ? _selectedAirlines.remove(airline) : _selectedAirlines.add(airline)),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? maincolor1 : backgroundColor.withOpacity(0.3),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: isSelected ? maincolor1 : textSecondary.withOpacity(0.1)),
        ),
        child: Text(
          airline,
          style: TextStyle(fontSize: 10, fontWeight: isSelected ? FontWeight.w800 : FontWeight.w600, color: isSelected ? Colors.white : textPrimary),
        ),
      ),
    );
  }

  Widget _buildTimeOption(String label, String time, IconData icon, int index) {
    bool isSelected = _selectedTimes.contains(index);
    return GestureDetector(
      onTap: () => setState(() => isSelected ? _selectedTimes.remove(index) : _selectedTimes.add(index)),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
          color: isSelected ? secondaryColor : backgroundColor.withOpacity(0.3),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: isSelected ? secondaryColor : backgroundColor.withOpacity(0.5)),
        ),
        child: Row(
          children: [
            Icon(icon, size: 16, color: isSelected ? Colors.white : textSecondary),
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(label, style: TextStyle(fontSize: 9, fontWeight: FontWeight.w800, color: isSelected ? Colors.white : maincolor1), maxLines: 1, overflow: TextOverflow.ellipsis),
                  Text(time, style: TextStyle(fontSize: 7, fontWeight: FontWeight.w600, color: isSelected ? Colors.white.withOpacity(0.8) : textSecondary)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
