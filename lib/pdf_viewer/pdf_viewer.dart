import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'dart:io';

class PDFViewerPage extends StatelessWidget {
  final File pdfFile;

  const PDFViewerPage({Key? key, required this.pdfFile}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Workout'),
      ),
      body: PDFView(
        filePath: pdfFile.path,
      ),
    );
  }
}
