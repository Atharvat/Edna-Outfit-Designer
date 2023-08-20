import 'dart:math';
import 'dart:ui';

import 'package:edna/widgets/ProductCard.dart';
import 'package:fading_edge_scrollview/fading_edge_scrollview.dart';
import 'package:flutter/material.dart';

import '../utils/flipkart_api.dart';

class ArticleHorizontal extends StatefulWidget {
  ArticleHorizontal({super.key, required this.title, required this.productDetails});
  String title;
  List<ProductDetails> productDetails;

  @override
  State<ArticleHorizontal> createState() => _ArticleHorizontalState();
}

class _ArticleHorizontalState extends State<ArticleHorizontal> {

  final _controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    List<ProductDetails> productDetails = widget.productDetails;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 36,),
        Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              widget.title,
              style: const TextStyle(
                fontFamily: 'Playfair Display',
                fontSize: 20,
                fontVariations: [
                  FontVariation("wght", 400),
                ],
                color: Colors.black,
              ),
            ),
          ),
        ),
        const SizedBox(height: 16,),
        SizedBox(
          height: 350,
          child: Stack(
            alignment: Alignment.centerRight,
            children: [
              FadingEdgeScrollView.fromScrollView(
                gradientFractionOnEnd: 0.25,
                gradientFractionOnStart: 0,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  controller: _controller,
                  children: [
                    SizedBox(width: 16,),
                    for(ProductDetails product in productDetails)
                      ProductCard(
                        name: product.name,
                        price: product.price,
                        rating: product.rating,
                        images: product.thumbnailUrl,
                        // add random value for noOfRatings field
                        noOfRatings: Random().nextInt(1000).toString(),
                        url: product.url,
                        isSelected: true,
                      ),
                    // ProductCard(),
                    // SizedBox(width: 8,),
                    // ProductCard()
                  ],
                ),
              ),
              Positioned(
                right: 16,
                child: Container(
                  height: 32,
                  width: 32,
                  decoration: const BoxDecoration(
                    color: Color(0xAA808080),
                    borderRadius: BorderRadius.all(Radius.circular(100)),
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.arrow_forward_ios, size: 16, color: Color(0xFF101828),),
                    tooltip: 'Next',
                    onPressed: () {
                      // handle the press
                      /*_controller.animateTo(
                        _controller.position.maxScrollExtent,
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.easeOut,
                      );*/
                    },
                  ),
                ),
              ),
            ]
          ),
        )
      ],
    );
  }
}
