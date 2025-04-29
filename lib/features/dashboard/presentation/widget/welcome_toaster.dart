import 'package:flutter/material.dart';
import 'package:mpos/core/models/responsive_config.dart';
import 'package:mpos/core/widgets/ult_toaster.dart';
import 'package:mpos/features/dashboard/presentation/widget/text_style.dart';

class WelcomeToaster extends StatelessWidget {
  final ResponsiveConfig config;
  final VoidCallback? onDismissed;

  const WelcomeToaster({
    super.key,
    required this.config,
    this.onDismissed,
  });

  @override
  Widget build(BuildContext context) {
    return ULTToaster(
      config: config,
      onDismissed: onDismissed,
      gradient: const LinearGradient(
        colors: [Colors.teal, Colors.tealAccent],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      padding: EdgeInsets.all(config.padding),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Welcome Back!',
                style: textStyle(
                  fontSize: 20,
                  config: config,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Here’s your overview',
                style: textStyle(
                  fontSize: 16,
                  config: config,
                  color: Colors.white70,
                ),
              ),
            ],
          ),
          Icon(
            Icons.analytics,
            size: 32 * config.fontSizeMultiplier,
            color: Colors.white,
          ),
        ],
      ),
    );
  }
}