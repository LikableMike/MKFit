import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

Future initFirebase() async {
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: FirebaseOptions(
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
