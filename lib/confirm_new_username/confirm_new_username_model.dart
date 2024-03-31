import '/flutter_flow/flutter_flow_util.dart';
import 'confirm_new_username_widget.dart' show ConfirmNewUsernameWidget;
import 'package:flutter/material.dart';

class ConfirmNewUsernameModel
    extends FlutterFlowModel<ConfirmNewUsernameWidget> {
  ///  State fields for stateful widgets in this page.

  // State field(s) for emailAddress widget.
  FocusNode? emailAddressFocusNode;
  TextEditingController? emailAddressController;
  String? Function(BuildContext, String?)? emailAddressControllerValidator;
  // State field(s) for PhoneNumber widget.
  FocusNode? phoneNumberFocusNode;
  TextEditingController? phoneNumberController;
  String? Function(BuildContext, String?)? phoneNumberControllerValidator;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    emailAddressFocusNode?.dispose();
    emailAddressController?.dispose();

    phoneNumberFocusNode?.dispose();
    phoneNumberController?.dispose();
  }
}
