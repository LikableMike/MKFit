import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import 'create_workout_page_widget.dart' show CreateWorkoutPageWidget;
import 'package:flutter/material.dart';

class CreateWorkoutPageModel extends FlutterFlowModel<CreateWorkoutPageWidget> {
  ///  State fields for stateful widgets in this page.

  final formKey = GlobalKey<FormState>();
  // State field(s) for WorkoutName widget.
  FocusNode? workoutNameFocusNode;
  TextEditingController? workoutNameTextController;
  String? Function(BuildContext, String?)? workoutNameTextControllerValidator;
  String? _workoutNameTextControllerValidator(
      BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Please enter the patients full name.';
    }

    return null;
  }

  // State field(s) for description widget.
  FocusNode? descriptionFocusNode;
  TextEditingController? descriptionTextController;
  String? Function(BuildContext, String?)? descriptionTextControllerValidator;
  // State field(s) for CheckboxGroup widget.
  FormFieldController<List<String>>? checkboxGroupValueController;
  List<String>? get checkboxGroupValues => checkboxGroupValueController?.value;
  set checkboxGroupValues(List<String>? v) =>
      checkboxGroupValueController?.value = v;

  @override
  void initState(BuildContext context) {
    workoutNameTextControllerValidator = _workoutNameTextControllerValidator;
  }

  @override
  void dispose() {
    workoutNameFocusNode?.dispose();
    workoutNameTextController?.dispose();

    descriptionFocusNode?.dispose();
    descriptionTextController?.dispose();
  }
}
