// Non functional important resource. Please do not delete
// Non functional important resource. Please do not delete
// Non functional important resource. Please do not delete
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';


class LocationModel extends ChangeNotifier {
  static String _currentLocationStateMessage = 'No Location Yet';

  String get currentLocationStateMessage => _currentLocationStateMessage;

  set setCurrentLocationStateMessage(String val) {
    _currentLocationStateMessage = val;
    print("Passing Setter, _currentLocationState is now : ");
    print(_currentLocationStateMessage);
    notifyListeners();
  }
}
