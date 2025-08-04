import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:simple_chat_demo/app/router/router_app_name.dart';
import 'package:simple_chat_demo/common/widgets/buttons/circle_icon_button.dart';
import 'package:simple_chat_demo/data/services/camera_service.dart';
import 'package:simple_chat_demo/gen/assets.gen.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:simple_chat_demo/presentation/screens/scan_screen/cubit/scan_cubit.dart';

class ScanScreen extends StatefulWidget {
  const ScanScreen({super.key});

  @override
  State<ScanScreen> createState() => _ScanScreenState();
}

class _ScanScreenState extends State<ScanScreen> {
  final CameraService _cameraService = CameraService();
  late Future<void> _initializeControllerFuture;

  @override
  void initState() {
    super.initState();
    _initializeControllerFuture = _cameraService.initCamera();
  }

  @override
  void dispose() {
    _cameraService.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CircleIconButton(
              icon: Icons.close_rounded,
              onPressed: () {
                context.pop();
              },
            ),
            CircleIconButton(
              icon:
                  _cameraService.flashMode == FlashMode.off
                      ? IconsaxPlusBold.flash_slash
                      : IconsaxPlusBold.flash_1,
              onPressed: () {
                _cameraService.toggleFlash();
                setState(() {});
              },
            ),
          ],
        ),
      ),
      extendBodyBehindAppBar: true,
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(Assets.images.backgroundScan.path),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          spacing: 30.h,
          children: [
            SizedBox(height: 120.h),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white, width: 2),
                  borderRadius: BorderRadius.circular(24),
                ),
                child: FutureBuilder(
                  future: _initializeControllerFuture,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      final controller = _cameraService.controller;
                      if (controller == null) {
                        return const Center(child: Text("Camera not available"));
                      }
                      return ClipRRect(
                        borderRadius: BorderRadius.circular(22),
                        child: CameraPreview(controller),
                      );
                    }
                    return const Center(child: CircularProgressIndicator());
                  },
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CircleIconButton(icon: IconsaxPlusBold.image, onPressed: () {}),
                InkWell(
                  onTap: () {
                    final controller = _cameraService.controller;
                    if (controller == null) return;
                    context.read<ScanCubit>().takePictureAndSave(controller).then((val) {
                      if (val) {
                        context.pop();
                      }
                    });
                  },
                  child: Container(
                    padding: EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.white, width: 1.5),
                      shape: BoxShape.circle,
                    ),
                    child: Container(
                      height: 60,
                      width: 60,
                      decoration: BoxDecoration(color: Colors.white, shape: BoxShape.circle),
                    ),
                  ),
                ),
                CircleIconButton(
                  icon: Icons.flip_camera_ios,
                  onPressed: () async {
                    await _cameraService.flipCamera();
                    setState(() {});
                  },
                ),
              ],
            ),
            const SizedBox(),
          ],
        ),
      ),
    );
  }
}
