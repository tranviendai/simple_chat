// lib/presentation/screens/scan_screen/bloc/scan_cubit.dart
import 'package:camera/camera.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_chat_demo/presentation/screens/scan_screen/cubit/scan_state.dart';
import 'package:image_picker/image_picker.dart';

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
      Future.delayed(const Duration(seconds: 1), () {
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

  Future<bool> getImage() async {
    emit(ScanInProgress());
    try {
      final picker = ImagePicker();
      final XFile? pickedFile = await picker.pickImage(source: ImageSource.gallery);

      if (pickedFile == null) {
        emit(ScanError('No image selected.'));
        return false;
      }

      final directory = await getApplicationDocumentsDirectory();
      final imagePath = p.join(directory.path, '${DateTime.now().millisecondsSinceEpoch}.png');
      await pickedFile.saveTo(imagePath);

      emit(ScanSuccess(imagePath: imagePath, isLoading: true));
      Future.delayed(const Duration(seconds: 1), () {
        emit(ScanSuccess(imagePath: imagePath, isLoading: false));
      });
      return true;
    } catch (e) {
      emit(ScanError('Failed to pick and save image: $e'));
      return false;
    }
  }
}
