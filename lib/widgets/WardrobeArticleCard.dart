import 'dart:ui';

import 'package:flutter/material.dart';

import '../globals/myColors.dart';

class WardrobeArticleCard extends StatefulWidget {
  const WardrobeArticleCard({super.key});

  @override
  State<WardrobeArticleCard> createState() => _WardrobeArticleCardState();
}

class _WardrobeArticleCardState extends State<WardrobeArticleCard> {
  final String _imageUrl = "https://images.unsplash.com/photo-1691860305089-9a2566296202?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=240&q=80";
  final String _articleName = "Shirts";
  final List<String> _colors = ["#000000", "#FFFFFF", "#FF0000", "#00FF00", "#0000FF"];
  final bool _greyed = false;
  final bool _expanded = false;

  @override
  Widget build(BuildContext context) {

    return Stack(
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              _imageUrl,
              height: 90,
              width: 90,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 8,),
            Text(
              _articleName,
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
                    _colors.length.toString(),
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
                  )
              ],
            )
          ],
        ),
        if (_greyed)
          Container(
            height: 136,
            width: 90,
            color: Colors.white.withOpacity(0.71),
          ),
        if (_expanded)
          const SizedBox(
            height: 90,
            width: 90,
            //add a down arrow icon in the center
            child: Icon(
              Icons.keyboard_double_arrow_down,
              color: MyColors.black20,
              size: 24,
            ),
          ),
      ],
    );
  }
}
