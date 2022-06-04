import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppText {
  static style({
    Color? color,
    FontWeight? weight,
    double? size,
    bool italic = false,
  }) =>
      GoogleFonts.montserrat(
        color: color ?? Colors.black,
        fontWeight: weight ?? FontWeight.w600,
        fontSize: size ?? 16,
        fontStyle: italic ? FontStyle.italic : FontStyle.normal,
      );

  static Widget build(
    String? label, {
    Color? color,
    FontWeight? weight,
    double? size,
    bool uppercase = false,
    TextAlign alignment = TextAlign.start,
    bool italic = false,
  }) {
    return Text(
      label != null && uppercase ? label.toUpperCase() : (label ?? ''),
      style: style(
        color: color,
        weight: weight,
        size: size,
        italic: italic,
      ),
      overflow: TextOverflow.clip,
      textAlign: alignment,
    );
  }
}
