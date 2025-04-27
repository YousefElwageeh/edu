import 'package:edu/di.dart';
import 'package:edu/src/config/theme/colorManger.dart';
import 'package:edu/src/config/theme/styles.dart';
import 'package:edu/src/config/utils/common_widgets/custom_button.dart';
import 'package:edu/src/core/helpers/spacing.dart';
import 'package:edu/src/features/profile/data/models/courses.dart';
import 'package:edu/src/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
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
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          backgroundColor: ColorsManager.primaryColor,
          onPressed: () => _showAddEventDialog(context),
          child: const Icon(Icons.add, color: Colors.white),
        ),
        body: Column(
          children: [
            _buildCalendar(),
            const SizedBox(height: 20),
            _buildDaySchedule(),
          ],
        ),
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
                  //  color: Colors.white,
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
                            session.sessionType ?? '',
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
  void _showAddEventDialog(BuildContext context) {
    final TextEditingController titleController = TextEditingController();
    final TextEditingController descriptionController = TextEditingController();

    DateTime startDate = _selectedDay ?? DateTime.now();
    DateTime endDate = _selectedDay ?? DateTime.now();

    showDialog(
      context: context,
      builder: (context) => Dialog(
        insetPadding: EdgeInsets.symmetric(horizontal: 16.w),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(20.r),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                // Header
                Row(
                  children: [
                    Text(
                      'Create Event',
                      style: font24BlackBold,
                    ),
                    const Spacer(),
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: Icon(
                        Icons.close,
                        color: ColorsManager.grey,
                      ),
                    ),
                  ],
                ),
                verticalSpace(10),
                Text(
                  'Every moment of learning is a step towards success.',
                  style: font16Greyregular,
                ),
                verticalSpace(20),

                // Event Title
                Text(
                  'Event Title',
                  style: font16BlackBold,
                ),
                verticalSpace(8),
                _buildTextField(titleController, 'Event Title'),
                verticalSpace(20),

                // Event Date Range
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Event Start Date',
                            style: font16BlackBold,
                          ),
                          verticalSpace(8),
                          _buildDatePicker(
                            context,
                            startDate,
                            (date) => startDate = date,
                          ),
                        ],
                      ),
                    ),
                    horizontalSpace(10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Event End Date',
                            style: font16BlackBold,
                          ),
                          verticalSpace(8),
                          _buildDatePicker(
                            context,
                            endDate,
                            (date) => endDate = date,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                verticalSpace(20),

                // Description
                Text(
                  'Description',
                  style: font16BlackBold,
                ),
                verticalSpace(8),
                _buildTextField(
                  descriptionController,
                  'Type Something Of You Want...',
                  maxLines: 4,
                ),
                verticalSpace(20),

                // Event Features
                Column(
                  children: [
                    _buildFeatureItem(
                      Icons.edit,
                      ColorsManager.primaryColor,
                      'With every event, we write a new chapter in our learning journey.',
                    ),
                    verticalSpace(10),
                    _buildFeatureItem(
                      Icons.lightbulb_outline,
                      Colors.amber,
                      'Learn, engage, and achieve your dreams with us',
                    ),
                    verticalSpace(10),
                    _buildFeatureItem(
                      Icons.school,
                      Colors.blue,
                      'Let\'s explore the world of knowledge, step by step.',
                    ),
                  ],
                ),
                verticalSpace(20),

                // Save Button
                CustomButton(
                  text: 'Save',
                  onPressed: () {
                    // Add event logic would go here
                    // For now, we'll just close the dialog
                    Navigator.pop(context);

                    // Show a snackbar to indicate success
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: const Text('Event created successfully'),
                        backgroundColor: ColorsManager.primaryColor,
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Helper method to build text fields
  Widget _buildTextField(TextEditingController controller, String hint,
      {int maxLines = 1}) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(color: Colors.grey[400]),
        filled: true,
        fillColor: Colors.grey[100],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: BorderSide.none,
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      ),
    );
  }

  // Helper method to build date pickers
  Widget _buildDatePicker(BuildContext context, DateTime initialDate,
      Function(DateTime) onDateSelected) {
    return GestureDetector(
      onTap: () async {
        final DateTime? picked = await showDatePicker(
          context: context,
          initialDate: initialDate,
          firstDate: DateTime.now(),
          lastDate: DateTime(2025),
          builder: (context, child) {
            return Theme(
              data: Theme.of(context).copyWith(
                colorScheme: ColorScheme.light(
                  primary: ColorsManager.primaryColor,
                ),
              ),
              child: child!,
            );
          },
        );
        if (picked != null) {
          onDateSelected(picked);
        }
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Row(
          children: [
            Text(
              DateFormat('MMM dd, yyyy').format(initialDate),
              style: font16BlackRegular.copyWith(fontSize: 12.r),
            ),
            const Spacer(),
            Icon(
              Icons.calendar_today,
              color: ColorsManager.primaryColor,
              size: 18.r,
            ),
          ],
        ),
      ),
    );
  }

  // Helper method to build feature items
  Widget _buildFeatureItem(IconData icon, Color color, String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.all(8.r),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8.r),
          ),
          child: Icon(
            icon,
            color: color,
            size: 20.r,
          ),
        ),
        horizontalSpace(10),
        Expanded(
          child: Text(
            text,
            style: font16Greyregular,
          ),
        ),
      ],
    );
  }
}
