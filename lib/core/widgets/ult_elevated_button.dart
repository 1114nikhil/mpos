import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ULTElevatedButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final double fontSizeMultiplier;
  final double padding;

  const ULTElevatedButton({
    super.key,
    required this.onPressed,
    required this.text,
    this.fontSizeMultiplier = 1.0,
    this.padding = 16.0,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF4CAF50), // Green
        minimumSize: Size(double.infinity, 50 * fontSizeMultiplier),
        padding: EdgeInsets.symmetric(horizontal: padding, vertical: padding / 2),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      child: Text(
        text,
        style: GoogleFonts.poppins(
          fontSize: 16 * fontSizeMultiplier,
          color: Colors.white,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}