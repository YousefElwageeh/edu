import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'courses_state.dart';

class CoursesCubit extends Cubit<CoursesState> {
  CoursesCubit() : super(CoursesInitial());
}
