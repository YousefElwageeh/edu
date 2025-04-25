part of 'home_cubit.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeLoaded extends HomeState {
  final StudentModel student;

  const HomeLoaded(this.student);

  @override
  List<Object> get props => [student];
}

class HomeError extends HomeState {
  final String message;

  const HomeError(this.message);

  @override
  List<Object> get props => [message];
}

class HomeLoadingWeeklyDeadlines extends HomeState {
  final List<WeeklyDeadLines> deadlines;

  const HomeLoadingWeeklyDeadlines(this.deadlines);

  @override
  List<Object> get props => [deadlines];
}

class HomeLoadedWeeklyDeadlines extends HomeState {
  final List<WeeklyDeadLines> deadlines;

  const HomeLoadedWeeklyDeadlines(this.deadlines);

  @override
  List<Object> get props => [deadlines];
}

class HomeErrorWeeklyDeadlines extends HomeState {
  final String message;

  const HomeErrorWeeklyDeadlines(this.message);

  @override
  List<Object> get props => [message];
}
