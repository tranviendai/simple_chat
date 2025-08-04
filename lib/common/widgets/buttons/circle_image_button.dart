import 'package:flutter/material.dart';
import 'package:simple_chat_demo/common/constants/themes/color_scheme.dart';

class CircleWidgetButton extends StatelessWidget {
  final Widget widget;
  final double height, width;
  final Color? color;
  final VoidCallback? onPressed;

  const CircleWidgetButton({
    super.key,
    required this.widget,
    this.onPressed,
    this.height = 40,
    this.width = 40,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(100),
      onTap: onPressed,
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: color ?? AppColorScheme.whiteSwatch[100],
          borderRadius: BorderRadius.circular(100),
        ),
        child: widget,
      ),
    );
  }
}
