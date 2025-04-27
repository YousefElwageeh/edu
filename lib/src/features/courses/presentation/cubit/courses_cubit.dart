import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:edu/di.dart';
import 'package:edu/src/core/api/constant&endPoints.dart';
import 'package:edu/src/features/courses/data/models/course.dart';
import 'package:edu/src/features/courses/data/models/quizes.dart';
import 'package:edu/src/features/home/data/models/weekly_dead_lines.dart';
import 'package:edu/src/features/profile/data/models/courses.dart';
import 'package:edu/src/features/courses/data/repositories/course_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'courses_state.dart';

class CoursesCubit extends Cubit<CoursesState> {
  final CourseRepo repo;
  CoursesCubit(this.repo) : super(CoursesInitial());
  List<Subjects> courses = [];
  Future<void> getCourses() async {
    emit(CoursesLoading());
    try {
      final result =
          await repo.getCourses(StudentID: Constants.studentId ?? "");
      result.fold(
        (failure) => emit(CoursesError(failure.message)),
        (coursesData) {
          courses = coursesData;
          emit(CoursesLoaded(coursesData));
        },
      );
    } catch (e) {
      emit(CoursesError(e.toString()));
    }
  }

  List<Quizes> quizes = [];
  Future<void> getQuizes(
    String courseName,
  ) async {
    emit(const GetQuizes());
    try {
      final result = await repo.getQuizes(courseName: courseName);
      result.fold(
        (failure) => emit(GetQuizesError()),
        (quizesData) {
          quizes = quizesData;
          sections.elementAt(3)['items'] = quizes
              .map((e) =>
                  "Lecture ${e.courseId} ${e.course?.courseName ?? 'N/A'}")
              .toList();
          emit(GetQuizesLoaded());
        },
      );
    } catch (e) {
      log(e.toString());
      emit(GetQuizesError());
    }
  }

  List<Map<String, dynamic>> sections = [
    {
      'title': 'Lecture',
      'subtitle': 'bla blaa blaaa blaaa',
      'icon': Icons.menu_book_outlined,
      'color': const Color(0xFFB9B5FF),
      'border': const Color(0xFF7C7CFF),
      'items': <String>[""],
    },
    {
      'title': 'Section',
      'subtitle': 'bla blaa blaaa blaaa',
      'icon': Icons.receipt_long_outlined,
      'color': const Color(0xFFFFE5D1),
      'border': const Color(0xFFFFB385),
      'items': <String>[""],
    },
    {
      'title': 'Assignment',
      'subtitle': 'bla blaa blaaa blaaa',
      'icon': Icons.event_note_outlined,
      'color': const Color(0xFFD7FFE6),
      'border': const Color(0xFF43E58B),
      'items': <String>[""],
    },
    {
      'title': 'Quiz',
      'subtitle': 'bla blaa blaaa blaaa',
      'icon': Icons.quiz_outlined,
      'color': const Color(0xFFFFF3D1),
      'border': const Color(0xFFFFD85C),
      'items': <String>[""],
    },
    {
      'title': 'Project',
      'subtitle': 'bla blaa blaaa blaaa',
      'icon': Icons.insert_chart_outlined,
      'color': const Color(0xFFD7FFE6),
      'border': const Color(0xFF43E58B),
      'items': <String>[""],
    },
    {
      'title': 'Chat',
      'subtitle': 'bla blaa blaaa blaaa',
      'icon': Icons.chat_outlined,
      'color': const Color(0xFFB9B5FF),
      'border': const Color(0xFF7C7CFF),
      'items': <String>[""],
    },
  ];
}
