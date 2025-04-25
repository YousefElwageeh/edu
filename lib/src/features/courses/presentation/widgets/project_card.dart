import 'package:flutter/material.dart';

class ProjectCard extends StatelessWidget {
  final String title;
  final String description;
  final DateTime dueDate;
  final bool isSubmitted;
  final VoidCallback onViewInstructions;
  final VoidCallback onUpload;
  final VoidCallback onSubmit;

  const ProjectCard({
    super.key,
    required this.title,
    required this.description,
    required this.dueDate,
    required this.isSubmitted,
    required this.onViewInstructions,
    required this.onUpload,
    required this.onSubmit,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1F1F39),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            description,
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Icon(
                Icons.calendar_today,
                size: 16,
                color: isSubmitted ? Colors.pink : Colors.indigo,
              ),
              const SizedBox(width: 8),
              Text(
                'Due: ${dueDate.toString().split(' ')[0]}',
                style: TextStyle(
                  color: isSubmitted ? Colors.pink : Colors.indigo,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          TextButton(
            onPressed: onViewInstructions,
            child: const Text('View Instructions'),
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: isSubmitted ? Colors.pink : Colors.indigo,
                style: BorderStyle.solid,
              ),
            ),
            child: Column(
              children: [
                Icon(
                  Icons.cloud_upload_outlined,
                  size: 48,
                  color: isSubmitted ? Colors.pink : Colors.indigo,
                ),
                const SizedBox(height: 8),
                const Text('Drag and drop project file here'),
                const SizedBox(height: 4),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('or '),
                    TextButton(
                      onPressed: onUpload,
                      child: Text(
                        'Upload File',
                        style: TextStyle(
                          color: isSubmitted ? Colors.pink : Colors.indigo,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: onSubmit,
              style: ElevatedButton.styleFrom(
                backgroundColor: isSubmitted ? Colors.pink : Colors.indigo,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text('Submit'),
            ),
          ),
        ],
      ),
    );
  }
}
