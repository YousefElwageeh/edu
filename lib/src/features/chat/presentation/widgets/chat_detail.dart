import 'dart:developer';

import 'package:edu/src/core/api/constant&endPoints.dart';
import 'package:edu/src/features/chat/data/models/chat_model.dart';
import 'package:edu/src/features/chat/data/models/message_model.dart';
import 'package:edu/src/features/chat/presentation/cubit/chat_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'message_bubble.dart';

class ChatDetail extends StatefulWidget {
  final ChatModel chat;
  const ChatDetail({super.key, required this.chat});

  @override
  State<ChatDetail> createState() => _ChatDetailState();
}

class _ChatDetailState extends State<ChatDetail> {
  final TextEditingController messageController = TextEditingController();
  final ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: MediaQuery.of(context).size.width <= 600
            ? const BackButton()
            : null,
        title: Row(
          children: [
            CircleAvatar(
              child: Text(widget.chat.chatName[0]),
            ),
            const SizedBox(width: 12),
            Text(
              widget.chat.chatName,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.black,
              ),
            ),
          ],
        ),
        actions: const [
          // IconButton(
          //   icon: const Icon(Icons.phone),
          //   onPressed: () {},
          // ),
          // IconButton(
          //   icon: const Icon(Icons.more_vert),
          //   onPressed: () {},
          // ),
        ],
      ),
      body: BlocBuilder<ChatCubit, ChatState>(
        builder: (context, state) {
          return Column(
            children: [
              Expanded(
                child: StreamBuilder<List<MessageModel>>(
                    stream: context.read<ChatCubit>().messages,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        final messages = snapshot.data!.reversed.toList();
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          if (scrollController.hasClients) {
                            scrollController.animateTo(
                              scrollController.position.maxScrollExtent,
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeOut,
                            );
                          }
                        });
                        return ListView.builder(
                          itemCount: messages.length ?? 0,
                          controller: scrollController,
                          itemBuilder: (context, index) {
                            DateTime dateTime =
                                DateTime.parse(messages[index].msg_date_time);

                            return MessageBubble(
                              message: messages[index].msg_content,
                              time:
                                  '${dateTime.year}-${dateTime.month}-${dateTime.day} ${dateTime.hour > 12 ? dateTime.hour - 12 : dateTime.hour}:${dateTime.minute}',
                              isMe: messages[index].senderid.toString() ==
                                  Constants.studentId!,
                            );
                          },
                        );
                      } else {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    }),
              ),
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 10,
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: messageController,
                        decoration: InputDecoration(
                          hintText: 'Enter Your Message',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                        ),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.send),
                      onPressed: () async {
                        if (messageController.text.trim().isEmpty) return;

                        await context
                            .read<ChatCubit>()
                            .sendMessage(MessageModel(
                              msg_content: messageController.text,
                              msg_date_time: DateTime.now().toString(),
                              senderid: int.parse(Constants.studentId!),
                              chat_id: widget.chat.chatId,
                            ));
                        messageController.clear();

                        // Wait briefly for the message to be added to the stream
                        await Future.delayed(const Duration(milliseconds: 100));

                        if (scrollController.hasClients) {
                          scrollController.animateTo(
                            scrollController.position.maxScrollExtent,
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeOut,
                          );
                        }
                      },
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
