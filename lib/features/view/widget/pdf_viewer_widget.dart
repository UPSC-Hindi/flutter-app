import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:upsc_web/utils/utils.dart';

class PdfViewerWidget extends StatelessWidget {
  final String url;
  const PdfViewerWidget({super.key, required this.url});
  @override
  Widget build(BuildContext context) {
    print(url);
    return Scaffold(
      appBar: AppBar(),
      body: SfPdfViewer.network(
        'https://cdn.syncfusion.com/content/PDFViewer/flutter-succinctly.pdf',
        // url,
        onDocumentLoaded: (details) {
          Utils.flutterToast("Successfullly Loaded");
        },
        onDocumentLoadFailed: (details) {
          print(details.error);
          Utils.toastMessage(details.description);
        },
      ),
    );
  }
}
