import '/flutter_flow/flutter_flow_util.dart';
import 'create_excersise_widget.dart' show CreateExcersiseWidget;
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class CreateExcersiseModel extends FlutterFlowModel<CreateExcersiseWidget> {
  ///  State fields for stateful widgets in this page.

  final formKey = GlobalKey<FormState>();
  // State field(s) for fullName widget.
  FocusNode? fullNameFocusNode;
  TextEditingController? fullNameTextController;
  String? Function(BuildContext, String?)? fullNameTextControllerValidator;
  String? _fullNameTextControllerValidator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Please enter the name of the exercise.';
    }

    return null;
  }

  // State field(s) for age widget.
  FocusNode? DocLinkFocusNode;
  TextEditingController? DocLinkController;
  String? Function(BuildContext, String?)? DocLinkControllerValidator;
  

  // State field(s) for phoneNumber widget.
  FocusNode? phoneNumberFocusNode;
  TextEditingController? phoneNumberTextController;
  String? Function(BuildContext, String?)? phoneNumberTextControllerValidator;
  // State field(s) for description widget.
  FocusNode? descriptionFocusNode;
  TextEditingController? descriptionTextController;
  String? Function(BuildContext, String?)? descriptionTextControllerValidator;
  // State field(s) for VideoLink widget.
  FocusNode? videoLinkFocusNode;
  TextEditingController? videoLinkTextController;
  final videoLinkMask = MaskTextInputFormatter(mask: '##/##/####');
  String? Function(BuildContext, String?)? videoLinkTextControllerValidator;
  bool isDataUploading = false;
  FFUploadedFile uploadedLocalFile =
      FFUploadedFile(bytes: Uint8List.fromList([]));
  String uploadedFileUrl = '';

  @override
  void initState(BuildContext context) {
    fullNameTextControllerValidator = _fullNameTextControllerValidator;
  }

  @override
  void dispose() {
    fullNameFocusNode?.dispose();
    fullNameTextController?.dispose();

    DocLinkFocusNode?.dispose();
    DocLinkController?.dispose();

    phoneNumberFocusNode?.dispose();
    phoneNumberTextController?.dispose();

    descriptionFocusNode?.dispose();
    descriptionTextController?.dispose();

    videoLinkFocusNode?.dispose();
    videoLinkTextController?.dispose();
  }
}
