import 'package:flutter/material.dart';

class UpdateWorkoutPage extends StatefulWidget {
  final String workoutId; // Workout ID to fetch and update specific workout
  const UpdateWorkoutPage({Key? key, required this.workoutId}) : super(key: key);

  @override
  _UpdateWorkoutPageState createState() => _UpdateWorkoutPageState();
}

class _UpdateWorkoutPageState extends State<UpdateWorkoutPage> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = true;
  String? _errorMessage;

  // Workout Fields
  String _title = '';
  String _description = '';
  int _duration = 0;
  String _type = 'Cardio'; // Default value
  String _difficulty = 'Beginner'; // Default value

  final List<String> _workoutTypes = ['Cardio', 'Strength', 'Flexibility'];
  final List<String> _difficultyLevels = ['Beginner', 'Intermediate', 'Advanced'];

  @override
  void initState() {
    super.initState();
    _fetchWorkoutDetails();
  }

  Future<void> _fetchWorkoutDetails() async {
    try {
      await Future.delayed(Duration(seconds: 2)); // Simulate network delay
      // Simulate fetching data (replace with actual API call)
      setState(() {
        _title = 'Morning Run';
        _description = 'A light run to kickstart the day';
        _duration = 20;
        _type = 'Cardio';
        _difficulty = 'Intermediate';
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _errorMessage = 'Failed to load workout details';
        _isLoading = false;
      });
    }
  }

  void _saveWorkout() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      // Logic to update the workout in the database or API
      print('Workout Updated: $_title, $_description, $_duration, $_type, $_difficulty');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Workout updated successfully!')),
      );
      Navigator.pop(context); // Navigate back
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Update Workout'),
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : _errorMessage != null
              ? Center(child: Text(_errorMessage!))
              : Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Form(
                    key: _formKey,
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildTextField(
                            label: 'Workout Title',
                            initialValue: _title,
                            onSaved: (value) => _title = value ?? '',
                            validator: (value) =>
                                value == null || value.isEmpty ? 'Please enter a title' : null,
                          ),
                          _buildTextField(
                            label: 'Description',
                            initialValue: _description,
                            maxLines: 3,
                            onSaved: (value) => _description = value ?? '',
                            validator: (value) =>
                                value == null || value.isEmpty ? 'Please enter a description' : null,
                          ),
                          _buildTextField(
                            label: 'Duration (minutes)',
                            initialValue: _duration.toString(),
                            keyboardType: TextInputType.number,
                            onSaved: (value) =>
                                _duration = int.tryParse(value ?? '0') ?? 0,
                            validator: (value) {
                              if (value == null || value.isEmpty || int.tryParse(value) == null) {
                                return 'Please enter a valid duration';
                              }
                              return null;
                            },
                          ),
                          _buildDropdown(
                            label: 'Workout Type',
                            value: _type,
                            items: _workoutTypes,
                            onChanged: (value) => setState(() => _type = value),
                          ),
                          _buildDropdown(
                            label: 'Difficulty Level',
                            value: _difficulty,
                            items: _difficultyLevels,
                            onChanged: (value) => setState(() => _difficulty = value),
                          ),
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              ElevatedButton(
                                onPressed: _saveWorkout,
                                child: Text('Save'),
                              ),
                              TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: Text('Cancel'),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
    );
  }

  Widget _buildTextField({
    required String label,
    required String initialValue,
    required FormFieldSetter<String> onSaved,
    FormFieldValidator<String>? validator,
    TextInputType keyboardType = TextInputType.text,
    int maxLines = 1,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: TextFormField(
        initialValue: initialValue,
        decoration: InputDecoration(labelText: label),
        keyboardType: keyboardType,
        maxLines: maxLines,
        onSaved: onSaved,
        validator: validator,
      ),
    );
  }

  Widget _buildDropdown({
    required String label,
    required String value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: DropdownButtonFormField<String>(
        value: value,
        decoration: InputDecoration(labelText: label),
        items: items.map((item) => DropdownMenuItem(value: item, child: Text(item))).toList(),
        onChanged: onChanged,
      ),
    );
  }
}