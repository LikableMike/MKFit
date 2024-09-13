/*
Ramin Selseleh

MA 113 - 114 - 115

For this task I was set up our firebase, whihc is being used for authetication
of users. Finishing this task allows us to validate accounts
users get an email once they are signed up with their email. They will recive
and email that is asking for vertification. If email is already being used
then it will pop error that email is already being used. If not and they validate
their email account using the link that is sent to them, their account will
be up and running. The user can not go to signing waivers page unless the account
is created.
 */



import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

Future initFirebase() async {
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
            apiKey: "AIzaSyDpYjsSk9f6XXxcKvEeit3xCzFcGdoATw0",
            authDomain: "mkfit-e22fa.firebaseapp.com",
            projectId: "mkfit-e22fa",
            storageBucket: "mkfit-e22fa.appspot.com",
            messagingSenderId: "926368246232",
            appId: "1:926368246232:web:f2c4bf8bc8baabee842aad",
            measurementId: "G-R6PRX64GJB"));
  } else {
    await Firebase.initializeApp();
  }
}
