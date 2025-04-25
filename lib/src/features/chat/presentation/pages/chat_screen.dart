import 'package:flutter/material.dart';
import '../widgets/chat_list.dart';
import '../widgets/chat_detail.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth > 600) {
            // Tablet/Desktop view
            return const Row(
              children: [
                Expanded(flex: 1, child: ChatList()),
                VerticalDivider(width: 1),
                Expanded(flex: 2, child: ChatDetail()),
              ],
            );
          } else {
            // Mobile view
            return const ChatList();
          }
        },
      ),
    );
  }
}
