import 'package:flutter/material.dart';

class UltCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color color;
  final double fontSizeMultiplier;
  final double padding;

  const UltCard({
    super.key,
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
    this.fontSizeMultiplier = 1.0,
    this.padding = 16.0,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Container(
        padding: EdgeInsets.all(padding),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 32 * fontSizeMultiplier,
              color: color,
            ),
            SizedBox(height: padding / 2),
            Text(
              value,
              style: TextStyle(
                fontSize: 20 * fontSizeMultiplier,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            SizedBox(height: padding / 4),
            Text(
              title,
              style: TextStyle(
                fontSize: 14 * fontSizeMultiplier,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
      ),
    );
  }
}