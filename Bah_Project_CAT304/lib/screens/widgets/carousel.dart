import 'package:flutter/material.dart';

class CustomCarouselFB2 extends StatefulWidget {
  const CustomCarouselFB2({Key? key}) : super(key: key);

  @override
  _CustomCarouselFB2State createState() => _CustomCarouselFB2State();
}

class _CustomCarouselFB2State extends State<CustomCarouselFB2> {
  // - - - - - - - - - - - - Instructions - - - - - - - - - - - - - -
  // 1.Replace cards list with whatever widgets you'd like.
  // 2.Change the widgetMargin attribute, to ensure good spacing on all screensize.
  // 3.If you have a problem with this widget, please contact us at flutterbricks90@gmail.com
  // Learn to build this widget at https://www.youtube.com/watch?v=dSMw1Nb0QVg!
  // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  List<Widget> cards = [
    CardFb1(
        text: "MALAYSIAN RED CRESENT SOCIETY",
        imageUrl:
            "https://firebasestorage.googleapis.com/v0/b/bah--application.appspot.com/o/download.png?alt=media&token=ca09de06-562d-44b2-98d8-8cf66c13ef1c",
        subtitle: "Maybank : 5621 7950 4126",
        onPressed: () {}),
    CardFb1(
        text: "MERCY Malaysia",
        imageUrl:
            "https://firebasestorage.googleapis.com/v0/b/bah--application.appspot.com/o/mercy%20logo.png?alt=media&token=32471e4a-d035-4bc5-9ee1-6b5693b79156",
        subtitle: "Maybank : 5144 2210 2657",
        onPressed: () {}),
    CardFb1(
        text: "Humanitarian Care Malaysia Bhd",
        imageUrl:
            "https://firebasestorage.googleapis.com/v0/b/bah--application.appspot.com/o/mycarelogo.png?alt=media&token=823393a6-6e15-47ad-b934-4dcb8a22f8b0",
        subtitle: "CIMB : 8602 135 592",
        onPressed: () {})
  ];

  final double carouselItemMargin = 16;

  late PageController _pageController;
  int _position = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0, viewportFraction: .7);
  }

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
        controller: _pageController,
        itemCount: cards.length,
        onPageChanged: (int position) {
          setState(() {
            _position = position;
          });
        },
        itemBuilder: (BuildContext context, int position) {
          return imageSlider(position);
        });
  }

  Widget imageSlider(int position) {
    return AnimatedBuilder(
      animation: _pageController,
      builder: (BuildContext context, widget) {
        return Container(
          margin: EdgeInsets.all(carouselItemMargin),
          child: Center(child: widget),
        );
      },
      child: Container(
        child: cards[position],
      ),
    );
  }
}

class CardFb1 extends StatefulWidget {
  final String text;
  final String imageUrl;
  final String subtitle;
  final Function() onPressed;

  const CardFb1(
      {required this.text,
      required this.imageUrl,
      required this.subtitle,
      required this.onPressed,
      Key? key})
      : super(key: key);

  @override
  State<CardFb1> createState() => _CardFb1State();
}

class _CardFb1State extends State<CardFb1> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onPressed,
      child: Container(
        width: 250,
        height: 230,
        padding: const EdgeInsets.all(30.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.5),
          boxShadow: [
            BoxShadow(
                offset: const Offset(10, 20),
                blurRadius: 10,
                spreadRadius: 0,
                color: Colors.grey.withOpacity(.05)),
          ],
        ),
        child: Column(
          children: [
            Image.network(widget.imageUrl, height: 90, fit: BoxFit.contain),
            const Spacer(),
            Text(widget.text,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                )),
            const SizedBox(
              height: 5,
            ),
            Text(
              widget.subtitle,
              textAlign: TextAlign.center,
              style: const TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.normal,
                  fontSize: 12),
            ),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}
