import 'package:flutter/material.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:simple_chat_demo/common/constants/themes/color_scheme.dart';
import 'package:simple_chat_demo/common/widgets/buttons/circle_image_button.dart';
import 'package:simple_chat_demo/data/services/speech_to_text_service.dart';

class ChatSpeechToTextWidget extends StatelessWidget {
  final SpeechToTextService provider;
  final Color? color;

  const ChatSpeechToTextWidget({required this.provider, this.color, super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: provider,
      builder: (context, child) {
        return provider.isListening
            ? InkWell(
              borderRadius: BorderRadius.circular(100),
              onTap: provider.stopListening,
              child: Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  border: Border.all(color: AppColorScheme.primarySwatch, width: 2),
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.stop_rounded, color: AppColorScheme.primarySwatch, size: 24),
              ),
            )
            : CircleWidgetButton(
              color: color,
              widget: Icon(IconsaxPlusBold.microphone, color: Colors.white, size: 20),
              onPressed: provider.startListening,
            );
      },
    );
  }
}
