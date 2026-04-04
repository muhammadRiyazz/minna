import 'package:flutter/material.dart';
import 'package:minna/cab/domain/confirm model/confirm_model.dart';
import 'package:minna/comman/pages/main home/home.dart';
import 'package:minna/comman/const/const.dart';
import 'package:iconsax/iconsax.dart';

class CabSuccessPage extends StatelessWidget {
  final BookingConfirmData bookingResponse;

  const CabSuccessPage({super.key, required this.bookingResponse});

  @override
  Widget build(BuildContext context) {
    final data = bookingResponse;

    return WillPopScope(
      onWillPop: () async {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (_) => const HomePage()),
          (route) => false,
        );
        return false;
      },
      child: Scaffold(
        backgroundColor: backgroundColor,
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                maincolor1,
                maincolor1.withOpacity(0.9),
                backgroundColor,
              ],
              stops: const [0.0, 0.3, 0.45],
            ),
          ),
          child: Column(
            children: [
              // Header section
              Container(
                padding: const EdgeInsets.only(top: 80, bottom: 40),
                child: Column(
                  children: [
                    Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.15),
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.white.withOpacity(0.2),
                          width: 2,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 20,
                            spreadRadius: 5,
                          ),
                        ],
                      ),
                      child: Center(
                        child: Container(
                          width: 70,
                          height: 70,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.check_rounded,
                            color: successColor,
                            size: 45,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    const Text(
                      'Booking Confirmed!',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 26,
                        fontWeight: FontWeight.w900,
                        letterSpacing: -0.5,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Your trip has been successfully scheduled',
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.8),
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),

              // Content section
              Expanded(
                child: Container(
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: backgroundColor,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(32),
                      topRight: Radius.circular(32),
                    ),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 32),

                        // ID Section
                        Row(
                          children: [
                            Expanded(
                              child: _buildInfoCard(
                                icon: Iconsax.ticket,
                                title: 'BOOKING ID',
                                value: data.bookingId,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: _buildInfoCard(
                                icon: Iconsax.key,
                                title: 'OTP / CODE',
                                value: data.verificationCode,
                                highlight: true,
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 32),

                        // Date and Time Section
                        _buildSectionHeader('Schedule Details'),
                        const SizedBox(height: 16),
                        _buildDateTimeCard(data.startDate, data.startTime),

                        const SizedBox(height: 32),

                        // Cab Information
                        _buildSectionHeader('Vehicle Information'),
                        const SizedBox(height: 16),
                        _buildCabInfoCard(data.cabRate.cab),

                        const SizedBox(height: 32),

                        // Fare Details
                        _buildSectionHeader('Fare Summary'),
                        const SizedBox(height: 16),
                        _buildFareCard(data),

                        const SizedBox(height: 40),

                        // Action buttons
                        SizedBox(
                          width: double.infinity,
                          height: 60,
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => const HomePage(),
                                ),
                                (route) => false,
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: maincolor1,
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18),
                              ),
                              elevation: 0,
                            ),
                            child: const Text(
                              'GO TO HOME',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w900,
                                letterSpacing: 1,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 40),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w900,
        color: textPrimary,
        letterSpacing: -0.5,
      ),
    );
  }

  Widget _buildInfoCard({
    required IconData icon,
    required String title,
    required String value,
    bool highlight = false,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
        border: Border.all(
          color: highlight ? secondaryColor.withOpacity(0.2) : borderSoft,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: (highlight ? secondaryColor : maincolor1).withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              icon,
              color: highlight ? secondaryColor : maincolor1,
              size: 20,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            title,
            style: const TextStyle(
              fontSize: 10,
              color: textLight,
              fontWeight: FontWeight.w800,
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w900,
              color: highlight ? secondaryColor : textPrimary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDateTimeCard(String dateString, String timeString) {
    final date = DateTime.parse(dateString);
    final timeParts = timeString.split(':');
    final hour = int.parse(timeParts[0]);
    final minute = int.parse(timeParts[1]);
    final timeDateTime = DateTime(2023, 1, 1, hour, minute);

    final formattedTime = _formatTime12Hour(timeDateTime);
    final formattedDate = _formatDateWithMonthName(date);

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
        border: Border.all(color: borderSoft),
      ),
      child: Row(
        children: [
          Container(
            width: 65,
            height: 65,
            decoration: BoxDecoration(
              color: secondaryColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(18),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  date.day.toString(),
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w900,
                    color: secondaryColor,
                  ),
                ),
                Text(
                  _getMonthAbbreviation(date.month),
                  style: const TextStyle(
                    fontSize: 11,
                    color: secondaryColor,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Scheduled Pickup',
                  style: TextStyle(
                    fontSize: 11,
                    color: textLight,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  formattedDate,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w900,
                    color: textPrimary,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Icon(Iconsax.clock, size: 14, color: textLight),
                    const SizedBox(width: 6),
                    Text(
                      formattedTime,
                      style: const TextStyle(
                        fontSize: 13,
                        color: textSecondary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _formatTime12Hour(DateTime dateTime) {
    final hour = dateTime.hour % 12;
    final minute = dateTime.minute.toString().padLeft(2, '0');
    final period = dateTime.hour < 12 ? 'AM' : 'PM';
    return '${hour == 0 ? 12 : hour}:$minute $period';
  }

  String _formatDateWithMonthName(DateTime dateTime) {
    const monthNames = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December',
    ];
    return '${dateTime.day} ${monthNames[dateTime.month - 1]}, ${dateTime.year}';
  }

  String _getMonthAbbreviation(int month) {
    const monthAbbreviations = [
      'JAN',
      'FEB',
      'MAR',
      'APR',
      'MAY',
      'JUN',
      'JUL',
      'AUG',
      'SEP',
      'OCT',
      'NOV',
      'DEC',
    ];
    return monthAbbreviations[month - 1];
  }

  Widget _buildCabInfoCard(Cab cab) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
        border: Border.all(color: borderSoft),
      ),
      child: Row(
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: borderSoft),
            ),
            child: cab.image.isNotEmpty
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.network(
                      cab.image,
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) => const Icon(
                        Iconsax.car,
                        size: 32,
                        color: secondaryColor,
                      ),
                    ),
                  )
                : const Icon(Iconsax.car, size: 32, color: secondaryColor),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  cab.type,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w900,
                    color: textPrimary,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  cab.category.toUpperCase(),
                  style: const TextStyle(
                    fontSize: 11,
                    color: secondaryColor,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 0.5,
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    _buildFeatureIcon(
                      Iconsax.user_tick,
                      cab.seatingCapacity.toString(),
                    ),
                    const SizedBox(width: 12),
                    _buildFeatureIcon(
                      Iconsax.bag_2,
                      cab.bagCapacity.toString(),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureIcon(IconData icon, String value) {
    return Row(
      children: [
        Icon(icon, size: 14, color: textLight),
        const SizedBox(width: 6),
        Text(
          value,
          style: const TextStyle(
            fontSize: 12,
            color: textSecondary,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }

  Widget _buildFareCard(BookingConfirmData data) {
    final fare = data.cabRate.fare;
    final totalPaid = data.paidAmount ?? fare.totalAmount.toDouble();
    final serviceCharge = totalPaid - fare.totalAmount;

    return Container(
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
        border: Border.all(color: maincolor1.withOpacity(0.05)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildFareRow('Base Fare', '₹${fare.baseFare}'),
            if (fare.driverAllowance > 0)
              _buildFareRow('Driver Allowance', '₹${fare.driverAllowance}'),
            if (fare.gst > 0) _buildFareRow('GST', '₹${fare.gst}'),
            if (fare.tollTax > 0) _buildFareRow('Toll Tax', '₹${fare.tollTax}'),
            if (fare.stateTax > 0)
              _buildFareRow('State Tax', '₹${fare.stateTax}'),
            if (fare.airportFee > 0)
              _buildFareRow('Airport Fee', '₹${fare.airportFee}'),

            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Divider(height: 1, color: borderSoft),
            ),

            _buildFareRow(
              'Service Fee & Commission',
              '₹${serviceCharge.toStringAsFixed(0)}',
              isHighlighted: true,
            ),

            const SizedBox(height: 16),

            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: maincolor1.withOpacity(0.04),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: maincolor1.withOpacity(0.1)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'TOTAL PAID',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w900,
                      color: maincolor1,
                      letterSpacing: 0.5,
                    ),
                  ),
                  Text(
                    '₹${totalPaid.toStringAsFixed(0)}',
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w900,
                      color: maincolor1,
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

  Widget _buildFareRow(
    String label,
    String value, {
    bool isHighlighted = false,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 14,
              color: isHighlighted ? secondaryColor : textSecondary,
              fontWeight: isHighlighted ? FontWeight.w800 : FontWeight.w600,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 14,
              color: isHighlighted ? secondaryColor : textPrimary,
              fontWeight: FontWeight.w900,
            ),
          ),
        ],
      ),
    );
  }
}
