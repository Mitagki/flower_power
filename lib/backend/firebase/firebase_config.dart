import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

Future initFirebase() async {
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: FirebaseOptions(
            apiKey: "AIzaSyDu4Jb_dcalPgKbDS4qY154SBuCQRYavQg",
            authDomain: "flower-power-8554c.firebaseapp.com",
            projectId: "flower-power-8554c",
            storageBucket: "flower-power-8554c.appspot.com",
            messagingSenderId: "664486443293",
            appId: "1:664486443293:web:d719c60c41ab6a2bfc09f4",
            measurementId: "G-54PXJC55FC"));
  } else {
    await Firebase.initializeApp();
  }
}
