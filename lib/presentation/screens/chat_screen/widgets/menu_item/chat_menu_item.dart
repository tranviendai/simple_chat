import 'package:flutter/material.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:simple_chat_demo/common/constants/themes/color_scheme.dart';

class ChatMenuItemWidget extends StatefulWidget {
  final String title;
  final VoidCallback onRename, onDelete, onNewChat;
  const ChatMenuItemWidget({
    required this.onDelete,
    required this.onNewChat,
    required this.onRename,
    required this.title,
    super.key,
  });

  @override
  State<ChatMenuItemWidget> createState() => _ChatMenuItemWidgetState();
}

class _ChatMenuItemWidgetState extends State<ChatMenuItemWidget> {
  bool isOpen = false;
  final GlobalKey _menuKey = GlobalKey();
  final GlobalKey _containerKey = GlobalKey();
  double _offsetY = 0;

  void _showPopupMenu() {
    final RenderBox? renderBox = _containerKey.currentContext?.findRenderObject() as RenderBox?;
    if (renderBox != null) {
      _offsetY = renderBox.size.height * 0.45;
    }

    final dynamic state = _menuKey.currentState;
    if (state != null) {
      state.showButtonMenu();
    }
  }

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: isOpen ? AppColorScheme.blackSwatch[500] : Colors.transparent,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Stack(
        children: [
          PopupMenuButton(
            key: _menuKey,
            borderRadius: BorderRadius.circular(8),
            constraints: BoxConstraints(minWidth: 168),
            color: AppColorScheme.blackSwatch[500],
            position: PopupMenuPosition.under,
            onOpened: () {
              isOpen = true;
              setState(() {});
            },
            onCanceled: () {
              isOpen = false;
              setState(() {});
            },
            offset: Offset(0, _offsetY),
            itemBuilder:
                (context) => [
                  PopupMenuItem(
                    onTap: widget.onRename,
                    child: PopMenuItemChildWidget(icon: IconsaxPlusBold.edit_2, title: 'Rename'),
                  ),
                  PopupMenuItem(
                    onTap: widget.onDelete,
                    child: PopMenuItemChildWidget(
                      icon: IconsaxPlusLinear.trash,
                      title: 'Delete Chat',
                    ),
                  ),
                  PopupMenuItem(
                    onTap: widget.onNewChat,
                    child: PopMenuItemChildWidget(icon: IconsaxPlusLinear.add, title: 'New Chat'),
                  ),
                ],
          ),
          InkWell(
            borderRadius: BorderRadius.circular(8),
            onTap: () {
              _showPopupMenu();
            },
            child: Container(
              key: _containerKey,
              padding: EdgeInsetsGeometry.symmetric(horizontal: 12, vertical: 8),
              width: MediaQuery.of(context).size.width,
              child: Text(
                widget.title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class PopMenuItemChildWidget extends StatelessWidget {
  final String title;
  final IconData icon;
  const PopMenuItemChildWidget({required this.icon, required this.title, super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.white)),
        Icon(icon, color: Colors.white),
      ],
    );
  }
}
