import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:simple_chat_demo/common/widgets/buttons/circle_icon_button.dart';
import 'package:simple_chat_demo/presentation/screens/scan_screen/cubit/scan_cubit.dart';
import 'package:simple_chat_demo/presentation/screens/scan_screen/cubit/scan_state.dart';

class ChatImageFileWidget extends StatelessWidget {
  const ChatImageFileWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ScanCubit, ScanState>(
      builder: (context, state) {
        if (state is ScanSuccess) {
          return Container(
            alignment: Alignment.centerLeft,
            child: Stack(
              children: [
                Positioned(
                  child: Padding(
                    padding: EdgeInsetsGeometry.only(top: 6, right: 6),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.file(
                        File(state.imagePath),
                        height: 40,
                        width: 40,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                if (state.isLoading)
                  Positioned.fill(
                    child: Container(
                      height: 40,
                      width: 40,
                      margin: EdgeInsetsGeometry.only(top: 6, right: 6),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.black54,
                      ),
                      child: SpinKitCircle(color: Colors.white, size: 12),
                    ),
                  ),
                Positioned(
                  right: 0,
                  top: 0,
                  child: CircleIconButton(
                    icon: Icons.close_rounded,
                    onPressed: () {
                      context.read<ScanCubit>().removePicture();
                    },
                    height: 18,
                    width: 18,
                    size: 14,
                  ),
                ),
              ],
            ),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
