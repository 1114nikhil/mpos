import 'package:flutter/material.dart';
import 'package:mpos/core/models/responsive_config.dart';
import 'package:mpos/core/widgets/ult_text_field.dart';

class SearchField extends StatelessWidget {
  final ResponsiveConfig config;

  const SearchField({
    super.key,
    required this.config
    });

  @override
  Widget build(BuildContext context) {
    return ULTTextField(
      controller: TextEditingController(), // Placeholder controller
      hintText: 'Search stats...',
      fontSizeMultiplier: config.fontSizeMultiplier,
      padding: config.padding,
      icon: Icons.search, // Use prefix icon
      isPrefixIcon: false, // Explicitly set as prefix (optional, since true is default)
    );
  }
}