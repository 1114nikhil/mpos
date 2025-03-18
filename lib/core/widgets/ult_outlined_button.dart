import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ULTOutlinedButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final String? iconPath; // Optional icon path for buttons with icons

  const ULTOutlinedButton({
    required this.onPressed,
    required this.text,
    this.iconPath,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        minimumSize: Size(double.infinity, 50),
        side: BorderSide(color: Color(0xFF00C4B4)), // Sky Blue
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
              height: 20,
            ),
            SizedBox(width: 8),
          ],
          Text(
            text,
            style: GoogleFonts.poppins(
              fontSize: 14,
              color: Color(0xFF00C4B4), // Sky Blue
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}