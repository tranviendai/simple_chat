import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_chat_demo/data/models/chat_model.dart';
import 'package:simple_chat_demo/presentation/screens/chat_screen/cubit/chat/chat_cubit.dart';
import 'package:simple_chat_demo/presentation/screens/chat_screen/cubit/message/message_cubit.dart';
import 'package:simple_chat_demo/presentation/screens/chat_screen/cubit/message/message_state.dart';
import 'package:simple_chat_demo/presentation/screens/chat_screen/widgets/messages/chat_message_widget.dart';
import 'package:simple_chat_demo/presentation/screens/chat_screen/widgets/text_field/chat_text_field.dart';

class ChatBodyWidget extends StatefulWidget {
  const ChatBodyWidget({super.key});

  @override
  State<ChatBodyWidget> createState() => _ChatBodyWidgetState();
}

class _ChatBodyWidgetState extends State<ChatBodyWidget> {
  ScrollController controller = ScrollController(initialScrollOffset: 1);

  @override
  Widget build(BuildContext context) {
    return BlocListener<MessageCubit, MessageState>(
      listener: (context, state) {
        if (state is MessageSuccess) {
          context.read<ChatCubit>().addChat(state.data);
        }
        if (state is MessageError) {
          //handle snackbar or error message
        }
      },
      child: BlocConsumer<ChatCubit, List<ChatModel>>(
        listener: (context, state) {
          controller.jumpTo(controller.position.maxScrollExtent + 100);
        },
        builder: (context, state) {
          return Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  controller: controller,
                  child: Padding(
                    padding: EdgeInsetsGeometry.symmetric(horizontal: 20, vertical: 12),
                    child: Column(
                      children: state.map((val) => ChatMessageWidget(data: val)).toList(),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                child: Row(children: [Expanded(child: ChatTextField(data: state))]),
              ),
            ],
          );
        },
      ),
    );
  }
}
