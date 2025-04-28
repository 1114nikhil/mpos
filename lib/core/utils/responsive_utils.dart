import 'package:flutter/material.dart';
import 'package:mpos/core/models/responsive_config.dart';

class ResponsiveUtils {
  // Device type breakpoints
  static const double mobileBreakpoint = 600;
  static const double tabletBreakpoint = 1200;
  static const double maxContentWidth = 1200;

  // Determine device type and configurations
  static ResponsiveConfig getResponsiveConfig(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    // Device type
    final isMobile = screenWidth <= mobileBreakpoint;
    final isTablet = screenWidth > mobileBreakpoint && screenWidth <= tabletBreakpoint;
    final isWeb = screenWidth > tabletBreakpoint;

    // Responsive configurations
    final padding = isWeb ? 32.0 : isTablet ? 24.0 : 16.0;
    final crossAxisCount = isWeb ? 4 : isTablet ? 3 : 2;
    final childAspectRatio = isWeb ? 1.3 : isTablet ? 1.2 : 1.0;
    final fontSizeMultiplier = isWeb ? 1.2 : isTablet ? 1.1 : 1.0;
    final maxWidth = isWeb ? maxContentWidth : screenWidth;

    return ResponsiveConfig(
      isMobile: isMobile,
      isTablet: isTablet,
      isWeb: isWeb,
      padding: padding,
      crossAxisCount: crossAxisCount,
      childAspectRatio: childAspectRatio,
      fontSizeMultiplier: fontSizeMultiplier,
      maxContentWidth: maxWidth,
    );
  }
}