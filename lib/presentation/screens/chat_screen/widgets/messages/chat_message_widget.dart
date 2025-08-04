import 'dart:io';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:simple_chat_demo/common/constants/themes/color_scheme.dart';
import 'package:simple_chat_demo/data/models/chat_model.dart';
import 'package:simple_chat_demo/gen/assets.gen.dart';

class ChatMessageWidget extends StatelessWidget {
  final ChatModel data;
  const ChatMessageWidget({required this.data, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerRight,
          child: IntrinsicWidth(
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: 246.w),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 14, vertical: 16),
                decoration: BoxDecoration(
                  color: AppColorScheme.whiteSwatch[50],
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 10,
                  children: [
                    if (data.imagePath != null)
                      ClipRRect(
                        borderRadius: BorderRadiusGeometry.circular(8),
                        child: Image.file(
                          File(data.imagePath!),
                          height: 246.h,
                          fit: BoxFit.cover,
                          width: 246.w,
                        ),
                      ),
                    Text(
                      data.content,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),

        Container(
          padding: EdgeInsets.symmetric(horizontal: 14, vertical: 16),
          child: Column(
            spacing: 8,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 4,
                children: [
                  Assets.icons.chatgpt.svg(),
                  Text(
                    'Chatbot',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppColorScheme.primarySwatch,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
              if (data.response != null)
                AnimatedTextKit(
                  isRepeatingAnimation: false,
                  animatedTexts: [
                    TypewriterAnimatedText(
                      data.response!.response,
                      textStyle: Theme.of(
                        context,
                      ).textTheme.bodyMedium?.copyWith(color: Colors.white),
                      speed: const Duration(milliseconds: 50),
                    ),
                  ],
                )
              else
                SizedBox(width: 30, child: SpinKitThreeBounce(color: Colors.white, size: 20)),
            ],
          ),
        ),
      ],
    );
  }
}
