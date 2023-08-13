import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {

  String pageTitle = "Goa fashion week";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        primary: true,
        titleSpacing: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,

            children: <Widget>[
              IconButton(
                icon: SvgPicture.asset("images/menu_icon.svg"),
                tooltip: 'Menu',
                onPressed: () {
                  // handle the press
                },
              ),
              Text(pageTitle,
                style: const TextStyle(
                  fontFamily: 'Playfair Display',
                  fontSize: 32,
                  fontWeight: FontWeight.w400,
                ),
              ),
              IconButton(
                //add an image with rounded corners as an icon
                icon: ClipRRect(
                    borderRadius: BorderRadius.circular(100.0),
                    child: const Image(
                      image: AssetImage('images/gunjan.jpeg'),
                      height: 32,
                      width: 32,
                    )// add an image with 32 height
                ),
                tooltip: 'Profile',
                onPressed: () {
                  // handle the press
                },
              ),
            ]
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Placeholder',
            ),
            Container(
              child: const Text(
                'You have pushed the button this many times:',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
