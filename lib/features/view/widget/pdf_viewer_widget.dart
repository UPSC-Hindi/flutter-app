import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:pdf_render/pdf_render_widgets.dart';

class PdfViewerWidget extends StatelessWidget {
  final Uint8List bytes;
  const PdfViewerWidget({super.key, required this.bytes});
  @override
  Widget build(BuildContext context) {
    print(bytes);
    return Scaffold(
      appBar: AppBar(),
      body: PdfViewer.openData(bytes),
    );
  }
}
