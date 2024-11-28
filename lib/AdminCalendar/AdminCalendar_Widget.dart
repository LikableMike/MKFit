import '/flutter_flow/flutter_flow_button_tabbar.dart';
import '/flutter_flow/flutter_flow_calendar.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'AdminCalendar_Model.dart';
export 'AdminCalendar_Model.dart';
import '/backend/firebase_storage/database.dart';
import 'package:intl/intl.dart';


import "/backend/firebase_storage/globals.dart" as globals;


class AdminCalendarWidget extends StatefulWidget {
  const AdminCalendarWidget({super.key});

  @override
  State<AdminCalendarWidget> createState() => _AdminCalendarWidgetState();
}

class _AdminCalendarWidgetState extends State<AdminCalendarWidget>
    with TickerProviderStateMixin {
  late AdminCalendarModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  DateTimeRange? _selectedDateRange;
  String? _selectedTime;
  final List<String> _availableTimes = [
    '9:00 AM - 10:00 AM', '10:00 AM - 11:00 AM', '11:00 AM - 12:00 AM', '1:00 PM - 2:00 PM', '2:00 PM - 3:00 PM', '3:00 PM - 4:00 PM'
  ];


  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => AdminCalendarModel());

    _model.tabBarController = TabController(
      vsync: this,
      length: 2,

    );

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
          title: Text(
            'Calendar',
            style: FlutterFlowTheme.of(context).headlineMedium.override(
              fontFamily: 'Outfit',
              color: FlutterFlowTheme.of(context).primaryBackground,
              fontSize: 30.0,
              letterSpacing: 0.0,
              fontWeight: FontWeight.bold,
            ),
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
          elevation: 2.0,
        ),
        body: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(16.0, 4.0, 16.0, 0.0),
                child: Column(
                  children: [
                    Align(
                      alignment: const Alignment(0.0, 0),

                    ),
                    Expanded(
                      child: TabBarView(
                        controller: _model.tabBarController,
                        children: [
                          Container(
                            width: 100.0,
                            height: 100.0,
                            decoration: BoxDecoration(
                              color: const Color(0xFF103E0C),
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            child: SingleChildScrollView(
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
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
                                      borderRadius: BorderRadius.circular(12.0),
                                    ),
                                    child: FlutterFlowCalendar(
                                      color: const Color(0xFF40DC28),
                                      iconColor: const Color(0xFF57636C),
                                      weekFormat: false,
                                      weekStartsMonday: true,
                                      adminAccess: true,
                                      onChange:
                                          (DateTimeRange? newSelectedDate) {
                                        setState(() =>
                                        _model.calendarSelectedDay1 =
                                            newSelectedDate);
                                        _selectedDateRange = newSelectedDate;

                                      },
                                      titleStyle: FlutterFlowTheme.of(context)
                                          .titleLarge
                                          .override(
                                        fontFamily: 'Outfit',
                                        color: const Color(0xFF14181B),
                                        fontSize: 22.0,
                                        letterSpacing: 0.0,
                                        fontWeight: FontWeight.w500,
                                      ),
                                      dayOfWeekStyle:
                                      FlutterFlowTheme.of(context)
                                          .labelMedium
                                          .override(
                                        fontFamily: 'Plus Jakarta Sans',
                                        color: const Color(0xFF57636C),
                                        fontSize: 14.0,
                                        letterSpacing: 0.0,
                                        fontWeight: FontWeight.normal,
                                      ),
                                      dateStyle: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                        fontFamily: 'Plus Jakarta Sans',
                                        color: const Color(0xFF14181B),
                                        fontSize: 14.0,
                                        letterSpacing: 0.0,
                                        fontWeight: FontWeight.normal,
                                      ),
                                      selectedDateStyle:
                                      FlutterFlowTheme.of(context)
                                          .titleSmall
                                          .override(
                                        fontFamily: 'Plus Jakarta Sans',
                                        color: Colors.white,
                                        fontSize: 16.0,
                                        letterSpacing: 0.0,
                                        fontWeight: FontWeight.w500,
                                      ),
                                      inactiveDateStyle:
                                      FlutterFlowTheme.of(context)
                                          .labelMedium
                                          .override(
                                        fontFamily: 'Plus Jakarta Sans',
                                        color: const Color(0xFF57636C),
                                        fontSize: 14.0,
                                        letterSpacing: 0.0,
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                  ),
                                  Column(
                                    mainAxisSize: MainAxisSize.max,
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsetsDirectional.fromSTEB(
                                            16.0, 12.0, 0.0, 0.0),
                                        child: Text(
                                          'Appointments:',
                                          style: FlutterFlowTheme.of(context)
                                              .labelMedium
                                              .override(
                                            fontFamily: 'Plus Jakarta Sans',
                                            color:
                                            FlutterFlowTheme.of(context)
                                                .alternate,
                                            fontSize: 14.0,
                                            letterSpacing: 0.0,
                                            fontWeight: FontWeight.normal,
                                          ),
                                        ),
                                      ),



                                      // Cancel Appointment Button
                                      Padding(
                                        padding: const EdgeInsets.all(16.0),
                                      child: FutureBuilder<bool>(

                                        future: DatabaseService().checkAdminAppointments(_selectedDateRange?.start.toString().split(" ")[0] ?? "null"),
                                        builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
                                          if (snapshot.connectionState == ConnectionState.waiting) {
                                            // While the future is still loading, show a loading indicator
                                            return CircularProgressIndicator();
                                          } else if (snapshot.hasError) {
                                            // Handle any errors from the future
                                            return Text('Error: ${snapshot.error}');
                                          } else if (snapshot.hasData && snapshot.data == true) {
                                            // If the data is true, show the Cancel Appointment button
                                            return ElevatedButton(

                                              style: ElevatedButton.styleFrom(
                                                backgroundColor: Color(0xFFD3FF82), // Red color for the cancel button
                                              ),
                                              onPressed: () async {
                                                  print("Pressed");
                                              },
                                              child: FutureBuilder<String>(
                                                future: DatabaseService().checkAdminDay(_selectedDateRange?.start.toString().split(" ")[0] ?? "null"),
                                                builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                                                  if (snapshot.connectionState == ConnectionState.waiting) {
                                                    // While the async operation is in progress, show a loading indicator or placeholder
                                                    return const Text('Loading...');
                                                  } else if (snapshot.hasError) {
                                                    // If there's an error, display an error message
                                                    return Text(snapshot.error.toString() ?? "Error");
                                                  } else if (snapshot.hasData) {
                                                    // Once the data is available, display it
                                                    return Text(snapshot.data ?? "No Appointments Found", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20));
                                                  } else {
                                                    // Handle any other case (unlikely but good to cover it)
                                                    return const Text('No data available');
                                                  }
                                                },
                                              ),
                                            );
                                          } else {
                                            // If no appointment exists, return an empty container or something else
                                            return Container();
                                          }
                                        },

                                      ),
                                      ),


                                      // ElevatedButton(
                                      //     style: ElevatedButton.styleFrom(
                                      //       backgroundColor: Colors.red, // Red color for the cancel button
                                      //     ),
                                      //     onPressed: () {
                                      //       setState(() {
                                      //         // Clear the selected date and time to cancel the appointment
                                      //         _selectedDateRange = null;
                                      //         _selectedTime = null;
                                      //       });
                                      //       ScaffoldMessenger.of(context).showSnackBar(
                                      //         const SnackBar(content: Text('Appointment has been canceled.')),
                                      //       );
                                      //     },
                                      //     child: const Text('Cancel Appointment')
                                      // ),

                                      
                                     

                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),

                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
