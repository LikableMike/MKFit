import '/flutter_flow/flutter_flow_choice_chips.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';

class WorkoutPageModel {
  // State fields for ChoiceChips widgets
  FormFieldController<List<String>>? choiceChipsValueController1;
  FormFieldController<List<String>>? choiceChipsValueController2;
  FormFieldController<List<String>>? choiceChipsValueController3;
  FormFieldController<List<String>>? choiceChipsValueController4;

  String? get choiceChipsValue1 => choiceChipsValueController1?.value?.firstOrNull;
  set choiceChipsValue1(String? val) => choiceChipsValueController1?.value = val != null ? [val] : [];

  String? get choiceChipsValue2 => choiceChipsValueController2?.value?.firstOrNull;
  set choiceChipsValue2(String? val) => choiceChipsValueController2?.value = val != null ? [val] : [];

  String? get choiceChipsValue3 => choiceChipsValueController3?.value?.firstOrNull;
  set choiceChipsValue3(String? val) => choiceChipsValueController3?.value = val != null ? [val] : [];

  String? get choiceChipsValue4 => choiceChipsValueController4?.value?.firstOrNull;
  set choiceChipsValue4(String? val) => choiceChipsValueController4?.value = val != null ? [val] : [];

  void dispose() {
    choiceChipsValueController1?.dispose();
    choiceChipsValueController2?.dispose();
    choiceChipsValueController3?.dispose();
    choiceChipsValueController4?.dispose();
  }
}
