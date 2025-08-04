import 'package:simple_chat_demo/data/models/response_model.dart';

class ChatModel {
  final String content;
  final String? imagePath;
  final DateTime timestamp;
  final ResponseModel? response;

  ChatModel({required this.content, required this.timestamp, this.imagePath, this.response});

  ChatModel copyWith({
    String? content,
    DateTime? timestamp,
    ResponseModel? response,
    String? imagePath,
  }) {
    return ChatModel(
      content: content ?? this.content,
      imagePath: imagePath ?? this.imagePath,
      timestamp: timestamp ?? this.timestamp,
      response: response ?? this.response,
    );
  }
}
