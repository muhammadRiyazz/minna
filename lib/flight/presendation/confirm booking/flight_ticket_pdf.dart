import 'dart:developer';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:open_file/open_file.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:permission_handler/permission_handler.dart';
import 'package:path_provider/path_provider.dart';
import 'package:minna/flight/application/booking/booking_bloc.dart';

Future<void> downloadFlightTicketPdf({
  required BuildContext context,
  required BookingState state,
}) async {
  if (state.bookingdata == null) {
    Fluttertoast.showToast(msg: 'No booking data found context');
    return;
  }

  try {
    final pdf = pw.Document();

    final ByteData image = await rootBundle.load('asset/mtlogo.jpg');
    final Uint8List imageData = image.buffer.asUint8List();

    final bookingData = state.bookingdata!;
    final flightOption = bookingData.journey.flightOption;
    final passengers = bookingData.passengers;
    final pnr = state.alhindPnr ?? '';
    final bookingId = state.tableID ?? '';
    
    // Calculate Add-ons
    double totalMealAmount = 0;
    double totalBaggageAmount = 0;
    double totalSeatAmount = 0;

    for (var p in passengers) {
      if (p.ssrAvailability?.mealInfo != null) {
        for (var info in p.ssrAvailability!.mealInfo!) {
          if (info.meals != null) {
            for (var meal in info.meals!) {
              totalMealAmount += (meal.amount ?? 0).toDouble();
            }
          }
        }
      }
      if (p.ssrAvailability?.baggageInfo != null) {
        for (var info in p.ssrAvailability!.baggageInfo!) {
          if (info.baggages != null) {
            for (var baggage in info.baggages!) {
              totalBaggageAmount += (baggage.amount ?? 0).toDouble();
            }
          }
        }
      }
      if (p.ssrAvailability?.seatInfo != null) {
        for (var info in p.ssrAvailability!.seatInfo!) {
          if (info.seats != null) {
            for (var seat in info.seats!) {
              if (seat.fare != null && seat.fare!.isNotEmpty) {
                totalSeatAmount += double.tryParse(seat.fare!) ?? 0;
              }
            }
          }
        }
      }
    }

    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(32),
        build: (pw.Context context) {
          return [
            // Header
            pw.Container(
              padding: const pw.EdgeInsets.all(16),
              decoration: pw.BoxDecoration(
                border: pw.Border.all(color: PdfColors.blueGrey300, width: 1.5),
                borderRadius: const pw.BorderRadius.all(pw.Radius.circular(12)),
              ),
              child: pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: [
                      pw.Image(pw.MemoryImage(imageData), height: 50),
                      pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.end,
                        children: [
                          pw.Text(
                            'mttrip E-Ticket',
                            style: pw.TextStyle(
                              fontSize: 22,
                              fontWeight: pw.FontWeight.bold,
                              color: PdfColors.blue900,
                            ),
                          ),
                          pw.SizedBox(height: 4),
                          pw.Text(
                            'Booking ID: $bookingId',
                            style: const pw.TextStyle(fontSize: 12),
                          ),
                          pw.Text(
                            'Date: ${DateFormat('dd MMM yyyy').format(DateTime.now())}',
                            style: const pw.TextStyle(fontSize: 12),
                          ),
                        ],
                      ),
                    ],
                  ),
                  pw.SizedBox(height: 20),
                  pw.Divider(color: PdfColors.grey300),
                  pw.SizedBox(height: 10),

                  // PNR Information
                  pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: [
                      pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
                          pw.Text(
                            'Booking Status',
                            style: pw.TextStyle(
                              color: PdfColors.grey600,
                              fontSize: 12,
                            ),
                          ),
                          pw.Text(
                            'CONFIRMED',
                            style: pw.TextStyle(
                              fontWeight: pw.FontWeight.bold,
                              color: PdfColors.green700,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                      if (pnr.isNotEmpty)
                        pw.Column(
                          crossAxisAlignment: pw.CrossAxisAlignment.end,
                          children: [
                            pw.Text(
                              'Airline PNR',
                              style: pw.TextStyle(
                                color: PdfColors.grey600,
                                fontSize: 12,
                              ),
                            ),
                            pw.Text(
                              'PNR: $pnr',
                              style: pw.TextStyle(
                                fontWeight: pw.FontWeight.bold,
                                color: PdfColors.blue900,
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ),
                    ],
                  ),
                ],
              ),
            ),
            pw.SizedBox(height: 20),

            // Flight Details
            pw.Container(
              decoration: pw.BoxDecoration(
                border: pw.Border.all(color: PdfColors.grey300),
                borderRadius: const pw.BorderRadius.all(pw.Radius.circular(8)),
              ),
              child: pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Container(
                    width: double.infinity,
                    padding: const pw.EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 10,
                    ),
                    decoration: const pw.BoxDecoration(
                      color: PdfColors.blue900,
                      borderRadius: pw.BorderRadius.only(
                        topLeft: pw.Radius.circular(8),
                        topRight: pw.Radius.circular(8),
                      ),
                    ),
                    child: pw.Text(
                      'Flight Details',
                      style: pw.TextStyle(
                        color: PdfColors.white,
                        fontWeight: pw.FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  pw.Padding(
                    padding: const pw.EdgeInsets.all(16),
                    child: pw.Column(
                      children: flightOption.flightLegs.map((leg) {
                        String flightDuration = '';
                        try {
                          DateTime d1 = DateTime.parse(leg.departureTime);
                          DateTime d2 = DateTime.parse(leg.arrivalTime);
                          Duration diff = d2.difference(d1);
                          flightDuration =
                              '${diff.inHours}h ${diff.inMinutes.remainder(60)}m';
                        } catch (e) {}

                        final fareType = flightOption.flightFares.isNotEmpty
                            ? flightOption.flightFares.first.fareType ??
                                  'Regular'
                            : 'Regular';
                        final cabinClass = 'Economy (${leg.rbd ?? 'Y'})';
                        final checkInBaggage =
                            (leg.freeBaggages != null &&
                                leg.freeBaggages.isNotEmpty &&
                                leg.freeBaggages.first is Map &&
                                leg.freeBaggages.first['Adt_Baggage'] != null &&
                                leg.freeBaggages.first['Adt_Baggage']
                                    .toString()
                                    .isNotEmpty)
                            ? leg.freeBaggages.first['Adt_Baggage'].toString()
                            : '15 KG';
                        final cabinBaggage =
                            (leg.freeBaggages != null &&
                                leg.freeBaggages.isNotEmpty &&
                                leg.freeBaggages.first is Map &&
                                leg.freeBaggages.first['Adt_HandBaggage'] !=
                                    null &&
                                leg.freeBaggages.first['Adt_HandBaggage']
                                    .toString()
                                    .isNotEmpty)
                            ? leg.freeBaggages.first['Adt_HandBaggage']
                                  .toString()
                            : '7 KG';
                        final dTerminal =
                            (leg.departureTerminal != null &&
                                leg.departureTerminal.toString().isNotEmpty)
                            ? 'Terminal ${leg.departureTerminal}'
                            : '';
                        final aTerminal =
                            (leg.arrivalTerminal != null &&
                                leg.arrivalTerminal.toString().isNotEmpty)
                            ? 'Terminal ${leg.arrivalTerminal}'
                            : '';
                        final legPnr =
                            (leg.airlinePNR != null &&
                                leg.airlinePNR.toString().isNotEmpty)
                            ? 'Airline PNR: ${leg.airlinePNR}'
                            : '';

                        return pw.Padding(
                          padding: const pw.EdgeInsets.only(bottom: 16),
                          child: pw.Column(
                            crossAxisAlignment: pw.CrossAxisAlignment.start,
                            children: [
                              if (legPnr.isNotEmpty)
                                pw.Padding(
                                  padding: const pw.EdgeInsets.only(bottom: 4),
                                  child: pw.Text(
                                    legPnr,
                                    style: pw.TextStyle(
                                      fontSize: 10,
                                      fontWeight: pw.FontWeight.bold,
                                      color: PdfColors.blue800,
                                    ),
                                  ),
                                ),
                              pw.Row(
                                mainAxisAlignment:
                                    pw.MainAxisAlignment.spaceBetween,
                                children: [
                                  pw.Column(
                                    crossAxisAlignment:
                                        pw.CrossAxisAlignment.start,
                                    children: [
                                      pw.Text(
                                        '${leg.airlineCode} ${leg.flightNo}',
                                        style: pw.TextStyle(
                                          fontWeight: pw.FontWeight.bold,
                                        ),
                                      ),
                                      pw.Text(
                                        leg.carrier ?? 'Airline',
                                        style: const pw.TextStyle(
                                          fontSize: 10,
                                          color: PdfColors.grey600,
                                        ),
                                      ),
                                    ],
                                  ),
                                  pw.Column(
                                    crossAxisAlignment:
                                        pw.CrossAxisAlignment.end,
                                    children: [
                                      pw.Text(
                                        leg.origin,
                                        style: pw.TextStyle(
                                          fontSize: 16,
                                          fontWeight: pw.FontWeight.bold,
                                          color: PdfColors.blue900,
                                        ),
                                      ),
                                      pw.Text(
                                        leg.departureTime.split('T').join(' '),
                                        style: const pw.TextStyle(fontSize: 10),
                                      ),
                                      if (dTerminal.isNotEmpty)
                                        pw.Text(
                                          dTerminal,
                                          style: const pw.TextStyle(
                                            fontSize: 9,
                                            color: PdfColors.grey700,
                                          ),
                                        ),
                                    ],
                                  ),
                                  pw.Column(
                                    children: [
                                      // pw.Icon(
                                      //   const pw.IconData(0xe5d8),
                                      //   color: PdfColors.grey400,
                                      //   size: 24,
                                      // ),
                                      pw.Text(
                                        "Duration",
                                        style: pw.TextStyle(
                                          fontSize: 16,
                                          fontWeight: pw.FontWeight.bold,
                                          color: PdfColors.grey600,
                                        ),
                                      ),
                                      pw.Text(
                                        flightDuration,
                                        style: pw.TextStyle(
                                          fontSize: 9,
                                          fontWeight: pw.FontWeight.bold,
                                          color: PdfColors.grey600,
                                        ),
                                      ),
                                    ],
                                  ),
                                  pw.Column(
                                    crossAxisAlignment:
                                        pw.CrossAxisAlignment.start,
                                    children: [
                                      pw.Text(
                                        leg.destination,
                                        style: pw.TextStyle(
                                          fontSize: 16,
                                          fontWeight: pw.FontWeight.bold,
                                          color: PdfColors.blue900,
                                        ),
                                      ),
                                      pw.Text(
                                        leg.arrivalTime.split('T').join(' '),
                                        style: const pw.TextStyle(fontSize: 10),
                                      ),
                                      if (aTerminal.isNotEmpty)
                                        pw.Text(
                                          aTerminal,
                                          style: const pw.TextStyle(
                                            fontSize: 9,
                                            color: PdfColors.grey700,
                                          ),
                                        ),
                                    ],
                                  ),
                                ],
                              ),
                              pw.SizedBox(height: 8),
                              pw.Container(
                                padding: const pw.EdgeInsets.all(6),
                                decoration: pw.BoxDecoration(
                                  color: PdfColors.grey100,
                                  borderRadius: const pw.BorderRadius.all(
                                    pw.Radius.circular(4),
                                  ),
                                ),
                                child: pw.Row(
                                  mainAxisAlignment:
                                      pw.MainAxisAlignment.spaceEvenly,
                                  children: [
                                    pw.Text(
                                      'Class: $cabinClass',
                                      style: const pw.TextStyle(fontSize: 9),
                                    ),
                                    pw.Text(
                                      'Fare Type: $fareType',
                                      style: const pw.TextStyle(fontSize: 9),
                                    ),
                                    pw.Text(
                                      'Check-in Baggage: $checkInBaggage',
                                      style: const pw.TextStyle(fontSize: 9),
                                    ),
                                    pw.Text(
                                      'Cabin Baggage: $cabinBaggage',
                                      style: const pw.TextStyle(fontSize: 9),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
            ),
            pw.SizedBox(height: 20),

            // Passengers
            pw.Container(
              decoration: pw.BoxDecoration(
                border: pw.Border.all(color: PdfColors.grey300),
                borderRadius: const pw.BorderRadius.all(pw.Radius.circular(8)),
              ),
              child: pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Container(
                    width: double.infinity,
                    padding: const pw.EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 10,
                    ),
                    decoration: const pw.BoxDecoration(
                      color: PdfColors.blue900,
                      borderRadius: pw.BorderRadius.only(
                        topLeft: pw.Radius.circular(8),
                        topRight: pw.Radius.circular(8),
                      ),
                    ),
                    child: pw.Text(
                      'Passenger Details',
                      style: pw.TextStyle(
                        color: PdfColors.white,
                        fontWeight: pw.FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  pw.Container(
                    padding: const pw.EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 8,
                    ),
                    color: PdfColors.grey100,
                    child: pw.Row(
                      children: [
                        pw.Expanded(
                          flex: 3,
                          child: pw.Text(
                            'Name',
                            style: pw.TextStyle(
                              fontWeight: pw.FontWeight.bold,
                              fontSize: 11,
                            ),
                          ),
                        ),
                        pw.Expanded(
                          child: pw.Text(
                            'Type',
                            style: pw.TextStyle(
                              fontWeight: pw.FontWeight.bold,
                              fontSize: 11,
                            ),
                          ),
                        ),
                        pw.Expanded(
                          flex: 2,
                          child: pw.Text(
                            'Date of Birth',
                            style: pw.TextStyle(
                              fontWeight: pw.FontWeight.bold,
                              fontSize: 11,
                            ),
                          ),
                        ),
                        pw.Expanded(
                          flex: 2,
                          child: pw.Text(
                            'Passport / ID',
                            style: pw.TextStyle(
                              fontWeight: pw.FontWeight.bold,
                              fontSize: 11,
                            ),
                          ),
                        ),
                        pw.Expanded(
                          flex: 2,
                          child: pw.Text(
                            'Add-ons',
                            style: pw.TextStyle(
                              fontWeight: pw.FontWeight.bold,
                              fontSize: 11,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  pw.Padding(
                    padding: const pw.EdgeInsets.all(10),
                    child: pw.Column(
                      children: passengers.map((p) {
                        final paxType = p.paxType == 'ADT'
                            ? 'Adult'
                            : (p.paxType == 'CHD' ? 'Child' : 'Infant');

                        String extras = '';
                        if (p.ssrAvailability?.mealInfo != null &&
                            p.ssrAvailability!.mealInfo!.isNotEmpty &&
                            p.ssrAvailability!.mealInfo!.first.meals != null &&
                            p
                                .ssrAvailability!
                                .mealInfo!
                                .first
                                .meals!
                                .isNotEmpty) {
                          extras +=
                              "Meal: ${p.ssrAvailability!.mealInfo!.first.meals!.first.name}\n";
                        }
                        if (p.ssrAvailability?.baggageInfo != null &&
                            p.ssrAvailability!.baggageInfo!.isNotEmpty &&
                            p.ssrAvailability!.baggageInfo!.first.baggages !=
                                null &&
                            p
                                .ssrAvailability!
                                .baggageInfo!
                                .first
                                .baggages!
                                .isNotEmpty) {
                          extras +=
                              "Bag: ${p.ssrAvailability!.baggageInfo!.first.baggages!.first.name ?? ''} ${p.ssrAvailability!.baggageInfo!.first.baggages!.first.weight ?? ''}KG\n";
                        }
                        if (extras.isEmpty) extras = '-';

                        return pw.Padding(
                          padding: const pw.EdgeInsets.symmetric(vertical: 4),
                          child: pw.Row(
                            children: [
                              pw.Expanded(
                                flex: 3,
                                child: pw.Text(
                                  '${p.title} ${p.firstName} ${p.lastName}',
                                  style: const pw.TextStyle(fontSize: 10),
                                ),
                              ),
                              pw.Expanded(
                                child: pw.Text(
                                  paxType,
                                  style: const pw.TextStyle(fontSize: 10),
                                ),
                              ),
                              pw.Expanded(
                                flex: 2,
                                child: pw.Text(
                                  p.dob ?? 'N/A',
                                  style: const pw.TextStyle(fontSize: 10),
                                ),
                              ),
                              pw.Expanded(
                                flex: 2,
                                child: pw.Text(
                                  p.passportNo ?? 'N/A',
                                  style: const pw.TextStyle(fontSize: 10),
                                ),
                              ),
                              pw.Expanded(
                                flex: 2,
                                child: pw.Text(
                                  extras,
                                  style: const pw.TextStyle(
                                    fontSize: 9,
                                    color: PdfColors.deepOrange600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
            ),
            pw.SizedBox(height: 20),

            // Payment / Fare Summary
            pw.Container(
              decoration: pw.BoxDecoration(
                border: pw.Border.all(color: PdfColors.grey300),
                borderRadius: const pw.BorderRadius.all(pw.Radius.circular(8)),
              ),
              child: pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Container(
                    width: double.infinity,
                    padding: const pw.EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 10,
                    ),
                    decoration: const pw.BoxDecoration(
                      color: PdfColors.blue900,
                      borderRadius: pw.BorderRadius.only(
                        topLeft: pw.Radius.circular(8),
                        topRight: pw.Radius.circular(8),
                      ),
                    ),
                    child: pw.Text(
                      'Fare Summary',
                      style: pw.TextStyle(
                        color: PdfColors.white,
                        fontWeight: pw.FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  pw.Padding(
                    padding: const pw.EdgeInsets.all(16),
                    child: pw.Column(
                      children: [
                        pw.Row(
                          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                          children: [
                            pw.Text(
                              'Base Fare (${passengers.length} Pax)',
                              style: const pw.TextStyle(fontSize: 12),
                            ),
                            pw.Text(
                              'INR ${(flightOption.flightFares.isNotEmpty ? flightOption.flightFares.first.aprxTotalBaseFare : 0.0).toStringAsFixed(2)}',
                              style: const pw.TextStyle(fontSize: 12),
                            ),
                          ],
                        ),
                        pw.SizedBox(height: 6),
                        pw.Row(
                          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                          children: [
                            pw.Text(
                              'Taxes & Fees',
                              style: const pw.TextStyle(fontSize: 12),
                            ),
                            pw.Text(
                              'INR ${(flightOption.flightFares.isNotEmpty ? flightOption.flightFares.first.aprxTotalTax : 0.0).toStringAsFixed(2)}',
                              style: const pw.TextStyle(fontSize: 12),
                            ),
                          ],
                        ),
                        if (totalMealAmount > 0) ...[
                          pw.SizedBox(height: 6),
                          pw.Row(
                            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                            children: [
                              pw.Text(
                                'Meal Add-ons',
                                style: const pw.TextStyle(fontSize: 12),
                              ),
                              pw.Text(
                                'INR ${totalMealAmount.toStringAsFixed(2)}',
                                style: const pw.TextStyle(fontSize: 12),
                              ),
                            ],
                          ),
                        ],
                        if (totalBaggageAmount > 0) ...[
                          pw.SizedBox(height: 6),
                          pw.Row(
                            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                            children: [
                              pw.Text(
                                'Extra Baggage',
                                style: const pw.TextStyle(fontSize: 12),
                              ),
                              pw.Text(
                                'INR ${totalBaggageAmount.toStringAsFixed(2)}',
                                style: const pw.TextStyle(fontSize: 12),
                              ),
                            ],
                          ),
                        ],
                        if (totalSeatAmount > 0) ...[
                          pw.SizedBox(height: 6),
                          pw.Row(
                            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                            children: [
                              pw.Text(
                                'Seat Selection',
                                style: const pw.TextStyle(fontSize: 12),
                              ),
                              pw.Text(
                                'INR ${totalSeatAmount.toStringAsFixed(2)}',
                                style: const pw.TextStyle(fontSize: 12),
                              ),
                            ],
                          ),
                        ],
                        pw.SizedBox(height: 6),
                        pw.Row(
                          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                          children: [
                            pw.Text(
                              'Service Charge',
                              style: const pw.TextStyle(fontSize: 12),
                            ),
                            pw.Text(
                              'INR ${(state.totalCommission ?? 0.0).toStringAsFixed(2)}',
                              style: const pw.TextStyle(fontSize: 12),
                            ),
                          ],
                        ),
                        pw.Divider(color: PdfColors.grey400),
                        pw.Row(
                          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                          children: [
                            pw.Text(
                              'Total Paid',
                              style: pw.TextStyle(
                                fontSize: 14,
                                fontWeight: pw.FontWeight.bold,
                              ),
                            ),
                            pw.Text(
                              'INR ${state.totalAmountWithCommission?.toStringAsFixed(2) ?? '0.00'}',
                              style: pw.TextStyle(
                                fontSize: 16,
                                fontWeight: pw.FontWeight.bold,
                                color: PdfColors.green800,
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
            pw.SizedBox(height: 30),

            // Footer
            pw.Center(
              child: pw.Text(
                'Thank you for booking with mttrip!',
                style: const pw.TextStyle(
                  fontSize: 12,
                  color: PdfColors.grey700,
                ),
              ),
            ),
            pw.Center(
              child: pw.Text(
                'For support, contact us at mttrip2025@gmail.com | +91 7511100557',
                style: const pw.TextStyle(
                  fontSize: 10,
                  color: PdfColors.grey500,
                ),
              ),
            ),
          ];
        },
      ),
    );

    var fileName =
        'mttrip_Flight_Ticket_${bookingId.isNotEmpty ? bookingId : DateTime.now().millisecondsSinceEpoch}.pdf';
    var byteList = await pdf.save();

    // Request permissions
    var status = await Permission.storage.status;
    if (!status.isGranted) {
      await Permission.storage.request();
    }
    if (Platform.isAndroid) {
      var manageStatus = await Permission.manageExternalStorage.status;
      if (!manageStatus.isGranted) {
        await Permission.manageExternalStorage.request();
      }
    }

    Directory? directory;
    if (Platform.isAndroid) {
      Directory standardDownload = Directory('/storage/emulated/0/Download');
      if (await standardDownload.exists()) {
        directory = standardDownload;
      } else {
        standardDownload = Directory('/storage/emulated/0/Downloads');
        if (await standardDownload.exists()) {
          directory = standardDownload;
        } else {
          // Fallback to app's external directory
          directory = await getExternalStorageDirectory();
        }
      }
    } else {
      // For iOS and others
      directory = await getApplicationDocumentsDirectory();
    }

    if (directory == null) {
      Fluttertoast.showToast(msg: 'Downloads folder not accessible.');
      return;
    }

    var filePath = "${directory.path}/$fileName";
    final file = File(filePath);

    await file.writeAsBytes(byteList);

    log('PDF successfully saved to: $filePath');

    if (context.mounted) {
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text(
            'E-Ticket Downloaded Successfully',
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
          duration: const Duration(seconds: 10),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          action: SnackBarAction(
            label: 'OPEN',
            textColor: Colors.orangeAccent,
            onPressed: () {
              OpenFile.open(filePath);
            },
          ),
        ),
      );
    }
  } catch (e) {
    Fluttertoast.showToast(msg: 'Failed to generate PDF: $e');
    log('PDF generation error: $e');
  }
}
