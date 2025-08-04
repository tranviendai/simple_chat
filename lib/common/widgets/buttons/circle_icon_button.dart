import 'package:flutter/material.dart';
import 'package:simple_chat_demo/common/constants/themes/color_scheme.dart';

class CircleIconButton extends StatelessWidget {
  final IconData icon;
  final double height, width, size;
  final VoidCallback onPressed;

  const CircleIconButton({
    super.key,
    required this.icon,
    required this.onPressed,
    this.height = 40,
    this.width = 40,
    this.size = 24,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(100),
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(color: AppColorScheme.whiteSwatch[100], shape: BoxShape.circle),
        child: Icon(icon, color: Colors.white, size: size),
      ),
    );
  }
}
