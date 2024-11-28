import '/flutter_flow/flutter_flow_checkbox_group.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import 'package:flutter/material.dart';
import '../backend/firebase_storage/database.dart';
import 'package:flutter/services.dart';
import 'exercise_list_model.dart';
export 'exercise_list_model.dart';
import "/backend/firebase_storage/globals.dart" as globals;

class ExerciseListWidget extends StatefulWidget {
  const ExerciseListWidget({super.key});

  @override
  State<ExerciseListWidget> createState() =>
      _ExerciseListWidgetState();
}

class _ExerciseListWidgetState extends State<ExerciseListWidget> {
  late ExerciseListModel _model;
  List<String> selectedWorkouts = [];
  List<String> workouts = [];
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final DatabaseService _databaseService = DatabaseService();



  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ExerciseListModel());

    _model.workoutNameTextController ??= TextEditingController();
    _model.workoutNameFocusNode ??= FocusNode();
    _model.workoutNameFocusNode!.addListener(() => safeSetState(() {}));
    _model.descriptionTextController ??= TextEditingController();
    _model.descriptionFocusNode ??= FocusNode();
    _model.descriptionFocusNode!.addListener(() => safeSetState(() {}));
    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }



  @override
  void dispose() {
    _model.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    DatabaseService databaseService = DatabaseService();
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryText,
        appBar: AppBar(
          backgroundColor: FlutterFlowTheme.of(context).primaryText,
          automaticallyImplyLeading: false,
          title: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Update Exercise"
              )

            ].divide(const SizedBox(height: 4.0)),
          ),
          actions: [
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(0.0, 8.0, 12.0, 8.0),
              child: FlutterFlowIconButton(
                borderColor: const Color(0xFFE5E7EB),
                borderRadius: 12.0,
                borderWidth: 1.0,
                buttonSize: 40.0,
                fillColor: Colors.white,
                icon: const Icon(
                  Icons.close_rounded,
                  color: Color(0xFF15161E),
                  size: 24.0,
                ),
                onPressed: () async {
                  context.safePop();
                },
              ),
            ),
          ],
          centerTitle: false,
          elevation: 0.0,
        ),
        body: SafeArea(
          top: true,
          child: Column(
              children: [
                Expanded(child: FutureBuilder<Map>(
                  future: DatabaseService().getAllExercises(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      // Show a loading spinner while waiting for data
                      return Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      // Show error message if something went wrong
                      return Center(child: Text('Error: ${snapshot.error}'));
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      // Show a message if the list is empty
                      return Center(child: Text('No Exercises found.'));
                    }

                    // If data is loaded successfully, use it
                    Map exercises = snapshot.data!;
                    return BuildExerciseList(Exercises: exercises);
                  },
                ),),




                Padding(
                    padding:
                    const EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0),
                    child: Container(
                      width: 350.0,
                      height: 80.0,
                      decoration: BoxDecoration(
                        color: const Color(0xFF00831B),
                        boxShadow: const [
                          BoxShadow(
                            blurRadius: 3.0,
                            color: Color(0x33000000),
                            offset: Offset(
                              0.0,
                              1.0,
                            ),
                          )
                        ],
                        borderRadius: BorderRadius.circular(16.0),
                        border: Border.all(
                          color: const Color(0xFF00831B),
                          width: 2.0,
                        ),
                      ),
                      child: Stack(
                        children: [
                          Align(
                            alignment: const AlignmentDirectional(0.0, 0.0),
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(12.0),
                                child: ColoredBox(color: Colors.transparent)
                            ),
                          ),
                          Container(
                            width: double.infinity,
                            height: double.infinity,
                            decoration: BoxDecoration(
                              color: const Color(0x9AFFFFFF),
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            child: FlutterFlowIconButton(
                              buttonSize: 60,
                              icon: Icon(
                                Icons.add,
                                color: Color(0xFF7EB687),
                                size: 50,
                              ),
                              onPressed: () async {
                                context.pushNamed("AssignWorkoutPage");
                                // Show a dialog to confirm if the user wants to cancel the appointment

                              },
                            ),
                          ),

                        ],
                      ),
                    )
                ),
              ]
          ),

        ),
      ),
    );
  }
}



class WorkoutWidget extends StatelessWidget {
  const WorkoutWidget({
    required this.name,
    required this.uid,
    super.key,
  });
  final String uid;
  final String name;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding:
        const EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0),
        child: Container(
          width: 100.0,
          height: 100.0,
          decoration: BoxDecoration(
            color: const Color(0xFF86BD92),
            boxShadow: const [
              BoxShadow(
                blurRadius: 3.0,
                color: Color(0x33000000),
                offset: Offset(
                  0.0,
                  1.0,
                ),
              )
            ],
            borderRadius: BorderRadius.circular(16.0),
            border: Border.all(
              color: const Color(0xFF86BD92),
              width: 2.0,
            ),
          ),
          child: Stack(
            children: [
              Align(
                alignment: const AlignmentDirectional(0.0, 0.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12.0),
                  child: Image.network(
                    'https://images.unsplash.com/photo-1544717684-1243da23b545?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w0NTYyMDF8MHwxfHNlYXJjaHwyNHx8d29ya291dHxlbnwwfHx8fDE3MDY2NjA2NzR8MA&ixlib=rb-4.0.3&q=80&w=1080',
                    width: double.infinity,
                    height: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Container(
                width: double.infinity,
                height: double.infinity,
                decoration: BoxDecoration(
                  color: const Color(0x9AFFFFFF),
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(

                      children: [
                        Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 280,
                              child: Text(
                                name,
                                style: FlutterFlowTheme.of(context)
                                    .titleLarge
                                    .override(
                                  fontFamily: 'Outfit',
                                  color: const Color(0xFF15161E),
                                  fontSize: 22.0,
                                  letterSpacing: 0.0,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),

                          ].divide(const SizedBox(height: 4.0)),
                        ),
                        FlutterFlowIconButton(
                          buttonSize: 60,
                          icon: Icon(
                            Icons.delete,
                            color: Colors.black54,
                            size: 50,
                          ),
                          onPressed: () async {
                            showDialog<bool>(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text('Delete ' + name + "?"),

                                  actions: <Widget>[
                                    TextButton(
                                      onPressed: () async {
                                        globals.selectedWorkout = name;
                                        await DatabaseService().removeExercise(uid);
                                        Navigator.of(context).pop(true); // Return 'true' for "Yes"
                                      },
                                      child: Text('Yes'),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop(false); // Return 'false' for "No"
                                      },
                                      child: Text('No'),
                                    ),
                                  ],
                                );
                              },
                            );
                            // Show a dialog to confirm if the user wants to cancel the appointment

                          },
                        ),
                      ]
                  ),
                ),
              ),
              FFButtonWidget(
                onPressed: () async{
                  print(name);
                  globals.selectedExercise = uid;
                  context.pushNamed('UpdateExercisePage');
                },
                text: '',
                options: FFButtonOptions(
                  width: 270,
                  height: 148.0,
                  padding: const EdgeInsetsDirectional.fromSTEB(
                      24.0, 0.0, 24.0, 0.0),
                  iconPadding: const EdgeInsetsDirectional.fromSTEB(
                      0.0, 0.0, 0.0, 0.0),
                  color: Colors.transparent,
                  textStyle: FlutterFlowTheme.of(context)
                      .titleSmall
                      .override(
                    fontFamily: 'Inter',
                    color: Colors.white,
                    letterSpacing: 0.0,
                  ),
                  elevation: 0.0,
                  borderSide: const BorderSide(
                    color: Colors.transparent,
                    width: 1.0,
                  ),
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ],
          ),
        )
    );
  }
}

class BuildExerciseList extends StatelessWidget {
  const BuildExerciseList({
    required this.Exercises,

  });

  final Map Exercises;

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
      children: List.generate(Exercises.length, (index) {
        return WorkoutWidget(name: Exercises[Exercises.keys.elementAt(index)], uid: Exercises.keys.elementAt(index));
      }),
    );
  }
}

