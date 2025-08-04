import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_chat_demo/common/constants/themes/color_scheme.dart';
import 'package:simple_chat_demo/gen/assets.gen.dart';
import 'package:simple_chat_demo/presentation/screens/chat_screen/cubit/bottom_sheet/chat_bottom_sheet_cubit.dart';
import 'package:simple_chat_demo/presentation/screens/chat_screen/widgets/chat_appbar.dart';
import 'package:simple_chat_demo/presentation/screens/chat_screen/widgets/chat_body_widget.dart';
import 'package:simple_chat_demo/presentation/screens/chat_screen/widgets/chat_end_drawer.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatBottomSheetCubit, bool>(
      builder: (context, isShowBottomSheet) {
        return Scaffold(
          backgroundColor: AppColorScheme.blackSwatch[1000],
          appBar: ChatAppbar(),
          drawerEdgeDragWidth: 0,
          endDrawer: ChatEndDrawer(),
          resizeToAvoidBottomInset: true,
          body: Stack(
            children: [
              ChatBodyWidget(),
              AnimatedOpacity(
                opacity: isShowBottomSheet ? 1.0 : 0.0,
                duration: const Duration(milliseconds: 300),
                child: IgnorePointer(
                  ignoring: !isShowBottomSheet,
                  child: Assets.images.backgroundBlur.image(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
