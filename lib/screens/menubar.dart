import 'package:flutter/material.dart';

import '../globals/myColors.dart';

class BurgerMenu extends StatelessWidget {
  const BurgerMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width * 0.9,
        height: MediaQuery.of(context).size.height,
        padding: const EdgeInsets.only(left: 20, top: 20, bottom: 20),
        color: MyColors.white,
        child: Column(children: [
          // top bar with a circular icon on left, name in middle and back icon on right
          Container(
            height: 100,
            width: MediaQuery.of(context).size.width * 0.9,
            color: MyColors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: const Icon(Icons.circle),
                  tooltip: 'Profile',
                  onPressed: () {
                    // handle the press
                  },
                ),
                const Text(
                  "Gunjan",
                  style: TextStyle(
                    fontFamily: 'Playfair Display',
                    fontSize: 32,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.menu_open),
                  tooltip: 'Back',
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ),
          // vertical space
          const SizedBox(height: 20),
          // a subheading and then a list of items where each item has a logo and a text
          Column(children: [
            // subheading is aligned to the left
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Ai Stylist',
                style: TextStyle(
                  color: Color(0xFF344053),
                  fontSize: 14,
                  fontFamily: 'General Sans Variable',
                  fontWeight: FontWeight.w600,
                  height: 1.71,
                  letterSpacing: 0.21,
                ),
              ),
            ),

            const SizedBox(height: 20),
            // a list of items where each item has a logo and a text
            BurgerItem(
              icon: const Icon(Icons.add, color: MyColors.black10, size: 14),
              text: "New Look",
              onClicked: () {},
            ),
            BurgerItem(
              icon: const Icon(Icons.history, color: MyColors.black10, size: 14),
              text: "History",
              onClicked: () {},
            ),
          ]),
          const SizedBox(height: 20),
          // a subheading and then a list of items where each item has a logo and a text
          Column(children: [
            // subheading is aligned to the left
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'User Wardrobe',
                style: TextStyle(
                  color: Color(0xFF344053),
                  fontSize: 14,
                  fontFamily: 'General Sans Variable',
                  fontWeight: FontWeight.w600,
                  height: 1.71,
                  letterSpacing: 0.21,
                ),
              ),
            ),

            const SizedBox(height: 20),
            // a list of items where each item has a logo and a text
            BurgerItem(
              icon: const Icon(Icons.checkroom, color: MyColors.black10, size: 14),
              text: "View Wardrobe",
              onClicked: () {},
            ),
            BurgerItem(
              icon: const Icon(Icons.checkroom, color: MyColors.black10, size: 14),
              text: "Add Articles",
              onClicked: () {},
            ),
            BurgerItem(
              icon: const Icon(Icons.travel_explore, color: MyColors.black10, size: 14),
              text: "Gap Analysis",
              onClicked: () {},
            ),
            BurgerItem(
              icon: const Icon(Icons.stream, color: MyColors.black10, size: 14),
              text: "Look of the Day",
              onClicked: () {},
            ),
          ]),
          // send the last BurgerItem to the bottom of screen
          const Spacer(),

          BurgerItem(
            icon: const Icon(Icons.support, color: MyColors.black10, size: 14),
            text: "Help and Support",
            onClicked: () {},
            backgroundColor: MyColors.white20,
          ),

    ]),
    );
  }
}

class BurgerItem extends StatelessWidget {
  const BurgerItem({
    super.key,
    required this.icon,
    required this.text,
    required this.onClicked,
    this.backgroundColor = MyColors.white
  });
  // take the icon, text and onClicked as parameter to this widget
  final Icon icon;
  final String text;
  final Function onClicked;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    // on click of this item, call the onClicked function
    return Container(
      width: 328,
      height: 56,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      decoration: ShapeDecoration(
        color: backgroundColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 24,
            height: 24,
            padding: const EdgeInsets.all(5),
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                icon,
              ],
            ),
          ),
          const SizedBox(width: 24),
          Text(
            text,
            style: const TextStyle(
              color: Color(0xFF0F1728),
              fontSize: 16,
              fontFamily: 'General Sans Variable',
              fontWeight: FontWeight.w500,
              height: 1.50,
              letterSpacing: 0.24,
            ),
          ),
        ],
      ),
    );
  }
}
