import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MKFit'),
      ),
      body: FutureBuilder<List<Workout>>(
        future: fetchWorkouts(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          final workouts = snapshot.data;

          return ListView.builder(
            itemCount: workouts!.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(workouts[index].title),
                subtitle: Text(workouts[index].description),
                onTap: () {
                  // Navigate to workout details
                },
              );
            },
          );
        },
      ),
    );
  }
}
