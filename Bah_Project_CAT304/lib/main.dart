// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'firebase_options.dart';
import 'package:flutterui/screens/general//waterlevel/waterlevel.dart';
import 'package:flutterui/screens/general/emergency/emergency_call.dart';
import 'package:flutterui/screens/general/pps/ppslocator.dart';
import 'screens/general/flood_tips/floodtips.dart';
import 'screens/general/waterlevel/setpoint.dart';
import 'screens/widgets/bottom_menu.dart';
import 'screens/widgets/home_button.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_database/firebase_database.dart';

/* OVERALL NOTES 
main.dart provides
- void main to run apps
- classes for HOMEPAGE UI
- other pages or features shall use another dart file to keep it modular and manageable
*/

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  final Future<FirebaseApp> _fbApp = Firebase.initializeApp();

  //const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          scaffoldBackgroundColor: const Color.fromRGBO(216, 233, 231, 1.0),
          appBarTheme: const AppBarTheme(
            backgroundColor: Color.fromRGBO(1, 39, 72, 1.0),
          ),
        ),
        home: FutureBuilder(
            future: _fbApp,
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                print('Error ${snapshot.error.toString()}');
                return const Text('Erorr!');
              } else if (snapshot.hasData) {
                return MyHomePage();
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            }));
  }
}

class MyHomePage extends StatefulWidget {
  // const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  // final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final FirebaseMessaging messaging = FirebaseMessaging.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Expanded(
                flex: 6,
                child: Container(
                  color: const Color.fromARGB(255, 1, 39, 72),
                  child: const Center(
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(0, 80, 0, 0),
                      child: Text(
                        'Welcome to Bah!',
                        textScaleFactor: 2,
                        maxLines: 1,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ),
                )),
            Expanded(
                flex: 6,
                child: Container(
                  color: const Color.fromARGB(255, 1, 39, 72),
                  child: Center(
                      child: SizedBox(
                    width: 300,
                    height: 300,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                      child: FloatingActionButton.large(
                          heroTag: "btn1",
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const SetPoint()),
                            );
                          },
                          backgroundColor: Colors.white,
                          child: Image.asset('assets/BellIcon.png')),
                    ),
                  )),
                )),
            Expanded(
                flex: 1,
                child: Container(
                  color: Colors.green,
                )),

/* ################################################################## */

            Expanded(
                flex: 7,
                child: GridView(
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                    childAspectRatio: (1 / 0.80),
                  ), // Set Columns
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(30, 0, 10, 20),
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => WaterLevel()),
                          );
                          debugPrint('Pressed');
                        },
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white,
                                boxShadow: const [
                                  BoxShadow(
                                      blurStyle: BlurStyle.normal,
                                      color: Colors.grey,
                                      blurRadius: 7)
                                ]),
                            child: Column(
                              children: [
                                Image.asset(
                                  'assets/hotspot.png',
                                  width: 130,
                                ),
                                const Text('Flood Hotspot')
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10, 0, 30, 20),
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                // Hello Testing Testing. Testing.
                                // This is my latest push.
                                builder: (context) => PPSLocator()),
                          );
                          debugPrint('Pressed Nearest PPS');
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white,
                              boxShadow: const [
                                BoxShadow(
                                    blurStyle: BlurStyle.normal,
                                    color: Colors.grey,
                                    blurRadius: 7)
                              ]),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Image.asset(
                                  'assets/relocationcentre.png',
                                  width: 90,
                                ),
                              ),
                              const Text('Nearest PPS')
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                )),
// ***********************************************************************//

            Expanded(
                flex: 9,
                child: GridView(
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                    childAspectRatio: (1 / 0.8),
                  ), // Set Columns
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(30, 0, 10, 20),
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const FloodTipsPage()),
                          );
                          debugPrint('Pressed Flood Tips');
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: const Color.fromARGB(255, 255, 216, 24),
                              boxShadow: const [
                                BoxShadow(
                                    blurStyle: BlurStyle.normal,
                                    color: Colors.grey,
                                    blurRadius: 7)
                              ]),
                          child: Column(
                            children: const [
                              Padding(
                                padding: EdgeInsets.fromLTRB(10, 25, 10, 10),
                                child: Icon(
                                  Icons.tips_and_updates,
                                  size: 50,
                                  color: Colors.white,
                                ),
                              ),
                              Text('Flood Tips')
                            ],
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10, 0, 30, 20),
                      child: InkWell(
                        onTap: () {
                          debugPrint('Pressed Emergency Call');
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => EmergencyCall()),
                          );
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.redAccent,
                              boxShadow: const [
                                BoxShadow(
                                    blurStyle: BlurStyle.normal,
                                    color: Colors.grey,
                                    blurRadius: 7)
                              ]),
                          child: Column(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(10, 25, 10, 10),
                                child: Image.asset(
                                  'assets/emergencycall.png',
                                  width: 55,
                                ),
                              ),
                              const Text(
                                'Emergency Call',
                                style: TextStyle(color: Colors.white),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                )),
          ],
        ),
      ),

      // Bottom Part
      bottomNavigationBar: const MyBottomMenuNavigationBar(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: MyHomeButton(),
    );
  }
}
