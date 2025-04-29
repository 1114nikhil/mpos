import 'package:flutter/material.dart';

class ULTTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool obscureText;
  final double fontSizeMultiplier;
  final double padding;
  final IconData? icon; // New parameter for prefix/suffix icon
  final bool isPrefixIcon; // Control whether icon is prefix or suffix

  const ULTTextField({
    super.key,
    required this.controller,
    required this.hintText,
    this.obscureText = false,
    this.fontSizeMultiplier = 1.0,
    this.padding = 16.0,
    this.icon,
    this.isPrefixIcon = true, // Default to prefix icon
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      style: TextStyle(fontSize: 16 * fontSizeMultiplier),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(
          fontSize: 16 * fontSizeMultiplier,
          color: Colors.grey[400],
        ),
        prefixIcon: icon != null && isPrefixIcon
            ? Icon(
                icon,
                size: 20 * fontSizeMultiplier,
                color: Colors.grey[400],
              )
            : null,
        suffixIcon: icon != null && !isPrefixIcon
            ? Icon(
                icon,
                size: 20 * fontSizeMultiplier,
                color: Colors.grey[400],
              )
            : null,
        filled: true,
        fillColor: Colors.grey[100],
        contentPadding: EdgeInsets.symmetric(
          horizontal: padding,
          vertical: padding / 2,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}