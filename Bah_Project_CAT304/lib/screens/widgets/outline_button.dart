import 'package:flutter/material.dart';

class OutlineButtonFb1 extends StatelessWidget {
  final String text;
  final IconData iconData;
  final Function() onPressed;

  const OutlineButtonFb1(
      {required this.text,
      required this.onPressed,
      required this.iconData,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    const primaryColor = Color(0xff2749FD);

    const double borderRadius = 40;

    return OutlinedButton(
      onPressed: () {},
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Text(
          text,
          style: TextStyle(
              fontSize: 18, fontWeight: FontWeight.w300, color: primaryColor),
        ),
        Icon(iconData, color: primaryColor)
      ]),
      style: ButtonStyle(
          side: MaterialStateProperty.all(
              BorderSide(color: primaryColor, width: 1.4)),
          padding: MaterialStateProperty.all(
              EdgeInsets.symmetric(vertical: 10, horizontal: 50)),
          shape: MaterialStateProperty.all(RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(borderRadius))))),
    );
  }
}
