/*

Ramin Selseleh
Parent: MA-148. Subtask: MA-152.

The goal for this task was to solve the cancel button and give it functionality. Now, when cancle
button is pressed , it goes back to log in page.

Also, preoiusly, users were able to sign the waiver without accepting the terms of
services. Now, users can not go to the next page or sign the waiver if they have not checked the
box that states they accepted the terms of services.

 */


import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'waiver_widget.dart' show WaiverWidget;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class WaiverModel extends FlutterFlowModel<WaiverWidget> {
  ///  State fields for stateful widgets in this page.

  // State field(s) for Checkbox widget.
  bool? checkboxValue;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
