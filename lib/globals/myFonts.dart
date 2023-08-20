import 'dart:ui';

import 'package:flutter/material.dart';

import 'myColors.dart';

class MyFonts{
  Text heading(text, color){
    return Text(text, style: TextStyle(
      fontFamily: 'Playfair Display',
      fontSize: 32,
      fontWeight: FontWeight.w400,
      color: color,
    ));
  }
  Text message(text, color){
    return Text(text, style: TextStyle(
      fontFamily: 'General Sans Variable',
      fontSize: 16,
      height: 1.5,
      letterSpacing: 0.24,
      fontWeight: FontWeight.w500,
      color: color,
    ));
  }
  Text senderName(text, color){
    return Text(text, style: TextStyle(
      fontFamily: 'General Sans Variable',
      fontSize: 14,
      fontWeight: FontWeight.w500,
      height: 1.43,
      color: color,
    ));
  }
  static const TextStyle senderNameStyle = TextStyle(
  fontFamily: 'General Sans Variable',
  fontSize: 14,
  fontVariations: [
    FontVariation('wght', 500)
  ],
  height: 1.43,
  color: MyColors.black10,
  );
  static const TextStyle sentMessageStyle = TextStyle(
    fontFamily: 'General Sans',
    fontSize: 16,
    height: 1.5,
    letterSpacing: 0.24,
    fontVariations: [
      FontVariation('wght', 500)
    ],
    color: Colors.white,
  );
  static const TextStyle receivedMessageStyle = TextStyle(
    fontFamily: 'General Sans',
    fontSize: 16,
    height: 1.5,
    letterSpacing: 0.24,
    fontVariations: [
      FontVariation('wght', 500)
    ],
    color: Colors.black,
  );
  static TextStyle serifHeading = TextStyle(
    fontFamily: 'Playfair Display',
    fontSize: 20,
    fontVariations: const [
      FontVariation("wght", 400),
    ],
    color: Colors.grey[900],
    letterSpacing: -0.04,
  );
  static TextStyle serifHeading24 = TextStyle(
    fontFamily: 'Playfair Display',
    fontSize: 24,
    fontVariations: const [
      FontVariation("wght", 400),
    ],
    color: Colors.grey[900],
    letterSpacing: -0.04,
  );
  static TextStyle prefSectionHeader = TextStyle(
    fontFamily: 'General Sans',
    fontSize: 14,
    fontVariations: const [
      FontVariation("wght", 600),
    ],
    color: Colors.grey[700],
    letterSpacing: 0.015,
  );

  static TextStyle prefKey = TextStyle(
    fontFamily: 'General Sans',
    fontSize: 16,
    fontVariations: const [
      FontVariation("wght", 500),
    ],
    color: Colors.grey[500],
    letterSpacing: 0.015,
  );

  static TextStyle prefValue = TextStyle(
    fontFamily: 'General Sans',
    fontSize: 20,
    fontVariations: const [
      FontVariation("wght", 500),
    ],
    color: Colors.grey[900],
    letterSpacing: 0.015,
  );

  static TextStyle radioText = TextStyle(
    fontFamily: 'General Sans',
    fontSize: 16,
    fontVariations: const [
      FontVariation("wght", 500),
    ],
    color: Colors.grey[900],
    letterSpacing: 0.015,
  );
}