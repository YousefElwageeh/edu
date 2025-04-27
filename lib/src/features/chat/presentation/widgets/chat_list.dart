import 'package:flutter/material.dart';
import 'chat_list_item.dart';

class ChatList extends StatelessWidget {
  const ChatList({super.key});

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
        children: const [
          ChatListItem(
            name: 'AIS',
            message: 'bla blaa blaa..',
            time: '2:10 am',
            unreadCount: 1,
          ),
          ChatListItem(
            name: 'IIS',
            message: 'bla blaa blaa..',
            time: '2:01 am',
          ),
          ChatListItem(
            name: 'e-commerce',
            message: 'bla blaa blaa..',
            time: '1:20 am',
            unreadCount: 2,
          ),
          ChatListItem(
            name: 'MIS',
            message: 'bla blaa blaa..',
            time: '4:20 pm',
            unreadCount: 6,
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
    );
  }
}
