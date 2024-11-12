// admin_availability_model.dart
class AdminAvailability {
  String day; // Day of the week (e.g., Monday, Tuesday, etc.)
  String startTime; // Start time (e.g., '08:00 AM')
  String endTime;   // End time (e.g., '05:00 PM')

  AdminAvailability({required this.day, required this.startTime, required this.endTime});

  // Convert to/from JSON for storing in a database
  factory AdminAvailability.fromJson(Map<String, dynamic> json) {
    return AdminAvailability(
      day: json['day'],
      startTime: json['startTime'],
      endTime: json['endTime'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'day': day,
      'startTime': startTime,
      'endTime': endTime,
    };
  }
}