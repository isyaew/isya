import 'package:flutter/material.dart';
import 'package:flutterui/screens/general/flood_tips/donation.dart';
import 'package:flutterui/screens/widgets/bottom_menu.dart';
import 'package:flutterui/screens/widgets/home_button.dart';
import 'package:flutterui/screens/general/flood_tips/preflood.dart';
import 'package:flutterui/screens/general/flood_tips/duringflood.dart';
import 'package:flutterui/screens/general/flood_tips/postflood.dart';

class FloodTipsPage extends StatelessWidget {
  const FloodTipsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flood Tips'),
      ),
      backgroundColor: const Color.fromRGBO(1, 39, 72, 1.0),

      body: Center(
          child: Column(
        children: [
          const Expanded(
            flex: 0,
            child: Padding(
              padding: EdgeInsets.all(0),
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
                    MaterialPageRoute(
                        builder: (context) => const PreFloodTips()),
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                      color: const Color.fromRGBO(245, 249, 248, 1),
                      borderRadius: BorderRadius.circular(15)),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.asset(
                          'assets/preflood.png',
                          width: 80,
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.fromLTRB(20, 8, 8, 8),
                        child: Text('Pre-flood',
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
                        builder: (context) => const DuringFloodTips()),
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                      color: const Color.fromRGBO(245, 249, 248, 1),
                      borderRadius: BorderRadius.circular(15)),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.asset(
                          'assets/flood.png',
                          width: 80,
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.fromLTRB(20, 8, 8, 8),
                        child: Text('During flood',
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
                        builder: (context) => const PostFloodTips()),
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                      color: const Color.fromRGBO(245, 249, 248, 1),
                      borderRadius: BorderRadius.circular(15)),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.asset(
                          'assets/postflood.png',
                          width: 80,
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.fromLTRB(20, 8, 8, 8),
                        child: Text('Post-flood',
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
                    MaterialPageRoute(builder: (context) => DonationPage()),
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.greenAccent,
                      borderRadius: BorderRadius.circular(15)),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.asset(
                          'assets/donate.png',
                          width: 80,
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.fromLTRB(20, 8, 8, 8),
                        child: Text('Donation',
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
                      color: const Color.fromRGBO(1, 39, 72, 1.0),
                      borderRadius: BorderRadius.circular(15)),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.asset(
                          'assets/preflood.png',
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
