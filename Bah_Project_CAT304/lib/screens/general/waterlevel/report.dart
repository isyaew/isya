import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:flutterui/screens/general/waterlevel/create_report.dart';
import 'package:flutterui/screens/widgets/bottom_menu.dart';

import 'package:flutterui/screens/widgets/home_button.dart';
import 'package:intl/intl.dart';
import 'package:flutterui/screens/widgets/report_card.dart';


class ReportList extends StatefulWidget {
  const ReportList({super.key});

  @override
  State<ReportList> createState() => _ReportListState();
}

class _ReportListState extends State<ReportList> {
  var dbRef = FirebaseDatabase.instance.ref().child('Report');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text(
            "Report",
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.add_circle, color: Colors.white),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CreateReport()),
                );
              },
            )
          ]),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
                child: Column(
              children: [
                SizedBox(
                  height: (MediaQuery.of(context).size.height) - 152,
                  child: Container(
                    child: FirebaseAnimatedList(
                      query: dbRef,
                      itemBuilder: (BuildContext context, DataSnapshot snapshot,
                          Animation<double> animation, int index) {
                        Map report = snapshot.value as Map;
                        report['key'] = snapshot.key;

                        return listItem(report: report);
                      },
                    ),
                  ),
                ),
              ],
            )),
          )
        ],
      ),
      bottomNavigationBar: MyBottomMenuNavigationBar(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: MyHomeButton(),
    );
  }

  Widget listItem({required Map report}) {
    final String title = report['title'];
    final String date = report['date'];
    String location = report['location'];
    String day = date.substring(2, 5);
    String time = date.substring(10, 15);

    if (time[time.length - 1] == ':') {
      time = time.substring(0, time.length - 1);
    }

    if (day[0] == '/') {
      day = day.substring(1, day.length);
    }
    if (day[day.length - 1] == '/') {
      day = day.substring(0, day.length - 1);
    }
    String month = date.substring(0, 2);
    if (month[month.length - 1] == '/') {
      month = month.substring(0, month.length - 1);
    }
    String ampm = '';
    if (time.length == 4 && day.length == 2) {
      ampm = date.substring(18, 20);
    } else if (time.length == 5 && day.length == 2) {
      ampm = date.substring(19, 21);
    }

    var monthInt = int.parse(month);
    final String monthString = DateFormat('MMMM').format(DateTime(0, monthInt));
    final String resultdate =
        day + " " + monthString + " | " + time + " " + ampm;

    String shortenedLocation = location.substring(0, location.indexOf(','));

    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 130,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            gradient: const LinearGradient(colors: [
              Color.fromARGB(255, 20, 131, 183),
              Color.fromARGB(255, 5, 79, 114)
            ])),
        child: Stack(
          children: [
            Opacity(
              opacity: 0.5,
              child: Image.network(report['img'], fit: BoxFit.fitWidth),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                child: Text(
                  title,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: EdgeInsets.fromLTRB(10, 40, 10, 10),
                child: Text(
                  shortenedLocation,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.normal),
                ),
              ),
            ),
            Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: EdgeInsets.fromLTRB(10, 40, 15, 10),
                child: Text(
                  resultdate,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.normal),
                ),
              ),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: EdgeInsets.fromLTRB(10, 70, 10, 10),
                child: Text(
                  report['description'],
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.normal),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
