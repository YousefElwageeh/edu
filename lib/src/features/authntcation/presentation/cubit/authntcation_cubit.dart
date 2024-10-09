import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'authntcation_state.dart';

class AuthntcationCubit extends Cubit<AuthntcationState> {
  AuthntcationCubit() : super(AuthntcationInitial());
}
