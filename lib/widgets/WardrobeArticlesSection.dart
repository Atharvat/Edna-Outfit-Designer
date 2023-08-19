import 'dart:ui';

import 'package:edna/widgets/WardrobeProductsHorizontal.dart';
import 'package:flutter/material.dart';
import 'package:edna/widgets/WardrobeArticleCard.dart';

class WardrobeArticlesSection extends StatefulWidget {
  const WardrobeArticlesSection({super.key});

  @override
  State<WardrobeArticlesSection> createState() => _WardrobeArticlesSectionState();
}

class _WardrobeArticlesSectionState extends State<WardrobeArticlesSection> {

  final String _sectionTitle = "Tops";
  bool expanded = false;

  @override
  Widget build(BuildContext context) {

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            _sectionTitle,
            style: const TextStyle(
              fontFamily: 'General Sans',
              fontSize: 14,
              fontVariations: [
                FontVariation("wght", 500),
              ],
              color: Color(0xFF101828),
            ),
          ),
        ),
        const SizedBox(height: 8,),
        SizedBox(
          height: 136,
          child: ListView(
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            children: [
              const SizedBox(width: 16,),
              InkWell(
                onTap: () {
                  setState(() {
                    expanded = !expanded;
                  });
                },
                child: WardrobeArticleCard()
              ),
              const SizedBox(width: 8,),
              WardrobeArticleCard(),
              const SizedBox(width: 8,),
              WardrobeArticleCard(),
              const SizedBox(width: 8,),
              WardrobeArticleCard(),
              const SizedBox(width: 8,),
              WardrobeArticleCard(),
              const SizedBox(width: 8,),
              WardrobeArticleCard(),
              const SizedBox(width: 16,),
            ],
          ),
        ),
        if (expanded) const SizedBox(height: 16,),
        if (expanded)
          WardrobeProductsHorizontal(),
        const SizedBox(height: 32,),
      ],
    );
  }
}
