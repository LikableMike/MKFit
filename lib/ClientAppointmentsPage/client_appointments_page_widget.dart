import '/flutter_flow/flutter_flow_checkbox_group.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import 'package:flutter/material.dart';
import '../backend/firebase_storage/database.dart';
import 'package:flutter/services.dart';
import 'client_appointments_page_model.dart';
export 'client_appointments_page_model.dart';
import "/backend/firebase_storage/globals.dart" as globals;

class ClientAppointmentsPageWidget extends StatefulWidget {
  const ClientAppointmentsPageWidget({super.key});

  @override
  State<ClientAppointmentsPageWidget> createState() =>
      _ClientAppointmentsPageWidgetState();
}

class _ClientAppointmentsPageWidgetState extends State<ClientAppointmentsPageWidget> {
  late ClientAppointmentsPageModel _model;
  List<String> selectedWorkouts = [];
  List<String> workouts = [];
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final DatabaseService _databaseService = DatabaseService();



  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ClientAppointmentsPageModel());

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
                    return Text('No Appointments found');
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
          child: Column(
            children: [FutureBuilder<List>(
            future: DatabaseService().fetchAppointments(globals.selectedClient),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                // Show a loading spinner while waiting for data
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                // Show error message if something went wrong
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                // Show a message if the list is empty
                return Center(child: Text('No appointments found.',));
              }

              // If data is loaded successfully, use it
              List appointments = snapshot.data!;
              return BuildAppointmentList(dates: appointments);
            },
          ),

        ]
          )

        ),

      ),
    );
  }
}

class DateWidget extends StatelessWidget {
  const DateWidget({
    required this.date,
    super.key,
  });

  final String date;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding:
        const EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0),
        child: Container(
          width: 70.0,
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
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          date,
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
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(90.0, 8.0, 0.0, 8.0),

                        ),
                        Column(
                          children: [
                          FlutterFlowIconButton(
                            buttonSize: 60,
                            icon: Icon(
                              Icons.highlight_remove_outlined,
                              color: Color(0xFF7EB687),
                              size: 50,
                            ),
                            onPressed: () async {
                              // Show a dialog to confirm if the user wants to cancel the appointment
                              bool? shouldCancelAppointment = await showDialog<bool>(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text('Cancel Appointment'),
                                    content: Text('Do you wish to cancel the appointment on ' + date),
                                    actions: <Widget>[
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop(true); // Yes, cancel the appointment
                                        },
                                        child: Text('Yes'),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop(false); // No, keep the appointment
                                        },
                                        child: Text('No'),
                                      ),
                                    ],
                                  );
                                },
                              );

                              if (shouldCancelAppointment != null && shouldCancelAppointment) {
                                // Cancel only the selected appointment
                                print(date);
                                await DatabaseService().cancelClientAppointment(date);

                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text('Appointment on date has been canceled.')),
                                );


                              }
                            },
                          ),
                          ]
                        ),



                      ]
                  ),
                ),
              ),

            ],
          ),
        )
    );
  }
}

class BuildAppointmentList extends StatelessWidget {
  const BuildAppointmentList({
    required this.dates,

  });

  final List dates;

  @override
  Widget build(BuildContext context) {
    var fixedDates = fixDates(dates);
    return ListView(
      padding: const EdgeInsets.fromLTRB(
        0,
        0,
        0,
        44.0,
      ),
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      children: List.generate(fixedDates.length, (index) {
          return DateWidget(
              date: fixedDates[index]);
      }),
    );
  }
}

List fixDates(dates){
  var newDates = [];
  var finalDates = [];
  for(int i = 0; i < dates.length; i++){
    newDates.add(dates[i]["startTime"].toDate().toString());
  }
  for(int i = 0; i < (newDates.length); i++){
    var currDate = newDates[i].split(" ")[0].split("-");
    var todaysDate = DateTime.now().toString().split(" ")[0].split("-");
      print(todaysDate.toString() + "  " + currDate.toString() + " Index:" +
          i.toString());
      if (int.parse(currDate[0]) >= int.parse(todaysDate[0])) {
        if (int.parse(currDate[1]) > int.parse(todaysDate[1])) {
          finalDates.add(
              newDates[i].split(".")[0]);
        }
        else if (int.parse(currDate[1]) == int.parse(todaysDate[1]) &&
            int.parse(currDate[2]) >= int.parse(todaysDate[2])) {
          finalDates.add(
              newDates[i].split(".")[0]);
        }
      }

    
  }
  return finalDates;
}