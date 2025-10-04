import 'package:edu/di.dart';
import 'package:edu/src/config/theme/colorManger.dart';
import 'package:edu/src/features/calender/presentation/widgets/event_card.dart';
import 'package:edu/src/features/calender/presentation/widgets/event_creation_dialog.dart';
import 'package:edu/src/features/profile/data/models/courses.dart';
import 'package:edu/src/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
  void initState() {
    preProfile();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileCubit()..getTodaySchedule(),
      child: BlocBuilder<ProfileCubit, ProfileState>(
        builder: (context, state) {
          return Scaffold(
            floatingActionButton: FloatingActionButton(
              backgroundColor: ColorsManager.primaryColor,
              onPressed: () =>
                  _showAddEventDialog(context, context.read<ProfileCubit>()),
              child: const Icon(Icons.add, color: Colors.white),
            ),
            body: Column(
              children: [
                _buildCalendar(),
                const SizedBox(height: 20),
                _buildDaySchedule(),
              ],
            ),
          );
        },
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
      child: BlocBuilder<ProfileCubit, ProfileState>(
        builder: (context, state) {
          return TableCalendar(
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
              context.read<ProfileCubit>().getTodaySchedule(date: selectedDay);
            },
            onFormatChanged: (format) {
              setState(() {
                _calendarFormat = format;
              });
            },
            calendarStyle: CalendarStyle(
              todayDecoration: BoxDecoration(
                color: Colors.indigo.withOpacity(0.5),
                // border: Border.all(color: Colors.black, width: 2),
                shape: BoxShape.circle,
              ),
              selectedDecoration: const BoxDecoration(
                color: Colors.indigo,
                shape: BoxShape.circle,
              ),
            ),
            headerStyle: const HeaderStyle(
              formatButtonVisible: true,
              titleCentered: true,
              formatButtonShowsNext: false,
            ),
          );
        },
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
            BlocBuilder<ProfileCubit, ProfileState>(
              builder: (context, state) {
                if (state is ProfileLoading) {
                  return const Expanded(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                }

                if (state is ProfileError) {
                  return Expanded(
                    child: Center(
                      child: Text(
                        state.message,
                        style: const TextStyle(
                          color: Colors.red,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  );
                }

                if (state is ProfileLoaded) {
                  if (state.todaySchedule.isEmpty) {
                    return const Expanded(
                      child: Center(
                        child: Text(
                          'No events for today',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    );
                  }

                  return Expanded(
                    child: ListView.builder(
                      itemCount:
                          context.read<ProfileCubit>().todaySchedule.length,
                      itemBuilder: (context, index) {
                        final event =
                            context.read<ProfileCubit>().todaySchedule[index];
                        return _buildEventCard(event);
                      },
                    ),
                  );
                }

                return const SizedBox.shrink();
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEventCard(TodaySchedule event) {
    return EventCard(event: event);
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

  // Show Add Event Dialog
  Future<void> _showAddEventDialog(
      BuildContext context, ProfileCubit profileCubit) async {
    final result = await showDialog(
      context: context,
      builder: (context) => EventCreationDialog(
        initialDate: _selectedDay ?? DateTime.now(),
      ),
    );

    if (result != null) {
      await profileCubit.addEvent(
        eventName: result['title'],
        eventStartDateTime: result['startDate'],
        eventEndDateTime: result['endDate'],
        eventType: 'Event',
        eventDetails: result['description'],
        date: _selectedDay,
      );
    }
  }
}
