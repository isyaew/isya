// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutterui/screens/general/waterlevel/report.dart';
import 'package:flutterui/screens/general/waterlevel/setpoint.dart';
import 'package:flutterui/screens/widgets/bottom_menu.dart';
import 'package:flutterui/screens/general/waterlevel/alert.dart';
import 'package:flutterui/screens/general/waterlevel/danger.dart';
import 'package:flutterui/screens/general/waterlevel/normal.dart';
import 'package:flutterui/screens/general/waterlevel/warning.dart';
import 'package:flutterui/screens/widgets/home_button.dart';
import 'package:firebase_database/firebase_database.dart';


class WaterLevel extends StatefulWidget {
  @override
  State<WaterLevel> createState() => _WaterLevelState();
}

class _WaterLevelState extends State<WaterLevel> {
  @override
  Widget build(BuildContext context) {
    // print(ref);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Water Level'),
      ),
      backgroundColor: const Color.fromRGBO(1, 39, 72, 1.0),

      body: Center(
          child: Column(
        children: [
          const Expanded(
            flex: 0,
            child: Padding(
              padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
              child: Text('',
                  textScaleFactor: 2,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  )),
            ),
          ),
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Danger()),
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                      color: Color.fromARGB(255, 155, 23, 23),
                      borderRadius: BorderRadius.circular(15)),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.asset(
                          'assets/danger.png',
                          width: 80,
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.fromLTRB(20, 8, 8, 8),
                        child: Text('DANGER',
                            textScaleFactor: 2,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            )),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const WarningList()),
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                      color: Color.fromARGB(255, 181, 82, 21),
                      borderRadius: BorderRadius.circular(15)),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.asset(
                          'assets/warning.png',
                          width: 80,
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.fromLTRB(20, 8, 8, 8),
                        child: Text('WARNING',
                            textScaleFactor: 2,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            )),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AlertList()),

                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                      color: Color.fromARGB(255, 213, 210, 43),
                      borderRadius: BorderRadius.circular(15)),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.asset(
                          'assets/alert.png',
                          width: 80,
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.fromLTRB(20, 8, 8, 8),
                        child: Text('ALERT',
                            textScaleFactor: 2,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            )),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const NormalList()),
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                      color: Color.fromARGB(255, 43, 185, 43),
                      borderRadius: BorderRadius.circular(15)),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.asset(
                          'assets/save.png',
                          width: 80,
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.fromLTRB(20, 8, 8, 8),
                        child: Text('NORMAL',
                            textScaleFactor: 2,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            )),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const ReportList()),
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                      color: Color.fromARGB(255, 40, 168, 170),
                      borderRadius: BorderRadius.circular(15)),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.asset(
                          'assets/communityicon.png',
                          width: 80,
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.fromLTRB(20, 8, 8, 8),
                        child: Text('REPORT',
                            textScaleFactor: 2,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            )),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
              child: InkWell(
                onTap: () {},
                child: Container(
                  decoration: BoxDecoration(
                      color: Color.fromRGBO(1, 39, 72, 1.0),
                      borderRadius: BorderRadius.circular(15)),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.asset(
                          'assets/communityicon.png',
                          width: 0,
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.fromLTRB(20, 8, 8, 8),
                        child: Text('',
                            textScaleFactor: 2,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            )),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      )),

      //Bottom Part
      bottomNavigationBar: const MyBottomMenuNavigationBar(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: const MyHomeButton(),
    );
  }
}
