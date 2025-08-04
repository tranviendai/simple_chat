import 'package:equatable/equatable.dart';
import 'package:simple_chat_demo/data/models/chat_model.dart';

class MessageState extends Equatable {
  @override
  List<Object?> get props => [];
}

class MessageInitial extends MessageState {}

class MessageInProgress extends MessageState {
  MessageInProgress();
}

class MessageSuccess extends MessageState {
  final ChatModel data;

  MessageSuccess({required this.data});

  @override
  List<Object?> get props => [data];
}

class MessageError extends MessageState {
  final String error;

  MessageError({required this.error});

  @override
  List<Object?> get props => [error];
}
