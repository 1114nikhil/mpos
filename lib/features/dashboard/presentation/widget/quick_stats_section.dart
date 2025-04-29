import 'package:flutter/material.dart';
import 'package:mpos/core/models/responsive_config.dart';
import 'package:mpos/core/widgets/ult_card.dart';
import 'package:mpos/features/dashboard/presentation/widget/text_style.dart';

class QuickStatsSection extends StatelessWidget {
  final ResponsiveConfig config;

  const QuickStatsSection({super.key,required this.config});

  @override
  Widget build(BuildContext context) {
    final stats = [
      {'title': 'Customer', 'icon': Icons.people, 'color': Colors.blue},
      {'title': 'Items', 'icon': Icons.inventory, 'color': Colors.purple},
      {'title': 'Orders', 'icon': Icons.shopping_cart, 'color': Colors.orange},
      {'title': 'Sales', 'icon': Icons.monetization_on, 'color': Colors.green},
      {'title': 'More', 'icon': Icons.menu, 'color': Colors.green},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Quick Stats',
          style: textStyle(
            fontSize: 18,
            config: config,
            fontWeight: FontWeight.bold,
            color: Colors.grey[800],
          ),
        ),
        SizedBox(height: config.padding / 2),
        GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: config.crossAxisCount,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: config.childAspectRatio,
          children: stats.map((stat) {
            return UltCard(
              title: stat['title'] as String,
              value: '', // TODO: Replace with real data
              icon: stat['icon'] as IconData,
              color: stat['color'] as Color,
              fontSizeMultiplier: config.fontSizeMultiplier,
              padding: config.padding,
            );
          }).toList(),
        ),
      ],
    );
  }
}