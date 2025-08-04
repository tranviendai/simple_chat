import 'dart:math';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_chat_demo/data/models/chat_model.dart';
import 'package:simple_chat_demo/data/models/response_model.dart';
import 'package:simple_chat_demo/mock/mock_data.dart';

class ChatCubit extends Cubit<List<ChatModel>> {
  ChatCubit() : super([]);

  void addChat(ChatModel data) {
    emit([...state, data]);
    Future.delayed(const Duration(seconds: 2), () {
      final List<ChatModel> updatedChats = [...state];
      final index = updatedChats.indexWhere((chat) => chat.timestamp == data.timestamp);

      if (index != -1) {
        updatedChats[index] = data.copyWith(response: getRandomResponse());
        emit(updatedChats);
      }
    });
  }

  void removeChat(ChatModel data) {
    emit(state.where((chat) => chat.timestamp != data.timestamp).toList());
  }

  void editChat(ChatModel data, String content) {
    final List<ChatModel> updatedChats = [...state];
    final index = updatedChats.indexWhere((chat) => chat.timestamp == data.timestamp);

    if (index != -1) {
      final updatedChat = data.copyWith(content: content, response: getRandomResponse());
      updatedChats[index] = updatedChat;

      emit(updatedChats);
    }
  }

  ResponseModel getRandomResponse() {
    final random = Random();
    final index = random.nextInt(mockResponses.length);
    return mockResponses[index];
  }

  Map<String, List<ChatModel>> groupMessagesByTime() {
    final now = DateTime.now();
    final Map<String, List<ChatModel>> groupedMessages = {};

    for (var message in state) {
      final difference = now.difference(message.timestamp);

      String groupKey;
      if (difference.inDays < 7) {
        groupKey = 'This week';
      } else if (difference.inDays < 365) {
        groupKey = 'Last month';
      } else {
        groupKey = 'Last year';
      }

      if (!groupedMessages.containsKey(groupKey)) {
        groupedMessages[groupKey] = [];
      }
      groupedMessages[groupKey]!.add(message);
    }

    return groupedMessages;
  }
}
