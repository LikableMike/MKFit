import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'confirm_new_password_widget.dart' show ConfirmNewPasswordWidget;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ConfirmNewPasswordModel
    extends FlutterFlowModel<ConfirmNewPasswordWidget> {
  ///  State fields for stateful widgets in this page.

  // State field(s) for PhoneNumber widget.
  FocusNode? phoneNumberFocusNode1;
  TextEditingController? phoneNumberTextController1;
  String? Function(BuildContext, String?)? phoneNumberTextController1Validator;
  // State field(s) for PhoneNumber widget.
  FocusNode? phoneNumberFocusNode2;
  TextEditingController? phoneNumberTextController2;
  String? Function(BuildContext, String?)? phoneNumberTextController2Validator;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    phoneNumberFocusNode1?.dispose();
    phoneNumberTextController1?.dispose();

    phoneNumberFocusNode2?.dispose();
    phoneNumberTextController2?.dispose();
  }
}
