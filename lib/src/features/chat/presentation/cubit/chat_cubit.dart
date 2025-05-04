import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:edu/di.dart';
import 'package:edu/src/features/chat/data/models/chat_model.dart';
import 'package:edu/src/features/chat/data/models/message_model.dart';
import 'package:equatable/equatable.dart';
import 'package:edu/src/features/chat/data/repositories/chat_repo.dart';
import 'package:flutter/widgets.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit() : super(ChatInitial());

  ChatRepo chatRepo = ChatRepo(dataSource: di());
  Stream<List<MessageModel>>? messages;
  List<ChatModel> chatsData = [];

  void getChats() async {
    emit(ChatLoading());
    final result = await chatRepo.getChats();
    result.fold((failure) {
      log(failure.message);
      emit(ChatError(failure.message));
    }, (chats) {
      data = chats;
      chatsData = chats;
      log(chats.toString());
      emit(ChatLoaded(chats));
    });
  }

  void getChatMessages(chatId) async {
    emit(ChatLoading());

    final result = await chatRepo.getChatMessages(chatId);
    result.fold((failure) => emit(ChatError(failure.message)), (chats) {
      messages = chats;
      emit(const GetMessagesLoaded());
    });
  }

  Future<void> sendMessage(MessageModel message) async {
    emit(ChatLoading());
    final result = await chatRepo.sendMessage(message);
    result.fold((failure) => emit(ChatError(failure.message)), (chats) {
      emit(ChatLoaded(chatsData));
    });
  }

  List<ChatModel> data = [];
  void search(String query) {
    emit(ChatLoading());

    if (query.isEmpty) {
      chatsData = data;
      emit(ChatLoaded(chatsData));
    } else {
      chatsData = chatsData
          .where((chat) =>
              chat.chatName.toLowerCase().contains(query.toLowerCase()))
          .toList();
      emit(ChatLoaded(chatsData));
    }
  }
}
