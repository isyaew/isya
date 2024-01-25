import 'package:flutter/material.dart';
import 'package:flutterui/main.dart';

class MyHomeButton extends StatefulWidget {
  const MyHomeButton({super.key});

  @override
  State<MyHomeButton> createState() => _MyBottomNavigationBarState();
}

class _MyBottomNavigationBarState extends State<MyHomeButton> {
  @override
  Widget build(BuildContext context) {
    // ignore: unnecessary_new
    return SizedBox(
      height: 80,
      width: 80,
      child: FloatingActionButton(
        heroTag: "btn2",
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => MyHomePage(
                    // title: 'Test',
                    )),
          );
          debugPrint('Pressed Home');
        },
        backgroundColor: Colors.white,
        child: Image.asset(
          'assets/homebutton.png',
          width: 400,
        ),
      ),
    );
  }
}
