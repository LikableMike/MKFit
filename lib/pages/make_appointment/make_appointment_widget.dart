import '/flutter_flow/flutter_flow_button_tabbar.dart';
import '/flutter_flow/flutter_flow_calendar.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'make_appointment_model.dart';
export 'make_appointment_model.dart';
import '/backend/firebase_storage/database.dart';
import 'package:intl/intl.dart';


import "/backend/firebase_storage/globals.dart" as globals;


class MakeAppointmentWidget extends StatefulWidget {
  const MakeAppointmentWidget({super.key});

  @override
  State<MakeAppointmentWidget> createState() => _MakeAppointmentWidgetState();
}

class _MakeAppointmentWidgetState extends State<MakeAppointmentWidget>
    with TickerProviderStateMixin {
  late MakeAppointmentModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  DateTimeRange? _selectedDateRange;
  String? _selectedTime;
  final List<String> _availableTimes = [
    '9:00 AM - 10:00 AM', '10:00 AM - 11:00 AM', '11:00 AM - 12:00 AM', '1:00 PM - 2:00 PM', '2:00 PM - 3:00 PM', '3:00 PM - 4:00 PM'
  ];

  List<DateTime> generateRecurringDates(DateTime start, DateTime end) {
    List<DateTime> dates = [];
    DateTime current = start;
    while (current.isBefore(end) || current.isAtSameMomentAs(end)) {
      dates.add(current);
      current = current.add(Duration(days: 7)); // Assuming weekly recurrence
    }
    return dates;
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => MakeAppointmentModel());

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
            FlutterFlowIconButton(
              borderColor: Colors.transparent,
              borderRadius: 30.0,
              borderWidth: 1.0,
              buttonSize: 70.0,
              icon: const Icon(
                Icons.person,
                color: Colors.white,
                size: 40.0,
              ),
              onPressed: () async {
                context.pushNamed('SettingsPage');
              },
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
                      child: FlutterFlowButtonTabBar(
                        useToggleButtonStyle: true,
                        isScrollable: true,
                        labelStyle:
                        FlutterFlowTheme.of(context).titleMedium.override(
                          fontFamily: 'Plus Jakarta Sans',
                          color: Colors.white,
                          fontSize: 18.0,
                          letterSpacing: 0.0,
                          fontWeight: FontWeight.normal,
                        ),
                        unselectedLabelStyle: const TextStyle(),
                        labelColor: const Color(0xFF14181B),
                        unselectedLabelColor:
                        FlutterFlowTheme.of(context).primaryText,
                        backgroundColor: Colors.white,
                        unselectedBackgroundColor: const Color(0xFFE0E3E7),
                        borderColor: const Color(0xFFE0E3E7),
                        borderWidth: 2.0,
                        borderRadius: 12.0,
                        elevation: 0.0,
                        labelPadding: const EdgeInsetsDirectional.fromSTEB(
                            20.0, 0.0, 20.0, 0.0),
                        padding: const EdgeInsetsDirectional.fromSTEB(
                            0.0, 12.0, 0.0, 12.0),
                        tabs: const [
                          Tab(
                            text: 'Month',
                          ),
                          Tab(
                            text: 'Week',
                          ),
                        ],
                        controller: _model.tabBarController,
                        onTap: (i) async {
                          [() async {}, () async {}][i]();
                        },
                      ),
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
                                          'Coming Up',
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
                                      Padding(
                                        padding: const EdgeInsets.all(16.0),
                                        child: DropdownButton<String>(
                                          value: _selectedTime,
                                          hint: Text(
                                            _selectedTime == null ? 'Select time' : 'Time Selected: $_selectedTime',
                                            style: TextStyle(
                                              color: Colors.white, // Set the color for "Select time" text
                                              fontSize: 16.0,
                                            ),
                                          ),
                                          style: TextStyle(
                                            color: Colors.white, // This applies to the selected item
                                            fontSize: 16.0,
                                          ),
                                          items: _availableTimes.map((String time) {
                                            return DropdownMenuItem<String>(
                                              value: time,
                                              child: Text(
                                                time,
                                                style: TextStyle(
                                                  color: Colors.blue, // Set the color for the dropdown items
                                                ),
                                              ),
                                            );
                                          }).toList(),
                                          onChanged: (String? newValue) {
                                            setState(() {
                                              _selectedTime = newValue;
                                            });
                                          },
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(16.0),
                                        child: ElevatedButton(
                                          onPressed: () async {
                                            if (_selectedDateRange != null && _selectedTime != null) {
                                              String formattedDate = DateFormat('yyyy-MM-dd').format(_selectedDateRange!.start);

                                              // Handle appointment confirmation here
                                              try {
                                                print('Appointment scheduled for $formattedDate at $_selectedTime');

                                                // Create the initial appointment
                                                await DatabaseService().makeAppointment(_selectedDateRange!.start.toString(), _selectedTime!);

                                                print(_selectedDateRange.toString() + " " + _selectedTime.toString());
                                                print(globals.UID);

                                                // Show a dialog asking if the user wants to set the meeting to recurring
                                                bool? shouldSetRecurring = await showDialog<bool>(
                                                  context: context,
                                                  builder: (BuildContext context) {
                                                    return AlertDialog(
                                                      title: Text('Set Recurring Meeting'),
                                                      content: Text('Would you like to set this meeting to recurring?'),
                                                      actions: <Widget>[
                                                        TextButton(
                                                          onPressed: () {
                                                            Navigator.of(context).pop(true); // Return 'true' when "Yes" is tapped
                                                          },
                                                          child: Text('Yes'),
                                                        ),
                                                        TextButton(
                                                          onPressed: () {
                                                            Navigator.of(context).pop(false); // Return 'false' when "No" is tapped
                                                          },
                                                          child: Text('No'),
                                                        ),
                                                      ],
                                                    );
                                                  },
                                                );

                                                if (shouldSetRecurring != null && shouldSetRecurring) {
                                                  // Allow the user to choose an end date for the recurring appointment
                                                  DateTimeRange? recurringDateRange = await showDateRangePicker(
                                                    context: context,
                                                    firstDate: DateTime.now(),
                                                    lastDate: DateTime(2100),
                                                    initialDateRange: _selectedDateRange,
                                                  );

                                                  if (recurringDateRange != null) {
                                                    // Generate recurring dates (e.g., every week on the same day)
                                                    List<DateTime> recurringDates = generateRecurringDates(
                                                      _selectedDateRange!.start,
                                                      recurringDateRange.end,
                                                    );

                                                    // Loop through each generated date and make an appointment
                                                    for (DateTime date in recurringDates) {
                                                      String recurringDateStr = DateFormat('yyyy-MM-dd').format(date);
                                                      await DatabaseService().makeAppointment(recurringDateStr, _selectedTime!);
                                                    }

                                                    // Display confirmation message including the time
                                                    String firstDate = DateFormat('yyyy-MM-dd').format(recurringDateRange.start);
                                                    String endDate = DateFormat('yyyy-MM-dd').format(recurringDateRange.end);

                                                    ScaffoldMessenger.of(context).showSnackBar(
                                                      SnackBar(content: Text('Recurring appointments set from $firstDate to $endDate at $_selectedTime')),
                                                    );
                                                  }
                                                } else {
                                                  // Display confirmation message including the time
                                                  ScaffoldMessenger.of(context).showSnackBar(
                                                    SnackBar(content: Text('Appointment confirmed for $formattedDate at $_selectedTime')),
                                                  );
                                                }
                                              } catch (e) {
                                                print(e);
                                              }
                                            } else {
                                              print(_selectedDateRange.toString() + " " + _selectedTime.toString());

                                              // Show error or prompt to select date/time
                                              ScaffoldMessenger.of(context).showSnackBar(
                                                SnackBar(content: Text('Please select both date and time.')),
                                              );
                                            }
                                          },
                                          child: Text('Confirm Appointment'),
                                        ),
                                      ),





                          // Cancel Appointment Button
                          FutureBuilder<bool>(
                            future: DatabaseService().checkAppointment(_selectedDateRange?.start.toString() ?? "null"),
                            builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
                              if (snapshot.connectionState == ConnectionState.waiting) {
                                return CircularProgressIndicator();
                              } else if (snapshot.hasError) {
                                return Text('Error: ${snapshot.error}');
                              } else if (snapshot.hasData && snapshot.data == true) {
                                return ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.red,
                                  ),
                                  onPressed: () async {
                                    String formattedDate = DateFormat('yyyy-MM-dd').format(_selectedDateRange!.start);

                                    // Show a dialog to confirm if the user wants to cancel all recurring appointments
                                    bool? shouldCancelRecurring = await showDialog<bool>(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: Text('Cancel Appointment'),
                                          content: Text('Would you like to cancel all recurring appointments, or just this one?'),
                                          actions: <Widget>[
                                            TextButton(
                                              onPressed: () {
                                                Navigator.of(context).pop(true); // Yes, cancel all recurring
                                              },
                                              child: Text('All Recurring'),
                                            ),
                                            TextButton(
                                              onPressed: () {
                                                Navigator.of(context).pop(false); // No, just this one
                                              },
                                              child: Text('Just This One'),
                                            ),
                                          ],
                                        );
                                      },
                                    );

                                    if (shouldCancelRecurring != null && shouldCancelRecurring) {
                                      // If the user chooses to cancel all recurring, gather all dates
                                      List<DateTime> recurringDates = generateRecurringDates(
                                        _selectedDateRange!.start,
                                        _selectedDateRange!.end, // Adjust as needed
                                      );

                                      List<String> formattedDates = recurringDates
                                          .map((date) => DateFormat('yyyy-MM-dd').format(date))
                                          .toList();

                                      await DatabaseService().cancelAppointment(formattedDates);

                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(content: Text('All recurring appointments have been canceled.')),
                                      );
                                    } else {
                                      // Cancel only the selected appointment
                                      await DatabaseService().cancelAppointment([formattedDate]);

                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(content: Text('Appointment on $formattedDate at $_selectedTime has been canceled.')),
                                      );
                                    }

                                    setState(() {
                                      _selectedDateRange = null;
                                      _selectedTime = null;
                                    });
                                  },
                                  child: const Text('Cancel Appointment'),
                                );
                              } else {
                                return Container();
                              }
                            },
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

                                      Padding(
                                        padding: const EdgeInsetsDirectional
                                            .fromSTEB(

                                            0.0, 12.0, 0.0, 0.0),
                                        child: ListView(
                                          padding: EdgeInsets.zero,
                                          primary: false,
                                          shrinkWrap: true,
                                          scrollDirection: Axis.vertical,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsetsDirectional
                                                  .fromSTEB(
                                                  16.0, 0.0, 16.0, 12.0),
                                              child: Container(
                                                width: 100.0,
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
                                                  borderRadius:
                                                  BorderRadius.circular(
                                                      8.0),
                                                ),
                                                child: Padding(
                                                  padding: const EdgeInsets.all(8.0),
                                                  child: Row(
                                                    mainAxisSize:
                                                    MainAxisSize.max,
                                                    mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                    children: [
                                                      Column(
                                                        mainAxisSize:
                                                        MainAxisSize.max,
                                                        mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                        crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                        children: [
                                                          Padding(
                                                            padding:
                                                            const EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                4.0,
                                                                0.0,
                                                                0.0,
                                                                0.0),
                                                            child: Text(
                                                              _selectedDateRange != null && _selectedTime != null
                                                                  ? 'Next Session with Makayla: ${_selectedDateRange!.start.toString().split(' ')[0]} at $_selectedTime'
                                                                  : 'Next Session with Makayla',
                                                              style: FlutterFlowTheme
                                                                  .of(context)
                                                                  .headlineSmall
                                                                  .override(
                                                                fontFamily:
                                                                'Outfit',
                                                                color: const Color(
                                                                    0xFF14181B),
                                                                fontSize:
                                                                24.0,
                                                                letterSpacing:
                                                                0.0,
                                                                fontWeight:
                                                                FontWeight
                                                                    .w500,
                                                              ),
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding:
                                                            const EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                0.0,
                                                                4.0,
                                                                0.0,
                                                                0.0),
                                                            child: Row(
                                                              mainAxisSize:
                                                              MainAxisSize
                                                                  .max,
                                                              children: [
                                                                Padding(
                                                                  padding: const EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                      0.0,
                                                                      0.0,
                                                                      8.0,
                                                                      0.0),
                                                                  child: Card(
                                                                    clipBehavior:
                                                                    Clip.antiAliasWithSaveLayer,
                                                                    color: const Color(
                                                                        0x4DEE8B60),
                                                                    elevation:
                                                                    0.0,
                                                                    shape:
                                                                    RoundedRectangleBorder(
                                                                      borderRadius:
                                                                      BorderRadius.circular(
                                                                          8.0),
                                                                    ),
                                                                    child:
                                                                    Padding(
                                                                      padding: const EdgeInsetsDirectional.fromSTEB(
                                                                          8.0,
                                                                          4.0,
                                                                          8.0,
                                                                          4.0),
                                                                      child:
                                                                      Text(
                                                                        _selectedTime ?? 'Select Time',
                                                                        style: FlutterFlowTheme
                                                                            .of(
                                                                            context)

                                                                            .bodyMedium
                                                                            .override(
                                                                          fontFamily: 'Plus Jakarta Sans',
                                                                          color: const Color(
                                                                              0xFF150903),
                                                                          fontSize: 14.0,
                                                                          letterSpacing: 0.0,
                                                                          fontWeight: FontWeight.normal,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                                Text(
                                                                  _selectedDateRange != null
                                                                      ? _selectedDateRange!.start.toString().split(' ')[0]
                                                                      : '', // Leave blank if no date is selected
                                                                  style: FlutterFlowTheme
                                                                      .of(
                                                                      context)

                                                                      .bodySmall
                                                                      .override(
                                                                    fontFamily:
                                                                    'Plus Jakarta Sans',
                                                                    color: const Color(
                                                                        0xFF14181B),
                                                                    fontSize:
                                                                    12.0,
                                                                    letterSpacing:
                                                                    0.0,
                                                                    fontWeight:
                                                                    FontWeight.normal,
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsetsDirectional.fromSTEB(
                                            16.0, 12.0, 0.0, 0.0),
                                        child: Text(
                                          'Payment',
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
                                      Padding(
                                        padding: const EdgeInsetsDirectional.fromSTEB(
                                            0.0, 12.0, 0.0, 24.0),
                                        child: ListView(
                                          padding: EdgeInsets.zero,
                                          primary: false,
                                          shrinkWrap: true,
                                          scrollDirection: Axis.vertical,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsetsDirectional
                                                  .fromSTEB(
                                                  16.0, 0.0, 16.0, 12.0),
                                              child: Container(
                                                width: 100.0,
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
                                                  borderRadius:
                                                  BorderRadius.circular(
                                                      8.0),
                                                ),
                                                child: Padding(
                                                  padding: const EdgeInsets.all(8.0),
                                                  child: Row(
                                                    mainAxisSize:
                                                    MainAxisSize.max,
                                                    mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                    children: [
                                                      Column(
                                                        mainAxisSize:
                                                        MainAxisSize.max,
                                                        mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                        crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                        children: [
                                                          Padding(
                                                            padding:
                                                            const EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                4.0,
                                                                0.0,
                                                                0.0,
                                                                0.0),
                                                            child: Text(
                                                              'Next Payment',
                                                              style: FlutterFlowTheme
                                                                  .of(context)
                                                                  .headlineSmall
                                                                  .override(
                                                                fontFamily:
                                                                'Outfit',
                                                                color: const Color(
                                                                    0xFF14181B),
                                                                fontSize:
                                                                24.0,
                                                                letterSpacing:
                                                                0.0,
                                                                fontWeight:
                                                                FontWeight
                                                                    .w500,
                                                              ),
                                                            ),
                                                          ),
                                                          Row(
                                                            mainAxisSize:
                                                            MainAxisSize
                                                                .max,
                                                            children: [
                                                              Padding(
                                                                padding:
                                                                const EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                    0.0,
                                                                    0.0,
                                                                    8.0,
                                                                    0.0),
                                                                child: Card(
                                                                  clipBehavior:
                                                                  Clip.antiAliasWithSaveLayer,
                                                                  color: const Color(
                                                                      0x4C4B39EF),
                                                                  elevation:
                                                                  0.0,
                                                                  shape:
                                                                  RoundedRectangleBorder(
                                                                    borderRadius:
                                                                    BorderRadius.circular(
                                                                        8.0),
                                                                  ),
                                                                  child:
                                                                  Padding(
                                                                    padding: const EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                        8.0,
                                                                        4.0,
                                                                        8.0,
                                                                        4.0),
                                                                    child: Text(
                                                                      '2:20pm',
                                                                      style: FlutterFlowTheme.of(
                                                                          context)
                                                                          .bodyLarge
                                                                          .override(
                                                                        fontFamily:
                                                                        'Inter',
                                                                        letterSpacing:
                                                                        0.0,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                              Padding(
                                                                padding:
                                                                const EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                    4.0,
                                                                    0.0,
                                                                    0.0,
                                                                    0.0),
                                                                child: Text(
                                                                  'Wed, 03/08/2022',
                                                                  style: FlutterFlowTheme.of(
                                                                      context)
                                                                      .bodySmall
                                                                      .override(
                                                                    fontFamily:
                                                                    'Plus Jakarta Sans',
                                                                    color: const Color(
                                                                        0xFF14181B),
                                                                    fontSize:
                                                                    18.0,
                                                                    letterSpacing:
                                                                    0.0,
                                                                    fontWeight:
                                                                    FontWeight.normal,
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ],
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
                                ],
                              ),
                            ),
                          ),
                          Container(
                            width: 100.0,
                            height: 100.0,
                            decoration: BoxDecoration(
                              color: FlutterFlowTheme.of(context).primaryText,
                            ),
                            child: SingleChildScrollView(
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: double.infinity,
                                    decoration: const BoxDecoration(
                                      color: Colors.white,
                                      boxShadow: [
                                        BoxShadow(
                                          blurRadius: 3.0,
                                          color: Color(0x33000000),
                                          offset: Offset(
                                            0.0,
                                            1.0,
                                          ),
                                        )
                                      ],
                                    ),
                                    child: FlutterFlowCalendar(
                                      color: const Color(0xFF4B39EF),
                                      iconColor: const Color(0xFF57636C),
                                      weekFormat: true,
                                      weekStartsMonday: true,
                                      onChange:
                                          (DateTimeRange? newSelectedDate) {
                                        setState(() =>
                                        _model.calendarSelectedDay2 =
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
                                          'Coming Up',
                                          style: FlutterFlowTheme.of(context)
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
                                      Padding(
                                        padding: const EdgeInsetsDirectional.fromSTEB(
                                            0.0, 12.0, 0.0, 0.0),
                                        child: ListView(
                                          padding: EdgeInsets.zero,
                                          primary: false,
                                          shrinkWrap: true,
                                          scrollDirection: Axis.vertical,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsetsDirectional
                                                  .fromSTEB(
                                                  16.0, 0.0, 16.0, 12.0),
                                              child: Container(
                                                width: 100.0,
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
                                                  borderRadius:
                                                  BorderRadius.circular(
                                                      8.0),
                                                ),
                                                child: Padding(
                                                  padding: const EdgeInsets.all(8.0),
                                                  child: Row(
                                                    mainAxisSize:
                                                    MainAxisSize.max,
                                                    mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                    children: [
                                                      Column(
                                                        mainAxisSize:
                                                        MainAxisSize.max,
                                                        mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                        crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                        children: [
                                                          Padding(
                                                            padding:
                                                            const EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                4.0,
                                                                0.0,
                                                                0.0,
                                                                0.0),
                                                            child: Text(
                                                              'Doctors Check In',
                                                              style: FlutterFlowTheme
                                                                  .of(context)
                                                                  .headlineSmall
                                                                  .override(
                                                                fontFamily:
                                                                'Outfit',
                                                                color: const Color(
                                                                    0xFF14181B),
                                                                fontSize:
                                                                24.0,
                                                                letterSpacing:
                                                                0.0,
                                                                fontWeight:
                                                                FontWeight
                                                                    .w500,
                                                              ),
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding:
                                                            const EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                0.0,
                                                                4.0,
                                                                0.0,
                                                                0.0),
                                                            child: Row(
                                                              mainAxisSize:
                                                              MainAxisSize
                                                                  .max,
                                                              children: [
                                                                Padding(
                                                                  padding: const EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                      0.0,
                                                                      0.0,
                                                                      8.0,
                                                                      0.0),
                                                                  child: Card(
                                                                    clipBehavior:
                                                                    Clip.antiAliasWithSaveLayer,
                                                                    color: const Color(
                                                                        0x4DEE8B60),
                                                                    elevation:
                                                                    0.0,
                                                                    shape:
                                                                    RoundedRectangleBorder(
                                                                      borderRadius:
                                                                      BorderRadius.circular(
                                                                          8.0),
                                                                    ),
                                                                    child:
                                                                    Padding(
                                                                      padding: const EdgeInsetsDirectional.fromSTEB(
                                                                          8.0,
                                                                          4.0,
                                                                          8.0,
                                                                          4.0),
                                                                      child:
                                                                      Text(
                                                                        '2:20pm',
                                                                        style: FlutterFlowTheme.of(context)
                                                                            .bodyMedium
                                                                            .override(
                                                                          fontFamily: 'Plus Jakarta Sans',
                                                                          color: const Color(0xFFEE8B60),
                                                                          fontSize: 14.0,
                                                                          letterSpacing: 0.0,
                                                                          fontWeight: FontWeight.normal,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                                Text(
                                                                  'Wed, 03/08/2022',
                                                                  style: FlutterFlowTheme.of(
                                                                      context)
                                                                      .bodySmall
                                                                      .override(
                                                                    fontFamily:
                                                                    'Plus Jakarta Sans',
                                                                    color: const Color(
                                                                        0xFF14181B),
                                                                    fontSize:
                                                                    12.0,
                                                                    letterSpacing:
                                                                    0.0,
                                                                    fontWeight:
                                                                    FontWeight.normal,
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      Container(
                                                        width: 50.0,
                                                        height: 50.0,
                                                        decoration:
                                                        BoxDecoration(
                                                          color:
                                                          const Color(0xFFF1F4F8),
                                                          borderRadius:
                                                          BorderRadius
                                                              .circular(
                                                              8.0),
                                                          shape: BoxShape
                                                              .rectangle,
                                                          border: Border.all(
                                                            color: const Color(
                                                                0xFFE0E3E7),
                                                            width: 1.0,
                                                          ),
                                                        ),
                                                        alignment:
                                                        const AlignmentDirectional(
                                                            0.0, 0.0),
                                                        child: const Icon(
                                                          Icons
                                                              .add_photo_alternate_outlined,
                                                          color:
                                                          Color(0xFF14181B),
                                                          size: 24.0,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsetsDirectional.fromSTEB(
                                            16.0, 12.0, 0.0, 0.0),
                                        child: Text(
                                          'Past Due',
                                          style: FlutterFlowTheme.of(context)
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
                                      Padding(
                                        padding: const EdgeInsetsDirectional.fromSTEB(
                                            0.0, 12.0, 0.0, 24.0),
                                        child: ListView(
                                          padding: EdgeInsets.zero,
                                          primary: false,
                                          shrinkWrap: true,
                                          scrollDirection: Axis.vertical,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsetsDirectional
                                                  .fromSTEB(
                                                  16.0, 0.0, 16.0, 12.0),
                                              child: Container(
                                                width: 100.0,
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
                                                  borderRadius:
                                                  BorderRadius.circular(
                                                      8.0),
                                                ),
                                                child: Padding(
                                                  padding: const EdgeInsets.all(8.0),
                                                  child: Row(
                                                    mainAxisSize:
                                                    MainAxisSize.max,
                                                    mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                    children: [
                                                      Column(
                                                        mainAxisSize:
                                                        MainAxisSize.max,
                                                        mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                        crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                        children: [
                                                          Padding(
                                                            padding:
                                                            const EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                4.0,
                                                                0.0,
                                                                0.0,
                                                                0.0),
                                                            child: Text(
                                                              'Check In',
                                                              style: FlutterFlowTheme
                                                                  .of(context)
                                                                  .headlineSmall
                                                                  .override(
                                                                fontFamily:
                                                                'Outfit',
                                                                color: const Color(
                                                                    0xFF14181B),
                                                                fontSize:
                                                                24.0,
                                                                letterSpacing:
                                                                0.0,
                                                                fontWeight:
                                                                FontWeight
                                                                    .w500,
                                                              ),
                                                            ),
                                                          ),
                                                          Row(
                                                            mainAxisSize:
                                                            MainAxisSize
                                                                .max,
                                                            children: [
                                                              Padding(
                                                                padding:
                                                                const EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                    0.0,
                                                                    0.0,
                                                                    8.0,
                                                                    0.0),
                                                                child: Card(
                                                                  clipBehavior:
                                                                  Clip.antiAliasWithSaveLayer,
                                                                  color: const Color(
                                                                      0x4C4B39EF),
                                                                  elevation:
                                                                  0.0,
                                                                  shape:
                                                                  RoundedRectangleBorder(
                                                                    borderRadius:
                                                                    BorderRadius.circular(
                                                                        8.0),
                                                                  ),
                                                                  child:
                                                                  Padding(
                                                                    padding: const EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                        8.0,
                                                                        4.0,
                                                                        8.0,
                                                                        4.0),
                                                                    child: Text(
                                                                      '2:20pm',
                                                                      style: FlutterFlowTheme.of(
                                                                          context)
                                                                          .bodyMedium
                                                                          .override(
                                                                        fontFamily:
                                                                        'Plus Jakarta Sans',
                                                                        color:
                                                                        const Color(0xFF4B39EF),
                                                                        fontSize:
                                                                        14.0,
                                                                        letterSpacing:
                                                                        0.0,
                                                                        fontWeight:
                                                                        FontWeight.normal,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                              Padding(
                                                                padding:
                                                                const EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                    4.0,
                                                                    0.0,
                                                                    0.0,
                                                                    0.0),
                                                                child: Text(
                                                                  'Wed, 03/08/2022',
                                                                  style: FlutterFlowTheme.of(
                                                                      context)
                                                                      .bodySmall
                                                                      .override(
                                                                    fontFamily:
                                                                    'Plus Jakarta Sans',
                                                                    color: const Color(
                                                                        0xFF14181B),
                                                                    fontSize:
                                                                    12.0,
                                                                    letterSpacing:
                                                                    0.0,
                                                                    fontWeight:
                                                                    FontWeight.normal,
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                      Container(
                                                        width: 50.0,
                                                        height: 50.0,
                                                        decoration:
                                                        BoxDecoration(
                                                          color:
                                                          const Color(0xFFF1F4F8),
                                                          borderRadius:
                                                          BorderRadius
                                                              .circular(
                                                              8.0),
                                                          shape: BoxShape
                                                              .rectangle,
                                                          border: Border.all(
                                                            color: const Color(
                                                                0xFFE0E3E7),
                                                            width: 1.0,
                                                          ),
                                                        ),
                                                        alignment:
                                                        const AlignmentDirectional(
                                                            0.0, 0.0),
                                                        child: const Icon(
                                                          Icons
                                                              .add_photo_alternate_outlined,
                                                          color:
                                                          Color(0xFF14181B),
                                                          size: 24.0,
                                                        ),
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