import 'package:edu/src/core/api/constant&endPoints.dart';
import 'package:edu/src/core/api/dio_factory.dart';
import 'package:edu/src/features/courses/data/models/course.dart';
import 'package:edu/src/features/courses/data/models/quizes.dart';
import 'package:edu/src/features/profile/data/models/courses.dart';
import 'package:edu/src/features/courses/data/models/leactures.dart';

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

  Future<List<Quizes>> getQuizes(String courseid) async {
    final response = await DioFactory.getdata(
      url: EndPoints.quiz,
      quary: {
        'select': '*,course(course_name),student(student_id,student_name)',
        "student.student_id": "eq.${Constants.studentId}",
        "student": "not.is.null",
        "course.course_id": "eq.$courseid",
        "course": "not.is.null"
      },
    );

    return (response.data as List).map((e) => Quizes.fromJson(e)).toList();
  }

  Future<Leactures> getLectures(int courseid) async {
    final response = await DioFactory.getdata(
      url: EndPoints.enrollment,
      quary: {
        'select':
            'student:student_id(student_id,student_name),course:course_id(course_id,course_name,instructor(instructor_name),session!inner(session_id,session_type,session_file_path))',
        "student_id": "eq.${Constants.studentId}",
        "student": "not.is.null",
        "course.session.session_type": "eq.lecture",
        "course.course_id": "eq.$courseid",
        "course": "not.is.null"
      },
    );

    return Leactures.fromJson(response.data[0]);
  }

  Future<Leactures> getSections(int courseid) async {
    final response = await DioFactory.getdata(
      url: EndPoints.enrollment,
      quary: {
        'select':
            'student:student_id(student_id,student_name),course:course_id(course_id,course_name,instructor(instructor_name),session!inner(session_id,session_type,session_file_path))',
        "student_id": "eq.${Constants.studentId}",
        "student": "not.is.null",
        "course.session.session_type": "eq.section",
        "course.course_id": "eq.$courseid",
        "course": "not.is.null"
      },
    );

    return Leactures.fromJson(response.data[0]);
  }
}
