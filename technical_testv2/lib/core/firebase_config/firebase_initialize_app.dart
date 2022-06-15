import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

class FirebaseConfig {
  static late FirebaseFirestore db;
  static late FirebaseAuth auth;

  static Future<void> firebaseInit() async {
    FirebaseApp firebaseApp = await Firebase.initializeApp();
    db = FirebaseFirestore.instanceFor(app: firebaseApp);
    auth = FirebaseAuth.instanceFor(app: firebaseApp);
  }
}
