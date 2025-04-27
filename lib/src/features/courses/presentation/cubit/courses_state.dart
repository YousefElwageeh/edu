part of 'courses_cubit.dart';

abstract class CoursesState extends Equatable {
  const CoursesState();

  @override
  List<Object> get props => [];
}

class CoursesInitial extends CoursesState {}

class CoursesLoading extends CoursesState {}

class CoursesLoaded extends CoursesState {
  final List<Subjects> courses;
  const CoursesLoaded(this.courses);

  @override
  List<Object> get props => [courses];
}

class CoursesError extends CoursesState {
  final String message;
  const CoursesError(this.message);
}

class GetQuizes extends CoursesState {
  const GetQuizes();
  @override
  List<Object> get props => [];
}

class GetQuizesLoaded extends CoursesState {}

class GetQuizesError extends CoursesState {}
