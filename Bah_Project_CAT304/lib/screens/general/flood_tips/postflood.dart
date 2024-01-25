import 'package:flutter/material.dart';
import 'package:flutterui/screens/widgets/bottom_menu.dart';
import 'package:flutterui/screens/widgets/home_button.dart';

class PostFloodTips extends StatelessWidget {
  const PostFloodTips({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tips Post Flood'),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/postflood_guide.png"),
                fit: BoxFit.cover)),
        padding: EdgeInsets.only(top: 50.0),
      ),
      bottomNavigationBar: MyBottomMenuNavigationBar(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: MyHomeButton(),
    );
  }
}
