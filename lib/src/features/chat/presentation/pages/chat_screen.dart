import 'package:edu/di.dart';
import 'package:edu/src/features/chat/data/models/chat_model.dart';
import 'package:flutter/material.dart';
import '../widgets/chat_list.dart';
import '../widgets/chat_detail.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/chat_cubit.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  void initState() {
    preChat();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ChatCubit()..getChats(),
      child: Scaffold(
        body: BlocBuilder<ChatCubit, ChatState>(
          builder: (context, state) {
            List<ChatModel> chats = context.read<ChatCubit>().chatsData;
            return LayoutBuilder(
              builder: (context, constraints) {
                // Mobile view
                return ChatList(chats: chats);
              },
            );
          },
        ),
      ),
    );
  }
}
