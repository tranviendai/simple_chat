// lib/presentation/screens/scan_screen/bloc/scan_cubit.dart
import 'package:camera/camera.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_chat_demo/presentation/screens/scan_screen/cubit/scan_state.dart';

class ScanCubit extends Cubit<ScanState> {
  ScanCubit() : super(ScanInitial());

  Future<bool> takePictureAndSave(CameraController controller) async {
    emit(ScanInProgress());
    try {
      if (!controller.value.isInitialized) {
        return false;
      }
      final XFile image = await controller.takePicture();
      final directory = await getApplicationDocumentsDirectory();
      final imagePath = p.join(directory.path, '${DateTime.now().millisecondsSinceEpoch}.png');
      await image.saveTo(imagePath);
      emit(ScanSuccess(imagePath: imagePath, isLoading: true));
      Future.delayed(const Duration(seconds: 3), () {
        emit(ScanSuccess(imagePath: imagePath, isLoading: false));
      });
      return true;
    } catch (e) {
      emit(ScanError('Failed to take picture and save: $e'));
      return false;
    }
  }

  void removePicture() {
    emit(ScanInitial());
  }

  void handleScanResult(String result) {}
}
