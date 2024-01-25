import 'package:flutter/material.dart';

class LocationListTile extends StatelessWidget {
  final String text;
  final Widget leadingIcon;
  final Widget trailingIcon;
  final Function() onTap;
  final Color color;
  const LocationListTile(
      {required this.text,
      required this.leadingIcon,
      required this.trailingIcon,
      required this.onTap,
      this.color = const Color(0xFF4338CA),
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTileTheme(
      child: ListTile(
        leading: leadingIcon,
        title: Text(
          text,
          textScaleFactor: 1,
        ),
        trailing: trailingIcon,
        selected: false,
        onTap: onTap,
      ),
      textColor: color,
      iconColor: color,
    );
  }
}
