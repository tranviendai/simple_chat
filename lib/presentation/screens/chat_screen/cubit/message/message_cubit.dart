import 'dart:math';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_chat_demo/data/models/chat_model.dart';
import 'package:simple_chat_demo/presentation/screens/chat_screen/cubit/message/message_state.dart';

class MessageCubit extends Cubit<MessageState> {
  MessageCubit() : super(MessageInitial());

  Future<void> addMessage({required String content}) async {
    emit(MessageInProgress());
    try {
      emit(
        MessageSuccess(
          data: ChatModel(
            content: content,
            timestamp: DateTime.now(),
            // .subtract(Duration(days: randomDay())), //-> random lastMonth or lastYear
          ),
        ),
      );
    } catch (ex) {
      emit(MessageError(error: '$ex'));
    }
  }

  int randomDay() {
    final random = Random();
    final index = random.nextInt(600);
    return index;
  }
}
