import 'dart:async';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class PDFLoader {
  static Future<File> loadAsset(String path) async {
    final data = await rootBundle.load(path);
    final byteData = data.buffer.asUint8List();
    final directory = await getTemporaryDirectory();
    final fileName = path.split('/').last;
    final file = File('${directory.path}/$fileName');
    await file.writeAsBytes(byteData, flush: true);
    return file;
  }
}
