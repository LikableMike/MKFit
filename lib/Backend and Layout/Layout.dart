class Layout extends StatelessWidget {
  final WorkoutService workoutService = WorkoutService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Workout App'),
      ),
      body: FutureBuilder<List<Workout>>(
        future: workoutService.fetchWorkouts(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          final workouts = snapshot.data ?? [];

          return ListView.builder(
            itemCount: workouts.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(workouts[index].title),
                subtitle: Text('${workouts[index].duration} mins'),
                onTap: () {
                  // Navigate to workout details
                },
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add workout logic
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
