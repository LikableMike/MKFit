import 'dart:ffi';

import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'individual_workout_page_model.dart';
export 'individual_workout_page_model.dart';
import 'package:m_k_fit/backend/firebase_storage/database.dart';
import "/backend/firebase_storage/globals.dart" as globals;
import 'package:url_launcher/url_launcher.dart';


class IndividualWorkoutPageWidget extends StatefulWidget {
  const IndividualWorkoutPageWidget({super.key});

  @override
  State<IndividualWorkoutPageWidget> createState() =>
      _IndividualWorkoutPageWidgetState();
}

class _IndividualWorkoutPageWidgetState
    extends State<IndividualWorkoutPageWidget> {
  late IndividualWorkoutPageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => IndividualWorkoutPageModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryText,
        appBar: AppBar(
          backgroundColor: FlutterFlowTheme.of(context).primaryText,
          automaticallyImplyLeading: false,
          leading: FlutterFlowIconButton(
            borderColor: Colors.transparent,
            borderRadius: 30.0,
            borderWidth: 1.0,
            buttonSize: 70.0,
            icon: const Icon(
              Icons.arrow_back_rounded,
              color: Colors.white,
              size: 40.0,
            ),
            onPressed: () async {
              context.pop();
            },
          ),
          title: Text(
            'Shoulder Session',
            style: FlutterFlowTheme.of(context).headlineLarge.override(
                  fontFamily: 'Readex Pro',
                  color: FlutterFlowTheme.of(context).primaryBackground,
                  letterSpacing: 0.0,
                ),
          ),
          actions: const [],
          centerTitle: false,
          elevation: 2.0,
        ),
        body: SafeArea(
          top: true,
          child: SingleChildScrollView(
            child: BuildWorkouts(Workouts: globals.testWorkouts[globals.selectedWorkout],)
          ),
        ),
      ),
    );
  }

}

class WorkoutSection extends StatelessWidget{
  const WorkoutSection({
    this.title = "Exercise Title",
    this.weight = -1,
    this.description = "Placeholder Description",
    this.sets = 2,
    this.reps = 4,
    this.url = "",
});

  final String title;
  final double weight;
  final String description;
  final int sets;
  final int reps;
  final String url;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 230.0,
      decoration: const BoxDecoration(),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Container(

            width: double.infinity,
            height: 80.0,
            decoration: const BoxDecoration(),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                  width: 300.0,
                  height: 105.0,
                  decoration: const BoxDecoration(),
                  child: Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(
                        15.0, 0.0, 0.0, 0.0),
                    child: Text(
                      title,
                      style: FlutterFlowTheme.of(context)
                          .headlineMedium
                          .override(
                        fontFamily: 'Readex Pro',
                        color: FlutterFlowTheme.of(context)
                            .primaryBackground,
                        letterSpacing: 0.0,
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: const AlignmentDirectional(0.0, 0.0),
                  child: Container(
                    width: 40.0,
                    height: 90.0,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: const Color(0xFF86BD92),
                        width: 2.0,
                      ),
                    ),
                    child: Align(
                      alignment:
                      const AlignmentDirectional(0.0, 0.0),
                      child: Text(
                        weight.toString() + " lb",
                        style: FlutterFlowTheme.of(context)
                            .bodyMedium
                            .override(
                          fontFamily: 'Inter',
                          color: FlutterFlowTheme.of(context)
                              .primaryBackground,
                          letterSpacing: 0.0,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: double.infinity,
            height: 144.0,
            decoration: const BoxDecoration(),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Align(
                  alignment: const AlignmentDirectional(-1.0, 0.0),
                  child: Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(
                        15.0, 0.0, 0.0, 15.0),
                    child: Text(
                      description,
                      style: FlutterFlowTheme.of(context)
                          .bodyMedium
                          .override(
                        fontFamily: 'Inter',
                        color: FlutterFlowTheme.of(context)
                            .primaryBackground,
                        letterSpacing: 0.0,
                      ),
                    ),
                  ),
                ),
                Container(
                  width: double.infinity,
                  height: 42.0,
                  decoration: const BoxDecoration(),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Align(
                        alignment:
                        const AlignmentDirectional(-1.0, -1.0),
                        child: Padding(
                          padding:
                          const EdgeInsetsDirectional.fromSTEB(
                              5.0, 5.0, 0.0, 0.0),
                          child: Container(
                            width: 40.0,
                            height: 40.0,
                            decoration: const BoxDecoration(),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Align(
                                  alignment:
                                  const AlignmentDirectional(
                                      0.0, 0.0),
                                  child: Text(
                                    '0/' + sets.toString(),
                                    textAlign: TextAlign.center,
                                    style:
                                    FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .override(
                                      fontFamily: 'Inter',
                                      color: FlutterFlowTheme
                                          .of(context)
                                          .secondaryBackground,
                                      letterSpacing: 0.0,
                                      fontWeight:
                                      FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Align(
                                  alignment:
                                  const AlignmentDirectional(
                                      0.0, 0.0),
                                  child: Text(
                                    'Sets',
                                    textAlign: TextAlign.center,
                                    style:
                                    FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .override(
                                      fontFamily: 'Inter',
                                      color: FlutterFlowTheme
                                          .of(context)
                                          .secondaryBackground,
                                      letterSpacing: 0.0,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SetBubble(height: 40.0,width: 40.0,reps: reps,sets: sets)
                    ],
                  ),
                ),
                Container(
                  width: double.infinity,
                  height: 70.0,
                  decoration: const BoxDecoration(),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Container(
                        width: 60.0,
                        height: 94.0,
                        decoration: const BoxDecoration(),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            FlutterFlowIconButton(
                              borderRadius: 20.0,
                              borderWidth: 1.0,
                              buttonSize: 44.0,
                              icon: const Icon(
                                Icons.ondemand_video_outlined,
                                color: Color(0xFF86BD92),
                                size: 35.0,
                              ),
                              onPressed: () async {
                                print(url);
                                final Uri URL = Uri.parse(url);
                                if (!await launchUrl(URL)) {
                                  throw Exception('Could not launch $URL');
                                }
                              },
                            ),
                            Text(
                              'Video',
                              textAlign: TextAlign.center,
                              style: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                fontFamily: 'Inter',
                                color:
                                FlutterFlowTheme.of(context)
                                    .primaryBackground,
                                fontSize: 14.0,
                                letterSpacing: 0.0,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: 54.0,
                        height: 94.0,
                        decoration: const BoxDecoration(),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            FlutterFlowIconButton(
                              borderRadius: 20.0,
                              borderWidth: 1.0,
                              buttonSize: 44.0,
                              icon: const Icon(
                                Icons.assignment_rounded,
                                color: Color(0xFF86BD92),
                                size: 35.0,
                              ),
                              onPressed: () {
                                print('IconButton pressed ...');
                              },
                            ),
                            Text(
                              'Details',
                              textAlign: TextAlign.center,
                              style: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                fontFamily: 'Inter',
                                color:
                                FlutterFlowTheme.of(context)
                                    .primaryBackground,
                                fontSize: 14.0,
                                letterSpacing: 0.0,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

}
class SetBubble extends StatelessWidget {
  const SetBubble({
    this.height = 40.0,
    this.width = 40.0,
    this.reps = 2,
    this.sets = 2,
    super.key,
  });

  final double height;
  final double width;
  final int reps;
  final int sets;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(sets, (index) {
        return Container(
          width: 40.0,
          height: 40.0,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: FlutterFlowTheme
                  .of(context)
                  .primaryBackground,
              width: 2.0,
            ),
          ),
          child: Align(
            alignment: const AlignmentDirectional(
                0.0, 0.0),
            child: Text(
              reps != null ? reps.toString() : "Loading",
              style: FlutterFlowTheme
                  .of(context)
                  .bodyMedium
                  .override(
                fontFamily: 'Inter',
                color: FlutterFlowTheme
                    .of(
                    context)
                    .primaryBackground,
                fontSize: 18.0,
                letterSpacing: 0.0,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
        );
      }),
    );
  }
}

class BuildWorkouts extends StatelessWidget {
  const BuildWorkouts({
    required this.Workouts,

  });

  final List Workouts;


  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(Workouts.length, (index) {
        return WorkoutSection(title: Workouts[index]["name"], weight: Workouts[index]["weight"], description: Workouts[index]["description"], sets: Workouts[index]["sets"], reps: Workouts[index]["reps"], url: Workouts[index]["video_sample"],);
      }),
    );
  }
}

