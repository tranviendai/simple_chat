import 'package:flutter/material.dart';
import 'package:simple_chat_demo/common/constants/themes/color_scheme.dart';
import 'package:simple_chat_demo/common/widgets/buttons/circle_icon_button.dart';
import 'package:simple_chat_demo/common/widgets/buttons/circle_image_button.dart';
import 'package:simple_chat_demo/gen/assets.gen.dart';
import 'package:simple_chat_demo/presentation/screens/chat_screen/widgets/bottom_sheet/chat_bottom_sheet_widget.dart';

class ChatAppbar extends StatelessWidget implements PreferredSizeWidget {
  const ChatAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      actions: [
        InkWell(
          borderRadius: BorderRadius.circular(30),
          onTap: () {
            showModalBottomSheet(context: context, builder: (context) => ChatBottomSheetWidget());
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 6, vertical: 3),
            decoration: BoxDecoration(
              color: AppColorScheme.whiteSwatch[100],
              borderRadius: BorderRadius.circular(30),
            ),
            child: Row(
              spacing: 4,
              children: [
                Assets.icons.gem.image(width: 19, height: 13),
                Text(
                  '5',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.white),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: 8),
        CircleWidgetButton(
          color: Colors.transparent,
          widget: Assets.icons.history.svg(),
          onPressed: () {
            Scaffold.of(context).openEndDrawer();
          },
        ),
      ],
      automaticallyImplyLeading: false,
      shape: Border(bottom: BorderSide(color: AppColorScheme.whiteSwatch[100]!, width: .5)),
      elevation: 0,
      backgroundColor: AppColorScheme.blackSwatch[1000],
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CircleIconButton(icon: Icons.close_rounded, onPressed: () {}),
          const SizedBox(width: 8),
          CircleWidgetButton(
            color: AppColorScheme.whiteSwatch[50],
            widget: Row(
              spacing: 4,
              children: [
                Assets.icons.gemini.image(height: 14, width: 14),
                Text(
                  'Gemini Pro',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.white),
                ),
                Icon(Icons.keyboard_arrow_down_sharp, color: Colors.white),
              ],
            ),
            onPressed: () {
              showModalBottomSheet(context: context, builder: (context) => ChatBottomSheetWidget());
            },
          ),
          Spacer(),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
