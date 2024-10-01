import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

void main() {
  runApp(MyWorkoutApp());
}

class MyWorkoutApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Workout Scheduler',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: AppointmentsScreen(),
    );
  }
}

class AppointmentsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('My Appointments')),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => CalendarView()),
            );
          },
          child: Text('View My Appointments'),
        ),
      ),
    );
  }
}

class CalendarView extends StatefulWidget {
  @override
  _CalendarViewState createState() => _CalendarViewState();
}

class _CalendarViewState extends State<CalendarView> {
  DateTime _chosenDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Select a Date')),
      body: Column(
        children: [
          TableCalendar(
            focusedDay: _chosenDate,
            selectedDayPredicate: (day) => isSameDay(day, _chosenDate),
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _chosenDate = selectedDay;
              });
            },
            firstDay: DateTime.utc(2020, 1, 1),
            lastDay: DateTime.utc(2030, 12, 31),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              // Logic to schedule an appointment for the chosen date
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Appointment set for $_chosenDate')),
              );
            },
            child: Text('Set Appointment'),
          ),
        ],
      ),
    );
  }
}
