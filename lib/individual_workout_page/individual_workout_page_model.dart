import '/flutter_flow/flutter_flow_util.dart';
import 'individual_workout_page_widget.dart' show IndividualWorkoutPageWidget;
import 'package:flutter/material.dart';

class IndividualWorkoutPageModel
    extends FlutterFlowModel<IndividualWorkoutPageWidget> {
  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    unfocusNode.dispose();
  }
}
