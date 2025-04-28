import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ULTOutlinedButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final String? iconPath;
  final double fontSizeMultiplier;
  final double padding;

  const ULTOutlinedButton({
    super.key,
    required this.onPressed,
    required this.text,
    this.iconPath,
    this.fontSizeMultiplier = 1.0,
    this.padding = 16.0,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        minimumSize: Size(double.infinity, 50 * fontSizeMultiplier),
        side: const BorderSide(color: Color(0xFF00C4B4)), // Sky Blue
        padding: EdgeInsets.symmetric(horizontal: padding, vertical: padding / 2),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (iconPath != null) ...[
            Image.asset(
              iconPath!,
              height: 20 * fontSizeMultiplier,
            ),
            SizedBox(width: padding / 2),
          ],
          Text(
            text,
            style: GoogleFonts.poppins(
              fontSize: 14 * fontSizeMultiplier,
              color: const Color(0xFF00C4B4), // Sky Blue
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}