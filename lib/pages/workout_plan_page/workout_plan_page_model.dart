import '/flutter_flow/flutter_flow_util.dart';
import 'workout_plan_page_widget.dart' show WorkoutPlanPageWidget;
import 'package:flutter/material.dart';

class WorkoutPlanPageModel extends FlutterFlowModel<WorkoutPlanPageWidget> {
  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    unfocusNode.dispose();
  }
}
