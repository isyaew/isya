import 'package:flutter/material.dart';
import 'package:flutterui/screens/widgets/bottom_menu.dart';
import 'package:flutterui/screens/widgets/home_button.dart';

class PPSList extends StatelessWidget {
  const PPSList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PPS List'),
      ),

      // Contents Placeholder

      bottomNavigationBar: MyBottomMenuNavigationBar(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: MyHomeButton(),
    );
  }
}
