import '/flutter_flow/flutter_flow_checkbox_group.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import 'package:flutter/material.dart';
import '../backend/firebase_storage/database.dart';
import 'package:flutter/services.dart';
import 'assign_workout_page_model.dart';
export 'assign_workout_page_model.dart';
import "/backend/firebase_storage/globals.dart" as globals;


class AssignWorkoutPageWidget extends StatefulWidget {
  const AssignWorkoutPageWidget({super.key});

  @override
  State<AssignWorkoutPageWidget> createState() =>
      _AssignWorkoutPageWidgetState();
}

class _AssignWorkoutPageWidgetState extends State<AssignWorkoutPageWidget> {
  late AssignWorkoutPageModel _model;
  List<String> selectedWorkouts = [];
  List<String> workouts = [];
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final DatabaseService _databaseService = DatabaseService();

  void onWorkoutSelected(String workoutName){
    setState((){
      if(selectedWorkouts.contains(workoutName)){
        selectedWorkouts.remove(workoutName);
      } else{
        selectedWorkouts.add(workoutName);
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => AssignWorkoutPageModel());

    _model.workoutNameTextController ??= TextEditingController();
    _model.workoutNameFocusNode ??= FocusNode();
    _model.workoutNameFocusNode!.addListener(() => safeSetState(() {}));
    _model.descriptionTextController ??= TextEditingController();
    _model.descriptionFocusNode ??= FocusNode();
    _model.descriptionFocusNode!.addListener(() => safeSetState(() {}));
    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
    fetchWorkouts();
  }

  Future<void> fetchWorkouts() async {
    try {
      // Fetch documents from the 'exercises_test' collection
      final snapshot = await FirebaseFirestore.instance.collection('workouts').get();
      List<String> workoutNames = [];

      // Check if there are no documents
      if (snapshot.docs.isEmpty) {
        print('No exercises found');
      } else {
        // Map through the documents and extract the desired field
        workoutNames = snapshot.docs.map((doc) {
          // Ensure to handle the absence of the field safely
          if (doc.data().containsKey('exercises')) {
            return doc.id;
          }
          else {
            print("Can't find workout");
            // Return null for documents without the field
            return null;
          }
        }).where((name) => name != null).cast<String>().toList();

        print('Fetched exercises: $workoutNames');
      }

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
                'Select Workout',
                style: FlutterFlowTheme.of(context).headlineMedium.override(
                  fontFamily: 'Readex Pro',
                  color: Colors.white,
                  fontSize: 34,
                  letterSpacing: 0.0,
                  fontWeight: FontWeight.bold,
                ),
              ),

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
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child:  Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(child: BuildWorkouts(Workouts: workouts),)



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
                      context.pushNamed("CreateWorkoutPage");
                      // Button action here
                    },
                    text: 'Create Workout',
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



class WorkoutWidget extends StatelessWidget {
  const WorkoutWidget({
    required this.name,
    super.key,
  });

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

              Container(
                width: double.infinity,
                height: double.infinity,
                decoration: BoxDecoration(
                  color: const Color(0x9AFFFFFF),
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
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

                    ].divide(const SizedBox(height: 4.0)),
                  ),
                ),
              ),
              FFButtonWidget(
                onPressed: () async {
                  globals.selectedWorkout = name;
                  //fetch excersises from this workout store in globals

                  print("Workouts:" + globals.userWorkouts.toString());
                  context.pushNamed("ExerciseValuePage");

                },
                text: '',
                options: FFButtonOptions(
                  width: double.infinity,
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
                  elevation: 3.0,
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
        return WorkoutWidget(name: Workouts[index]);
      }),
    );
  }
}