import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  const CustomText({super.key, required this.text,  this.color = Colors.white,  this.maxLines,  this.fontWeight,  this.fontSize});
  final String text;
  final Color color;
  final int? maxLines;
  final FontWeight? fontWeight;
  final double? fontSize;
 

  @override
  Widget build(BuildContext context) {
    return Text(text,
    maxLines: maxLines,
    overflow: TextOverflow.clip,
    
    style: TextStyle(
      color: color,
      fontSize: fontSize,
      fontWeight: fontWeight,
     
    ),);
  }
}