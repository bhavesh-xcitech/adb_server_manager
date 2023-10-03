import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class GoogleText extends StatelessWidget {
  final String text;
  final double fontSize;
  final Color? textColor;
  final FontWeight? fontWeight;
  final TextAlign? textAlign;

  const GoogleText({
    Key? key,
    required this.text,
    this.fontSize = 16.0,
    this.textColor = Colors.white,
    this.fontWeight,
    this.textAlign,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      style: GoogleFonts.nunito(
        fontSize: fontSize,
        color: textColor,
        fontWeight: fontWeight,
      ),
    );
  }
}
