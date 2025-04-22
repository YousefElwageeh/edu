import 'package:edu/src/core/api/constant&endPoints.dart';
import 'package:edu/src/core/api/dio_factory.dart';
import 'package:edu/src/features/courses/data/models/course.dart';
import 'package:edu/src/features/profile/data/models/courses.dart';

class CoursesDataSource {
  Future<List<Subjects>> getCourses({required String StudentID}) async {
    final response = await DioFactory.getdata(
      url: EndPoints.enrollment,
      quary: {
        'select':
            'student_id,course(course_id,course_name,course_description),instructor(instructor_id,instructor_name)',
        "student_id": "eq.$StudentID"
      },
    );

    return (response.data as List).map((e) => Subjects.fromJson(e)).toList();
  }
}
