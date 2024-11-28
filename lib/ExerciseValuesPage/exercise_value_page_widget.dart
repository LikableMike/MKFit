import 'dart:ffi';

import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'exercise_value_page_model.dart';
export 'exercise_value_page_model.dart';
import 'package:m_k_fit/backend/firebase_storage/database.dart';
import "/backend/firebase_storage/globals.dart" as globals;

class ExerciseValuePageWidget extends StatefulWidget {
  const ExerciseValuePageWidget({
    super.key,
    this.exercises,
  });

  final exercises;
  @override
  State<ExerciseValuePageWidget> createState() =>
      _ExerciseValuePageWidgetState();
}

class _ExerciseValuePageWidgetState
    extends State<ExerciseValuePageWidget> {
  late ExerciseValuePageModel _model;
  List<dynamic> workouts = [];

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ExerciseValuePageModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
    fetchExercises();
    globals.builtWorkout.clear();
  }

  Future<void> fetchExercises() async {
    try {
      // Fetch documents from the 'exercises_test' collection
      List<dynamic> workoutNames = await DatabaseService().fetchWorkoutExercises(globals.selectedWorkout);

      // Update the state to reflect the fetched exercises
      setState(() {
        workouts = workoutNames;
      });
    } catch (e) {
      print('Error fetching exercises: $e');
    }
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
            globals.selectedWorkout,
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
          child:
          Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child:  Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                      child:
                          BuildWorkouts(Workouts: workouts)
                    ),





                  ],
                ),

              ),
              Container(
                constraints: BoxConstraints(
                  maxWidth: 770.0,
                ),
                decoration: BoxDecoration(),
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(16.0, 12.0, 16.0, 12.0),
                  child: FFButtonWidget(
                    onPressed: () async {
                      // Button action here
                      print(globals.builtWorkout);
                      DatabaseService().assignWorkout();
                    },
                    text: 'Assign Workout',
                    options: FFButtonOptions(
                      width: double.infinity,
                      height: 48.0,
                      color: Color(0xFF87A88E),
                      textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                        fontFamily: 'Figtree',
                        color: Color(0xFF364233),
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                      elevation: 3.0,
                      borderSide: BorderSide(
                        color: Colors.transparent,
                        width: 1.0,
                      ),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                ),
              ),
            ],
          ),

        ),
      ),
    );
  }

}

class WorkoutSection extends StatefulWidget {
  WorkoutSection({
    this.title = "Exercise Title",
    this.weight = -1,
    this.description = "Placeholder Description",
    this.sets = 2,
    this.reps = 4,
    this.uid = "",
    this.index = 0
  });

  final String title;
  final double weight;
  final String description;
  final int reps;
  int sets;
  String uid;
  int index;

  @override
  _WorkoutSectionState createState() => _WorkoutSectionState();
}

class _WorkoutSectionState extends State<WorkoutSection> {
  late int sets;
  late int reps;
  late double weight;
  late String uid;
  late int index;
  @override
  void initState() {

    super.initState();
    sets = widget.sets;
    reps = widget.reps;
    weight = widget.weight;// Initialize with the passed-in value
    uid = widget.uid;
    index = widget.index;
    globals.builtWorkout.add({"uid" : uid, "reps" : reps, "sets" : sets, "weight" : weight});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 300.0,
      decoration: const BoxDecoration(),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Container(

            width: double.infinity,
            height: 86.0,
            decoration: const BoxDecoration(),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  width: 300.0,
                  height: 70.0,
                  decoration: const BoxDecoration(),

                  child: Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(
                        15.0, 0.0, 0.0, 0.0),
                    child: Text(
                      widget.title,
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

              ],
            ),
          ),
          Container(
            width: double.infinity,
            height: 214.0,
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
                      widget.description,
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
                  height: 41.0,
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
                              10.0, 5.0, 0.0, 0.0),
                          child: Container(
                            width:300,
                            height: 40.0,
                            decoration: const BoxDecoration(),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [

                                  Text(
                                    'Sets: ',
                                    textAlign: TextAlign.center,
                                    style:
                                    FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .override(
                                      fontSize: 25,
                                      fontFamily: 'Inter',
                                      color: FlutterFlowTheme
                                          .of(context)
                                          .secondaryBackground,
                                      letterSpacing: 0.0,
                                    ),
                                  ),


                                     FlutterFlowIconButton(
                                      borderRadius: 20.0,
                                      borderWidth: 1.0,
                                      buttonSize: 50.0,
                                      icon: const Icon(
                                        Icons.chevron_left,
                                        color: Color(0xFF86BD92),
                                        size: 30.0,
                                      ),
                                      onPressed: () {
                                        setState((){
                                          sets -= 1;
                                          globals.builtWorkout[index]["sets"] = sets;
                                        });

                                      },
                                    ),

                                    Text(sets.toString(),
                                      textAlign: TextAlign.center,
                                      style:
                                      FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                        fontSize: 21,
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.bold,
                                        color: FlutterFlowTheme
                                            .of(context)
                                            .secondaryBackground,
                                        letterSpacing: 0.0,

                                      ),),

                                FlutterFlowIconButton(
                                  borderRadius: 20.0,
                                  borderWidth: 1.0,
                                  buttonSize: 50.0,
                                  icon: const Icon(
                                    Icons.chevron_right,
                                    color: Color(0xFF86BD92),
                                    size: 30.0,
                                  ),
                                  onPressed: () {
                                    setState((){
                                      sets += 1;
                                      globals.builtWorkout[index]["sets"] = sets;
                                    });

                                  },
                                ),


                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: double.infinity,
                  height: 41.0,
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
                              10.0, 5.0, 0.0, 0.0),
                          child: Container(
                            width:300,
                            height: 40.0,
                            decoration: const BoxDecoration(),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [

                                Text(
                                  'Reps: ',
                                  textAlign: TextAlign.center,
                                  style:
                                  FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                    fontSize: 25,
                                    fontFamily: 'Inter',
                                    color: FlutterFlowTheme
                                        .of(context)
                                        .secondaryBackground,
                                    letterSpacing: 0.0,
                                  ),
                                ),

                                FlutterFlowIconButton(
                                  borderRadius: 20.0,
                                  borderWidth: 1.0,
                                  buttonSize: 50.0,
                                  icon: const Icon(
                                    Icons.chevron_left,
                                    color: Color(0xFF86BD92),
                                    size: 30.0,
                                  ),
                                  onPressed: () {
                                    setState((){
                                      reps -= 1;
                                      globals.builtWorkout[index]["reps"] = reps;
                                    });

                                  },
                                ),
                               Text(reps.toString(),
                                      textAlign: TextAlign.left,
                                 style:
                                 FlutterFlowTheme.of(context)
                                     .bodyMedium
                                     .override(
                                   fontSize: 21,
                                   fontFamily: 'Inter',
                                   fontWeight: FontWeight.bold,
                                   color: FlutterFlowTheme
                                       .of(context)
                                       .secondaryBackground,
                                   letterSpacing: 0.0,

                                 ),),
                                FlutterFlowIconButton(
                                  borderRadius: 20.0,
                                  borderWidth: 1.0,
                                  buttonSize: 50.0,
                                  icon: const Icon(
                                    Icons.chevron_right,
                                    color: Color(0xFF86BD92),
                                    size: 30.0,
                                  ),
                                  onPressed: () {
                                    setState((){
                                      reps += 1;
                                      globals.builtWorkout[index]["reps"] = reps;
                                    });

                                  },
                                ),


                              ],
                            ),
                          ),


                        ),
                      ),
                    ],
                  ),
                ),

                Container(
                  width: double.infinity,
                  height: 41.0,
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
                              10.0, 5.0, 0.0, 0.0),
                          child: Container(
                            width:300,
                            height: 40.0,
                            decoration: const BoxDecoration(),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [

                                Text(
                                  'Weight: ',
                                  textAlign: TextAlign.center,
                                  style:
                                  FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                    fontSize: 25,
                                    fontFamily: 'Inter',
                                    color: FlutterFlowTheme
                                        .of(context)
                                        .secondaryBackground,
                                    letterSpacing: 0.0,
                                  ),
                                ),

                                FlutterFlowIconButton(
                                  borderRadius: 20.0,
                                  borderWidth: 1.0,
                                  buttonSize: 50.0,
                                  icon: const Icon(
                                    Icons.chevron_left,
                                    color: Color(0xFF86BD92),
                                    size: 30.0,
                                  ),
                                  onPressed: () {
                                    setState((){
                                      weight -= 5;
                                      globals.builtWorkout[index]["weight"] = weight;
                                    });

                                  },
                                ),

                                Text(weight.toString(),
                                      textAlign: TextAlign.left,
                                  style:
                                  FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                    fontSize: 21,
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.bold,
                                    color: FlutterFlowTheme
                                        .of(context)
                                        .secondaryBackground,
                                    letterSpacing: 0.0,

                                  ),),


                                FlutterFlowIconButton(
                                  borderRadius: 20.0,
                                  borderWidth: 1.0,
                                  buttonSize: 50.0,
                                  icon: const Icon(
                                    Icons.chevron_right,
                                    color: Color(0xFF86BD92),
                                    size: 30.0,
                                  ),
                                  onPressed: () {
                                    setState((){
                                      weight += 5;
                                      globals.builtWorkout[index]["weight"] = weight;
                                    });

                                  },
                                ),

                              ],
                            ),
                          ),
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


class BuildWorkouts extends StatelessWidget {
  const BuildWorkouts({

    required this.Workouts,

  });

  final List Workouts;


  @override
  Widget build(BuildContext context) {

    return ListView(
      padding: const EdgeInsets.fromLTRB(
        0,
        0,
        0,
        44.0,
      ),
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      children: List.generate(Workouts.length, (index) {

        return WorkoutSection(title: Workouts[index]['name'], weight: 10, description: Workouts[index]['description'], sets: 5, reps: 5, uid: Workouts[index]['uid'].toString(), index: index);

      }),
    );
  }
}

