import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  CalendarFormat _calendarFormat = CalendarFormat.week;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  final List<Map<String, dynamic>> _events = [
    {
      'title': 'Programming Lecture',
      'time': '10:00 AM',
      'type': 'lecture',
      'location': 'Room 101'
    },
    {
      'title': 'Database Assignment Due',
      'time': '11:59 PM',
      'type': 'assignment',
      'description': 'Submit ERD diagram'
    },
    {
      'title': 'Statistics Quiz',
      'time': '2:00 PM',
      'type': 'quiz',
      'location': 'Lab 3'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          _buildCalendar(),
          const SizedBox(height: 20),
          _buildDaySchedule(),
        ],
      ),
    );
  }

  Widget _buildCalendar() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.vertical(bottom: Radius.circular(20)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: TableCalendar(
        firstDay: DateTime.utc(2024, 1, 1),
        lastDay: DateTime.utc(2025, 12, 31),
        focusedDay: _focusedDay,
        calendarFormat: _calendarFormat,
        selectedDayPredicate: (day) {
          return isSameDay(_selectedDay, day);
        },
        onDaySelected: (selectedDay, focusedDay) {
          setState(() {
            _selectedDay = selectedDay;
            _focusedDay = focusedDay;
          });
        },
        onFormatChanged: (format) {
          setState(() {
            _calendarFormat = format;
          });
        },
        calendarStyle: const CalendarStyle(
          todayDecoration: BoxDecoration(
            color: Colors.indigo,
            shape: BoxShape.circle,
          ),
          selectedDecoration: BoxDecoration(
            color: Colors.indigo,
            shape: BoxShape.circle,
          ),
        ),
        headerStyle: const HeaderStyle(
          formatButtonVisible: true,
          titleCentered: true,
          formatButtonShowsNext: false,
        ),
      ),
    );
  }

  Widget _buildDaySchedule() {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Schedule for ${_selectedDay?.day ?? _focusedDay.day} ${_getMonthName(_selectedDay?.month ?? _focusedDay.month)}',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.indigo,
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: _events.length,
                itemBuilder: (context, index) {
                  final event = _events[index];
                  return _buildEventCard(event);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEventCard(Map<String, dynamic> event) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        leading: _getEventIcon(event['type']),
        title: Text(
          event['title'],
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(event['time']),
            if (event['location'] != null)
              Text(
                '📍 ${event['location']}',
                style: const TextStyle(
                  color: Colors.grey,
                ),
              ),
            if (event['description'] != null)
              Text(
                event['description'],
                style: const TextStyle(
                  color: Colors.grey,
                ),
              ),
          ],
        ),
        trailing: _getEventTypeChip(event['type']),
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
      case 'assignment':
        chipColor = Colors.orange;
        label = 'Assignment';
        break;
      case 'quiz':
        chipColor = Colors.red;
        label = 'Quiz';
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

  String _getMonthName(int month) {
    const months = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December'
    ];
    return months[month - 1];
  }
}