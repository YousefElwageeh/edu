import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:edu/di.dart';
import 'package:edu/src/core/api/constant&endPoints.dart';
import 'package:edu/src/core/routes/app_router.dart';
import 'package:edu/src/core/routes/extensions.dart';
import 'package:edu/src/core/shared_prefrence/shared_prefrence.dart';
import 'package:edu/src/features/profile/data/models/courses.dart';
import 'package:edu/src/features/courses/presentation/cubit/courses_cubit.dart';
import 'package:edu/src/features/profile/data/repositories/profile_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileInitial());

  List<TodaySchedule> todaySchedule = [];
  ProfileRepo repo = di();

  Future<void> getTodaySchedule({
    DateTime? date,
  }) async {
    emit(ProfileLoading());
    try {
      final result = await repo.getTodaySchedule(
        date ?? DateTime.now(),
      );
      result.fold(
        (failure) => emit(ProfileError(failure.message)),
        (coursesData) {
          todaySchedule = coursesData;
          log(todaySchedule.length.toString());
          emit(ProfileLoaded(coursesData));
        },
      );
    } catch (e) {
      emit(ProfileError(e.toString()));
    }
  }

  Future<void> logout(BuildContext context) async {
    Constants.studentId = null;
    await di<FlutterSecureStorage>().delete(key: PrefData.token);
    context.goToAndReplaceUntil(Routes.loginRoute, predicate: (route) => false);
  }
}
