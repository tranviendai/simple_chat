import 'package:flutter/material.dart';
import 'package:simple_chat_demo/common/widgets/buttons/circle_image_button.dart';
import 'package:simple_chat_demo/gen/assets.gen.dart';

class FileAttachmentButton extends StatelessWidget {
  final VoidCallback onTap;
  const FileAttachmentButton({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(onTap: onTap, child: Assets.icons.file.svg());
  }
}

class ScanButton extends StatelessWidget {
  final VoidCallback onTap;
  const ScanButton({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(onTap: onTap, child: Assets.icons.scan.svg());
  }
}

class SendButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Color color;
  const SendButton({super.key, required this.onPressed, required this.color});

  @override
  Widget build(BuildContext context) {
    return CircleWidgetButton(
      height: 32,
      width: 32,
      color: color,
      widget: const Icon(Icons.arrow_upward, color: Colors.black),
      onPressed: onPressed,
    );
  }
}
