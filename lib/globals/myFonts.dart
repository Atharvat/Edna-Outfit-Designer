import 'package:flutter/material.dart';

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
}