import '/flutter_flow/flutter_flow_util.dart';
import 'change_address_widget.dart' show ChangeAddressWidget;
import 'package:flutter/material.dart';

class ChangeAddressModel extends FlutterFlowModel<ChangeAddressWidget> {
  // State field(s) for email input.
  FocusNode? emailFocusNode;
  TextEditingController? emailTextController;
  String? Function(BuildContext, String?)? emailTextControllerValidator;

  @override
  void initState(BuildContext context) {
    emailTextController = TextEditingController(); // Initialize email text controller
    emailFocusNode = FocusNode(); // Initialize email focus node
  }

  @override
  void dispose() {
    emailFocusNode?.dispose();
    emailTextController?.dispose();
  }
}
