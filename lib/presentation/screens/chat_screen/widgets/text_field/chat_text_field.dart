import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_chat_demo/app/router/router_app_name.dart';
import 'package:simple_chat_demo/common/constants/themes/color_scheme.dart';
import 'package:simple_chat_demo/common/widgets/buttons/circle_icon_button.dart';
import 'package:simple_chat_demo/data/models/chat_model.dart';
import 'package:simple_chat_demo/presentation/screens/chat_screen/cubit/message/message_cubit.dart';
import 'package:simple_chat_demo/presentation/screens/chat_screen/widgets/icons/chat_icons_widget.dart';
import 'package:simple_chat_demo/presentation/screens/chat_screen/widgets/images/chat_image_file_widget.dart';
import 'package:simple_chat_demo/presentation/screens/chat_screen/widgets/text_field/chat_text_field_no_data_widget.dart';
import 'package:simple_chat_demo/presentation/screens/scan_screen/cubit/scan_cubit.dart';
import 'package:simple_chat_demo/presentation/screens/scan_screen/cubit/scan_state.dart';

class ChatTextField extends StatefulWidget {
  final List<ChatModel> data;
  const ChatTextField({required this.data, super.key});

  @override
  State<ChatTextField> createState() => _ChatTextFieldState();
}

class _ChatTextFieldState extends State<ChatTextField> {
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

  void _onSend() {
    context.read<MessageCubit>().addMessage(content: _controller.text);
    context.read<ScanCubit>().removePicture();
    _controller.clear();
  }

  void _onScan() {
    context.push(RouterAppName.scan);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ChatTextFieldNoDataWidget(data: widget.data),
        BlocBuilder<ScanCubit, ScanState>(
          builder: (context, state) {
            final bool isTextFieldEmpty = _controller.text.isEmpty && state is! ScanSuccess;
            return Container(
              margin: EdgeInsets.only(bottom: 28),
              padding:
                  isTextFieldEmpty
                      ? EdgeInsets.symmetric(horizontal: 8)
                      : EdgeInsets.symmetric(horizontal: 12, vertical: 12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: AppColorScheme.whiteSwatch[50],
              ),
              child: AnimatedSize(
                duration: const Duration(milliseconds: 100),
                curve: Curves.easeInOut,
                child: Column(
                  children: [
                    TextField(
                      controller: _controller,
                      cursorColor: Colors.white,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.white),
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide.none,
                        ),
                        isDense: true,
                        hintText: 'Ask another question',
                        hintStyle: Theme.of(
                          context,
                        ).textTheme.bodyMedium?.copyWith(color: Colors.white54),
                        prefixIcon:
                            isTextFieldEmpty
                                ? Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const SizedBox(width: 8),
                                    FileAttachmentButton(onTap: () {}),
                                    const SizedBox(width: 8),
                                    ScanButton(onTap: _onScan),
                                  ],
                                )
                                : null,
                        suffixIconConstraints: BoxConstraints(maxWidth: 40),
                        suffixIcon:
                            isTextFieldEmpty
                                ? Padding(
                                  padding: EdgeInsetsGeometry.symmetric(vertical: 2),
                                  child: CircleIconButton(icon: Icons.mic, onPressed: () {}),
                                )
                                : null,
                        suffix:
                            !isTextFieldEmpty
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
                    ChatImageFileWidget(),
                    if (!isTextFieldEmpty)
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4),
                        child: Row(
                          children: [
                            FileAttachmentButton(onTap: () {}),
                            const SizedBox(width: 8),
                            ScanButton(onTap: _onScan),
                            const Spacer(),
                            MicrophoneButton(onTap: () {}),
                            const SizedBox(width: 8),
                            SendButton(onPressed: _onSend, color: AppColorScheme.primarySwatch),
                          ],
                        ),
                      ),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
