import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:simple_chat_demo/common/constants/themes/color_scheme.dart';
import 'package:simple_chat_demo/data/models/chat_model.dart';
import 'package:simple_chat_demo/presentation/screens/chat_screen/widgets/bottom_sheet/chat_bottom_sheet_widget.dart';

class ChatTextFieldNoDataWidget extends StatelessWidget {
  final List<ChatModel> data;
  const ChatTextFieldNoDataWidget({required this.data, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: 'You have ${data.length} free message left. ',
                style: Theme.of(
                  context,
                ).textTheme.bodySmall?.copyWith(fontWeight: FontWeight.w700, color: Colors.white),
              ),
              TextSpan(
                text: 'Get Premium',
                recognizer:
                    TapGestureRecognizer()
                      ..onTap = () {
                        showModalBottomSheet(
                          context: context,
                          builder: (context) => ChatBottomSheetWidget(),
                        );
                      },
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Colors.yellow,
                  fontWeight: FontWeight.w700,
                  decoration: TextDecoration.underline,
                  decorationColor: Colors.yellow,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        if (data.isEmpty)
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              spacing: 10,
              children: [
                Container(
                  padding: EdgeInsetsDirectional.symmetric(horizontal: 16, vertical: 12),
                  margin: EdgeInsets.only(bottom: 16),
                  decoration: BoxDecoration(
                    color: AppColorScheme.whiteSwatch[50],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    'Help me solve a math',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.grey),
                  ),
                ),
                Container(
                  padding: EdgeInsetsDirectional.symmetric(horizontal: 16, vertical: 12),
                  margin: EdgeInsets.only(bottom: 16),
                  decoration: BoxDecoration(
                    color: AppColorScheme.whiteSwatch[50],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    'Make a recommendation',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.grey),
                  ),
                ),
                Container(
                  padding: EdgeInsetsDirectional.symmetric(horizontal: 16, vertical: 12),
                  margin: EdgeInsets.only(bottom: 16),
                  decoration: BoxDecoration(
                    color: AppColorScheme.whiteSwatch[50],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    'Make a video',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.grey),
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}
