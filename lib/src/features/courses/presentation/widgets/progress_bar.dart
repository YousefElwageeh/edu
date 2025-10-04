import 'package:flutter/material.dart';

class QuizProgressBar extends StatelessWidget {
  final double progress;

  const QuizProgressBar({
    super.key,
    required this.progress,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 8,
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(4),
      ),
      child: FractionallySizedBox(
        alignment: Alignment.centerLeft,
        widthFactor: progress,
        child: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary,
            borderRadius: BorderRadius.circular(4),
          ),
        ),
      ),
    );
  }
}
