import '/flutter_flow/flutter_flow_util.dart';
import 'change_address_widget.dart' show ChangeAddressWidget;
import 'package:flutter/material.dart';

class ChangeAddressModel extends FlutterFlowModel<ChangeAddressWidget> {
  ///  State fields for stateful widgets in this page.

  // State field(s) for PhoneNumber widget.
  FocusNode? phoneNumberFocusNode1;
  TextEditingController? phoneNumberController1;
  String? Function(BuildContext, String?)? phoneNumberController1Validator;
  // State field(s) for PhoneNumber widget.
  FocusNode? phoneNumberFocusNode2;
  TextEditingController? phoneNumberController2;
  String? Function(BuildContext, String?)? phoneNumberController2Validator;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    phoneNumberFocusNode1?.dispose();
    phoneNumberController1?.dispose();

    phoneNumberFocusNode2?.dispose();
    phoneNumberController2?.dispose();
  }
}
