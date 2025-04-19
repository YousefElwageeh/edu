import 'package:flutter/material.dart';
import 'package:edu/src/config/theme/colorManger.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat'),
        backgroundColor:
            theme.appBarTheme.backgroundColor ?? ColorsManager.primaryColor,
        foregroundColor: theme.appBarTheme.foregroundColor ?? Colors.black,
      ),
      backgroundColor: theme.scaffoldBackgroundColor,
      body: Center(
        child: Text(
          'Welcome to Chat!',
          style: theme.textTheme.headlineSmall?.copyWith(
            color:
                theme.textTheme.bodyLarge?.color ?? ColorsManager.primaryColor,
          ),
        ),
      ),
    );
  }
}
