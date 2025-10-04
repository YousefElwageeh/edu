import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:edu/src/core/api/constant&endPoints.dart';
import 'package:edu/src/core/api/dio_factory.dart';
import 'package:edu/src/features/profile/data/models/courses.dart';
import 'package:intl/intl.dart';

class ProfileDataSource {
  Future<List<TodaySchedule>> getTodaySchedule(DateTime date) async {
    //  DateFormat format = DateFormat("dd-MM-yyyy");
    DateTime dateAfterDay = date.add(const Duration(days: 1));
    final response = await DioFactory.getdata(
      url: EndPoints.enrollment,
      quary: {
        'student_id': 'eq.${Constants.studentId}',
        "select":
            "course_id,course:course_id!inner(course_name,session:session!inner(course_id,session_type,session_time))",
        "course.session.session_time": [
          "gte.${date.year}-${date.month}-${date.day}",
          "lt.${dateAfterDay.year}-${dateAfterDay.month}-${dateAfterDay.day}"
        ]
      },
    );

    return (response.data as List)
        .map((e) => TodaySchedule.fromJson(e))
        .toList();
  }

  Future<List<TodaySchedule>> getCalenderEvents(DateTime date) async {
    DateTime dateAfterDay = date.add(const Duration(days: 1));

    final response = await DioFactory.getdata(
      url: EndPoints.calendar,
      quary: {
        "select": "*'",
        "event_startdatetime": [
          "gte.${date.year}-${date.month}-${date.day}",
          "lt.${dateAfterDay.year}-${dateAfterDay.month}-${dateAfterDay.day}"
        ]
      },
    );

    return (response.data as List).map((e) {
      log(e.toString());
      return TodaySchedule(
          courseId: e['event_id'],
          course: CourseTodaySchedule(courseName: e['event_name'], session: [
            Session(
              sessionType: e['event_type'],
              sessionTime: DateTime.parse(e["event_startdatetime"]),
              courseId: e['event_id'],
            )
          ]));
    }).toList();
  }

  Future<Response<dynamic>> addEvent({
    required String eventName,
    required DateTime eventStartDateTime,
    required DateTime eventEndDateTime,
    required String eventType,
    required String eventDetails,
  }) async {
    final response = await DioFactory.postdata(
      url: EndPoints.calendar,
      data: {
        "event_name": eventName,
        "event_startdatetime": eventStartDateTime.toIso8601String(),
        "event_enddatetime": eventEndDateTime.toIso8601String(),
        "event_type": "event",
        "event_details": eventDetails,
        "student_id": Constants.studentId
      },
    );

    return response;
  }
}
