// ignore_for_file: avoid_print, unused_import, non_constant_identifier_names

import 'dart:convert';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutterui/screens/widgets/bottom_menu.dart';
import 'package:flutterui/screens/widgets/home_button.dart';


class SetPoint extends StatefulWidget {
  const SetPoint({super.key});

  @override
  State<SetPoint> createState() => _SetPointState();
}

class _SetPointState extends State<SetPoint> {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  final TextEditingController _pointOfInterestController =
      TextEditingController();
  final List<String> _pointsOfInterest = [];
  List<dynamic> warninglistlocations = [];
  List<String> WarningListlocation_string = [];
  List<dynamic> dangerlistlocations = [];
  List<String> DangerListlocation_string = [];
  List<dynamic> alertlistlocations = [];
  List<String> AlertListlocation_string = [];
  bool _dataLoaded = false;
  List<String> entries = [];

  //==================   Referencing Database =============================
  final refer = FirebaseDatabase.instance.ref();
  // ignore: non_constant_identifier_names
  Future<void> fetch_fb() async {
    var warning = await refer.child('warning/data/').get();
    var danger = await refer.child('danger/data/').get();
    var alert = await refer.child('alert/data/').get();

    if (alert.exists) {
      //print(warning.value);
      alertlistlocations = jsonDecode(
          jsonEncode(alert.value)); // Passing JSON Data Into ListLocation
      // Converting Dynamic List Locations into String Listlocation | by Appending The Empty Nodes.
      setState(() {
        for (String key in alertlistlocations) {
          AlertListlocation_string.add(key);
        }
        AlertListlocation_string =
            AlertListlocation_string.map((string) => string.trim()).toList();
        print('Alert Location');
        print(AlertListlocation_string);
      });
    } else {
      print('NO ACCESS TO DATABASE');
    }

    if (warning.exists) {
      //print(warning.value);
      warninglistlocations = jsonDecode(
          jsonEncode(warning.value)); // Passing JSON Data Into ListLocation
      // Converting Dynamic List Locations into String Listlocation | by Appending The Empty Nodes.
      setState(() {
        for (String key in warninglistlocations) {
          WarningListlocation_string.add(key);
        }
        WarningListlocation_string =
            WarningListlocation_string.map((string) => string.trim()).toList();
        print('Warning Location');
        print(WarningListlocation_string);
      });
    } else {
      print('NO ACCESS TO DATABASE');
    }

    if (danger.exists) {
      //print(danger.value);
      dangerlistlocations = jsonDecode(
          jsonEncode(danger.value)); // Passing JSON Data Into ListLocation
      // Converting Dynamic List Locations into String Listlocation | by Appending The Empty Nodes.
      setState(() {
        for (String key in dangerlistlocations) {
          DangerListlocation_string.add(key);
        }
        DangerListlocation_string =
            DangerListlocation_string.map((string) => string.trim()).toList();
        print('Danger Location');
        print(DangerListlocation_string);
      });
    } else {
      print('NO ACCESS TO DATABASE');
    }
    setState(() {
      _dataLoaded = true;
    });
  }

  // Add default selected value for DropdownButton
  String _selectedPoint = 'Johor';

  @override
  void initState() {
    super.initState();
    var initializationSettingsAndroid =
        const AndroidInitializationSettings('@mipmap/ic_launcher');
    var initializationSettingsIOS = const DarwinInitializationSettings();
    var initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
    flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse: onDidReceiveNotificationResponse);
    fetch_fb();
  }

  Future<void> onDidReceiveNotificationResponse(
      NotificationResponse response) async {
    if (response.payload != null) {
      debugPrint('notification payload: ${response.payload}');
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!_dataLoaded) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    } else {
      for (String key in WarningListlocation_string) {
        entries.add(key);
      }
      for (String key in DangerListlocation_string) {
        entries.add(key);
      }
      return Scaffold(
        appBar: AppBar(
          title: const Text('Location'),
        ),
        body: Container(
          decoration: BoxDecoration(
              color: const Color.fromARGB(255, 255, 255, 255),
              borderRadius: BorderRadius.circular(15)),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              child: Center(
                child: Column(
                  children: [
                    // Container(
                    //   child: TextField(
                    //     controller: _pointOfInterestController,
                    //     decoration: const InputDecoration(
                    //         //hintText: 'Enter your point of interest',
                    //         ),
                    //   ),
                    // ),
                    Container(
                      padding: const EdgeInsets.all(8.0),
                      child: DropdownButton<String>(
                        value: _selectedPoint,
                        items: const [
                          DropdownMenuItem<String>(
                            value: 'Johor',
                            child: Text('Johor'),
                          ),
                          DropdownMenuItem<String>(
                            value: 'Melaka',
                            child: Text('Melaka'),
                          ),
                          DropdownMenuItem<String>(
                            value: 'Pahang',
                            child: Text('Pahang'),
                          ),
                          DropdownMenuItem<String>(
                            value: 'Negeri Sembilan',
                            child: Text('Negeri Sembilan'),
                          ),
                          DropdownMenuItem<String>(
                            value: 'Selangor',
                            child: Text('Selangor'),
                          ),
                          DropdownMenuItem<String>(
                            value: 'Wilayah Persekutuan Kuala Lumpur',
                            child: Text('Wilayah Persekutuan Kuala Lumpur'),
                          ),
                          DropdownMenuItem<String>(
                            value: 'Wilayah Persekutuan Putrajaya',
                            child: Text('Wilayah Persekutuan Putrajaya'),
                          ),
                          DropdownMenuItem<String>(
                            value: 'Wilayah Persekutuan Labuan',
                            child: Text('Wilayah Persekutuan Labuan'),
                          ),
                          DropdownMenuItem<String>(
                            value: 'Perak',
                            child: Text('Perak'),
                          ),
                          DropdownMenuItem<String>(
                            value: 'Kelantan',
                            child: Text('Kelantan'),
                          ),
                          DropdownMenuItem<String>(
                            value: 'Terengganu',
                            child: Text('Terengganu'),
                          ),
                          DropdownMenuItem<String>(
                            value: 'Pulau Pinang',
                            child: Text('Pulau Pinang'),
                          ),
                          DropdownMenuItem<String>(
                            value: 'Kedah',
                            child: Text('Kedah'),
                          ),
                          DropdownMenuItem<String>(
                            value: 'Perlis',
                            child: Text('Perlis'),
                          ),
                          DropdownMenuItem<String>(
                            value: 'Sabah',
                            child: Text('Sabah'),
                          ),
                          DropdownMenuItem<String>(
                            value: 'Sarawak',
                            child: Text('Sarawak'),
                          )
                        ],
                        onChanged: (String? value) {
                          setState(() {
                            _selectedPoint = value!;
                            _pointOfInterestController.text = value;
                          });
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                        onPressed: () async {
                          // Save the point of interest to your desired location
                          String pointOfInterest =
                              _pointOfInterestController.text;
                          _pointsOfInterest.add(pointOfInterest);

                          refer
                              .child("users")
                              .set({"point_of_interest": pointOfInterest});
                          // save the point of interest
                          print(pointOfInterest);

                          var androidPlatformChannelSpecs =
                              const AndroidNotificationDetails(
                            'your channel id',
                            'your channel name',
                            importance: Importance.max,
                            priority: Priority.high,
                          );
                          var iOSPlatformChannelSpecifics =
                              const DarwinNotificationDetails();
                          DangerListlocation_string;
                          var platformChannelSpecs = NotificationDetails(
                            android: androidPlatformChannelSpecs,
                            iOS: iOSPlatformChannelSpecifics,
                          );

                          if (DangerListlocation_string.contains(
                              pointOfInterest)) {
                            await flutterLocalNotificationsPlugin.show(
                              0,
                              'Your POI is in great danger',
                              'Your point of interest, "$pointOfInterest", was saved successfully.',
                              platformChannelSpecs,
                              payload: pointOfInterest,
                            );
                          } else if (WarningListlocation_string.contains(
                              pointOfInterest)) {
                            await flutterLocalNotificationsPlugin.show(
                              1,
                              'Your POI is in the warning zone.',
                              'Your point of interest, "$pointOfInterest", was saved successfully.',
                              platformChannelSpecs,
                              payload: pointOfInterest,
                            );
                          } else if (AlertListlocation_string.contains(
                              pointOfInterest)) {
                            await flutterLocalNotificationsPlugin.show(
                              2,
                              'Your POI is in alerting situation zone.',
                              'Your point of interest, "$pointOfInterest", was saved successfully.',
                              platformChannelSpecs,
                              payload: pointOfInterest,
                            );
                          } else {
                            await flutterLocalNotificationsPlugin.show(
                              3,
                              'Your POI is in normal zone.',
                              'Your point of interest, "$pointOfInterest", was saved successfully.',
                              platformChannelSpecs,
                              payload: pointOfInterest,
                            );
                          }
                        },
                        child: const Text('Save'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        bottomNavigationBar: const MyBottomMenuNavigationBar(),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: const MyHomeButton(),
      );
    }
  }

  Stream<Map<String, List<String>>> getData() {
    final databaseReference = FirebaseDatabase.instance.ref();
    return databaseReference.onValue.map((event) {
      if (event.snapshot.value != null) {
        Map<dynamic, dynamic> values =
            event.snapshot.value as Map<dynamic, dynamic>;
        Map<String, List<String>> results = {};
        values.forEach((key, value) {
          results[key] = value;
        });
        return results;
      } else {
        return <String, List<String>>{};
      }
    });
  }
}
