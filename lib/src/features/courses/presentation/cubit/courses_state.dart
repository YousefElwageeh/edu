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

class GetLectures extends CoursesState {
  const GetLectures();
  @override
  List<Object> get props => [];
}

class GetLecturesLoaded extends CoursesState {}

class GetLecturesError extends CoursesState {}

class GetSections extends CoursesState {
  const GetSections();
  @override
  List<Object> get props => [];
}

class GetSectionsLoaded extends CoursesState {}

class GetSectionsError extends CoursesState {}
