import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NunitoSans {
  static custom({
    required text,
    required double fontSize,
    required FontWeight fontWeight,
    required Color color,
    TextAlign? textAlign,
    TextOverflow? overflow,
    int? maxLines,
  }) {
    return Text(
      text,
      style: GoogleFonts.nunitoSans(
        fontSize: fontSize,
        color: color,
        fontWeight: fontWeight,
      ),
      overflow: overflow,
      maxLines: maxLines,
      textAlign: textAlign,
    );
  }
}
