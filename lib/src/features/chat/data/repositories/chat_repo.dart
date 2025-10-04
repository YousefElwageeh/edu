import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:edu/src/core/api/error_handler.dart';
import 'package:edu/src/core/api/failure.dart';
import 'package:edu/src/features/chat/data/models/chat_model.dart';
import 'package:edu/src/features/chat/data/models/message_model.dart';
import 'package:edu/src/features/chat/data/datasources/chat_data_source.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ChatRepo {
  final ChatDataSource dataSource;

  ChatRepo({required this.dataSource});

  Future<Either<Failure, Stream<List<MessageModel>>>> getChatMessages(
      chatId) async {
    try {
      final response = await dataSource.getChatMessages(chatId);
      return Right(response);
    } catch (e) {
      return Left(ErrorHandler.handle(e).failure);
    }
  }

  Future<Either<Failure, List<ChatModel>>> getChats() async {
    try {
      final response = await dataSource.getChats();
      return Right(response);
    } catch (e) {
      log(e.toString());
      return Left(ErrorHandler.handle(e).failure);
    }
  }

  Future<Either<Failure, void>> sendMessage(MessageModel message) async {
    try {
      await dataSource.sendMessage(message);
      return const Right(null);
    } catch (e) {
      return Left(ErrorHandler.handle(e).failure);
    }
  }
}
