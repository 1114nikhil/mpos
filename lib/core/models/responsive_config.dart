class ResponsiveConfig {
  final bool isMobile;
  final bool isTablet;
  final bool isWeb;
  final double padding;
  final int crossAxisCount;
  final double childAspectRatio;
  final double fontSizeMultiplier;
  final double maxContentWidth;

  ResponsiveConfig({
    required this.isMobile,
    required this.isTablet,
    required this.isWeb,
    required this.padding,
    required this.crossAxisCount,
    required this.childAspectRatio,
    required this.fontSizeMultiplier,
    required this.maxContentWidth,
  });
}