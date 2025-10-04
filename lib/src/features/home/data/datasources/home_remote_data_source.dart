import 'dart:math';

import 'package:dio/dio.dart';
import 'package:edu/src/core/api/dio_factory.dart';
import 'package:edu/src/features/courses/data/datasources/courses_data_source.dart';
import 'package:edu/src/features/home/data/models/weekly_dead_lines.dart';
import '../models/student_model.dart';
import '../../../../core/api/constant&endPoints.dart';
import '../../../../core/error/exceptions.dart';

abstract class HomeRemoteDataSource {
  Future<StudentModel> getStudentData(String studentId);

  Future<List<WeeklyDeadLines>> getWeeklyDeadlines(String studentId);
}

class HomeRemoteDataSourceImpl implements HomeRemoteDataSource {
  @override
  Future<StudentModel> getStudentData(String studentId) async {
    final response = await DioFactory.getdata(
      url: '${EndPoints.baseUrl}/student',
      quary: {
        'student_id': 'eq.$studentId',
      },
    );

    return StudentModel.fromJson(response.data[0]);
  }

  @override
  Future<List<WeeklyDeadLines>> getWeeklyDeadlines(String studentId) async {
    List<String> instructorsId = await getInstructorsIds();
    final today = DateTime.now();

    final endOfWeek = today.add(const Duration(days: 13)); // Sunday

    final endStr = endOfWeek.toIso8601String();

    final response = await DioFactory.getdata(
      url: '/enrollment',
      quary: {
        'student_id': 'eq.$studentId',
        'instructor_id': 'in.(${instructorsId.join(',')})',
        'select':
            '*,course:course_id!inner(course_id,course_name,assignment:assignment!inner(*))',
        'course.assignment.assign_duedate': [
          "gte.${today.year}-${today.month}-${today.day}",
          "lt.${endOfWeek.year}-${endOfWeek.month}-${endOfWeek.day}"
        ],
      },
    );

    return (response.data as List)
        .map((e) => WeeklyDeadLines.fromJson(e))
        .toList();
  }
}
