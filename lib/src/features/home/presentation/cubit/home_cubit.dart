import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:edu/src/core/api/constant&endPoints.dart';
import 'package:edu/src/features/home/data/models/weekly_dead_lines.dart';
import 'package:edu/src/features/home/data/repositories/home_repository_impl.dart';
import 'package:equatable/equatable.dart';
import '../../data/models/student_model.dart';
import '../../data/repositories/home_repository_impl.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final HomeRepository repository;

  HomeCubit({required this.repository}) : super(HomeInitial());
  StudentModel student = StudentModel(
    studentId: 0,
    studentName: '',
    studentPassword: '',
    studentLevel: 0,
    studentMajor: '',
    studentCgpa: 0.0,
    institutionId: 0,
  );
  void getStudentData() {
    emit(HomeLoading());
    log("message");
    final result = repository
        .getStudentData(Constants.studentId!)
        .then((result) => result.fold(
              (failure) => emit(HomeError(failure.message)),
              (student) {
                this.student = student;
                emit(HomeLoaded(student));
              },
            ));
  }

  List<WeeklyDeadLines> deadlines = [];
  void getWeeklyDeadlines() async {
    emit(HomeLoadingWeeklyDeadlines(deadlines));
    final result = await repository.getWeeklyDeadlines(Constants.studentId!);
    result.fold((failure) => emit(HomeErrorWeeklyDeadlines(failure.message)),
        (deadlines) {
      this.deadlines = deadlines;
      emit(HomeLoadedWeeklyDeadlines(
        deadlines,
      ));
    });
  }
}
