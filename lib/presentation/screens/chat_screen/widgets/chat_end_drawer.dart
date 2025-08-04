import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:simple_chat_demo/common/constants/themes/color_scheme.dart';
import 'package:simple_chat_demo/common/widgets/buttons/circle_icon_button.dart';
import 'package:simple_chat_demo/presentation/screens/chat_screen/widgets/menu_item/chat_group_item_widget.dart';

class ChatEndDrawer extends StatefulWidget {
  const ChatEndDrawer({super.key});

  @override
  State<ChatEndDrawer> createState() => _ChatEndDrawerState();
}

class _ChatEndDrawerState extends State<ChatEndDrawer> {
  final TextEditingController _controller = TextEditingController();
  @override
  void initState() {
    super.initState();
    _controller.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool textFieldIsEmpty = _controller.text.isNotEmpty;
    return Drawer(
      backgroundColor: Colors.black,
      child: SafeArea(
        child: Padding(
          padding: EdgeInsetsGeometry.symmetric(horizontal: 14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 16,
            children: [
              CircleIconButton(icon: Icons.close_rounded, onPressed: () => context.pop()),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      cursorColor: Colors.white,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                      decoration: InputDecoration(
                        fillColor: AppColorScheme.whiteSwatch[50],
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide.none,
                        ),
                        isDense: true,
                        hintText: 'Search',
                        hintStyle: const TextStyle(color: Colors.white54),
                        prefixIcon: Icon(IconsaxPlusLinear.search_normal_1, color: Colors.white),
                        suffix:
                            textFieldIsEmpty
                                ? CircleIconButton(
                                  icon: Icons.close_rounded,
                                  onPressed: _controller.clear,
                                  size: 12,
                                  height: 16,
                                  width: 16,
                                )
                                : null,
                      ),
                    ),
                  ),
                  if (textFieldIsEmpty)
                    InkWell(
                      onTap: () {
                        _controller.clear();
                      },
                      child: Text(
                        'Cancel',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                ],
              ),
              Expanded(child: ChatGroupItemWidget(content: _controller.text)),
            ],
          ),
        ),
      ),
    );
  }
}
