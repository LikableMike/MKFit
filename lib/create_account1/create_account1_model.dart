import '/flutter_flow/flutter_flow_util.dart';
import 'create_account1_widget.dart' show CreateAccount1Widget;
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class CreateAccount1Model extends FlutterFlowModel<CreateAccount1Widget> {
  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  // State field(s) for FullName widget.
  FocusNode? fullNameFocusNode;
  TextEditingController? fullNameController;
  String? Function(BuildContext, String?)? fullNameControllerValidator;
  // State field(s) for emailAddress widget.
  FocusNode? emailAddressFocusNode;
  TextEditingController? emailAddressController;
  String? Function(BuildContext, String?)? emailAddressControllerValidator;
  // State field(s) for phoneNumber widget.
  FocusNode? phoneNumberFocusNode;
  TextEditingController? phoneNumberController;
  final phoneNumberMask = MaskTextInputFormatter(mask: '(###) ###-####');
  String? Function(BuildContext, String?)? phoneNumberControllerValidator;
  // State field(s) for Height widget.
  FocusNode? heightFocusNode;
  TextEditingController? heightController;
  String? Function(BuildContext, String?)? heightControllerValidator;
  // State field(s) for Weight widget.
  FocusNode? weightFocusNode;
  TextEditingController? weightController;
  String? Function(BuildContext, String?)? weightControllerValidator;
  // State field(s) for userName widget.
  FocusNode? userNameFocusNode;
  TextEditingController? userNameController;
  String? Function(BuildContext, String?)? userNameControllerValidator;
  // State field(s) for password widget.
  FocusNode? passwordFocusNode;
  TextEditingController? passwordController;
  late bool passwordVisibility;
  String? Function(BuildContext, String?)? passwordControllerValidator;
  // State field(s) for passwordConfirm widget.
  FocusNode? passwordConfirmFocusNode;
  TextEditingController? passwordConfirmController;
  late bool passwordConfirmVisibility;
  String? Function(BuildContext, String?)? passwordConfirmControllerValidator;

  @override
  void initState(BuildContext context) {
    passwordVisibility = false;
    passwordConfirmVisibility = false;
  }

  @override
  void dispose() {
    unfocusNode.dispose();
    fullNameFocusNode?.dispose();
    fullNameController?.dispose();

    emailAddressFocusNode?.dispose();
    emailAddressController?.dispose();

    phoneNumberFocusNode?.dispose();
    phoneNumberController?.dispose();

    heightFocusNode?.dispose();
    heightController?.dispose();

    weightFocusNode?.dispose();
    weightController?.dispose();

    userNameFocusNode?.dispose();
    userNameController?.dispose();

    passwordFocusNode?.dispose();
    passwordController?.dispose();

    passwordConfirmFocusNode?.dispose();
    passwordConfirmController?.dispose();
  }
}
