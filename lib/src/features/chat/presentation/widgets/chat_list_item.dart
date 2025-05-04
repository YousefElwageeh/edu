import 'package:edu/src/features/chat/data/models/chat_model.dart';
import 'package:edu/src/features/chat/presentation/cubit/chat_cubit.dart';
import 'package:edu/src/features/chat/presentation/widgets/chat_detail.dart';
import 'package:flutter/material.dart';
import 'package:edu/src/features/chat/presentation/pages/chat_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatListItem extends StatelessWidget {
  final String name;
  final String message;
  final String time;
  final int unreadCount;
  final int chatId;

  const ChatListItem({
    super.key,
    required this.name,
    required this.message,
    required this.time,
    this.unreadCount = 0,
    required this.chatId,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        if (MediaQuery.of(context).size.width <= 600) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => BlocProvider.value(
                value: ChatCubit()..getChatMessages(chatId),
                child:
                    ChatDetail(chat: ChatModel(chatId: chatId, chatName: name)),
              ),
            ),
          );
        }
      },
      leading: CircleAvatar(
        backgroundColor: Theme.of(context).colorScheme.primary.withOpacity(0.1),
        child: Text(
          name[0],
          style: TextStyle(
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
      ),
      title: Text(
        name,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      subtitle: Text(
        message,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            time,
            style: TextStyle(
              color: unreadCount > 0
                  ? Theme.of(context).colorScheme.primary
                  : Colors.grey,
              fontSize: 12,
            ),
          ),
          if (unreadCount > 0) ...[
            const SizedBox(height: 4),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                unreadCount.toString(),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
