import 'package:dartz/dartz.dart';
import 'package:edu/src/core/api/error_handler.dart';
import 'package:edu/src/core/api/failure.dart';
import 'package:edu/src/features/profile/data/models/courses.dart';
import 'package:edu/src/features/profile/data/datasources/profile_data_source.dart';

class ProfileRepo {
  final ProfileDataSource dataSource;
  ProfileRepo(this.dataSource);

  Future<Either<Failure, List<TodaySchedule>>> getTodaySchedule(
      DateTime date) async {
    try {
      final response = await dataSource.getTodaySchedule(date);
      return Right(response);
    } catch (e) {
      return Left(ErrorHandler.handle(e).failure);
    }
  }
}
