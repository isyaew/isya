import 'package:flutter/material.dart';

class MyBottomMenuNavigationBar extends StatefulWidget {
  const MyBottomMenuNavigationBar({super.key});

  @override
  State<MyBottomMenuNavigationBar> createState() =>
      _MyBottomNavigationBarState();
}

class _MyBottomNavigationBarState extends State<MyBottomMenuNavigationBar> {
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    // ignore: unnecessary_new
    return BottomNavigationBar(
      currentIndex: currentIndex,
      iconSize: 0,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      onTap: (index) => setState(() => currentIndex = index),
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
          backgroundColor: Colors.black,
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.info),
          label: 'Info',
          backgroundColor: Colors.black,
        )
      ],
    );
  }
}
