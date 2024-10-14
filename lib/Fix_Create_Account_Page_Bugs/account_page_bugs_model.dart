// bug_model.dart
class Bug {
  String id;                // Unique identifier for the bug
  String description;       // Description of the bug
  String status;            // Current status of the bug (e.g., 'open', 'in progress', 'resolved')
  String severity;          // Severity of the bug (e.g., 'low', 'medium', 'high')
  DateTime createdDate;     // Date when the bug was reported
  DateTime? resolvedDate;   // Date when the bug was resolved (optional)

  // Constructor for the Bug class
  Bug({
    required this.id,
    required this.description,
    required this.status,
    required this.severity,
    required this.createdDate,
    this.resolvedDate,
  });

  // Method to mark the bug as resolved
  void resolve() {
    status = 'resolved';
    resolvedDate = DateTime.now();
  }

  // Method to provide a summary of the bug
  String summary() {
    return 'Bug ID: $id\n'
           'Description: $description\n'
           'Status: $status\n'
           'Severity: $severity\n'
           'Created Date: ${createdDate.toLocal()}\n'
           'Resolved Date: ${resolvedDate?.toLocal() ?? 'Not resolved'}';
  }
}
