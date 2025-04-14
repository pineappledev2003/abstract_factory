import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomText extends StatelessWidget {
  final String label;
  final String value;
  final Color color;

  const CustomText({super.key, required this.label, required this.value, required this.color});

  @override
  Widget build(BuildContext context) {
    return Text("$label $value", style: GoogleFonts.ibmPlexMono(fontSize: 14, color: color));
  }
}
