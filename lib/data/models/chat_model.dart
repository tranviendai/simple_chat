import 'package:simple_chat_demo/data/models/response_model.dart';

class ChatModel {
  final String content;
  final DateTime timestamp;
  final ResponseModel? response;

  ChatModel({required this.content, required this.timestamp, this.response});

  ChatModel copyWith({String? content, DateTime? timestamp, ResponseModel? response}) {
    return ChatModel(
      content: content ?? this.content,
      timestamp: timestamp ?? this.timestamp,
      response: response ?? this.response,
    );
  }
}
