/*
Ramin Selseleh

Jira Task MA - 54 - Sub task MA - 109.

For this tasks, we have cretaed a myProgress page, in which teh user using the app
is able to update the data that they want to keep track of and see how much
they have progressed. I have added an option for the user to update their weight and height
once they click on the plus (+) icon on the weight page. At the buttom of the page
they are now able to upload images from their phone to keep track of their progress.
 */


import '/flutter_flow/flutter_flow_charts.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/random_data_util.dart' as random_data;
import 'progress_page_widget.dart' show ProgressPageWidget;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

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

