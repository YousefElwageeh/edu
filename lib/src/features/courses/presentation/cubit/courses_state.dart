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

class GetAssignments extends CoursesState {
  const GetAssignments();
  @override
  List<Object> get props => [];
}

class GetAssignmentsLoaded extends CoursesState {}

class GetAssignmentsError extends CoursesState {}

class GetProjects extends CoursesState {
  const GetProjects();
  @override
  List<Object> get props => [];
}

class GetProjectsLoaded extends CoursesState {}

class GetProjectsError extends CoursesState {}

class UplodeProject extends CoursesState {
  const UplodeProject();
  @override
  List<Object> get props => [];
}

class UplodeProjectLoaded extends CoursesState {}

class UplodeProjectError extends CoursesState {}

class UplodeAssignment extends CoursesState {
  const UplodeAssignment();
  @override
  List<Object> get props => [];
}

class UplodeAssignmentLoaded extends CoursesState {}

class UplodeAssignmentError extends CoursesState {}

class RecordQuizScore extends CoursesState {
  const RecordQuizScore();
  @override
  List<Object> get props => [];
}

class RecordQuizScoreLoaded extends CoursesState {}

class RecordQuizScoreError extends CoursesState {}
