// client_schedule_page.dart
import 'package:flutter/material.dart';
import 'firebase_service.dart';
import 'admin_availability_model.dart';

class ClientSchedulePage extends StatefulWidget {
  @override
  _ClientSchedulePageState createState() => _ClientSchedulePageState();
}

class _ClientSchedulePageState extends State<ClientSchedulePage> {
  Map<String, AdminAvailability> adminAvailability = {};

  @override
  void initState() {
    super.initState();
    _fetchAdminAvailability();
  }

  Future<void> _fetchAdminAvailability() async {
    FirebaseService service = FirebaseService();
    Map<String, AdminAvailability> availability = await service.getAvailability();
    setState(() {
      adminAvailability = availability;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Schedule Appointment')),
      body: ListView(
        children: adminAvailability.keys.map((day) {
          return ListTile(
            title: Text(day),
            subtitle: Text(
              'Available: ${adminAvailability[day]?.startTime} - ${adminAvailability[day]?.endTime}',
            ),
            onTap: () {
              // Proceed with the scheduling process for this day
            },
          );
        }).toList(),
      ),
    );
  }
}