import 'package:flutter/material.dart';
import 'chat_list_item.dart';
import 'package:edu/src/features/chat/data/models/chat_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/chat_cubit.dart';

class ChatList extends StatelessWidget {
  final List<ChatModel> chats;
  const ChatList({super.key, required this.chats});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const SizedBox(),
        title: const Text('Messages'),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: (value) {
                context.read<ChatCubit>().search(value);
              },
              decoration: InputDecoration(
                hintText: 'Search Conversation',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                filled: true,
                fillColor: Theme.of(context).colorScheme.surface,
              ),
            ),
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(8),
        children: chats
            .map(
              (chat) => ChatListItem(
                chatId: chat.chatId,
                name: chat.chatName,
                message: chat.chatName,
                time: '',
                unreadCount: 0,
              ),
            )
            .toList(),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {},
      //   child: const Icon(Icons.add),
      // ),
    );
  }
}
