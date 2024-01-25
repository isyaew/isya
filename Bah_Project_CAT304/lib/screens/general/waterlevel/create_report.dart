import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:flutterui/screens/general/waterlevel/location_model.dart';
import 'package:flutterui/screens/widgets/gradient_button.dart';
import 'package:flutterui/screens/general/waterlevel/location_page.dart';
import 'package:flutterui/screens/general/waterlevel/report.dart';
import 'package:flutterui/screens/widgets/text_field.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
// import 'package:geocoder2/geocoder2.dart';
import 'package:firebase_database/firebase_database.dart';


// Passing Data Through Provider
class CreateReport extends StatefulWidget {
  @override
  State<CreateReport> createState() => _CreateReportState();
}

class _CreateReportState extends State<CreateReport> {
  // Referencing Database
  final referenceDatabase = FirebaseDatabase.instance;

  // Input Contoller Variables
  final reportTitleController = TextEditingController();
  final locationController = TextEditingController();
  final dateController = TextEditingController();
  final descController = TextEditingController();

  String datetime = DateTime.now().toString();
  XFile? image;
  final ImagePicker picker = ImagePicker();

  // ============================= Location Configuration =======================================
  // String locationMessage = 'Set Location';
  late String lat;
  late String long;
  List<Placemark> addresses = [];
  String tempString = '';
  String locationMessage = 'Set Location';
  String? _currentAddress = 'No Location yet';
  Position? _currentPosition;
  final _firebaseStorage = FirebaseStorage.instance;

  //  ==============  Upload image configuration ===========================
  Future getImage(ImageSource media) async {
    var img = await picker.pickImage(source: media);
    setState(() {
      image = img;
    });
  }

  void myAlert() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            title: Text('Please choose media to select'),
            content: Container(
              height: MediaQuery.of(context).size.height / 6,
              child: Column(
                children: [
                  ElevatedButton(
                    //if user click this button, user can upload image from gallery
                    onPressed: () {
                      Navigator.pop(context);
                      getImage(ImageSource.gallery);
                    },
                    child: Row(
                      children: [
                        Icon(Icons.image),
                        Text('From Gallery'),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    //if user click this button. user can upload image from camera
                    onPressed: () {
                      Navigator.pop(context);
                      getImage(ImageSource.camera);
                    },
                    child: Row(
                      children: [
                        Icon(Icons.camera),
                        Text('From Camera'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  // Handle Location Permission
  Future<bool> _handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location services are disabled. Please enable the services')));
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Location permissions are denied')));
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location permissions are permanently denied, we cannot request permissions.')));
      return false;
    }
    return true;
  }

  void Printer() {
    print('Hello This is Printer');
  }

  Future<void> _getCurrentPosition() async {
    final hasPermission = await _handleLocationPermission();
    print('Pass her cutr');
    if (!hasPermission) return;
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) {
      setState(() => _currentPosition = position);
      print('Pass here dwa');
      _getAddressFromLatLng(_currentPosition!);
    }).catchError((e) {
      debugPrint(e);
    });
  }

  Future<void> _getAddressFromLatLng(Position position) async {
    await placemarkFromCoordinates(
            _currentPosition!.latitude, _currentPosition!.longitude)
        .then((List<Placemark> placemarks) {
      Placemark place = placemarks[0];
      setState(() {
        _currentAddress =
            '${place.street}, ${place.subLocality}, ${place.subAdministrativeArea}, ${place.postalCode}';
        print('Pass here');
      });
    }).catchError((e) {
      debugPrint(e);
    });
  }

  // ====================================================== Main build ===================================================
  @override
  Widget build(BuildContext context) {
    final ref = referenceDatabase.ref('Report');
    String imageUrl = '';

    Widget okButton = TextButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Thank you"),
      content: Text("Your report is succesfully posted."),
      actions: [
        TextButton(
          child: Text("OK"),
          onPressed: () {
            Navigator.of(context).pop();
          },
        )
      ],
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Post Report'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Text Fields
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: MyInputTextField(
                    inputController: reportTitleController,
                    inputLabel: 'Report Title',
                    iconsImage: Icons.title,
                    inputHintText: '"roadblock due to flood..."',
                    wordlimit: 28,
                    linelimit: 1,
                  ),
                ),
                // =================== AD ================================

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: MyInputTextField(
                    inputController: descController,
                    inputLabel: 'Description of Report',
                    iconsImage: Icons.description,
                    inputHintText: 'Describe the event',
                    wordlimit: 179,
                    linelimit: 3,
                  ),
                ),

                Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                        child: Container(
                            child: Text('ADDRESS: ${_currentAddress ?? ""}')))),
                Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      onPressed: () {
                        Printer();
                        _getCurrentPosition();
                        print('ADDRESS: ${_currentAddress ?? ""}');
                      },
                      child: Text('Get Location'),
                    )),

                ElevatedButton(
                  onPressed: () {
                    myAlert();
                  },
                  child: Text('Upload Photo'),
                ),
                SizedBox(
                  height: 10,
                ),
                //if image not null show the image
                //if image null show text
                image != null
                    ? Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.file(
                            //to show image, you type like this.
                            File(image!.path),
                            fit: BoxFit.cover,
                            width: MediaQuery.of(context).size.width,
                            height: 300,
                          ),
                        ),
                      )
                    : const Text(
                        "No Image",
                        style: TextStyle(fontSize: 20),
                      ),

                // Post Button & Data Insertion Command
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GradientButtonFb1(
                    text: 'Post',
                    onPressed: () async {
                      print('Dalam Ni Ha');
                      print((image?.path));
                      if (image != null) {
                        String uniqueFileName =
                            DateTime.now().millisecondsSinceEpoch.toString();
                        Reference referenceRoot = _firebaseStorage.ref();
                        Reference referenceDirImages =
                            referenceRoot.child('images');
                        Reference referenceImageToUpload =
                            referenceDirImages.child(uniqueFileName);

                        try {
                          await referenceImageToUpload
                              .putFile(File(image!.path));
                          imageUrl =
                              await referenceImageToUpload.getDownloadURL();
                        } catch (error) {}
                        //Upload to Firebase

                        //var snapshot = _firebaseStorage
                        //  .ref()
                        //.child('images/')
                        // .putFile(File(image!.path));
                        //   var downloadUrl = snapshot.ref.getDownloadURL();
                        //   setState(() {
                        //     // imageUrl = downloadUrl;
                        //   });
                      } else {
                        print('No Image Path Received');
                      }

                      Map<String, String> reportdata = {
                        'description': descController.text,
                        'location': _currentAddress.toString(),
                        'date': DateFormat.yMd()
                            .add_jms()
                            .format(DateTime.now())
                            .toString(),
                        'title': reportTitleController.text,
                        'img': imageUrl,
                      };
                      ref.push().set(reportdata);
                      descController.clear();
                      //_currentAddress.clear();
                      dateController.clear();
                      reportTitleController.clear();
                      Navigator.of(context).pop();
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return (AlertDialog(
                              title: Text("Thank you"),
                              content:
                                  Text("Your report is succesfully posted."),
                              actions: [
                                TextButton(
                                  child: Text("OK"),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                )
                              ],
                            ));
                          });
                    },
                  ),
                ),
              ]),
        ),
      ),
    );
  }
}
