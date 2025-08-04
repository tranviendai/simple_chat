import 'package:flutter_bloc/flutter_bloc.dart';

class ChatBottomSheetCubit extends Cubit<bool> {
  ChatBottomSheetCubit() : super(false);

  initBottomSheet() {
    emit(true);
  }

  dispose() {
    emit(false);
  }
}
