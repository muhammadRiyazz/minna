// import 'dart:io';

// import 'package:flutter/material.dart';

// import 'package:syncfusion_flutter_pdf/pdf.dart';

// import 'package:open_file/open_file.dart';
// import 'package:path_provider/path_provider.dart';

// class ViewTic extends StatefulWidget {
//   const ViewTic({Key? key}) : super(key: key);

//   @override
//   State<ViewTic> createState() => _ViewTicState();
// }

// class _ViewTicState extends State<ViewTic> {
//   Future<void> _createPDF() async {
//     //Create a PDF document.
//     print('hieee');
//     var document = PdfDocument();

//     //Add page and draw text to the page.
//     document.pages.add().graphics.drawString(
//         'Hello World!', PdfStandardFont(PdfFontFamily.helvetica, 18),
//         brush: PdfSolidBrush(PdfColor(0, 0, 0)),
//         bounds: Rect.fromLTWH(0, 0, 500, 30));

//     //Save the document
//     List<int> bytes = await document.save();

//     // Dispose the document
//     document.dispose();
//     print('hieee');
//     //Save the file and launch/download
//     SaveFile.saveAndLaunchFile(bytes, 'output.pdf');
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('View Ticket'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             TextButton(
//               child: Text(
//                 'Generate PDF',
//                 style: TextStyle(color: Colors.white),
//               ),
//               style: ButtonStyle(
//                   backgroundColor: MaterialStateProperty.resolveWith(
//                       (states) => Colors.blue)),
//               onPressed: _createPDF,
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }

// class SaveFile {
//   static Future<void> saveAndLaunchFile(
//       List<int> bytes, String fileName) async {
//     //Get external storage directory
//     Directory directory = await getApplicationSupportDirectory();
//     //Get directory path
//     String path = directory.path;
//     //Create an empty file to write PDF data
//     File file = File('$path/$fileName');
//     //Write PDF data
//     await file.writeAsBytes(bytes, flush: true);
//     //Open the PDF document in mobile
//     await OpenFile.open('$path/$fileName');
//   }
// }
