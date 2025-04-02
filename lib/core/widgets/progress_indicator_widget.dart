import 'package:flutter/material.dart';

class ProgressIndicatorWidget extends StatelessWidget {
  final Color? color;
  final double? strokeWidth;
  final double? radius;
  final EdgeInsets? margin;

  const ProgressIndicatorWidget({
    super.key,
    this.color,
    this.strokeWidth = 2,
    this.radius = 28,
    this.margin,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: margin ?? const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        height: radius,
        width: radius,
        child: CircularProgressIndicator.adaptive(
          valueColor: AlwaysStoppedAnimation<Color>(Colors.grey.shade700),
          strokeWidth: strokeWidth ?? 3,
        ),
      ),
    );
  }
}
