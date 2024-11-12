import '/flutter_flow/flutter_flow_checkbox_group.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import 'package:flutter/material.dart';
import '../backend/firebase_storage/database.dart';
import 'package:flutter/services.dart';
import 'client_info_page_model.dart';
export 'client_info_page_model.dart';
import "/backend/firebase_storage/globals.dart" as globals;

class ClientInfoPageWidget extends StatefulWidget {
  const ClientInfoPageWidget({super.key});

  @override
  State<ClientInfoPageWidget> createState() =>
      _ClientInfoPageWidgetState();
}

class _ClientInfoPageWidgetState extends State<ClientInfoPageWidget> {
  late ClientInfoPageModel _model;
  List<String> selectedWorkouts = [];
  List<String> workouts = [];
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final DatabaseService _databaseService = DatabaseService();



  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ClientInfoPageModel());

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
              child: ListView(
                padding: const EdgeInsets.fromLTRB(
                  20,
                  20,
                  20,
                  44.0,
                ),
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                children: [


                                      Row(
                                      //padding: const EdgeInsetsDirectional.fromSTEB(16.0, 8.0, 0.0, 8.0),
                                        children:[
                                          FlutterFlowIconButton(
                                            borderColor: Color(0xFf1c502d),
                                            borderRadius: 40,
                                            borderWidth: 4,
                                            buttonSize: 90,
                                            icon: Icon(
                                              Icons.calendar_today,
                                              color: Color(0xFF7EB687),
                                              size: 60,
                                            ),
                                            onPressed: () {
                                              context.pushNamed("ClientAppointmentsPage");
                                            },
                                          ),
                                          Padding(
                                            padding: const EdgeInsetsDirectional.fromSTEB(16.0, 8.0, 0.0, 8.0),

                                          ),
                                          ElevatedButton(
                                            onPressed: () {
                                              context.pushNamed("ClientAppointmentsPage");
                                              },
                                            child: Text(
                                            'Upcoming \nAppointments',
                                            style: FlutterFlowTheme.of(context)
                                                .labelMedium
                                                .override(
                                              fontFamily: 'Outfit',
                                              color: const Color(0xFF606A85),
                                              fontSize: 30.0,
                                              letterSpacing: 0.0,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: Colors.transparent,
                                              elevation: 0,
                                            ),

                                          )


                                        ]
                                      ),

                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(16.0, 8.0, 0.0, 8.0),

                  ),

                  Row(
                    //padding: const EdgeInsetsDirectional.fromSTEB(16.0, 8.0, 0.0, 8.0),
                      children:[
                        FlutterFlowIconButton(
                          borderColor: Color(0xFf1c502d),
                          borderRadius: 40,
                          borderWidth: 4,
                          buttonSize: 90,
                          icon: Icon(
                            Icons.sports_gymnastics_rounded,
                            color: Color(0xFF7EB687),
                            size: 60,
                          ),
                          onPressed: () {
                            context.pushNamed("ClientWorkoutsPage");
                          },
                        ),
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(16.0, 8.0, 0.0, 8.0),

                        ),
                        ElevatedButton(
                          onPressed: () {
                            context.pushNamed("ClientWorkoutsPage");
                          },
                          child: Text(
                            'Current \nWorkouts',
                            style: FlutterFlowTheme.of(context).labelMedium.override(
                              fontFamily: 'Outfit',
                              color: const Color(0xFF606A85),
                              fontSize: 30.0,
                              letterSpacing: 0.0,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.transparent,
                            elevation: 0,
                          ),

                        )


                      ]
                  ),







                ],
              ),

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
        width: 100.0,
        height: 70.0,
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
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
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
                    

                  ]
                ),
              ),
            ),
            FFButtonWidget(
              onPressed: () {
                globals.selectedClient = date;
                context.pushNamed('ClientInfoPage');

              },
              text: '',
              options: FFButtonOptions(
                width: double.infinity,
                height: 60.0,
                padding: const EdgeInsetsDirectional.fromSTEB(
                    24.0, 0.0, 24.0, 0.0),
                iconPadding: const EdgeInsetsDirectional.fromSTEB(
                    0.0, 0.0, 0.0, 0.0),
                color: Colors.transparent,
                textStyle: FlutterFlowTheme.of(context)
                    .titleSmall
                    .override(
                  fontFamily: 'Inter',
                  color: Colors.transparent,
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

class BuildAppointmentList extends StatelessWidget {
  const BuildAppointmentList({
    required this.dates,

  });

  final List dates;

  @override
  Widget build(BuildContext context) {
    print(dates.length);
    return ListView(
      padding: const EdgeInsets.fromLTRB(
        0,
        0,
        0,
        44.0,
      ),
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      children: List.generate(dates.length, (index) {
          return DateWidget(
              date: dates[index]["date"].toString().split(" ")[0]);
      }),
    );
  }
}

