// admin_availability_page.dart
import 'package:flutter/material.dart';
import 'admin_availability_model.dart';

class AdminAvailabilityPage extends StatefulWidget {
  @override
  _AdminAvailabilityPageState createState() => _AdminAvailabilityPageState();
}

class _AdminAvailabilityPageState extends State<AdminAvailabilityPage> {
  final Map<String, AdminAvailability> availability = {
    'Monday': AdminAvailability(day: 'Monday', startTime: '08:00 AM', endTime: '05:00 PM'),
    'Tuesday': AdminAvailability(day: 'Tuesday', startTime: '08:00 AM', endTime: '05:00 PM'),
    // Add other days similarly...
  };

  Future<void> _selectTime(BuildContext context, String day, bool isStartTime) async {
    TimeOfDay selectedTime = TimeOfDay.now();
    final TimeOfDay? newTime = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );

    if (newTime != null) {
      String timeString = newTime.format(context);
      setState(() {
        if (isStartTime) {
          availability[day]?.startTime = timeString;
        } else {
          availability[day]?.endTime = timeString;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Admin Availability')),
      body: ListView(
        children: availability.keys.map((day) {
          return Card(
            child: ListTile(
              title: Text(day),
              subtitle: Text(
                'From: ${availability[day]?.startTime}\nTo: ${availability[day]?.endTime}',
              ),
              trailing: Icon(Icons.edit),
              onTap: () => _showTimeSelectionDialog(context, day),
            ),
          );
        }).toList(),
      ),
    );
  }

  void _showTimeSelectionDialog(BuildContext context, String day) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Set Availability for $day'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: Text('Start Time'),
                subtitle: Text(availability[day]?.startTime ?? 'Not Set'),
                onTap: () => _selectTime(context, day, true),
              ),
              ListTile(
                title: Text('End Time'),
                subtitle: Text(availability[day]?.endTime ?? 'Not Set'),
                onTap: () => _selectTime(context, day, false),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                // Save changes to DB
                _saveAvailability();
                Navigator.of(context).pop();
              },
              child: Text('Save'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  void _saveAvailability() {
    // Save the availability to your database
    // Example with Firebase:
    // FirebaseFirestore.instance.collection('admin_availability').doc('admin_id').set({
    //   'availability': availability.map((key, value) => MapEntry(key, value.toJson())),
    // });
    print("Saving availability to database...");
  }
}