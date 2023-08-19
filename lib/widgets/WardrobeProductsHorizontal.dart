import 'dart:ui';

import 'package:edna/widgets/WardrobeProductCard.dart';
import 'package:flutter/material.dart';
import 'package:edna/widgets/WardrobeArticleCard.dart';

class WardrobeProductsHorizontal extends StatefulWidget {
  const WardrobeProductsHorizontal({super.key});

  @override
  State<WardrobeProductsHorizontal> createState() => _WardrobeProductsHorizontalState();
}

class _WardrobeProductsHorizontalState extends State<WardrobeProductsHorizontal> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 136,
      child: ListView(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        children: const [
          SizedBox(width: 16,),
          WardrobeProductCard(),
          SizedBox(width: 8,),
          WardrobeProductCard(),
          SizedBox(width: 8,),
          WardrobeProductCard(),
          SizedBox(width: 8,),
          WardrobeProductCard(),
          SizedBox(width: 8,),
          WardrobeProductCard(),
          SizedBox(width: 8,),
          WardrobeProductCard(),
          SizedBox(width: 16,),
        ],
      ),
    );
  }
}
