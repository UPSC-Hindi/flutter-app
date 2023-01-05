import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:pdf_render/pdf_render_widgets.dart';
import 'package:pdfx/pdfx.dart';

class PdfViewerWidget extends StatefulWidget {
  final Uint8List bytes;
  const PdfViewerWidget({super.key, required this.bytes});

  @override
  State<PdfViewerWidget> createState() => _PdfViewerWidgetState();
}

class _PdfViewerWidgetState extends State<PdfViewerWidget> {
  PdfController? pdfController;
  @override
  void initState() {
  pdfController = PdfController(
      document: PdfDocument.openData(widget.bytes),
    );
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: PdfView(
        controller: pdfController!,
      ),
    );
  }
}
