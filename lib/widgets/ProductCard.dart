import 'dart:ui';

import 'package:edna/globals/myColors.dart';
import 'package:flutter/material.dart';

class ProductCard extends StatefulWidget {
  final String name;
  final String price;
  final String rating;
  final String noOfRatings;
  final String images;
  final String url;
  final bool isSelected;

  ProductCard(
      {super.key,
      required this.name,
      required this.price,
      required this.rating,
      required this.noOfRatings,
      required this.images,
      required this.url,
      required this.isSelected});

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  // String name = "Embroidered Georgette Stitched Anarkali Gown";
  // String price = "499";
  // String rating = "4.5";
  // String noOfRatings = "379";
  // //create an array of strings called images which contain the urls for different images
  // List<String> images = [
  //   "https://images.unsplash.com/photo-1691860305089-9a2566296202?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=300&q=80",
  //   "https://images.unsplash.com/photo-1691860305089-9a2566296202?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=300&q=80"
  // ];
  // String url = "https://images.unsplash.com/photo-1691860305089-9a2566296202?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1585&q=80";
  // bool isSelected = true;

  // _ProductCardState(
  //     this.name,
  //     this.price,
  //     this.rating,
  //     this.noOfRatings,
  //     this.images,
  //     this.url,
  //     );

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shadowColor: const Color(0x77000000),
      child: Container(
        height: 350,
        width: 244,
        decoration: BoxDecoration(
            border: widget.isSelected
                ? Border.all(
                    color: const Color(0xFF6AC4DC),
                    width: 2,
                  )
                : null,
            borderRadius: const BorderRadius.all(Radius.circular(8)),
            color: MyColors.white20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 244,
              width: 244,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(8), topRight: Radius.circular(8)),
                image: DecorationImage(
                    image: NetworkImage(widget.images.replaceAll("180", "480")), fit: BoxFit.cover),
              ),
              child: Stack(
                children: [
                  // Positioned(
                  //   top: 12,
                  //   left: 12,
                  //   child: Column(
                  //     mainAxisAlignment: MainAxisAlignment.start,
                  //     crossAxisAlignment: CrossAxisAlignment.center,
                  //     children: [
                  //       //create a circular image for all the image urls in the images array
                  //       for (int i = 0; i < widget.images.length; i++)
                  //         Padding(
                  //           padding: const EdgeInsets.only(bottom: 8),
                  //           child: Container(
                  //             height: 32,
                  //             width: 32,
                  //             decoration: BoxDecoration(
                  //               /*color: MyColors.white20,
                  //               border: Border.all(
                  //                 color: MyColors.white20,
                  //                 width: 2,
                  //               ),*/
                  //               borderRadius: const BorderRadius.all(
                  //                   Radius.circular(100)),
                  //               image: DecorationImage(
                  //                 image: NetworkImage(widget.images[i]),
                  //                 fit: BoxFit.cover,
                  //               ),
                  //             ),
                  //           ),
                  //         ),
                  //     ],
                  //   ),
                  // ),
                  //add a button with text 'Go to site' with a call_made icon at the bottom right corner
                  Positioned(
                    bottom: 16,
                    right: 12,
                    child: Directionality(
                      textDirection: TextDirection.rtl,
                      child: ClipRect(
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 2.0, sigmaY: 2.0),
                          child: ElevatedButton.icon(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.arrow_outward,
                              size: 16,
                              color: MyColors.white20,
                            ),
                            label: const Text(
                              "Go to site",
                              style: TextStyle(
                                color: MyColors.white20,
                                fontFamily: 'General Sans',
                                fontSize: 12,
                                fontVariations: [
                                  FontVariation("wght", 600),
                                ],
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                                minimumSize: Size.zero,
                                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                backgroundColor: Colors.white.withOpacity(0.1),
                                elevation: 0,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 4),
                                //add a white border around the button of 1 px with 40% opacity
                                side: BorderSide(
                                  color: Colors.white.withOpacity(0.1),
                                  width: 1,
                                  style: BorderStyle.solid,
                                )),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                // handle overflow of text
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "₹${widget.price}",
                        style: const TextStyle(
                          color: Colors.black,
                          fontFamily: 'General Sans',
                          fontSize: 16,
                          fontVariations: [
                            FontVariation("wght", 700),
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            widget.rating,
                            style: const TextStyle(
                              color: MyColors.black20,
                              fontFamily: 'General Sans',
                              fontSize: 12,
                              fontVariations: [
                                FontVariation("wght", 600),
                              ],
                            ),
                          ),
                          const SizedBox(
                            width: 2,
                          ),
                          const Icon(
                            Icons.star,
                            size: 16,
                            color: Colors.yellow,
                          ),
                          const SizedBox(
                            width: 2,
                          ),
                          Text(
                            // handle overflow of text by adding ellipsis

                            "(${widget.noOfRatings})",
                            style: const TextStyle(
                              color: Colors.grey,
                              fontFamily: 'General Sans',
                              fontSize: 12,
                              fontVariations: [
                                FontVariation("wght", 500),
                              ],
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 7,
                  ),
                  Text(
                    widget.name,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    style: const TextStyle(
                      color: MyColors.black20,
                      fontFamily: 'General Sans',
                      fontSize: 14,
                      fontVariations: [
                        FontVariation("wght", 500),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
