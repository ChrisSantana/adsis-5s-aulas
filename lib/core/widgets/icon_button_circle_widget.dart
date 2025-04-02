import 'package:flutter/material.dart';

class IconButtonCircleWidget extends StatelessWidget {
  final IconData icon;
  final EdgeInsets? padding;
  final Color? iconColor;
  final VoidCallback? onPressed;
  final Color? backgroundColor;
  final bool showWidget;
  final double iconSize;
  final bool showShadow;

  const IconButtonCircleWidget({
    super.key,
    required this.icon,
    this.padding,
    this.iconColor,
    this.onPressed,
    this.showWidget = true,
    this.backgroundColor,
    this.iconSize = 32,
    this.showShadow = true,
  });

  @override
  Widget build(BuildContext context) {
    if (!showWidget) return const Offstage();
    return Padding(
      padding: padding ?? EdgeInsets.zero,
      child: IconButtonTheme(
        data: _createIconButtonThemeData(),
        child: Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            boxShadow: showShadow ? [
              BoxShadow(
                color: Theme.of(context).disabledColor,
                spreadRadius: 2,
                blurRadius: 5,
                offset: Offset(0, 3),
              ),
            ] : null,
          ),
          child: IconButton(
            icon: Padding(
              padding: const EdgeInsets.all(4),
              child: Icon(
                icon,
                color: iconColor,
                size: iconSize,
              ),
            ),
            onPressed: onPressed,
          ),
        ),
      ),
    );
  }

  IconButtonThemeData _createIconButtonThemeData() {
    return IconButtonThemeData(
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.all(backgroundColor),
      ),
    );
  }
}
