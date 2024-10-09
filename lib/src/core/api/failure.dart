import 'package:dio/dio.dart';

class Failure {
  int code; // 200, 201, 400, 303..500 and so on
  String message; // error , success
  Response<dynamic>? response; // error , success

  Failure(
    this.code,
    this.message,
    this.response,
  );
}
