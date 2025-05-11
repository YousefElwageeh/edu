import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:edu/src/core/api/constant&endPoints.dart';
import 'package:edu/src/core/api/error_handler.dart';
import 'package:edu/src/core/api/failure.dart';
import 'package:edu/src/features/courses/data/datasources/courses_data_source.dart';
import 'package:edu/src/features/courses/data/models/answers_model.dart';
import 'package:edu/src/features/courses/data/models/course.dart';
import 'package:edu/src/features/courses/data/models/quizes.dart';
import 'package:edu/src/features/courses/data/models/leactures.dart';
import 'package:edu/src/features/courses/data/models/project_model.dart';
import 'package:edu/src/features/home/data/models/weekly_dead_lines.dart';

class CourseRepo {
  final CoursesDataSource dataSource;
  CourseRepo(this.dataSource);

  Future<Either<Failure, List<Subjects>>> getCourses() async {
    try {
      final response = await dataSource.getCourses();

      return Right(response);
    } catch (e) {
      return Left(ErrorHandler.handle(e).failure);
    }
  }

  Future<Either<Failure, List<Quizes>>> getQuizes(
      {required String courseid}) async {
    try {
      final response = await dataSource.getQuizes(courseid);

      return Right(response);
    } catch (e) {
      return Left(ErrorHandler.handle(e).failure);
    }
  }

  Future<Either<Failure, Leactures>> getLectures(int courseid) async {
    try {
      final response = await dataSource.getLectures(courseid);

      return Right(response);
    } catch (e) {
      return Left(ErrorHandler.handle(e).failure);
    }
  }

  Future<Either<Failure, Leactures>> getSections(int courseid) async {
    try {
      final response = await dataSource.getSections(courseid);

      return Right(response);
    } catch (e) {
      return Left(ErrorHandler.handle(e).failure);
    }
  }

  Future<Either<Failure, List<Projects>>> getProjects(int courseid) async {
    try {
      final response = await dataSource.getProjects(courseid);

      return Right(response);
    } catch (e) {
      return Left(ErrorHandler.handle(e).failure);
    }
  }

  Future<Either<Failure, List<Assignment>>> getAssignments(int courseid) async {
    try {
      final response = await dataSource.getAssignments(courseid);

      return Right(response);
    } catch (e) {
      return Left(ErrorHandler.handle(e).failure);
    }
  }

  Future<Either<Failure, void>> uplodeProject(
      Assignment project, File file) async {
    try {
      final response = await dataSource.uplodeProject(project, file);

      return Right(response);
    } catch (e) {
      return Left(ErrorHandler.handle(e).failure);
    }
  }

  Future<Either<Failure, void>> uplodeAssignment(
      Assignment assignment, File file) async {
    try {
      final response = await dataSource.uplodeAssignment(assignment, file);

      return Right(response);
    } catch (e) {
      return Left(ErrorHandler.handle(e).failure);
    }
  }

  Future<Either<Failure, void>> recordQuizScore(
      List<Answers> answersData, String quizID) async {
    try {
      final response = await dataSource.recordQuizScore(answersData, quizID);
      return Right(response);
    } catch (e) {
      return Left(ErrorHandler.handle(e).failure);
    }
  }
}
