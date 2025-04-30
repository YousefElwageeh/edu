import 'package:dartz/dartz.dart';
import 'package:edu/src/core/api/constant&endPoints.dart';
import 'package:edu/src/core/api/error_handler.dart';
import 'package:edu/src/core/api/failure.dart';
import 'package:edu/src/features/courses/data/datasources/courses_data_source.dart';
import 'package:edu/src/features/courses/data/models/course.dart';
import 'package:edu/src/features/courses/data/models/quizes.dart';
import 'package:edu/src/features/profile/data/models/courses.dart';
import 'package:edu/src/features/courses/data/models/leactures.dart';

class CourseRepo {
  final CoursesDataSource dataSource;
  CourseRepo(this.dataSource);

  Future<Either<Failure, List<Subjects>>> getCourses(
      {required String StudentID}) async {
    try {
      final response = await dataSource.getCourses(StudentID: StudentID);

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
}
