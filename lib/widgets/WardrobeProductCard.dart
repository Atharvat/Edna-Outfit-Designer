import 'dart:ui';

import 'package:edna/globals/myColors.dart';
import 'package:flutter/material.dart';

class WardrobeProductCard extends StatefulWidget {
  const WardrobeProductCard({super.key});

  @override
  State<WardrobeProductCard> createState() => _WardrobeProductCardState();
}

class _WardrobeProductCardState extends State<WardrobeProductCard> {

  final String _productText = "Vintage-style black graphic tee with retro arcade game design";
  final List<String> _colors = ["#000000", "#FFFFFF"];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 136,
      width: 124,
      color: MyColors.white20,
      padding: const EdgeInsets.all(10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  for (int i = 0; i < _colors.length; i++)
                    Container(
                      height: 12,
                      width: 12,
                      transform: Matrix4.translationValues((-7*i).toDouble(), 0, 0),
                      decoration: BoxDecoration(
                          color: Color(int.parse("0xFF${_colors[i].substring(1)}")),
                          shape: BoxShape.circle,
                          border: _colors[i] == "#FFFFFF" ? Border.all(
                              color: Colors.black,
                              width: 1
                          ) : null
                      ),
                    ),
                ],
              ),
              const Icon(
                Icons.edit_outlined,
                color: MyColors.black20,
                size: 16,
              )
            ],
          ),
          const SizedBox(height: 4,),
          Expanded(
            child: Align(
              alignment: Alignment.center,
              child: Text(
                  _productText,
                  style: TextStyle(
                    fontFamily: 'General Sans',
                    fontSize: 12,
                    fontVariations: const [
                      FontVariation("wght", 600),
                    ],
                    color: Colors.grey[600],
                  ),
              ),
            ),
          )
        ],
      )
    );
  }
}
