import 'package:edu/src/features/profile/data/models/courses.dart';
import 'package:flutter/material.dart';

/// A widget that displays a calendar event card
class EventCard extends StatelessWidget {
  /// The event data to display
  final TodaySchedule event;

  const EventCard({
    super.key,
    required this.event,
  });

  @override
  Widget build(BuildContext context) {
    final courseName = event.course?.courseName ?? '';
    final sessions = event.course?.session ?? [];

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: const BoxDecoration(
              color: Colors.indigo,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15),
                topRight: Radius.circular(15),
              ),
            ),
            child: Text(
              courseName,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: sessions.length,
            itemBuilder: (context, index) {
              final session = sessions[index];
              return Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: index < sessions.length - 1
                      ? const Border(
                          bottom: BorderSide(color: Colors.grey, width: 0.5),
                        )
                      : null,
                ),
                child: Row(
                  children: [
                    _getEventIcon(session.sessionType ?? ''),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '$courseName - ${session.sessionType!}',
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 15,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            session.sessionTime?.toString() ?? '',
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                    _getEventTypeChip(session.sessionType ?? ''),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _getEventIcon(String type) {
    IconData iconData;
    Color iconColor;

    switch (type) {
      case 'lecture':
        iconData = Icons.school;
        iconColor = Colors.blue;
        break;
      case 'assignment':
        iconData = Icons.assignment;
        iconColor = Colors.orange;
        break;
      case 'quiz':
        iconData = Icons.quiz;
        iconColor = Colors.red;
        break;
      default:
        iconData = Icons.event;
        iconColor = Colors.grey;
    }

    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: iconColor.withOpacity(0.1),
        shape: BoxShape.circle,
      ),
      child: Icon(
        iconData,
        color: iconColor,
      ),
    );
  }

  Widget _getEventTypeChip(String type) {
    Color chipColor;
    String label;

    switch (type) {
      case 'lecture':
        chipColor = Colors.blue;
        label = 'Lecture';
        break;
      case 'section':
        chipColor = Colors.orange;
        label = 'Section';
        break;
      case 'quiz':
        chipColor = Colors.red;
        label = 'Quiz';
        break;
      case 'assignment':
        chipColor = Colors.redAccent;
        label = 'Assignment';
        break;
      default:
        chipColor = Colors.grey;
        label = 'Event';
    }

    return Chip(
      label: Text(
        label,
        style: TextStyle(
          color: chipColor,
          fontSize: 12,
        ),
      ),
      backgroundColor: chipColor.withOpacity(0.1),
    );
  }
}
