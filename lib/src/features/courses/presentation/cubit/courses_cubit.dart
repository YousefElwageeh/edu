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
          emit(CoursesLoaded(
            courses,
          ));
        },
      );
    } catch (e) {
      log(e.toString());
      emit(GetQuizesError());
    }
  }
}
