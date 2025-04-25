import 'package:flutter/material.dart';
import 'package:edu/src/core/routes/app_router.dart';
import 'package:edu/src/core/routes/extensions.dart';
import '../widgets/project_card.dart';

class ProjectScreen extends StatelessWidget {
  const ProjectScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text(
          'Programming Projects',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            ProjectCard(
              title: 'ZOHO',
              description: 'Project description blaaaaaaaa blaaaa',
              dueDate: DateTime(2025, 4, 25),
              isSubmitted: false,
              onViewInstructions: () {
                context.goTo(Routes.quizRoute);
              },
              onUpload: () {
                // Handle file upload
              },
              onSubmit: () {
                // Handle project submission
              },
            ),
          ],
        ),
      ),
    );
  }
}
