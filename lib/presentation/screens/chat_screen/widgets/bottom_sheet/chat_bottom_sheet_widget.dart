import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:simple_chat_demo/common/constants/themes/color_scheme.dart';
import 'package:simple_chat_demo/common/widgets/buttons/circle_image_button.dart';
import 'package:simple_chat_demo/gen/assets.gen.dart';
import 'package:simple_chat_demo/presentation/screens/chat_screen/cubit/bottom_sheet/chat_bottom_sheet_cubit.dart';

class ChatBottomSheetWidget extends StatefulWidget {
  const ChatBottomSheetWidget({super.key});

  @override
  State<ChatBottomSheetWidget> createState() => _ChatBottomSheetWidgetState();
}

class _ChatBottomSheetWidgetState extends State<ChatBottomSheetWidget> {
  @override
  void initState() {
    super.initState();
    context.read<ChatBottomSheetCubit>().initBottomSheet();
  }

  @override
  void deactivate() {
    context.read<ChatBottomSheetCubit>().dispose();
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaY: 5, sigmaX: 5),
      enabled: true,
      blendMode: BlendMode.darken,
      child: DraggableScrollableSheet(
        initialChildSize: 0.9,
        minChildSize: 0.2,
        maxChildSize: 0.9,
        expand: false,
        builder: (_, scrollController) {
          return Container(
            decoration: BoxDecoration(
              color: AppColorScheme.blackSwatch[700],
              borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
                  child: Center(
                    child: Container(
                      width: 40,
                      height: 5,
                      decoration: BoxDecoration(
                        color: Colors.grey[600],
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                  child: Text(
                    'Select a model',
                    style: Theme.of(
                      context,
                    ).textTheme.headlineMedium?.copyWith(color: Colors.white),
                  ),
                ),
                Expanded(
                  child: ListView(
                    controller: scrollController,
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    children: [
                      ModelOption(
                        logo: Assets.logo.chatgptModel.svg(height: 40, width: 40),
                        iconColor: Colors.green,
                        title: 'Auto',
                        subtitle: 'All-in-one chat: search the web, generate image, and more',
                        isSelected: true,
                      ),
                      ModelOption(
                        logo: Assets.logo.claudeModel.svg(height: 40, width: 40),
                        iconColor: Colors.deepOrange,
                        title: 'Claude',
                        subtitle: 'Expert at handling complex tasks',
                        isPremium: true,
                      ),
                      ModelOption(
                        logo: Assets.logo.geminiModel.svg(height: 40, width: 40),
                        iconColor: Colors.blue,
                        title: 'Gemini Pro',
                        subtitle: 'Ideal choice for large projects',
                        isPremium: true,
                      ),
                      ModelOption(
                        logo: Assets.logo.deepseekModel.image(height: 40, width: 40),
                        iconColor: Colors.blueAccent,
                        title: 'DeepSeek-R1',
                        subtitle: 'Expert at handling complex tasks',
                        isPremium: true,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class ModelOption extends StatelessWidget {
  final Widget logo;
  final Color iconColor;
  final String title;
  final String subtitle;
  final bool isSelected;
  final bool isPremium;

  const ModelOption({
    super.key,
    required this.logo,
    required this.iconColor,
    required this.title,
    required this.subtitle,
    this.isSelected = false,
    this.isPremium = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      padding: const EdgeInsets.all(15.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.grey.shade800),
        gradient: LinearGradient(
          begin: Alignment.bottomLeft,
          end: Alignment.topRight,
          colors: [
            iconColor.withOpacity(0.1),
            AppColorScheme.whiteSwatch[50]!,
            AppColorScheme.whiteSwatch[50]!,
            AppColorScheme.whiteSwatch[50]!,
            AppColorScheme.whiteSwatch[50]!,
          ],
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          logo,
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: Colors.white),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: Theme.of(
                    context,
                  ).textTheme.bodyMedium?.copyWith(color: Colors.white, fontSize: 12),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          if (isSelected)
            Icon(IconsaxPlusBold.tick_circle, color: Colors.white, size: 32)
          else if (isPremium)
            CircleWidgetButton(widget: Assets.icons.gem.image(height: 20, width: 20)),
        ],
      ),
    );
  }
}
