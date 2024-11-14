library globals;

import 'package:flutter/cupertino.dart';
import 'package:m_k_fit/main.dart';
import '/backend/firebase_storage/database.dart';
import "/index.dart";

String? UID = "";
Future<String>? futureUID;

List clientUIDS = [];

Map userWorkoutsUIDs = {"Shoulders" : "shoulders",
                        "Daily Warmup" : "daily_warmup"};

List userWorkouts = [];

var selectedWorkout = "";
var selectedClient = "";

List builtWorkout = [];

Map testWorkouts = {};

StatefulWidget findInitialState(){

  if(futureUID.toString() == "Qtg99NjZtpZW7EvWOYoy7Xvh7kF3" ||
      futureUID.toString() == "nOlIEy4WKkddkikrMPhQNLEjT9y1"){
    return const AdminNewWidget();
  }else{
    return const NavBarPage();
  }
}