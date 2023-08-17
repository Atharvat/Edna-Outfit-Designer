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
    letterSpacing: 0.97,
  );
}