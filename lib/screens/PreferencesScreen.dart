import 'package:edna/globals/myFonts.dart';
import 'package:edna/screens/BurgerMenu.dart';
import 'package:edna/screens/BurgerMenuNew.dart';
import 'package:edna/widgets/Preference.dart';
import 'package:flutter/material.dart';

class PreferencesScreen extends StatefulWidget {
  const PreferencesScreen({super.key});

  @override
  State<PreferencesScreen> createState() => _PreferencesScreenState();
}

class _PreferencesScreenState extends State<PreferencesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const BurgerMenuNew(),
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
                    Expanded(
                      child: Align(
                        alignment: Alignment.center,
                        child: Text("Your Preferences",
                          style: MyFonts.serifHeading24,
                        ),
                      ),
                    ),
                    IconButton(
                      //add an image with rounded corners as an icon
                      icon: Icon(Icons.close, size: 24, color: Colors.grey[900],),
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
      body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 14,),
                //add a circular image
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ClipRRect(
                        borderRadius: BorderRadius.circular(100.0),
                        child: const Image(
                          image: AssetImage('images/gunjan.jpg'),
                          height: 36,
                          width: 36,
                        )// add an image with 32 height
                    ),
                    const SizedBox(width: 16,),
                    Text(
                      "Gunjan Dhanuka",
                      style: MyFonts.serifHeading24,
                    ),
                  ],
                ),
                const SizedBox(height: 32,),
                Text(
                  "Basic Preferences",
                  style: MyFonts.prefSectionHeader,
                ),
                const SizedBox(height: 12,),
                Preference.withImage(title: "Color", value: "Black", imagePath: "black",),
                Preference.withImage(title: "Pattern", value: "Checkers", imagePath: "checkers",),
                Preference.withImage(title: "Sleeve length", value: "Short", imagePath: "short",),
                Preference.withImage(title: "Fabric Preferences", value: "Khadi", imagePath: "khadi",),
                Preference.withImage(title: "Fit and Silhouette", value: "Pear Shaped", imagePath: "pear_shaped",),
                Preference.withImage(title: "Neckline Preferences", value: "Deep V neck", imagePath: "deep_v_neck",),
                Preference.withImage(title: "Budget Range", value: "Mid - High Range", imagePath: "mid_high_range",),
                Preference.withImage(title: "Style Aesthetics", value: "Rustic Modern", imagePath: "rustic_modern",),
                Preference.withImage(title: "Top brands", value: "Jockey, Nike", imagePath: "jockey",),
                Preference.withImage(title: "Fit preferences", value: "Slim Fitting", imagePath: "slim_fit",),
                const SizedBox(height: 32,),
              ],
            ),
          )
      ),
    );
  }
}
