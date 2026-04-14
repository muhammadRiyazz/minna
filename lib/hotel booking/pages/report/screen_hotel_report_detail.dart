import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:minna/hotel booking/application/report/hotel_report_bloc.dart';
import 'package:minna/hotel booking/domain/report/hotel_report_model.dart';
import 'package:minna/comman/const/const.dart';

class ScreenHotelReportDetail extends StatelessWidget {
  final HotelBookingRecord record;

  const ScreenHotelReportDetail({super.key, required this.record});

  void _showCancelDialog(BuildContext context, String bookingId) {
    final TextEditingController remarksController = TextEditingController();
    final formKey = GlobalKey<FormState>();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: Container(
          decoration: BoxDecoration(
            color: cardColor,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.12),
                blurRadius: 30,
                offset: const Offset(0, -12),
              ),
            ],
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 12),
                // Drag Handle
                Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: textLight.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                const SizedBox(height: 12),

                // Premium Header
                Container(
                  width: double.infinity,
                  padding:
                      const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.red.withOpacity(0.1),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Iconsax.close_circle,
                          color: Colors.red,
                          size: 28,
                        ),
                      ),
                      const SizedBox(width: 16),
                      const Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Cancel Hotel Booking',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w900,
                                letterSpacing: -0.5,
                              ),
                            ),
                            SizedBox(height: 2),
                            Text(
                              'Provide a reason for cancellation',
                              style: TextStyle(
                                fontSize: 13,
                                color: textSecondary,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: Icon(
                          Icons.close_rounded,
                          color: textSecondary,
                          size: 20,
                        ),
                        style: IconButton.styleFrom(
                          backgroundColor: backgroundColor,
                          padding: const EdgeInsets.all(8),
                        ),
                      ),
                    ],
                  ),
                ),

                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24),
                  child: Divider(height: 1),
                ),

                Padding(
                  padding: const EdgeInsets.fromLTRB(24, 24, 24, 32),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'CANCELLATION REMARKS',
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w800,
                            color: textLight,
                            letterSpacing: 1.2,
                          ),
                        ),
                        const SizedBox(height: 12),
                        TextFormField(
                          controller: remarksController,
                          maxLines: 4,
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                          decoration: InputDecoration(
                            hintText: 'Enter your remarks here...',
                            hintStyle: TextStyle(
                              fontSize: 14,
                              color: textLight,
                              fontWeight: FontWeight.w400,
                            ),
                            filled: true,
                            fillColor: backgroundColor,
                            contentPadding: const EdgeInsets.all(20),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide.none,
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(
                                color: maincolor1.withOpacity(0.5),
                                width: 1.5,
                              ),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Please enter a valid reason';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 20),
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.orange.withOpacity(0.08),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: Colors.orange.withOpacity(0.2),
                            ),
                          ),
                          child: const Row(
                            children: [
                              Icon(
                                Iconsax.warning_2,
                                color: Colors.orange,
                                size: 20,
                              ),
                              const SizedBox(width: 12),
                              const Expanded(
                                child: Text(
                                  'Note: Cancellation charges may apply based on the hotel policy.',
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xFF92400E),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 32),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                context.read<HotelReportBloc>().add(
                                      CancelHotelBooking(
                                        bookingId: bookingId,
                                        remarks: remarksController.text.trim(),
                                      ),
                                    );
                                Navigator.pop(context);
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red,
                              foregroundColor: Colors.white,
                              elevation: 0,
                              padding: const EdgeInsets.symmetric(vertical: 18),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                            ),
                            child: const Text(
                              'Confirm Cancellation',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w800,
                                letterSpacing: 0.5,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showRefundDetails(BuildContext context, dynamic data) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        padding: const EdgeInsets.fromLTRB(24, 12, 24, 32),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 48,
                height: 5,
                decoration: BoxDecoration(
                  color: const Color(0xFFE2E8F0),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(height: 32),
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: maincolor1.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(Iconsax.receipt_2, color: maincolor1, size: 24),
                ),
                const SizedBox(width: 16),
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Cancellation Summary",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w900,
                        color: Color(0xFF1A1A1A),
                      ),
                    ),
                    Text(
                      "Review your refund details below",
                      style: TextStyle(
                        fontSize: 13,
                        color: Color(0xFF64748B),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 32),
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color(0xFFF8FAFC),
                borderRadius: BorderRadius.circular(24),
                border: Border.all(color: const Color(0xFFF1F5F9)),
              ),
              child: Column(
                children: [
                  _buildRefundRow(
                    "Total Price",
                    "₹${data['TotalPrice']?.toStringAsFixed(2) ?? '0.00'}",
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 12),
                    child: Divider(height: 1, color: Color(0xFFE2E8F0)),
                  ),
                  if (data['CancellationChargeBreakUp'] != null) ...[
                    _buildRefundRow(
                      "Cancellation Fees",
                      "₹${data['CancellationChargeBreakUp']['CancellationFees']?.toStringAsFixed(2) ?? '0.00'}",
                      isNegative: true,
                    ),
                    const SizedBox(height: 12),
                    _buildRefundRow(
                      "Service Charges",
                      "₹${data['CancellationChargeBreakUp']['CancellationServiceCharge']?.toStringAsFixed(2) ?? '0.00'}",
                      isNegative: true,
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 12),
                      child: Divider(height: 1, color: Color(0xFFE2E8F0)),
                    ),
                  ],
                  _buildRefundRow(
                    "Amount to Refund",
                    "₹${data['RefundedAmount']?.toStringAsFixed(2) ?? '0.00'}",
                    isHighlight: true,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: maincolor1,
                  padding: const EdgeInsets.symmetric(vertical: 18),
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: const Text(
                  "Done",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w900,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRefundRow(
    String label,
    String value, {
    bool isNegative = false,
    bool isHighlight = false,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 14,
              fontWeight: isHighlight ? FontWeight.w900 : FontWeight.w600,
              color: isHighlight
                  ? const Color(0xFF1A1A1A)
                  : const Color(0xFF64748B),
            ),
          ),
          Text(
            isNegative ? "- $value" : value,
            style: TextStyle(
              fontSize: isHighlight ? 18 : 15,
              fontWeight: FontWeight.w900,
              color: isHighlight
                  ? maincolor1
                  : (isNegative ? Colors.red : const Color(0xFF1A1A1A)),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final booking = record.booking;
    final tboData = booking.parsedTboResponse;
    final String status = booking.bookingStatus.toUpperCase();
    final bool isConfirmed = status == "CONFIRMED" || status == "CONFORMS";
    final bool isCancellationPending = status == "CANCELLATION_PENDING";
    final bool isCancelled = status == "CANCELLED";
    final bool canCancel = isConfirmed && booking.bookingId != null;

    return BlocListener<HotelReportBloc, HotelReportState>(
      listener: (context, state) {
        if (state is HotelCancelLoading || state is HotelStatusCheckLoading) {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) => const Center(
              child: CircularProgressIndicator(color: Colors.white),
            ),
          );
        } else if (state is HotelCancelSuccess) {
          Navigator.pop(context); // Pop loading dialog
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              behavior: SnackBarBehavior.floating,
            ),
          );
          // Wait for status check to complete (handled in Bloc)
          // We stay on the page until final status is confirmed
        } else if (state is HotelCancelError) {
          Navigator.pop(context); // Pop loading dialog
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: Colors.red,
              behavior: SnackBarBehavior.floating,
            ),
          );
        } else if (state is HotelStatusCheckSuccess) {
          Navigator.pop(context); // Pop loading dialog
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: Colors.green,
              behavior: SnackBarBehavior.floating,
            ),
          );
          // Auto-navigate back to the list as requested
          Navigator.pop(context);
        } else if (state is HotelStatusCheckError) {
          Navigator.pop(context); // Pop loading dialog
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: Colors.red,
              behavior: SnackBarBehavior.floating,
            ),
          );
        }
      },
      child: Scaffold(
        backgroundColor: backgroundColor,
        appBar: AppBar(
          backgroundColor: maincolor1,
          elevation: 0,
          centerTitle: true,
          title: const Text(
            "Booking Report",
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w900,
              letterSpacing: -0.5,
            ),
          ),
          leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Iconsax.arrow_left, color: Colors.white),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              _buildHeader(
                booking,
                isConfirmed,
                isCancellationPending,
                isCancelled,
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    _buildItineraryCard(booking),
                    const SizedBox(height: 16),
                    if (tboData != null) _buildTboDetails(tboData),
                    if (tboData == null) _buildBasicDetails(booking),
                    const SizedBox(height: 16),
                    _buildPaymentCard(record),
                    if (isCancelled || booking.refundStatus != null) ...[
                      const SizedBox(height: 16),
                      _buildRefundCard(booking),
                    ],
                    const SizedBox(height: 24),
                    if (canCancel)
                      SizedBox(
                        width: double.infinity,
                        child: OutlinedButton(
                          onPressed: () =>
                              _showCancelDialog(context, booking.bookingId!),
                          style: OutlinedButton.styleFrom(
                            side: const BorderSide(color: Colors.red),
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                          child: const Text(
                            "Cancel Booking",
                            style: TextStyle(
                              color: Colors.red,
                              fontWeight: FontWeight.w900,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                    if (isCancellationPending)
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton.icon(
                          onPressed: () {
                            context.read<HotelReportBloc>().add(
                              CheckBookingStatus(bookingId: booking.bookingId!),
                            );
                          },
                          icon: const Icon(Iconsax.refresh, size: 20),
                          label: const Text(
                            "Check Status",
                            style: TextStyle(
                              fontWeight: FontWeight.w900,
                              fontSize: 16,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.orange,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                        ),
                      ),
                    const SizedBox(height: 32),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(
    BookingInfo booking,
    bool isConfirmed,
    bool isCancellationPending,
    bool isCancelled,
  ) {
    Color statusColor;
    IconData statusIcon;

    if (isConfirmed) {
      statusColor = Colors.green;
      statusIcon = Iconsax.tick_circle;
    } else if (isCancellationPending) {
      statusColor = Colors.orange;
      statusIcon = Iconsax.clock;
    } else if (isCancelled) {
      statusColor = Colors.red;
      statusIcon = Iconsax.close_circle;
    } else {
      statusColor = Colors.grey;
      statusIcon = Iconsax.info_circle;
    }

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: maincolor1,
        borderRadius: const BorderRadius.vertical(bottom: Radius.circular(32)),
      ),
      padding: const EdgeInsets.fromLTRB(24, 0, 24, 40),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: const Icon(Iconsax.house, size: 40, color: Colors.white),
          ),
          const SizedBox(height: 16),
          Text(
            booking.hotelName,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w900,
              color: Colors.white,
              letterSpacing: -0.5,
            ),
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: statusColor.withOpacity(0.2),
              borderRadius: BorderRadius.circular(100),
              border: Border.all(color: statusColor.withOpacity(0.3)),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  statusIcon,
                  size: 14,
                  color: statusColor == Colors.green
                      ? Colors.greenAccent
                      : statusColor,
                ),
                const SizedBox(width: 8),
                Text(
                  booking.bookingStatus.toUpperCase(),
                  style: TextStyle(
                    color: statusColor == Colors.green
                        ? Colors.greenAccent
                        : statusColor,
                    fontSize: 12,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 1,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRefundCard(BookingInfo booking) {
    return Column(
      children: [
        _buildSectionHeader("Refund Information", Iconsax.money_send),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: cardColor,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: Colors.red.withOpacity(0.2)),
          ),
          child: Column(
            children: [
              _buildDetailRow(
                "Refund Status",
                booking.refundStatus ?? "PROCESSING",
              ),
              _buildDetailRow(
                "Refund Amount",
                "${booking.currency} ${booking.refundAmount ?? '0.00'}",
              ),
              if (booking.cancellationCharge != null)
                _buildDetailRow(
                  "Cancellation Fee",
                  "${booking.currency} ${booking.cancellationCharge}",
                ),
              if (booking.changeRequestId != null)
                _buildDetailRow("Change Request ID", booking.changeRequestId!),
              if (booking.refundId != null)
                _buildDetailRow("Refund ID", booking.refundId!),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildItineraryCard(BookingInfo booking) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: borderSoft),
      ),
      child: Column(
        children: [
          Row(
            children: [
              _buildDateItem("Check-In", booking.checkIn),
              const Spacer(),
              Column(
                children: [
                  const Icon(
                    Iconsax.arrow_right_1,
                    color: secondaryColor,
                    size: 20,
                  ),
                  Text(
                    "1 Night",
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                      color: textSecondary,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              _buildDateItem(
                "Check-Out",
                booking.checkOut,
                crossAlignment: CrossAxisAlignment.end,
              ),
            ],
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              _buildIconDetail(Iconsax.user, "${booking.guests} Guests"),
              const Spacer(),
              _buildIconDetail(Iconsax.status, booking.paymentStatus),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDateItem(
    String label,
    String dateStr, {
    CrossAxisAlignment crossAlignment = CrossAxisAlignment.start,
  }) {
    final date = DateTime.tryParse(dateStr);
    final day = date != null ? DateFormat('dd').format(date) : "--";
    final month = date != null ? DateFormat('MMM').format(date) : "--";
    final year = date != null ? DateFormat('yyyy').format(date) : "";

    return Column(
      crossAxisAlignment: crossAlignment,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: textSecondary,
          ),
        ),
        const SizedBox(height: 4),
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              day,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w900,
                color: maincolor1,
              ),
            ),
            const SizedBox(width: 4),
            Padding(
              padding: const EdgeInsets.only(bottom: 4),
              child: Text(
                "$month $year",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: maincolor1,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildIconDetail(IconData icon, String value) {
    return Row(
      children: [
        Icon(icon, size: 16, color: secondaryColor),
        const SizedBox(width: 8),
        Text(
          value,
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w700,
            color: textPrimary,
          ),
        ),
      ],
    );
  }

  Widget _buildTboDetails(TboBookingDetail tbo) {
    return Column(
      children: [
        _buildSectionHeader("Reservation Summary", Iconsax.note_21),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: cardColor,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: borderSoft),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildDetailRow(
                "Confirmation No",
                tbo.confirmationNo ?? "Pending",
              ),
              _buildDetailRow("TBO Reference", tbo.tboReferenceNo ?? "N/A"),
              _buildDetailRow("City", tbo.city ?? "N/A"),
              _buildDetailRow("Address", tbo.addressLine1 ?? "N/A"),
              const SizedBox(height: 16),
              const Divider(),
              const SizedBox(height: 16),
              ...tbo.rooms.map(
                (room) => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      room.roomTypeName ?? "Room Details",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w900,
                        color: maincolor1,
                      ),
                    ),
                    const SizedBox(height: 8),
                    ...room.passengers.map(
                      (pax) => Padding(
                        padding: const EdgeInsets.only(bottom: 4),
                        child: Row(
                          children: [
                            const Icon(
                              Iconsax.user,
                              size: 14,
                              color: textSecondary,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              "${pax.title} ${pax.firstName} ${pax.lastName}",
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                color: textPrimary,
                              ),
                            ),
                            if (pax.leadPassenger == true)
                              Container(
                                margin: const EdgeInsets.only(left: 8),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 6,
                                  vertical: 2,
                                ),
                                decoration: BoxDecoration(
                                  color: secondaryColor.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: const Text(
                                  "LEAD",
                                  style: TextStyle(
                                    fontSize: 8,
                                    fontWeight: FontWeight.w900,
                                    color: secondaryColor,
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildBasicDetails(BookingInfo booking) {
    return Column(
      children: [
        _buildSectionHeader("Booking Information", Iconsax.info_circle),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: cardColor,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: borderSoft),
          ),
          child: Column(
            children: [
              _buildDetailRow("Order ID", booking.id),
              _buildDetailRow("Booking ID", booking.bookingId ?? "N/A"),
              _buildDetailRow(
                "Confirmation",
                booking.confirmationNo ?? "Pending",
              ),
              _buildDetailRow("Guests", booking.guests),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildPaymentCard(HotelBookingRecord record) {
    final payment = record.payment;
    final booking = record.booking;

    return Column(
      children: [
        _buildSectionHeader("Payment Information", Iconsax.wallet_3),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: cardColor,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: borderSoft),
          ),
          child: Column(
            children: [
              _buildDetailRow(
                "Base Amount",
                "${booking.currency} ${booking.netAmount}",
              ),
              _buildDetailRow(
                "Payment Status",
                payment?.status.toUpperCase() ?? "PENDING",
              ),
              if (payment?.razorpayPaymentId != null)
                _buildDetailRow("Transaction ID", payment!.razorpayPaymentId!),
              const SizedBox(height: 16),
              const Divider(),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Total Paid",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w900),
                  ),
                  Text(
                    "${booking.currency} ${payment?.amount ?? booking.netAmount}",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w900,
                      color: maincolor1,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSectionHeader(String title, IconData icon) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 24, 8, 12),
      child: Row(
        children: [
          Icon(icon, size: 18, color: maincolor1),
          const SizedBox(width: 12),
          Text(
            title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w900,
              color: maincolor1,
              letterSpacing: -0.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: textSecondary,
            ),
          ),
          const SizedBox(width: 16),
          Flexible(
            child: Text(
              value,
              textAlign: TextAlign.right,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w800,
                color: textPrimary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
