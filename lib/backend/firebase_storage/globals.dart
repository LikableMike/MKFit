library globals;

String? UID = "";

Map userWorkoutsUIDs = {"Shoulders" : "shoulders",
                        "Daily Warmup" : "daily_warmup"};

List userWorkouts = [];

var selectedWorkout = "";

Map testWorkouts = {};
// {"Shoulders" : [
//   {"name" : "Arnold Press",
//     "weight" : 20,
//     "reps" : 5,
//     "sets" : 4,
//     "description" : "Test Description"},
//   {"name" : "Lateral Raises",
//     "weight" : 5,
//     "reps" : 8,
//     "sets" : 8,
//     "description" : "Test Description"}
// ],
//   "Daily Warmup": [
//     {"name" : "Leg Stretch",
//       "weight" : 20,
//       "reps" : 5,
//       "sets" : 4,
//       "description" : "Test Description"},
//     {"name" : "Arm Circles",
//       "weight" : 5,
//       "reps" : 8,
//       "sets" : 8,
//       "description" : "Test Description"}
//   ]
// };