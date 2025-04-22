import 'package:dartz/dartz.dart';
import 'package:edu/src/core/api/error_handler.dart';
import 'package:edu/src/core/api/failure.dart';
import 'package:edu/src/features/authntcation/data/datasources/login_data_source.dart';
import 'package:edu/src/features/home/data/models/student_model.dart';

class LoginRepository {
  final LoginDataSource dataSource;

  LoginRepository({required this.dataSource});

  Future<Either<Failure, StudentModel>> login({
    required String studentId,
    required String password,
  }) async {
    try {
      final result =
          await dataSource.login(studentId: studentId, password: password);
      return Right(result);
    } catch (e) {
      return Left(ErrorHandler.handle(e).failure);
    }
  }
}
