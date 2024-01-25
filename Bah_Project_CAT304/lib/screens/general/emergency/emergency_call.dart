import 'package:flutter/material.dart';
import 'package:flutterui/screens/widgets/bottom_menu.dart';
import 'package:flutterui/screens/widgets/home_button.dart';
import 'package:flutterui/screens/general/flood_tips/preflood.dart';
import 'package:flutterui/screens/general/flood_tips/duringflood.dart';
import 'package:flutterui/screens/general/flood_tips/postflood.dart';
import 'package:flutterui/screens/general/emergency/contact_widget.dart';
import 'package:intl/intl.dart';

class EmergencyCall extends StatefulWidget {
  EmergencyCall({super.key});

  @override
  State<EmergencyCall> createState() => _EmergencyCallState();
}

class _EmergencyCallState extends State<EmergencyCall> {
  final List<String> entries = <String>[
    'MERS',
    'NADMA',
    'JPAM',
    'BOMBA',
    'PDRM'
  ];
  final List<String> imageUrl = <String>[
    'assets/MERS.png',
    'assets/NADMA.png',
    'assets/jpam.png',
    'assets/bomba.png',
    'assets/pdrm.png'
  ];
  final List<String> displayNumber = <String>[
    '999',
    '03 8870 4800',
    '04 7323810',
    '1800 888 994',
    '03 22663333'
  ];
  final List<num> callNumber = <num>[
    999,
    0388704800,
    047323810,
    1800888994,
    0322663333
  ];

  final List<int> colorCodes = <int>[600, 500, 100, 200];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Emergency Contacts'),
        backgroundColor: const Color.fromRGBO(1, 39, 72, 1.0),
      ),
      backgroundColor: const Color.fromRGBO(1, 39, 72, 1.0),

      body: ListView.builder(
          padding: const EdgeInsets.all(10),
          itemCount: entries.length,
          itemBuilder: (BuildContext context, int index) {
            // ignore: prefer_const_constructors
            return ContactTile(
              title: ' ${entries[index]}',
              contactNumber: '${displayNumber[index]}',
              imgUrl: '${imageUrl[index]}',
              callNumber: '${callNumber[index]}',
            );
            // Container(
            //   height: 50,
            //   color: Colors.amber[colorCodes[index]],
            //   child: Center(child: Text('Entry ${entries[index]}')),
          }),

      //Bottom Part
      bottomNavigationBar: const MyBottomMenuNavigationBar(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: const MyHomeButton(),
    );
  }
}

// Malaysian Emergency Response Services
// 999

// NADMA
// 03-8870 4800

// JPAM
// 1800 888 994

// BOMBA
// 1800 888 994

// PDRM
// 1800 888 994
