import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactTile extends StatefulWidget {
  const ContactTile({
    Key? key,
    required this.title,
    required this.contactNumber,
    required this.imgUrl,
    this.color = Colors.grey,
    required this.callNumber,
  }) : super(key: key);
  final String title;
  final String contactNumber;
  final Color color;
  final String imgUrl;
  final String callNumber;

  @override
  State<ContactTile> createState() => _ContactTileState();
}

class _ContactTileState extends State<ContactTile> {
  // final number = contactNumber.tonUM
  @override
  Widget build(BuildContext context) {
    print(widget.imgUrl);
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 5),
      child: InkWell(
        child: ListTile(
          tileColor: Colors.white,
          shape: RoundedRectangleBorder(
            side: BorderSide(width: 2),
            borderRadius: BorderRadius.circular(15),
          ),
          contentPadding: EdgeInsets.all(3),
          leading: Container(
            width: 50,
            child: AspectRatio(
              aspectRatio: 1,
              child: Padding(
                padding: const EdgeInsets.all(3.0),
                child: Container(
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage(
                            widget.imgUrl,
                          ))),
                ),
              ),
            ),
          ),
          title: Text(widget.title),
          subtitle: Row(
            children: [
              Icon(Icons.call, color: Colors.orange, size: 20),
              SizedBox(
                width: 3,
              ),
              Text(widget.contactNumber),
            ],
          ),
          trailing: CallButton(
            onPressed: () {},
            color: Colors.orange,
          ),
        ),
        onTap: () {
          print('Pressed ' + widget.title);
          launch('tel://${widget.contactNumber}');
        },
      ),
    );
  }
}

class CallButton extends StatefulWidget {
  const CallButton({
    Key? key,
    required this.onPressed,
    this.color = Colors.black12,
  }) : super(key: key);
  final Function onPressed;
  final Color color;
  @override
  _CallButtonState createState() => _CallButtonState();
}

class _CallButtonState extends State<CallButton> {
  bool isLiked = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Icon(Icons.call, color: Color.fromARGB(255, 0, 0, 0)),
    );
  }
}
