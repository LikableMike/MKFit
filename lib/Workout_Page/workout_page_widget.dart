import '/flutter_flow/flutter_flow_choice_chips.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import 'workout_page_model.dart';
import 'package:flutter/material.dart';

class WorkoutPageWidget extends StatefulWidget {
  const WorkoutPageWidget({Key? key}) : super(key: key);

  @override
  State<WorkoutPageWidget> createState() => _WorkoutPageWidgetState();
}

class _WorkoutPageWidgetState extends State<WorkoutPageWidget> {
  late WorkoutPageModel _model;

  @override
  void initState() {
    super.initState();
    _model = WorkoutPageModel();
  }

  @override
  void dispose() {
    _model.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
      appBar: AppBar(
        title: Text("Create Workout"),
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Workout Categories", style: FlutterFlowTheme.of(context).headlineSmall),
            SizedBox(height: 16),
            FlutterFlowChoiceChips(
              options: [
                ChipData('Strength'),
                ChipData('Cardio'),
                ChipData('Flexibility'),
                ChipData('Core')
              ],
              onChanged: (val) => setState(() => _model.choiceChipsValue1 = val?.firstOrNull),
              selectedChipStyle: ChipStyle(
                backgroundColor: Colors.blue,
                textStyle: FlutterFlowTheme.of(context).bodyMedium.override(
                      fontFamily: 'Inter',
                      color: Colors.white,
                    ),
              ),
              unselectedChipStyle: ChipStyle(
                backgroundColor: Colors.grey[300],
                textStyle: FlutterFlowTheme.of(context).bodyMedium,
              ),
              controller: _model.choiceChipsValueController1 ??= FormFieldController<List<String>>([]),
            ),
            SizedBox(height: 24),
            // Additional categories can be added here, using similar FlutterFlowChoiceChips configurations
          ],
        ),
      ),
    );
  }
}
