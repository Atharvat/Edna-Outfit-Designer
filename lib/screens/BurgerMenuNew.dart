import 'package:edna/globals/myColors.dart';
import 'package:edna/screens/BurgerMenu.dart';
import 'package:flutter/material.dart';

import '../globals/myFonts.dart';

class BurgerMenuNew extends StatefulWidget {
  const BurgerMenuNew({super.key});

  @override
  State<BurgerMenuNew> createState() => _BurgerMenuNewState();
}

class _BurgerMenuNewState extends State<BurgerMenuNew> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      height: MediaQuery.of(context).size.height,
      color: Colors.white,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(64.0),
          child: Container(
            decoration: const BoxDecoration(boxShadow: [
              BoxShadow(
                color: Color(0x15000000),
                offset: Offset(0, 2.0),
                blurRadius: 4.0,
              )
            ]),
            child: AppBar(
              automaticallyImplyLeading: false,
              primary: true,
              titleSpacing: 0,
              backgroundColor: Colors.white,
              centerTitle: true,
              title: Padding(
                padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 12),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      IconButton(
                          onPressed: (){},
                          icon: ClipRRect(
                              borderRadius: BorderRadius.circular(24.0),
                              child: const Image(
                                image: AssetImage("images/gunjan.jpg"),
                                height: 48,
                                width: 48,
                              )
                            ),
                      ),
                      const SizedBox(width: 8,),
                      Expanded(
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text("Gunjan Dhanuka",
                            style: MyFonts.serifHeading24,
                          ),
                        ),
                      ),
                      IconButton(
                        //add an image with rounded corners as an icon
                        icon: Icon(Icons.menu_open, size: 24, color: Colors.grey[900],),
                        tooltip: 'Close',
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ]
                ),
              ),
            ),
          ),
        ),
        body: /*SingleChildScrollView(
          child:*/ Container(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16),
            color: Colors.white,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 12,),
                Text(
                  "Basic Preferences",
                  style: MyFonts.prefSectionHeader,
                ),
                const SizedBox(height: 12,),
                BurgerItem(
                  icon: const Icon(Icons.add, color: MyColors.black10, size: 24),
                  text: "New Look",
                  onClicked: () {
                    // load the new look screen
                    print("clicked");
                    Navigator.pushNamed(context, '/chat');
                  },
                  backgroundColor: MyColors.white20,
                ),
                BurgerItem(
                  icon: const Icon(Icons.history, color: MyColors.black10, size: 24),
                  text: "History",
                  onClicked: () {
                    // load the history screen
                    Navigator.pushNamed(context, '/history');
                  },
                ),
                const SizedBox(height: 12,),
                Text(
                  "Your Wardrobe",
                  style: MyFonts.prefSectionHeader,
                ),
                const SizedBox(height: 12,),
                BurgerItem(
                  icon: const Icon(Icons.checkroom, color: MyColors.black10, size: 24),
                  text: "View Wardrobe",
                  onClicked: () {
                    // load the view wardrobe screen
                    Navigator.pushNamed(context, '/wardrobe');
                  },
                ),
                BurgerItem(
                  icon: const Icon(Icons.checkroom, color: MyColors.black10, size: 24),
                  text: "Add Articles",
                  onClicked: () {
                    // load the add articles screen
                    Navigator.pushNamed(context, '/wardrobe');
                  },
                ),
                BurgerItem(
                  icon: const Icon(Icons.travel_explore, color: MyColors.black10, size: 24),
                  text: "Gap Analysis",
                  onClicked: () {
                    Navigator.pushNamed(context, '/wardrobe');
                  },
                ),
                BurgerItem(
                  icon: const Icon(Icons.stream, color: MyColors.black10, size: 24),
                  text: "Look of the Day",
                  onClicked: () {
                    Navigator.pushNamed(context, '/wardrobe');
                  },
                ),
                const SizedBox(height: 12,),
                Text(
                  "User Profile",
                  style: MyFonts.prefSectionHeader,
                ),
                const SizedBox(height: 12,),
                BurgerItem(
                  icon: const Icon(Icons.straighten_outlined, color: MyColors.black10, size: 24),
                  text: "About You",
                  onClicked: () {
                    Navigator.pushNamed(context, '/about_you');
                  },
                ),
                BurgerItem(
                  icon: const Icon(Icons.change_circle_outlined, color: MyColors.black10, size: 24),
                  text: "Preferences",
                  onClicked: () {
                    Navigator.pushNamed(context, '/preferences');
                  },
                ),
                // const SizedBox(height: 12,),
                const Spacer(),

                BurgerItem(
                  icon: const Icon(Icons.support, color: MyColors.black10, size: 14),
                  text: "Help and Support",
                  onClicked: () {},
                  backgroundColor: MyColors.white20,
                ),
              ],
            ),
          ),
        ),
      // ),
    );
  }
}
