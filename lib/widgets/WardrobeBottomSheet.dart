import 'dart:io';
import 'dart:ui';

import 'package:edna/globals/myColors.dart';
import 'package:edna/globals/myFonts.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

class WardrobeBottomSheet extends StatefulWidget {
  void Function(String text) addProduct;

  WardrobeBottomSheet({super.key, required this.addProduct});

  @override
  State<WardrobeBottomSheet> createState() => _WardrobeBottomSheetState();
}

class _WardrobeBottomSheetState extends State<WardrobeBottomSheet> {

  String text = "";
  bool isUploaded = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      //add a 16px border radius
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(16)),
        color: Colors.white,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Add an article",
                style: MyFonts.serifHeading,
              ),
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.close,
                  color: Colors.black,
                  size: 24,
                ),
              )
            ],
          ),
          const SizedBox(
            height: 32,
          ),
          GestureDetector(
            onTap: () {
              File? image;
              Future pickImage() async {
                try {
                  var image = await ImagePicker().pickImage(source: ImageSource.gallery);
                  if(image == null) return;
                  final imageTemp = File(image!.path);
                  // setState(() => this.image = imageTemp);
                  setState(() {
                    isUploaded = true;
                  });
                } on PlatformException catch(e) {
                  if (kDebugMode) {
                    print('Failed to pick image: $e');
                  }
                }
              }
              pickImage();
            },
            child: Material(
              elevation: 2,
              borderRadius: BorderRadius.circular(8),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: MyColors.white,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(
                        isUploaded ? Icons.check : Icons.camera_alt_outlined,
                        color: Colors.black,
                        size: 24,
                      ),
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    Text(
                        "Add a picture for better recommendation",
                      style: TextStyle(
                        fontFamily: 'General Sans',
                        fontSize: 16,
                        fontVariations: const [
                          FontVariation("wght", 500),
                        ],
                        color: Colors.grey[900],
                      ),
                    )
                  ],
                )
              ),
            ),
          ),
          const SizedBox(
            height: 12,
          ),
          Material(
            elevation: 2,
            borderRadius: BorderRadius.circular(28),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(28),
                color: const Color(0xFFF2F7FB),
              ),
              child: TextField(
                onChanged: (value) {
                  setState(() {
                    text = value;
                  });
                },
                minLines: 1,
                maxLines: 5,
                decoration: const InputDecoration(
                  hintText: "Write a brief description about the article you want to add to your wardrobe. ",
                  hintStyle: TextStyle(
                    fontFamily: 'General Sans',
                    height: 1.5,
                    fontSize: 16,
                    fontVariations: [
                      FontVariation("wght", 500),
                    ],
                    color: Color(0xFF818792),
                  ),
                  border: InputBorder.none,
                ),
                style: TextStyle(
                  fontFamily: 'General Sans',
                  fontSize: 16,
                  fontVariations: const [
                    FontVariation("wght", 500),
                  ],
                  height: 1.5,
                  color: Colors.grey[900],
                )
              ),
            ),
          ),
          const SizedBox(height: 12,),
          InkWell(
            onTap: () {
              widget.addProduct(text);
              Navigator.pop(context);
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color: MyColors.green10,
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Add Article",
                    style: TextStyle(
                      fontFamily: 'General Sans',
                      fontSize: 16,
                      fontVariations: [
                        FontVariation("wght", 500),
                      ],
                      color: Colors.white,
                    ),
                  ),
                  Icon(
                    Icons.send,
                    color: Colors.white,
                    size: 24,
                  )
                ],
              ),
            ),
          ),
        ],


      ),
    );
  }


}
