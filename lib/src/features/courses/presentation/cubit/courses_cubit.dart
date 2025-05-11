import 'dart:developer';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:edu/di.dart';
import 'package:edu/src/core/api/constant&endPoints.dart';
import 'package:edu/src/core/app%20states/app_states.dart';
import 'package:edu/src/core/routes/extensions.dart';
import 'package:edu/src/features/courses/data/models/answers_model.dart';
import 'package:edu/src/features/courses/data/models/course.dart';
import 'package:edu/src/features/courses/data/models/leactures.dart';
import 'package:edu/src/features/courses/data/models/project_model.dart';
import 'package:edu/src/features/courses/data/models/quizes.dart';
import 'package:edu/src/features/home/data/models/weekly_dead_lines.dart';
import 'package:edu/src/features/profile/data/models/courses.dart';
import 'package:edu/src/features/courses/data/repositories/course_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

part 'courses_state.dart';

class CoursesCubit extends Cubit<CoursesState> {
  final CourseRepo repo;
  CoursesCubit(this.repo) : super(CoursesInitial());
  List<Subjects> courses = [];
  Future<void> getCourses() async {
    emit(CoursesLoading());
    try {
      final result = await repo.getCourses();
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
    String courseid,
  ) async {
    emit(const GetQuizes());
    try {
      final result = await repo.getQuizes(courseid: courseid);
      result.fold(
        (failure) => emit(GetQuizesError()),
        (quizesData) async {
          quizes = quizesData;
          sections.elementAt(3)['items'] = quizes
              .map((e) =>
                  "Lecture ${e.courseId} ${e.course?.courseName ?? 'N/A'}")
              .toList();
          await checkForUnfinishedQuizzes();
          emit(GetQuizesLoaded());
        },
      );
    } catch (e) {
      log(e.toString());
      emit(GetQuizesError());
    }
  }

  Leactures leactures = Leactures();
  Future<void> getLectures(int courseid) async {
    emit(const GetLectures());
    try {
      final result = await repo.getLectures(courseid);
      result.fold(
        (failure) => emit(GetLecturesError()),
        (lecturesData) {
          leactures = lecturesData;
          sections.elementAt(0)['items'] = leactures.course?.session
                  ?.map((e) => "Lecture ${e.sessionId}")
                  .toList() ??
              [""];
          emit(GetLecturesLoaded());
        },
      );
    } catch (e) {
      log(e.toString());
      emit(GetLecturesError());
    }
  }

  Leactures sectionsMaterial = Leactures();

  Future<void> getSections(int courseid) async {
    emit(const GetSections());
    try {
      final result = await repo.getSections(courseid);
      result.fold(
        (failure) => emit(GetSectionsError()),
        (sectionsData) {
          sectionsMaterial = sectionsData;
          sections.elementAt(1)['items'] = sectionsMaterial.course?.session
                  ?.map((e) => "Section ${e.sessionId}")
                  .toList() ??
              [""];
          log(sectionsMaterial.course?.session.toString() ?? '');

          log(sections.elementAt(1)['items'].toString());
          emit(GetSectionsLoaded());
        },
      );
    } catch (e) {
      log(e.toString());
      emit(GetSectionsError());
    }
  }

  List<Assignment> assignments = [];
  Future<void> getAssignments(int courseid) async {
    emit(const GetProjects());
    try {
      final result = await repo.getAssignments(courseid);
      result.fold(
        (failure) => emit(GetAssignmentsError()),
        (assignmentsData) {
          assignments = assignmentsData;
          sections.elementAt(2)['items'] =
              assignments.map((e) => "Assignment ${e.assignId}").toList();

          emit(GetAssignmentsLoaded());
        },
      );
    } catch (e) {
      log(e.toString());
      emit(GetAssignmentsError());
    }
  }

  List<Projects> projects = [];
  Future<void> getProjects(int courseid) async {
    emit(const GetProjects());
    try {
      final result = await repo.getProjects(courseid);
      result.fold(
        (failure) => emit(GetProjectsError()),
        (projectsData) {
          projects = projectsData;
          sections.elementAt(4)['items'] =
              projects.map((e) => "Project ${e.activityTitle}").toList();
          emit(GetProjectsLoaded());
        },
      );
    } catch (e) {
      log(e.toString());
      emit(GetProjectsError());
    }
  }

  File? fileData;
  Future<void> uplodeProject(
      Assignment project, File file, BuildContext context) async {
    emit(const UplodeProject());
    try {
      final result = await repo.uplodeProject(project, file);
      result.fold(
        (failure) => emit(UplodeProjectError()),
        (projectsData) {
          sections.elementAt(4)['items'] =
              projects.map((e) => "Project ${e.activityTitle}").toList();
          AppStates.SucessToast("Assignment uploaded successfully");
          context.back();
          fileData = null;
          projects
              .firstWhere((e) => e.activityId == project.assignId)
              .isFinished = true;
          emit(UplodeProjectLoaded());
        },
      );
    } catch (e) {
      log(e.toString());
      AppStates.ErrorToast("Failed to upload project");
      emit(UplodeProjectError());
    }
  }

  Future<void> uplodeAssignment(
      Assignment assignment, File file, BuildContext context) async {
    emit(const UplodeProject());
    try {
      final result = await repo.uplodeAssignment(assignment, file);
      result.fold(
        (failure) => emit(UplodeAssignmentError()),
        (assignmentsData) {
          sections.elementAt(2)['items'] =
              assignments.map((e) => "Assignment ${e.assignId}").toList();
          fileData = null;
          AppStates.SucessToast("Assignment uploaded successfully");
          context.back();
          assignments
              .firstWhere((e) => e.assignId == assignment.assignId)
              .isFinished = true;
          emit(UplodeAssignmentLoaded());
        },
      );
    } catch (e) {
      log(e.toString());
      AppStates.ErrorToast("Failed to upload assignment");
      emit(UplodeAssignmentError());
    }
  }

  Future<void> recordQuizScore(List<Answers> answersData, String quizID) async {
    emit(const RecordQuizScore());
    try {
      final result = await repo.recordQuizScore(answersData, quizID);
      result.fold(
        (failure) => emit(RecordQuizScoreError()),
        (assignmentsData) {
          sections.elementAt(2)['items'] =
              assignments.map((e) => "Assignment ${e.assignId}").toList();
          quizes.firstWhere((e) => e.quizId.toString() == quizID).isFinished =
              true;

          emit(RecordQuizScoreLoaded());
        },
      );
    } catch (e) {
      log(e.toString());
      emit(RecordQuizScoreError());
    }
  }

  // Check for unfinished quizzes and record zero scores
  Future<void> checkForUnfinishedQuizzes() async {
    try {
      final storage = di<FlutterSecureStorage>();
      final allItems = await storage.readAll();

      // Filter for unfinished quiz keys
      final unfinishedQuizKeys = allItems.keys
          .where((key) =>
              key.startsWith('unfinished_quiz_') && !key.contains('course_'))
          .toList();

      for (final key in unfinishedQuizKeys) {
        // Extract quiz ID from the key
        final quizId = key.replaceFirst('unfinished_quiz_', '');
        final courseIdKey = 'unfinished_quiz_course_$quizId';
        final courseId = await storage.read(key: courseIdKey);

        // Only process quizzes for this course
        if (courseId == courseId.toString()) {
          log('Found unfinished quiz $quizId for course $courseId');

          // Record a zero score for this quiz
          await recordZeroScoreForQuiz(quizId);

          // Delete the unfinished quiz entries
          await storage.delete(key: key);
          await storage.delete(key: courseIdKey);
        }
      }
    } catch (e) {
      log('Error checking for unfinished quizzes: $e');
    }
  }

  Future<void> recordZeroScoreForQuiz(String quizId) async {
    try {
      // Wait for quizzes to load if needed
      await Future.delayed(const Duration(milliseconds: 500));

      // Find the quiz in the loaded quizzes
      final quizIndex =
          quizes.indexWhere((quiz) => quiz.quizId.toString() == quizId);

      if (quizIndex != -1) {
        final quiz = quizes[quizIndex];

        // Create zero-score answers for all questions
        final zeroScoreAnswers = List.generate(
          quiz.questions?.length ?? 0,
          (index) => Answers(isCorrect: false, degree: 0),
        );

        // Record the zero score
        await recordQuizScore(
          zeroScoreAnswers,
          quizId,
        );

        // Update the quiz score in the cubit's list
        quizes[quizIndex].score = '0';
        log('Recorded zero score for quiz $quizId');
      }
    } catch (e) {
      log('Error recording zero score for quiz $quizId: $e');
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
