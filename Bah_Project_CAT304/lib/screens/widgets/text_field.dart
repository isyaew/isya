import 'package:flutter/material.dart';

class MyInputTextField extends StatelessWidget {
  final TextEditingController inputController;
  final String inputLabel;
  final IconData iconsImage;
  final String inputHintText;
  final int wordlimit;
  final int linelimit;

  const MyInputTextField(
      {Key? key,
      required this.inputController,
      required this.inputLabel,
      required this.iconsImage,
      required this.inputHintText,
      required this.wordlimit,
      required this.linelimit})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    const primaryColor = Color(0xff4338CA);
    const secondaryColor = Color(0xff6D28D9);
    const accentColor = Color(0xffffffff);
    const backgroundColor = Color(0xffffffff);
    const errorColor = Color(0xffEF4444);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Text(
        //   "Email",
        //   style: TextStyle(
        //       fontSize: 14,
        //       fontWeight: FontWeight.normal,
        //       color: Colors.white.withOpacity(.9)),
        // ),
        const SizedBox(
          height: 8,
        ),
        Container(
          height: 50,
          decoration: BoxDecoration(boxShadow: [
            BoxShadow(
                offset: const Offset(12, 26),
                blurRadius: 50,
                spreadRadius: 0,
                color: Colors.grey.withOpacity(.1)),
          ]),
          child: TextField(
            maxLength: wordlimit,
            maxLines: linelimit,
            controller: inputController,
            onChanged: (value) {},
            keyboardType: TextInputType.emailAddress,
            style: const TextStyle(fontSize: 14, color: Colors.black),
            decoration: InputDecoration(
              counterText: '',
              label: Text(inputLabel),
              labelStyle: const TextStyle(color: primaryColor),
              prefixIcon: Icon(iconsImage),
              filled: true,
              fillColor: accentColor,
              hintText: inputHintText,
              hintStyle: TextStyle(color: Colors.grey.withOpacity(.75)),
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
              border: const OutlineInputBorder(
                borderSide: BorderSide(color: primaryColor, width: 1.0),
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
              ),
              focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: secondaryColor, width: 1.0),
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
              ),
              errorBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: errorColor, width: 1.0),
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
              ),
              enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: primaryColor, width: 1.0),
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
