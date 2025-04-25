import 'package:edu/di.dart';
import 'package:edu/src/features/courses/presentation/cubit/courses_cubit.dart';
import 'package:edu/src/features/home/data/models/student_model.dart';
import 'package:edu/src/features/home/presentation/cubit/home_cubit.dart';
import 'package:edu/src/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    preHome();
    preProfile();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await context.read<ProfileCubit>().getTodaySchedule();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const SizedBox(),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await context.read<ProfileCubit>().logout(context);
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 40),
            _buildProfileCard(),
            const SizedBox(height: 20),
            _buildScheduleSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileCard() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          StudentModel student = context.read<HomeCubit>().student;
          return Column(
            children: [
              // University Logo
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.indigo.shade100,
                ),
                child: const Icon(
                  Icons.school,
                  color: Colors.indigo,
                  size: 40,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'Alex. University',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.indigo,
                ),
              ),
              const SizedBox(height: 20),
              _buildInfoRow('Name', student.studentName),
              _buildInfoRow('ID', student.studentId.toString()),
              _buildInfoRow('GPA', student.studentCgpa.toString()),
              _buildInfoRow('DEP.', student.studentMajor),
              _buildInfoRow('Class', student.studentLevel.toString()),
            ],
          );
        },
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Text(
            '$label: ',
            style: const TextStyle(
              fontSize: 16,
              color: Colors.indigo,
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildScheduleSection() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          _buildCalendarSection(),
          const SizedBox(height: 20),
          _buildTodaySchedule(),
        ],
      ),
    );
  }

  Widget _buildCalendarSection() {
    return Column(
      children: [
        Text(
          MonthMap[DateTime.now().month] ?? '',
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.indigo,
          ),
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ...List.generate(7, (index) {
              final date = DateTime.now()
                  .subtract(Duration(days: DateTime.now().weekday - index - 1));
              return _buildDateItem(
                [
                  'SUN',
                  'MON',
                  'TUE',
                  'WED',
                  'THU',
                  'FRI',
                  'SAT'
                ][date.weekday % 7],
                '${date.day}',
                isSelected: date.day == DateTime.now().day,
              );
            }),
          ],
        ),
      ],
    );
  }

  Widget _buildDateItem(String day, String date, {bool isSelected = false}) {
    return Column(
      children: [
        Text(
          day,
          style: TextStyle(
            fontSize: 12,
            color: isSelected ? Colors.indigo : Colors.grey,
          ),
        ),
        const SizedBox(height: 4),
        Container(
          width: 30,
          height: 30,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isSelected ? Colors.indigo : Colors.transparent,
          ),
          child: Center(
            child: Text(
              date,
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.grey,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTodaySchedule() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(Icons.calendar_today, color: Colors.indigo),
              SizedBox(width: 10),
              Text(
                'Today Schedule',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.indigo,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          BlocBuilder<ProfileCubit, ProfileState>(
            builder: (context, state) {
              ProfileCubit profileCubit = context.read<ProfileCubit>();
              return SizedBox(
                height: 300,
                width: double.infinity,
                child: ListView.separated(
                  itemBuilder: (context, index) {
                    final course = profileCubit.todaySchedule[index];
                    final courseName = course.course?.courseName ?? '';
                    final sessions = course.course?.session ?? [];

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          courseName,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.indigo,
                          ),
                        ),
                        const SizedBox(height: 8),
                        ...sessions.map((session) {
                          final time = session.sessionTime;
                          if (time == null) return const SizedBox();

                          return _buildScheduleItem(
                            session.sessionType ?? '',
                            '${time.hour}:${time.minute.toString().padLeft(2, '0')}',
                          );
                        }),
                      ],
                    );
                  },
                  separatorBuilder: (context, index) =>
                      const Divider(height: 32, color: Colors.indigo),
                  itemCount: profileCubit.todaySchedule.length,
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildScheduleItem(String type, String time) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(
                type.toLowerCase() == 'lecture' ? Icons.school : Icons.class_,
                size: 16,
                color: Colors.indigo,
              ),
              const SizedBox(width: 8),
              Text(
                type.toUpperCase(),
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.indigo.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              time,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.indigo,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Map MonthMap = {
  1: 'JAN',
  2: 'FEB',
  3: 'MAR',
  4: 'APR',
  5: 'MAY',
  6: 'JUN',
  7: 'JUL',
  8: 'AUG',
  9: 'SEP',
  10: 'OCT',
  11: 'NOV',
  12: 'DEC',
};
