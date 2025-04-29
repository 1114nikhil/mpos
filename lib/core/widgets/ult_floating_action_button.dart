
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class UltFloatingActionButton extends StatelessWidget{
  final VoidCallback onPressed;
  final double fontSizeMultiplier;
  final IconData icon;
  final Color backgroundColor;
  final String? tooltip;
  final double padding;

  const UltFloatingActionButton({
    super.key,
    required this.onPressed,
    required this.icon,
    this.tooltip,
    this.backgroundColor=Colors.teal,
    this.fontSizeMultiplier=1.0,
    this.padding= 16.0
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: onPressed,
      backgroundColor: backgroundColor,
      tooltip: tooltip,
      child: Icon(
        icon,
        size: 24 * fontSizeMultiplier,
      ),
      mini: fontSizeMultiplier<1.1,
      elevation: 2,
      shape: const CircleBorder(),
      );
  }
}