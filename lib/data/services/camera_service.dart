import 'package:camera/camera.dart';

class CameraService {
  CameraController? controller;
  FlashMode flashMode = FlashMode.off;
  Future<void>? initializeControllerFuture;

  Future<void> initCamera() async {
    final cameras = await availableCameras();
    final camera = cameras.first;

    controller = CameraController(camera, ResolutionPreset.medium);
    initializeControllerFuture = controller!.initialize();
    await initializeControllerFuture;

    if (camera.lensDirection == CameraLensDirection.back) {
      await controller?.setFlashMode(flashMode);
    } else {
      flashMode = FlashMode.off;
    }
  }

  Future<void> flipCamera() async {
    if (controller == null) return;

    final cameras = await availableCameras();
    final currentDirection = controller!.description.lensDirection;

    final newCamera = cameras.firstWhere((cam) => cam.lensDirection != currentDirection);

    await controller?.dispose();

    controller = CameraController(newCamera, ResolutionPreset.medium);
    initializeControllerFuture = controller!.initialize();
    await initializeControllerFuture;

    if (newCamera.lensDirection == CameraLensDirection.back) {
      await controller?.setFlashMode(flashMode);
    } else {
      flashMode = FlashMode.off;
      await controller?.setFlashMode(FlashMode.off);
    }
  }

  void toggleFlash() {
    if (controller == null || !isRearCamera) return;

    flashMode = flashMode == FlashMode.off ? FlashMode.torch : FlashMode.off;
    controller?.setFlashMode(flashMode);
  }

  bool get isRearCamera => controller?.description.lensDirection == CameraLensDirection.back;

  void dispose() {
    controller?.dispose();
  }
}
