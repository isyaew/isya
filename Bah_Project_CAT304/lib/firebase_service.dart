import 'package:firebase_database/firebase_database.dart';

class FirebaseService {
  static final FirebaseDatabase database = FirebaseDatabase(
    databaseURL: "https://aquaalert-90e88-default-rtdb.firebaseio.com/",
  );