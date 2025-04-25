import 'package:flutter/material.dart';
import 'message_bubble.dart';

class ChatDetail extends StatelessWidget {
  const ChatDetail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: MediaQuery.of(context).size.width <= 600
            ? const BackButton()
            : null,
        title: const Row(
          children: [
            CircleAvatar(
              child: Text('IIS'),
            ),
            SizedBox(width: 12),
            Text('IIS'),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.phone),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: const [
                MessageBubble(
                  message: 'bla blaa blaaaaaaaaaaaaaaaaaaaa blaaa blaa blaaaaaaa blaaaaaaaaaa blaaaaaa.',
                  time: '1:20 am',
                  isMe: true,
                ),
                MessageBubble(
                  message: 'bla blaa blaaaaaaaaaaaaaaaaaaaa blaaa blaa blaaaaaaa blaaaaaaaaaa blaaaaaa.',
                  time: '1:20 am',
                  isMe: false,
                ),
              ],
            ),
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
                IconButton(
                  icon: const Icon(Icons.attach_file),
                  onPressed: () {},
                ),
                IconButton(
                  icon: const Icon(Icons.camera_alt),
                  onPressed: () {},
                ),
                Expanded(
                  child: TextField(
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
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
