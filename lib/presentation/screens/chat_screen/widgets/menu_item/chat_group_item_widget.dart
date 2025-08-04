import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_chat_demo/app/router/router_app_name.dart';
import 'package:simple_chat_demo/data/models/chat_model.dart';
import 'package:simple_chat_demo/presentation/screens/chat_screen/cubit/chat/chat_cubit.dart';
import 'package:simple_chat_demo/presentation/screens/chat_screen/widgets/dialog/delete_dialog.dart';
import 'package:simple_chat_demo/presentation/screens/chat_screen/widgets/dialog/update_dialog.dart';
import 'package:simple_chat_demo/presentation/screens/chat_screen/widgets/menu_item/chat_menu_item.dart';

class ChatGroupItemWidget extends StatelessWidget {
  final String content;
  const ChatGroupItemWidget({required this.content, super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatCubit, List<ChatModel>>(
      builder: (context, state) {
        final groupedMessages = context.read<ChatCubit>().groupMessagesByTime();
        return ListView.builder(
          itemCount:
              groupedMessages.entries
                  .where((entry) => entry.value.any((value) => value.content.contains(content)))
                  .length,
          physics: BouncingScrollPhysics(),
          itemBuilder: (context, index) {
            final groupKey = groupedMessages.keys.elementAt(index);
            final messagesInGroup = groupedMessages[groupKey]?.where(
              (e) => e.content.contains(content),
            );
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  groupKey,
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(color: Colors.grey),
                ),
                if (messagesInGroup != null)
                  ...messagesInGroup.map(
                    (val) => Padding(
                      padding: EdgeInsetsGeometry.only(top: 8, bottom: 8),
                      child: ChatMenuItemWidget(
                        onDelete: () {
                          showGeneralDialog(
                            context: context,
                            pageBuilder: (context, animation, secondaryAnimation) {
                              return DeleteDialog(
                                onDelete: () {
                                  context.read<ChatCubit>().removeChat(val);
                                },
                              );
                            },
                          );
                        },
                        onRename: () {
                          showGeneralDialog(
                            context: context,
                            pageBuilder:
                                (context, animation, secondaryAnimation) => UpdateDialog(
                                  onUpdate: (content) {
                                    context.read<ChatCubit>().editChat(val, content);
                                  },
                                ),
                          );
                        },
                        onNewChat: () {
                          context.pop();
                        },
                        title: val.content,
                      ),
                    ),
                  ),
              ],
            );
          },
        );
      },
    );
  }
}
