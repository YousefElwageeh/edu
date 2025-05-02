import 'dart:io';

import 'package:edu/src/core/api/constant&endPoints.dart';
import 'package:edu/src/core/api/dio_factory.dart';
import 'package:edu/src/features/courses/data/models/answers_model.dart';
import 'package:edu/src/features/courses/data/models/course.dart';
import 'package:edu/src/features/courses/data/models/project_model.dart';
import 'package:edu/src/features/courses/data/models/quizes.dart';
import 'package:edu/src/features/home/data/models/weekly_dead_lines.dart';
import 'package:edu/src/features/profile/data/models/courses.dart';
import 'package:edu/src/features/courses/data/models/leactures.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

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
    final response = await Supabase.instance.client
        .from("quiz")
        .select("*")
        .eq("course_id", courseid);

    final response2 = await Supabase.instance.client
        .from("student_quiz")
        .select("*")
        .eq("student_id", Constants.studentId!);

    List<Quizes> quizes =
        (response as List).map((e) => Quizes.fromJson(e)).toList();

    for (var element in quizes) {
      element.isFinished = response2.any((e) => e['quiz_id'] == element.quizId);
    }

    return quizes;
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

  Future<List<Assignment>> getAssignments(int courseid) async {
    final response = await Supabase.instance.client
        .from("assignment")
        .select("*")
        .eq("course_id", courseid);

    final response2 = await Supabase.instance.client
        .from("student_assignment")
        .select("*")
        .eq("student_id", Constants.studentId!);

    List<Assignment> assignments =
        (response as List).map((e) => Assignment.fromJson(e)).toList();

    for (var element in assignments) {
      element.isFinished =
          response2.any((e) => e['assign_id'] == element.assignId);
    }

    return assignments;
  }

  Future<List<Projects>> getProjects(int courseid) async {
    final response = await Supabase.instance.client
        .from("course_activity")
        .select("*")
        .eq("course_id", courseid);
    if (response.isEmpty) {
      return [];
    }
    final activityIds = response.map((e) => e['activity_id']).toList();

    final activities = await Supabase.instance.client
        .from("activity")
        .select("*")
        .inFilter("activity_id", activityIds);

    final response2 = await Supabase.instance.client
        .from("student_activity")
        .select("*")
        .eq("student_id", Constants.studentId!);

    List<Projects> projects =
        (activities as List).map((e) => Projects.fromJson(e)).toList();

    for (var element in projects) {
      element.isFinished =
          response2.any((e) => e['activity_id'] == element.activityId);
    }

    return projects;
  }

  Future<void> uplodeAssignment(Assignment assignment, File file) async {
    String url = await Supabase.instance.client.storage
        .from("students-assignments")
        .upload(file.path, file);

    final response =
        await Supabase.instance.client.from("student_assignment").insert([
      {
        "student_id": Constants.studentId,
        "assign_id": assignment.assignId,
        "assignment_path": url,
      }
    ]);
  }

  Future<void> uplodeProject(Assignment project, File file) async {
    String url = await Supabase.instance.client.storage
        .from("students-activities")
        .upload(file.path, file);

    final response =
        await Supabase.instance.client.from("student_activity").insert([
      {
        "student_id": Constants.studentId,
        "activity_id": project.assignId,
        "teamid": 1,
        "activity_path": url,
      }
    ]);
  }

  Future<void> recordQuizScore(List<Answers> answersData, String quizID) async {
    final response =
        await Supabase.instance.client.from("student_quiz").insert([
      {
        "student_id": Constants.studentId,
        "quiz_id": quizID,
        "score":
            answersData.where((element) => element.isCorrect == true).length,
        "percentage":
            (answersData.where((element) => element.isCorrect == true).length /
                    answersData.length) *
                100,
      }
    ]);
  }
}
