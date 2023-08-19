import 'dart:ui';

import 'package:flutter/material.dart';

import '../globals/myColors.dart';

class WardrobeArticleCard extends StatefulWidget {
  String imageUrl;
  String name;
  List<String> colors;
  bool greyed;
  bool expanded;
  int productsCount;

  WardrobeArticleCard({super.key, required this.colors, required this.greyed, required this.expanded, required this.name, required this.imageUrl, required this.productsCount});

  @override
  State<WardrobeArticleCard> createState() => _WardrobeArticleCardState();
}

class _WardrobeArticleCardState extends State<WardrobeArticleCard> {
  final String _imageUrl = "https://images.unsplash.com/photo-1691860305089-9a2566296202?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=240&q=80";


  @override
  Widget build(BuildContext context) {

    return Stack(
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image(
              image: AssetImage("images/wardrobe/${widget.imageUrl}"),
              height: 90,
              width: 90,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 8,),
            Text(
              widget.name,
              style: const TextStyle(
                fontFamily: 'General Sans',
                fontSize: 12,
                fontVariations: [
                  FontVariation("wght", 600),
                ],
                color: Color(0xFF101828),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                    widget.productsCount.toString(),
                    style: const TextStyle(
                      fontFamily: 'General Sans',
                      fontSize: 12,
                      fontVariations: [
                        FontVariation("wght", 500),
                      ],
                      color: Color(0xFF101828),
                    ),
                ),
                const SizedBox(width: 4,),
                for (int i = 0; i < widget.colors.length; i++)
                  Container(
                    height: 12,
                    width: 12,
                    transform: Matrix4.translationValues((-7*i).toDouble(), 0, 0),
                    decoration: BoxDecoration(
                      color: Color(int.parse("0xFF${widget.colors[i].substring(1)}")),
                      shape: BoxShape.circle,
                      border: widget.colors[i] == "#FFFFFF" ? Border.all(
                        color: Colors.black,
                        width: 1
                      ) : null
                    ),
                  )
              ],
            )
          ],
        ),
        if (widget.greyed)
          Container(
            height: 136,
            width: 90,
            color: Colors.white.withOpacity(0.71),
          ),
        if (widget.expanded)
          Container(
            height: 90,
            width: 90,
            color: Colors.white.withOpacity(0.71),
          ),
        if (widget.expanded)
          const SizedBox(
            height: 90,
            width: 90,
            //add a down arrow icon in the center
            child: Icon(
              Icons.keyboard_double_arrow_down,
              color: Colors.black,
              size: 32,
            ),
          ),
      ],
    );
  }
}
