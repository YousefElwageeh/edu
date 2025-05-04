import 'dart:developer';

import 'package:edu/src/core/api/constant&endPoints.dart';
import 'package:edu/src/features/chat/data/models/chat_model.dart';
import 'package:edu/src/features/chat/data/models/message_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ChatDataSource {
  Future<List<ChatModel>> getChats() async {
    final response = await Supabase.instance.client
        .from("student_chat")
        .select("*")
        .eq("student_id", Constants.studentId!);

    if (response.isEmpty) {
      return [];
    }

    final chatIds = response.map((chat) => chat['chat_id']).toList();

    //  log(response.toString());
    final response2 = await Supabase.instance.client
        .from("chat")
        .select("*")
        .inFilter("chat_id", chatIds);

    log(response2.toString());

    if (response2.isEmpty) {
      return [];
    }
    return response2.map((e) => ChatModel.fromJson(e)).toList();
  }

  Future<Stream<List<MessageModel>>> getChatMessages(chatId) async {
    final response = Supabase.instance.client
        .from('message')
        .stream(primaryKey: ['msg_id'])
        .eq('chat_id', chatId)
        .order('msg_date_time', ascending: false)
        .map((event) => event.map((e) => MessageModel.fromJson(e)).toList());
    return response;
  }

  //send message
  Future<void> sendMessage(MessageModel message) async {
    await Supabase.instance.client.from('message').insert(message.toJson());
  }
}
