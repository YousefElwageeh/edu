import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:edu/di.dart';
import 'package:edu/src/core/api/constant&endPoints.dart';
import 'package:edu/src/core/app%20states/app_states.dart';
import 'package:edu/src/core/routes/app_router.dart';
import 'package:edu/src/core/routes/extensions.dart';
import 'package:edu/src/core/shared_prefrence/shared_prefrence.dart';
import 'package:edu/src/features/authntcation/data/repositories/login_repo.dart';
import 'package:edu/src/features/home/data/models/student_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

part 'authntcation_state.dart';

class AuthntcationCubit extends Cubit<AuthntcationState> {
  final LoginRepository repository;

  AuthntcationCubit({required this.repository}) : super(AuthntcationInitial());

  Future<void> login({
    required String studentId,
    required String password,
    required BuildContext context,
  }) async {
    emit(AuthntcationLoading());

    try {
      final result =
          await repository.login(studentId: studentId, password: password);
      result.fold((failure) {
        emit(AuthntcationError());
        AppStates.ErrorToast(failure.message);
      }, (student) {
        di<FlutterSecureStorage>()
            .write(key: PrefData.token, value: student.studentId.toString());

        Constants.studentId = student.studentId.toString();
        Constants.institutionId = student.institutionId.toString();
        Constants.studentName = student.studentName;
        log(student.studentName);
        di<FlutterSecureStorage>().write(
            key: PrefData.studentName, value: student.studentName.toString());
        di<FlutterSecureStorage>().write(
            key: PrefData.institutionId,
            value: student.institutionId.toString());
        context.goToAndReplaceUntil(Routes.layoutRoute,
            predicate: (route) => false);
        AppStates.SucessToast('Login Success');

        emit(AuthntcationSuccess(student));
      });
    } catch (e) {
      AppStates.ErrorToast("id or password is incorrect");
      emit(AuthntcationError());
    }
  }
}
