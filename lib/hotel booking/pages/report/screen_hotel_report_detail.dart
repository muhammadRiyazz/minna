import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:minna/hotel booking/application/report/hotel_report_bloc.dart';
import 'package:minna/hotel booking/domain/report/hotel_report_model.dart';
import 'package:minna/comman/const/const.dart';
import 'package:minna/hotel booking/functions/hotel_api.dart'; // For the loading dialog if needed

class ScreenHotelReportDetail extends StatelessWidget {
  final HotelBookingRecord record;

  const ScreenHotelReportDetail({super.key, required this.record});

  void _showCancelDialog(BuildContext context, String bookingId) {
    final TextEditingController remarksController = TextEditingController();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text(
          "Cancel Booking",
          style: TextStyle(fontWeight: FontWeight.w900),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              "Please provide a reason for cancellation.",
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: remarksController,
              maxLines: 3,
              decoration: InputDecoration(
                hintText: "Enter remarks here...",
                filled: true,
                fillColor: Colors.grey[100],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () {
              if (remarksController.text.trim().isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Please enter remarks")),
                );
                return;
              }
              context.read<HotelReportBloc>().add(
                    CancelHotelBooking(
                      bookingId: bookingId,
                      remarks: remarksController.text.trim(),
                    ),
                  );
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: const Text(
              "Confirm Cancel",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  void _showRefundDetails(BuildContext context, dynamic data) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        padding: const EdgeInsets.all(24),
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
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              "Cancellation Summary",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900),
            ),
            const SizedBox(height: 16),
            _buildRefundRow("Refunded Amount", "₹${data['RefundedAmount']}"),
            _buildRefundRow("Total Price", "₹${data['TotalPrice']}"),
            if (data['CancellationChargeBreakUp'] != null) ...[
              _buildRefundRow(
                "Cancellation Fees",
                "₹${data['CancellationChargeBreakUp']['CancellationFees']}",
              ),
            ],
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: maincolor1,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: const Text(
                  "Done",
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.w900),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRefundRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w900,
              color: maincolor1,
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
    final bool isConfirmed = booking.bookingStatus.toUpperCase() == "CONFIRMED";
    final bool canCancel = isConfirmed && booking.bookingId != null;

    return BlocListener<HotelReportBloc, HotelReportState>(
      listener: (context, state) {
        if (state is HotelCancelLoading) {
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
            SnackBar(content: Text(state.message)),
          );
          _showRefundDetails(context, state.data);
        } else if (state is HotelCancelError) {
          Navigator.pop(context); // Pop loading dialog
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message), backgroundColor: Colors.red),
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
              _buildHeader(booking, isConfirmed),
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
                    const SizedBox(height: 24),
                    if (canCancel)
                      SizedBox(
                        width: double.infinity,
                        child: OutlinedButton(
                          onPressed: () => _showCancelDialog(
                            context,
                            booking.bookingId!,
                          ),
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

  Widget _buildHeader(BookingInfo booking, bool isConfirmed) {
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
              color: isConfirmed
                  ? Colors.green.withOpacity(0.2)
                  : Colors.orange.withOpacity(0.2),
              borderRadius: BorderRadius.circular(100),
              border: Border.all(
                color: isConfirmed
                    ? Colors.green.withOpacity(0.3)
                    : Colors.orange.withOpacity(0.3),
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  isConfirmed ? Iconsax.tick_circle : Iconsax.info_circle,
                  size: 14,
                  color: isConfirmed ? Colors.greenAccent : Colors.orangeAccent,
                ),
                const SizedBox(width: 8),
                Text(
                  booking.bookingStatus.toUpperCase(),
                  style: TextStyle(
                    color: isConfirmed
                        ? Colors.greenAccent
                        : Colors.orangeAccent,
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
