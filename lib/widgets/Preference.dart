import 'package:edna/globals/myFonts.dart';
import 'package:edna/widgets/BudgetRange.dart';
import 'package:flutter/material.dart';

class Preference extends StatefulWidget {
  String title;
  String value;
  IconData? icon;
  String? imagePath;
  Preference.withIcon({super.key, required this.title, required this.value, required this.icon});
  Preference.withImage({super.key, required this.title, required this.value, required this.imagePath});
  Preference({super.key, required this.title, required this.value});

  @override
  State<Preference> createState() => _PreferenceState();
}

class _PreferenceState extends State<Preference> {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if(widget.icon == null && widget.imagePath == null)
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.title,
                      style: MyFonts.prefKey),
                  Text(widget.value,
                      style: MyFonts.prefValue),
                ],
              ),
            if(widget.icon != null || widget.imagePath != null)
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  if(widget.icon != null)
                    Icon(widget.icon, color: Colors.grey[900], size: 40, weight: 0.5,),
                  if(widget.imagePath != null)
                    ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: Image(
                          image: AssetImage("images/prefs/${widget.imagePath!}.jpg"),
                          height: 48,
                          width: 48,
                        )
                    ),
                  const SizedBox(width: 16,),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(widget.title,
                          style: MyFonts.prefKey),
                      Text(widget.value,
                          style: MyFonts.prefValue),
                    ],
                  ),
                ],
              ),

            IconButton(onPressed: (){
              if(widget.title == "Budget Range") {
                showDialog(
                // isScrollControlled: false,
                  context: context,
                  builder: (context) {
                    return SimpleDialog(
                      contentPadding: const EdgeInsets.all(0),
                      children: [
                        BudgetRange(setBudgetRange: (String text){
                          setState(() {
                            widget.value = text;
                          });
                        }),
                      ],
                    );
                  }
              );
              }
            }, icon: Icon(Icons.edit, color: Colors.grey[900], size: 16,)),
          ],
        )
    );
  }
}
