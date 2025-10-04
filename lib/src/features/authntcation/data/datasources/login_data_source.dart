import 'package:edu/src/core/api/constant&endPoints.dart';
import 'package:edu/src/core/api/dio_factory.dart';
import 'package:edu/src/features/home/data/models/student_model.dart';

class LoginDataSource {
  Future<StudentModel> login({
    required String studentId,
    required String password,
  }) async {
    final response =
        await DioFactory.dio.get(EndPoints.student, queryParameters: {
      "student_id": "eq.$studentId",
      "student_password": "eq.$password",
    });

    return StudentModel.fromJson(
      (response.data as List).first,
    );
  }
}
