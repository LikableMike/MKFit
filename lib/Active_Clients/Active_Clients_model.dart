import '/flutter_flow/upload_data.dart';
import 'admin_widget.dart' show AdminWidget;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AdminModel extends FlutterFlowModel<AdminWidget> {
  /// State fields for the uploading process.
  bool isDataUploading = false;
  FFUploadedFile uploadedLocalFile = FFUploadedFile(bytes: Uint8List.fromList([]));

  /// Initialize any data or controllers as needed.
  @override
  void initState(BuildContext context) {
    // Optionally: additional setup if required
  }

  /// Dispose of any resources as needed.
  @override
  void dispose() {
    // Cleanup if required
  }

  /// Helper method to handle file upload updates.
  void updateUploadStatus(bool status) {
    isDataUploading = status;
    notifyListeners();
  }

  /// Method to store the uploaded file.
  void setUploadedFile(FFUploadedFile file) {
    uploadedLocalFile = file;
    notifyListeners();
  }
}
