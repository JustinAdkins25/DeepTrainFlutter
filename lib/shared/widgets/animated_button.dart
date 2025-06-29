import 'package:flutter/material.dart';

class AnimatedButton extends StatelessWidget {
  final String text;
  final Color mainColor;
  final Color hoverTextColor;
  final Color? reverseHoverColor;
  final bool reverse;
  final bool iconOnly;
  final double borderRadius;
  final double spacing;
  final Widget? startIcon;
  final Widget? endIcon;
  final VoidCallback? onPressed;
  final bool fullWidth;
  final bool disabled;
  final String size;

  const AnimatedButton({
    super.key,
    this.text = 'Click Me',
    this.mainColor = Colors.black,
    this.hoverTextColor = Colors.white,
    this.reverseHoverColor,
    this.reverse = false,
    this.iconOnly = false,
    this.borderRadius = 0,
    this.spacing = 0,
    this.startIcon,
    this.endIcon,
    this.onPressed,
    this.fullWidth = false,
    this.disabled = false,
    this.size = 'large',
  });

  @override
  Widget build(BuildContext context) {
    final sizeStyle = _getSizeStyle(size);

    return MouseRegion(
      cursor: disabled ? SystemMouseCursors.basic : SystemMouseCursors.click,
      child: GestureDetector(
        onTap: disabled ? null : onPressed,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          padding: iconOnly ? EdgeInsets.zero : sizeStyle.padding,
          height: iconOnly ? sizeStyle.dimension : null,
          width: iconOnly ? sizeStyle.dimension : (fullWidth ? double.infinity : null),
          decoration: BoxDecoration(
            color: disabled ? Colors.grey : (reverse ? mainColor : Colors.transparent),
            border: Border.all(color: disabled ? Colors.grey : mainColor, width: 3),
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: fullWidth ? MainAxisSize.max : MainAxisSize.min,
            children: [
              if (startIcon != null && !iconOnly) ...[
                IconTheme(data: IconThemeData(size: sizeStyle.iconSize), child: startIcon!),
                const SizedBox(width: 6),
              ],
              if (!iconOnly)
                Text(
                  text.toUpperCase(),
                  style: TextStyle(
                    fontSize: sizeStyle.fontSize,
                    fontWeight: FontWeight.w600,
                    color: disabled ? Colors.white : (reverse ? hoverTextColor : mainColor),
                  ),
                ),
              if (endIcon != null && !iconOnly) ...[
                const SizedBox(width: 6),
                IconTheme(data: IconThemeData(size: sizeStyle.iconSize), child: endIcon!),
              ],
            ],
          ),
        ),
      ),
    );
  }

  _SizeStyle _getSizeStyle(String key) {
    switch (key) {
      case 'small':
        return _SizeStyle(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          fontSize: 12,
          iconSize: 18,
          dimension: 36,
        );
      case 'medium':
        return _SizeStyle(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          fontSize: 16,
          iconSize: 20,
          dimension: 44,
        );
      case 'xlarge':
        return _SizeStyle(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
          fontSize: 32,
          iconSize: 24,
          dimension: 60,
        );
      default:
        return _SizeStyle(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          fontSize: 18,
          iconSize: 22,
          dimension: 52,
        );
    }
  }
}

class _SizeStyle {
  final EdgeInsets padding;
  final double fontSize;
  final double iconSize;
  final double dimension;

  const _SizeStyle({
    required this.padding,
    required this.fontSize,
    required this.iconSize,
    required this.dimension,
  });
}
