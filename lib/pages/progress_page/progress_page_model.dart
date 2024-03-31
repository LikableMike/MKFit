import '/flutter_flow/flutter_flow_util.dart';
import 'progress_page_widget.dart' show ProgressPageWidget;
import 'package:flutter/material.dart';

class ProgressPageModel extends FlutterFlowModel<ProgressPageWidget> {
  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    unfocusNode.dispose();
  }
}
