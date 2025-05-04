part of 'chat_cubit.dart';

abstract class ChatState extends Equatable {
  const ChatState();

  @override
  List<Object> get props => [];
}

class ChatInitial extends ChatState {}

class ChatLoading extends ChatState {}

class ChatLoaded extends ChatState {
  final List<ChatModel> chats;

  const ChatLoaded(this.chats);
}

class ChatError extends ChatState {
  final String message;

  const ChatError(this.message);
}

class GetMessagesLoaded extends ChatState {
  const GetMessagesLoaded();
}

class GetMessagesError extends ChatState {
  final String message;

  const GetMessagesError(this.message);
}
