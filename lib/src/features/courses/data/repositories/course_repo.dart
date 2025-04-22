import 'package:dartz/dartz.dart';
import 'package:edu/src/core/api/constant&endPoints.dart';
import 'package:edu/src/core/api/dio_factory.dart';
import 'package:edu/src/core/api/error_handler.dart';
import 'package:edu/src/core/api/failure.dart';
import 'package:edu/src/features/courses/data/datasources/courses_data_source.dart';
import 'package:edu/src/features/courses/data/models/course.dart';

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
}
