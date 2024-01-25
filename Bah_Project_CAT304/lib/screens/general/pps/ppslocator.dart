import 'dart:convert';

import 'package:flutter/material.dart';
// import 'package:flutterui/screens/widgets/bottom_menu.dart';
// import 'package:flutterui/screens/widgets/home_button.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:firebase_database/firebase_database.dart';

class PPSLocator extends StatefulWidget {
  PPSLocator({super.key});

  static const CameraPosition initialCameraPosition = CameraPosition(
    target: LatLng(1.3521, 103.8198),
    zoom: 11.0,
  );

  Set<Marker> userLocationMarker = {};

  @override
  State<PPSLocator> createState() => _PPSLocatorState();
}

class _PPSLocatorState extends State<PPSLocator> {
  late GoogleMapController mapController;

  // Variables
  Set<Marker> markers = {};
  // List<dynamic> listlocations = [];
  List<dynamic> locationsData = [];
  bool _dataLoaded = false;
  List<String> entries = [];
  List<String> listlocation_string = [];

  //==================   Referencing Database =============================
  var ref = FirebaseDatabase.instance.ref();

  //==================   Fetching Location Data =============================
  // Fetch the data and store it in a list of locationsData only
  Future<void> fetchLocationData() async {
    DataSnapshot snapshot = await ref.child('location').get();

    if (snapshot.exists) {
      print(snapshot.value);

      Map locationsData = snapshot.value as Map;

      locationsData['key'] = snapshot.key;
      // return
      showLocationData(locationsData: locationsData);

      //print(listlocations);
      //show datatype of the content in the listlocations
      //print(listlocations.runtimeType);
    } else {
      print('NO ACCESS TO DATABASE');
    }
  }

  // Future<void> fetch_fb() async {
  //   var snapshot = await ref.child('Report').get();
  //   if (snapshot.exists) {
  //     print(snapshot.value);
  //     // listlocations = jsonDecode(
  //     //     jsonEncode(snapshot.value)); // Passing JSON Data Into ListLocation
  //     // // Converting Dynamic List Locations into String Listlocation | by Appending The Empty Nodes.
  //     // setState(() {
  //     //   for (String key in listlocations) {
  //     //     listlocation_string.add(key);
  //     //   }
  //     //   print('List location string');
  //     //   print(listlocation_string);
  //     // });
  //   } else {
  //     print('NO ACCESS TO DATABASE');
  //   }
  //   setState(() {
  //     _dataLoaded = true;
  //   });
  // }

// treat the listlocations as the PPS locations and show it as marker in the maps
  void showLocationData({required Map locationsData}) {
    print('pukimak');
    locationsData.forEach((key, value) {
      if (key != 'key') {
        print(key);
        print(value);
        String latitudestr = value['latitude'];
        String longitudestr = value['longitude'];
        double latitude = double.parse(latitudestr);
        double longitude = double.parse(longitudestr);
        print(latitude);
        print(longitude);
        markers.add(Marker(
          markerId: MarkerId(key),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
          position: LatLng(latitude, longitude),
        ));
      }
    });
    // print(locationsData['latitude']);
    // print(locationsData['longitude']);
  }

  @override
  void initState() {
    super.initState();
    // fetchLocationData();

//fetch_fb();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PPS Locator'),
      ),

      // Contents Placeholder
      body: GoogleMap(
        initialCameraPosition: PPSLocator.initialCameraPosition,
        markers: markers,
        zoomControlsEnabled: false,
        mapType: MapType.normal,
        onMapCreated: (GoogleMapController controller) {
          mapController = controller;
        },
      ),

      floatingActionButton: FloatingActionButton.extended(
          onPressed: () async {
            markers.clear();
            fetchLocationData();
            Position position = await _determinePosition();
            mapController.animateCamera(CameraUpdate.newCameraPosition(
                CameraPosition(
                    target: LatLng(position.latitude, position.longitude),
                    zoom: 11.0)));

            markers.add(Marker(
              markerId: const MarkerId("userLocation"),
              position: LatLng(position.latitude, position.longitude),
            ));

            setState(() {});
          },
          label: const Text("Current Location"),
          icon: const Icon(Icons.location_history)),

      // bottomNavigationBar: MyBottomMenuNavigationBar(),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      // floatingActionButton: MyHomeButton(),
    );
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();

      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    Position position = await Geolocator.getCurrentPosition();

    return position;
  }
}
