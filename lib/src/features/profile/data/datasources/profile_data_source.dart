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
}
