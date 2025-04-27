import 'package:edu/src/core/api/constant&endPoints.dart';
import 'package:edu/src/core/api/dio_factory.dart';
import 'package:edu/src/features/courses/data/models/course.dart';
import 'package:edu/src/features/courses/data/models/quizes.dart';
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

  Future<List<Quizes>> getQuizes(String courseName) async {
    final response = await DioFactory.getdata(
      url: EndPoints.quiz,
      quary: {
        'select': '*,course(course_name),student(student_id,student_name)',
        "student.student_id": "eq.${Constants.studentId}",
        "student": "not.is.null",
        "course.course_name": "eq.$courseName",
        "course": "not.is.null"
      },
    );

    return (response.data as List).map((e) => Quizes.fromJson(e)).toList();
  }
}
