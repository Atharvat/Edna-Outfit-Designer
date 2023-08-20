import 'dart:ui';

import 'package:edna/globals/myFonts.dart';
import 'package:edna/screens/ChatScreen.dart';
import 'package:edna/utils/flipkart_api.dart';
import 'package:flutter/material.dart';
import 'package:edna/widgets/ArticleHorizontal.dart';

class LookScreen extends StatefulWidget {
  const LookScreen({super.key});

  @override
  State<LookScreen> createState() => _LookScreenState();
}

class _LookScreenState extends State<LookScreen> {
  String pageTitle = "Looks you like";

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as LookScreenArguments;
    final allProductsDetails = args.allProductDetails;
    pageTitle = args.pageTitle;
    return Scaffold(
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
            shadowColor: Colors.black,
            elevation: 0,
            title: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 200, horizontal: 12),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      pageTitle,
                      style: const TextStyle(
                        fontFamily: 'Playfair Display',
                        fontSize: 24,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        IconButton(
                          icon: const Icon(
                            Icons.bookmark_add_outlined,
                            size: 24,
                            color: Colors.black,
                          ),
                          tooltip: 'Bookmark',
                          onPressed: () {
                            // handle the press
                          },
                        ),
                        // IconButton(
                        //   icon: const Icon(
                        //     Icons.close,
                        //     size: 24,
                        //     color: Colors.black,
                        //   ),
                        //   tooltip: 'Close',
                        //   onPressed: () {
                        //     // handle the press
                        //   },
                        // ),
                      ],
                    )
                  ]),
            ),
          ),
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 80),
        child: FloatingActionButton.extended(
          extendedPadding: const EdgeInsetsDirectional.only(start: 20, end: 20),
          elevation: 0,
          icon: const Icon(
            Icons.add_shopping_cart,
            size: 24,
            color: Colors.white,
          ),
          onPressed: () {},
          label: const Text(
            "Add look to cart",
            style: TextStyle(
              fontFamily: 'General Sans Variable',
              fontSize: 16,
              fontVariations: [
                FontVariation("wght", 500),
              ],
              color: Colors.white,
            ),
          ),
          backgroundColor: const Color(0xFF038969),
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(100.0))),
        ),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
              child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                for (List<ProductDetails> productDetails in allProductsDetails)
                  ArticleHorizontal(
                    title: productDetails[0].name,
                    productDetails: productDetails,
                  ),
                const SizedBox(height: 64),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Did you like our suggestions?",
                        style: MyFonts.serifHeading,
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      const Icon(
                        Icons.thumbs_up_down_outlined,
                        size: 24,
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ElevatedButton.icon(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.thumb_up_outlined,
                          size: 24,
                          color: Colors.black,
                        ),
                        label: const Text(
                          "I like it",
                          style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'General Sans Variable',
                            fontSize: 16,
                            fontVariations: [
                              FontVariation("wght", 500),
                            ],
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFC3D4E1),
                            elevation: 0,
                            padding: const EdgeInsets.only(
                                left: 12, top: 8, bottom: 8, right: 12)),
                      ),
                      const SizedBox(width: 8),
                      ElevatedButton.icon(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.thumb_down_outlined,
                          size: 24,
                          color: Colors.black,
                        ),
                        label: const Text(
                          "Could be better",
                          style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'General Sans Variable',
                            fontSize: 16,
                            fontVariations: [
                              FontVariation("wght", 500),
                            ],
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFC3D4E1),
                            elevation: 0,
                            padding: const EdgeInsets.only(
                                left: 12, top: 8, bottom: 8, right: 12)),
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 100),
              ],
            ),
          )),
          Container(
            height: 80,
            alignment: Alignment.center,
            color: const Color(0x10ffffff),
            // black text box to enter chat message
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[

                Container(
                  width: MediaQuery.of(context).size.width - 32,
                  height: 60,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      IconButton(
                        icon: const Icon(
                          Icons.add,
                          size: 24,
                          color: Colors.black,
                        ),
                        tooltip: 'Add',
                        onPressed: () {
                          // handle the press
                        },
                      ),
                      const Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Type a message',
                            hintStyle: TextStyle(
                              fontFamily: 'General Sans Variable',
                              fontSize: 18,
                              fontVariations: [
                                FontVariation("wght", 500),
                              ],
                              color: Color(0xFF101828),
                            ),
                          ),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(
                          Icons.send,
                          size: 24,
                          color: Colors.black,
                        ),
                        tooltip: 'Send',
                        onPressed: () {
                          // handle the press
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
