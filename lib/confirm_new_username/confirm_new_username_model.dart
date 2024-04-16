/*
Ramin Selseleh
Jira Task MA-52. Sub tasks MA - 106, 107, and 108.

For this task, I was in charge of
making sure that all of the buttons within the settings page have functionalities and they are doing
what they're supposed to do. To complete task, I had to create pages such as
change_address and confirm_new_username. The other pages that were already created
so I only needed to creat these two. Within all of the pages located inside the settings page
I added a navigate back function, so whe you clikk on thos pages, you can navigate back to teh settings
page.
 */


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
