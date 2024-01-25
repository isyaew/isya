import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutterui/screens/widgets/bottom_menu.dart';
import 'package:flutterui/screens/widgets/home_button.dart';
import 'package:flutterui/screens/widgets/location_card.dart';
import 'dart:convert';

class AlertScreen extends StatefulWidget {
  @override
  _AlertScreenState createState() => _AlertScreenState();
}

class _AlertScreenState extends State<AlertScreen> {
  final FirebaseDatabase database = FirebaseDatabase(
    databaseURL: "https://aquaalert-90e88-default-rtdb.firebaseio.com/",
  );

  @override
  Widget build(BuildContext context) {
    return AlertList();
  }
}

class AlertList extends StatefulWidget {
  @override
  _AlertListState createState() => _AlertListState();
}

class _AlertListState extends State<AlertList> {
  List<dynamic> listlocations = [];
  List<String> listlocation_string = [];
  bool _dataLoaded = false;
  List<String> entries = [];

  final DatabaseReference ref = FirebaseDatabase.instance.ref();

  Future<void> fetch_fb() async {
    var snapshot = await ref.child('alert/data/').get();
    if (snapshot.exists) {
      print(snapshot.value);
      listlocations = jsonDecode(jsonEncode(snapshot.value));
      setState(() {
        listlocation_string = listlocations.map((e) => e.toString()).toList();
        print('List location string: $listlocation_string');
      });
    } else {
      print('NO ACCESS TO DATABASE');
    }
    setState(() {
      _dataLoaded = true;
    });
  }

  @override
  void initState() {
    super.initState();
    fetch_fb();
  }

  @override
  Widget build(BuildContext context) {
    if (!_dataLoaded) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    } else {
      entries = listlocation_string;
      return Scaffold(
        appBar: AppBar(
          title: const Text('Alert'),
        ),
        body: ListView.builder(
          padding: const EdgeInsets.all(8),
          itemCount: entries.length,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: CardFb2(
                text: '${entries[index]}'.trim(),
                imageUrl: "assets/location.png",
                onPressed: () {},
              ),
            );
          },
        ),
        bottomNavigationBar: MyBottomMenuNavigationBar(),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: MyHomeButton(),
      );
    }
  }
}
