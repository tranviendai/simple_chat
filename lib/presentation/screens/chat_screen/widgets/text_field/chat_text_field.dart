import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_chat_demo/app/router/router_app_name.dart';
import 'package:simple_chat_demo/common/constants/themes/color_scheme.dart';
import 'package:simple_chat_demo/common/widgets/buttons/circle_icon_button.dart';
import 'package:simple_chat_demo/data/models/chat_model.dart';
import 'package:simple_chat_demo/data/services/speech_to_text_service.dart';
import 'package:simple_chat_demo/presentation/screens/chat_screen/cubit/message/message_cubit.dart';
import 'package:simple_chat_demo/presentation/screens/chat_screen/widgets/icons/chat_icons_widget.dart';
import 'package:simple_chat_demo/presentation/screens/chat_screen/widgets/images/chat_image_file_widget.dart';
import 'package:simple_chat_demo/presentation/screens/chat_screen/widgets/speech_to_text/chat_speech_to_text_widget.dart';
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
  late final SpeechToTextService _speechProvider;
  bool isClear = false;

  @override
  void initState() {
    super.initState();
    _speechProvider = SpeechToTextService(
      onListen: (result) {
        if (!isClear) {
          _controller.text = result.recognizedWords;
          setState(() {});
        }
      },
    );
    _controller.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _speechProvider.dispose();
    _controller.dispose();
    super.dispose();
  }

  void _onSend() {
    final scan = context.read<ScanCubit>();
    final scanState = scan.state;
    final imageUrl = scanState is ScanSuccess ? (scanState).imagePath : null;
    context.read<MessageCubit>().addMessage(content: _controller.text, imagePath: imageUrl);
    scan.removePicture();
    clear();
  }

  void clear() async {
    isClear = true;
    _controller.clear();
    if (_speechProvider.isListening) {
      _speechProvider.stopListening();
    }
    Future.delayed(Duration(seconds: 1), () {
      isClear = false;
      setState(() {});
    });
  }

  void _onScan() {
    context.push(RouterAppName.scan);
  }

  void _onFile() {
    context.read<ScanCubit>().getImage().then((val) {
      if (val) {
        context.pop();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ChatTextFieldNoDataWidget(data: widget.data),
        BlocBuilder<ScanCubit, ScanState>(
          builder: (context, state) {
            final bool isTextFieldEmpty = _controller.text.isEmpty && state is! ScanSuccess;
            return AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeOut,
              margin: EdgeInsets.only(bottom: 28),
              padding:
                  isTextFieldEmpty
                      ? EdgeInsets.symmetric(horizontal: 8)
                      : EdgeInsets.symmetric(horizontal: 12, vertical: 12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: AppColorScheme.whiteSwatch[50],
              ),
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
                                  FileAttachmentButton(onTap: _onFile),
                                  const SizedBox(width: 8),
                                  ScanButton(onTap: _onScan),
                                ],
                              )
                              : null,
                      suffixIconConstraints: BoxConstraints(maxWidth: 40),
                      suffixIcon:
                          isTextFieldEmpty
                              ? Padding(
                                padding: EdgeInsets.symmetric(vertical: 2),
                                child: ChatSpeechToTextWidget(provider: _speechProvider),
                              )
                              : null,
                      suffix:
                          !isTextFieldEmpty
                              ? CircleIconButton(
                                icon: Icons.close_rounded,
                                onPressed: clear,
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
                          FileAttachmentButton(onTap: _onFile),
                          const SizedBox(width: 8),
                          ScanButton(onTap: _onScan),
                          const Spacer(),
                          ChatSpeechToTextWidget(
                            provider: _speechProvider,
                            color: Colors.transparent,
                          ),
                          const SizedBox(width: 8),
                          SendButton(
                            onPressed: () {
                              if (_controller.text.isNotEmpty) {
                                _onSend();
                              }
                            },
                            color:
                                _controller.text.isEmpty
                                    ? Colors.grey
                                    : AppColorScheme.primarySwatch,
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}
