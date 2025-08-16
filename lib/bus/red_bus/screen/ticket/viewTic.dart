import 'dart:io';
import 'dart:typed_data';

import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:permission_handler/permission_handler.dart';

// class PdfPageScreeenn extends StatelessWidget {
//    PdfPageScreeenn({Key? key}) : super(key: key);
//   final pdf = pw.Document();
//   @override
//   Widget build(BuildContext context) {

//     return Scaffold(
//       body: Column(
//         children: [

//         ],
//       ),
//     );
//   }
// }

class CreatePdf {
  createPdf2() async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          //pdf formating
          return pw.Column(
            children: [
              pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Text('Invoice',
                        style: pw.TextStyle(
                            fontWeight: pw.FontWeight.bold, fontSize: 30)),
                    pw.Text(
                      'Date and Invoicec Number',
                      style: const pw.TextStyle(fontSize: 20),
                    )
                  ]),
              pw.SizedBox(height: 50),
              pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceEvenly,
                  children: [
                    pw.Column(children: [
                      pw.Text("Billed To",
                          style: const pw.TextStyle(fontSize: 25)),
                      pw.Text('clinet : ...',
                          style: const pw.TextStyle(fontSize: 25))
                    ]),
                    pw.Column(children: [
                      pw.Text('Your Company Name',
                          style: const pw.TextStyle(fontSize: 20)),
                      pw.Text('Deatils : ...',
                          style: const pw.TextStyle(fontSize: 20))
                    ])
                  ]),
              pw.SizedBox(height: 50),
              pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Text('Cart Total: ',
                      style: const pw.TextStyle(fontSize: 20)),
                  pw.SizedBox(height: 10),
                  pw.Text('Cart Discount(50%off):',
                      style: const pw.TextStyle(fontSize: 20)),
                  pw.SizedBox(height: 10),
                  pw.Text('Tax (0.5%): ',
                      style: const pw.TextStyle(fontSize: 20)),
                  pw.SizedBox(height: 10),
                  pw.Text('Total: ',
                      style: pw.TextStyle(
                          fontSize: 20, fontWeight: pw.FontWeight.bold))
                ],
              ),
            ],
          );
        },
      ),
    );
    var fileName = 'Invoice';
    var byteList = await pdf.save();
    var status = await Permission.storage.status;
    await Permission.storage.request();
    await Permission.manageExternalStorage.request();
    if (!status.isGranted) {
      await Permission.storage.request();
    }
    // final directory = await getTemporaryDirectory();
    var directory = Directory('/storage/emulated/0/Download');
    var filePath = "${directory.path}/$fileName.pdf";
    print(filePath);
    final file = File(filePath);

    var finalfile = await file.writeAsBytes(byteList);
    print(finalfile);
  }
}

Future<void> savePdfFile(String fileName, Uint8List byteList) async {
  var status = await Permission.storage.status;
  if (!status.isGranted) {
    await Permission.storage.request();
  }
  // final directory = await getTemporaryDirectory();
  var directory = Directory('/storage/emulated/0/Download');
  var filePath = "${directory.path}/$fileName.pdf";
  print(filePath);
  final file = File(filePath);
  await file.writeAsBytes(byteList);
}
