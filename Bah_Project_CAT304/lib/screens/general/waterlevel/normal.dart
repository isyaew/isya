// ignore_for_file: avoid_print, override_on_non_overriding_member, non_constant_identifier_names
import 'dart:convert';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutterui/screens/widgets/bottom_menu.dart';
import 'package:flutterui/screens/widgets/home_button.dart';
import 'package:flutterui/screens/widgets/location_card.dart';


class NormalList extends StatefulWidget {
  const NormalList({super.key});

  @override
  State<NormalList> createState() => NormalListState();
}

class NormalListState extends State<NormalList> {
  //Variables
  List<dynamic> listlocations = [];
  List<String> listlocation_string = [];
  bool _dataLoaded = false;
  List<String> entries = [];

  //==================   Referencing Database =============================
  @override
  final ref = FirebaseDatabase.instance.ref();
  // ignore: non_constant_identifier_names
  Future<void> fetch_fb() async {
    var snapshot = await ref.child('normal/data/').get();
    if (snapshot.exists) {
      print(snapshot.value);
      listlocations = jsonDecode(
          jsonEncode(snapshot.value)); // Passing JSON Data Into ListLocation
      // Converting Dynamic List Locations into String Listlocation | by Appending The Empty Nodes.
      setState(() {
        for (String key in listlocations) {
          listlocation_string.add(key);
        }
        print('List location string');
        print(listlocation_string);
      });
    } else {
      print('NO ACCESS TO DATABASE');
    }
    setState(() {
      _dataLoaded = true;
    });
  }

  // =================   Initializing Database State =============
  @override
  void initState() {
    super.initState();
    fetch_fb();
  }

  // ==================  User Interface ==========================
  Widget build(BuildContext context) {
    if (!_dataLoaded) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    } else {
      for (String key in listlocation_string) {
        entries.add(key);
      }
      return Scaffold(
        appBar: AppBar(
          title: const Text('Normal'),
        ),
        body: ListView.builder(
            padding: const EdgeInsets.all(8),
            itemCount: entries.length,
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: CardFb2(
                  text: ' ${entries[index]}'.trim(),
                  imageUrl: "assets/location.png",
                  onPressed: () {},
                ),
              );
            }),
        // Template
        bottomNavigationBar: MyBottomMenuNavigationBar(),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: MyHomeButton(),
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
