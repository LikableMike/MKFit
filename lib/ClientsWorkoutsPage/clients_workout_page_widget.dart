import '/flutter_flow/flutter_flow_checkbox_group.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import 'package:flutter/material.dart';
import '../backend/firebase_storage/database.dart';
import 'package:flutter/services.dart';
import 'clients_workout_page_model.dart';
export 'clients_workout_page_model.dart';
import "/backend/firebase_storage/globals.dart" as globals;

class ClientWorkoutsPageWidget extends StatefulWidget {
  const ClientWorkoutsPageWidget({super.key});

  @override
  State<ClientWorkoutsPageWidget> createState() =>
      _ClientWorkoutsPageWidgetState();
}

class _ClientWorkoutsPageWidgetState extends State<ClientWorkoutsPageWidget> {
  late ClientWorkoutsPageModel _model;
  List<String> selectedWorkouts = [];
  List<String> workouts = [];
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final DatabaseService _databaseService = DatabaseService();



  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ClientWorkoutsPageModel());

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
              FutureBuilder<String>(
                future: DatabaseService().findClientName(globals.selectedClient),
                builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    // Display a loading indicator while waiting
                    return CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    // Handle errors here
                    return Text('Error: ${snapshot.error}');
                  } else if (snapshot.hasData) {
                    // Display the text once data is available
                    return Text(
                      snapshot.data!,
                      style: FlutterFlowTheme.of(context).headlineMedium.override(
                        fontFamily: 'Outfit',
                        color: FlutterFlowTheme.of(context).primaryBackground,
                        fontSize: 24.0,
                        letterSpacing: 0.0,
                        fontWeight: FontWeight.w500,
                      ),
                    );
                  } else {
                    // Handle the case where there is no data
                    return Text('No client name found');
                  }
                },
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
          child:


            FutureBuilder<List>(
            future: DatabaseService().getClientWorkouts(globals.selectedClient),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                // Show a loading spinner while waiting for data
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                // Show error message if something went wrong
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                // Show a message if the list is empty
                return Center(child: Text('No clients found.'));
              }

              // If data is loaded successfully, use it
              List workouts = snapshot.data!;
              return BuildWorkouts(Workouts: workouts);
            },
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
        height: 150.0,
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
                    RichText(
                      textScaler:
                      MediaQuery.of(context).textScaler,
                      text: TextSpan(
                        children: const [
                          TextSpan(
                            text: '8 Mins',
                            style: TextStyle(),
                          ),
                          TextSpan(
                            text: ' || ',
                            style: TextStyle(),
                          ),
                          TextSpan(
                            text: '3 workouts',
                            style: TextStyle(),
                          )
                        ],
                        style: FlutterFlowTheme.of(context)
                            .labelMedium
                            .override(
                          fontFamily: 'Outfit',
                          color: const Color(0xFF606A85),
                          fontSize: 14.0,
                          letterSpacing: 0.0,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ].divide(const SizedBox(height: 4.0)),
                ),
              ),
            ),
            FFButtonWidget(
              onPressed: () {
                print(name);
                globals.selectedWorkout = name;
                context.pushNamed('IndividualWorkoutPage');
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

