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
  late DatabaseService dbService;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  DateTimeRange? _selectedDateRange;
  TimeOfDay? _selectedTime;


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
    dbService = DatabaseService();
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
  List<String> getAvailableTimes(BuildContext context) {
    return [
      TimeOfDay(hour: 10, minute: 0).format(context),
      TimeOfDay(hour: 11, minute: 0).format(context),
      TimeOfDay(hour: 12, minute: 0).format(context),
      TimeOfDay(hour: 13, minute: 0).format(context),
      TimeOfDay(hour: 14, minute: 0).format(context),
      TimeOfDay(hour: 15, minute: 0).format(context),
      TimeOfDay(hour: 16, minute: 0).format(context),
    ];
  }
  void _updateSelectedTime(String? newValue) {
    // Parse the string to a TimeOfDay
    if (newValue != null) {
      final timeParts = newValue.split(" "); // Splits "9:00 AM" to ["9:00", "AM"]
      final hourMinute = timeParts[0].split(":"); // ["9", "00"]
      int hour = int.parse(hourMinute[0]);
      int minute = int.parse(hourMinute[1]);

      // Adjust for AM/PM if necessary
      if (timeParts[1] == "PM" && hour != 12) {
        hour += 12;
      } else if (timeParts[1] == "AM" && hour == 12) {
        hour = 0;
      }

      setState(() {
        _selectedTime = TimeOfDay(hour: hour, minute: minute);
      });
    } else {
      setState(() {
        _selectedTime = null;
      });
    }
  }
  Future<void> attemptToBookAppointment(DateTime startTime, DateTime endTime) async {
    try {
      // Check for appointment availability
      bool isAvailable = await dbService.isAppointmentAvailable(startTime);

      if (isAvailable) {
        // If available, proceed with adding the appointment
        String resultMessage = await dbService.addAppointment(startTime, endTime);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(resultMessage)),
        );
      } else {
        // If not available, inform the user
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('This time slot is already taken. Please choose another.')),
        );
      }
    } catch (e) {
      print("Error in booking appointment: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('An error occurred while booking the appointment. Please try again.')),
      );
    }
  }
  @override
  Widget build(BuildContext context) {
  final List<String> _availableTimes = getAvailableTimes(context);
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
                                        child: Column(
                                          children: [
                                            // Print statements to debug time format
                                            Text(
                                              'Appointment Ends One Hour After Start Time',
                                              style: TextStyle(color: Colors.white),
                                            ),
                                            Text(
                                              'Select Start Time:',
                                              style: TextStyle(color: Colors.white),
                                            ),

                                            // Your DropdownButton
                                            DropdownButton<String>(
                                              value: _selectedTime != null ? _selectedTime!.format(context) : null,
                                              hint: Text(
                                                _selectedTime == null ? 'Select time' : 'Time Selected: ${_selectedTime!.format(context)}',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 16.0,
                                                ),
                                              ),
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 16.0,
                                              ),
                                              items: _availableTimes.map((String time) {
                                                return DropdownMenuItem<String>(
                                                  value: time,
                                                  child: Text(
                                                    time,
                                                    style: TextStyle(
                                                      color: Colors.blue,
                                                    ),
                                                  ),
                                                );
                                              }).toList(),
                                              onChanged: (String? newValue) {
                                                if (newValue != null) {
                                                  // Parse the new value back into a TimeOfDay object
                                                  final timeParts = newValue.split(" ");
                                                  final period = timeParts[1];
                                                  final hourMinute = timeParts[0].split(":");
                                                  int hour = int.parse(hourMinute[0]);
                                                  int minute = int.parse(hourMinute[1]);

                                                  if (period == "PM" && hour != 12) {
                                                    hour += 12;
                                                  } else if (period == "AM" && hour == 12) {
                                                    hour = 0;
                                                  }

                                                  setState(() {
                                                    _selectedTime = TimeOfDay(hour: hour, minute: minute);
                                                  });
                                                }
                                              },
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(16.0),
                                        child: ElevatedButton(
                                          onPressed: () async {
                                            // Extract date and time
                                            DateTime selectedDate = _selectedDateRange!.start; // The selected start date
                                            TimeOfDay selectedTime = _selectedTime!;           // The selected time

                                            // Combine date and time into DateTime objects for start and end
                                            DateTime startTime = DateTime(
                                              selectedDate.year,
                                              selectedDate.month,
                                              selectedDate.day,
                                              selectedTime.hour,
                                              selectedTime.minute,
                                            );

                                            // Define an end time, e.g., for a 1-hour appointment
                                            DateTime endTime = startTime.add(Duration(hours: 1));

                                            try {
                                              // Check for availability and schedule if available
                                              bool isAvailable = await DatabaseService().isAppointmentAvailable(startTime);

                                              if (isAvailable) {
                                                print('Appointment scheduled for ${DateFormat('yyyy-MM-dd – kk:mm').format(startTime)}');

                                                // Add appointment to the database with both date and time
                                                String resultMessage = await DatabaseService().addAppointment(startTime, endTime);
                                                print(resultMessage);

                                                // Show dialog for recurring option
                                                bool? shouldSetRecurring = await showDialog<bool>(
                                                  context: context,
                                                  builder: (BuildContext context) {
                                                    return AlertDialog(
                                                      title: Text('Set Recurring Meeting'),
                                                      content: Text('Would you like to set this meeting to recurring?'),
                                                      actions: <Widget>[
                                                        TextButton(
                                                          onPressed: () {
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

                                                if (shouldSetRecurring != null && shouldSetRecurring) {
                                                  DateTimeRange? recurringDateRange = await showDateRangePicker(
                                                    context: context,
                                                    firstDate: DateTime.now(),
                                                    lastDate: DateTime(2100),
                                                    initialDateRange: _selectedDateRange,
                                                  );

                                                  if (recurringDateRange != null) {
                                                    List<DateTime> recurringDates = generateRecurringDates(
                                                      _selectedDateRange!.start,
                                                      recurringDateRange.end,
                                                    );

                                                    for (DateTime date in recurringDates) {
                                                      DateTime recurringStartTime = DateTime(
                                                        date.year,
                                                        date.month,
                                                        date.day,
                                                        selectedTime.hour,
                                                        selectedTime.minute,
                                                      );
                                                      DateTime recurringEndTime = recurringStartTime.add(Duration(hours: 1));

                                                      await DatabaseService().addAppointment(recurringStartTime, recurringEndTime);
                                                    }

                                                    ScaffoldMessenger.of(context).showSnackBar(
                                                      SnackBar(content: Text('Recurring appointments set from ${DateFormat('yyyy-MM-dd').format(recurringDateRange.start)} to ${DateFormat('yyyy-MM-dd').format(recurringDateRange.end)} at ${_selectedTime!.format(context)}')),
                                                    );
                                                  }
                                                } else {
                                                  ScaffoldMessenger.of(context).showSnackBar(
                                                    SnackBar(content: Text('Appointment confirmed for ${DateFormat('yyyy-MM-dd – kk:mm').format(startTime)}')),
                                                  );
                                                }
                                              } else {
                                                // Notify user if the selected time slot is unavailable
                                                ScaffoldMessenger.of(context).showSnackBar(
                                                  SnackBar(content: Text('This time slot is already taken. Please choose another.')),
                                                );
                                              }
                                            } catch (e) {
                                              print(e);
                                            }
                                          },
                                          child: Text('Confirm Appointment'),
                                        ),
                                      ),






                                      // Cancel Appointment Button
                                      Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0), // Adjusted padding to align parallel with Confirm Appointment button
                                        child: FutureBuilder<bool>(
                                          future: DatabaseService().checkAppointment(
                                              DateFormat('yyyy-MM-dd').format(_selectedDateRange?.start ?? DateTime.now())),
                                          builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
                                            if (snapshot.connectionState == ConnectionState.waiting) {
                                              return CircularProgressIndicator();
                                            } else if (snapshot.hasError) {
                                              return Text('Error: \${snapshot.error}');
                                            } else if (snapshot.hasData && snapshot.data == true) {
                                              return FutureBuilder<String?>(
                                                future: DatabaseService().getAppointmentTime(
                                                    DateFormat('yyyy-MM-dd').format(_selectedDateRange!.start)),
                                                builder: (BuildContext context, AsyncSnapshot<String?> timeSnapshot) {
                                                  if (timeSnapshot.connectionState == ConnectionState.waiting) {
                                                    return CircularProgressIndicator();
                                                  } else if (timeSnapshot.hasError) {
                                                    return Text('Error: \${timeSnapshot.error}');
                                                  } else {
                                                    String formattedDate = DateFormat('MM-dd-yyyy').format(_selectedDateRange!.start);
                                                    String timeString = timeSnapshot.data != null ? ' at ${timeSnapshot.data}' : '';

                                                    return ElevatedButton(
                                                      style: ElevatedButton.styleFrom(
                                                        backgroundColor: Colors.red,
                                                      ),
                                                      onPressed: () async {
                                                        // Show a dialog to confirm if the user wants to cancel the appointment
                                                        bool? shouldCancelAppointment = await showDialog<bool>(
                                                          context: context,
                                                          builder: (BuildContext context) {
                                                            return AlertDialog(
                                                              title: Text('Cancel Appointment'),
                                                              content: Text('Do you wish to cancel your appointment on $formattedDate$timeString?'),
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
                                                          await DatabaseService().cancelAppointment([DateFormat('yyyy-MM-dd').format(_selectedDateRange!.start)]);

                                                          ScaffoldMessenger.of(context).showSnackBar(
                                                            SnackBar(content: Text('Appointment on $formattedDate$timeString has been canceled.')),
                                                          );

                                                          // Refresh UI
                                                          setState(() {
                                                            _selectedDateRange = null;
                                                            _selectedTime = null;
                                                          });

                                                          // Trigger a re-fetch of appointments
                                                          setState(() {});
                                                        }
                                                      },
                                                      child: const Text('Cancel Appointment'),
                                                    );
                                                  }
                                                },
                                              );
                                            } else {
                                              return Container();
                                            }
                                          },
                                        ),
                                      ),


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
                                                                        _selectedTime != null ? _selectedTime!.format(context) : 'Select Time',
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