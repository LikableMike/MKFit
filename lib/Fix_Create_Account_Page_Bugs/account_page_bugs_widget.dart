import 'package:flutter/material.dart';
import 'bug_model.dart'; // Import the Bug model

class BugReportWidget extends StatefulWidget {
  @override
  _BugReportWidgetState createState() => _BugReportWidgetState();
}

class _BugReportWidgetState extends State<BugReportWidget> {
  List<Bug> bugs = [];
  final _descriptionController = TextEditingController();
  String _severity = 'low';

  // Method to report a new bug
  void reportBug() {
    String id = 'bug_${bugs.length + 1}';
    Bug newBug = Bug(
      id: id,
      details: _descriptionController.text,
      currentStatus: 'open',
      severityLevel: _severity,
      reportedDate: DateTime.now(),
    );
    setState(() {
      bugs.add(newBug);
      _descriptionController.clear(); // Clear the input field
    });
  }

  // Method to resolve a bug by ID
  void resolveBug(String bugId) {
    setState(() {
      for (var bug in bugs) {
        if (bug.id == bugId) {
          bug.resolve();
          break;
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bug Reporting System'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _descriptionController,
              decoration: InputDecoration(
                labelText: 'Bug Details',
              ),
            ),
            DropdownButton<String>(
              value: _severity,
              items: ['low', 'medium', 'high']
                  .map((String value) => DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      ))
                  .toList(),
              onChanged: (newValue) {
                setState(() {
                  _severity = newValue!;
                });
              },
            ),
            ElevatedButton(
              onPressed: reportBug,
              child: Text('Report Bug'),
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: bugs.length,
                itemBuilder: (context, index) {
                  final bug = bugs[index];
                  return Card(
                    margin: EdgeInsets.symmetric(vertical: 8.0),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(bug.summary(), style: TextStyle(fontSize: 14)),
                          SizedBox(height: 10),
                          if (bug.currentStatus == 'open')
                            ElevatedButton(
                              onPressed: () => resolveBug(bug.id),
                              child: Text('Resolve Bug'),
                            ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}