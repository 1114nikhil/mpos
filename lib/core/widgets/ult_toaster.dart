import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mpos/core/models/responsive_config.dart';

class ULTToaster extends StatefulWidget {
  final ResponsiveConfig config;
  final Widget child;
  final VoidCallback? onDismissed;
  final Duration autoDismissDuration;
  final double borderRadius;
  final BoxShadow? shadow;
  final Color? backgroundColor;
  final Gradient? gradient;
  final EdgeInsets padding;
  final bool topPositioned;

  const ULTToaster({
    super.key,
    required this.config,
    required this.child,
    this.onDismissed,
    this.autoDismissDuration = const Duration(seconds: 5),
    this.borderRadius = 12.0,
    this.shadow,
    this.backgroundColor,
    this.gradient,
    this.padding = const EdgeInsets.all(16.0),
    this.topPositioned = true,
  });

  @override
  _ULTToasterState createState() => _ULTToasterState();
}

class _ULTToasterState extends State<ULTToaster> with SingleTickerProviderStateMixin {
  bool _isVisible = true;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    // Auto-dismiss after specified duration
    _timer = Timer(widget.autoDismissDuration, () {
      if (mounted) {
        setState(() {
          _isVisible = false;
        });
        widget.onDismissed?.call();
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _dismiss() {
    if (mounted) {
      setState(() {
        _isVisible = false;
      });
      widget.onDismissed?.call();
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned(
      duration: const Duration(milliseconds: 300),
      top: widget.topPositioned
          ? (_isVisible ? widget.config.padding : -100)
          : null,
      bottom: !widget.topPositioned
          ? (_isVisible ? widget.config.padding : -100)
          : null,
      left: widget.config.padding,
      right: widget.config.padding,
      child: Material(
        color: Colors.transparent,
        child: GestureDetector(
          onTap: _dismiss,
          child: Container(
            padding: widget.padding,
            decoration: BoxDecoration(
              color: widget.backgroundColor,
              gradient: widget.gradient,
              borderRadius: BorderRadius.circular(widget.borderRadius),
              boxShadow: [
                widget.shadow ??
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
              ],
            ),
            child: widget.child,
          ),
        ),
      ),
    );
  }
}
// to reuse
// ULTToaster(
//   config: config,
//   backgroundColor: Colors.red,
//   autoDismissDuration: const Duration(seconds: 3),
//   child: Text(
//     'Error: Failed to load data',
//     style: textStyle(
//       fontSize: 16,
//       config: config,
//       color: Colors.white,
//     ),
//   ),
// )