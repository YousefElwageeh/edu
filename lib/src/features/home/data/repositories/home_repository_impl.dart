import 'package:dartz/dartz.dart';
import 'package:edu/src/core/api/error_handler.dart';
import 'package:edu/src/core/api/failure.dart';
import 'package:edu/src/features/home/data/models/weekly_dead_lines.dart';
import '../datasources/home_remote_data_source.dart';
import '../models/student_model.dart';

class HomeRepository {
  final HomeRemoteDataSource remoteDataSource;

  HomeRepository({required this.remoteDataSource});

  Future<Either<Failure, StudentModel>> getStudentData(String studentId) async {
    try {
      final result = await remoteDataSource.getStudentData(studentId);
      return Right(result);
    } catch (e) {
      return Left(ErrorHandler.handle(e).failure);
    }
  }

  Future<Either<Failure, List<WeeklyDeadLines>>> getWeeklyDeadlines(
      String studentId) async {
    try {
      final result = await remoteDataSource.getWeeklyDeadlines(studentId);
      return Right(result);
    } catch (e) {
      return Left(ErrorHandler.handle(e).failure);
    }
  }
}
