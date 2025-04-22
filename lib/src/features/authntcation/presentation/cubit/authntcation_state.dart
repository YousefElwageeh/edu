part of 'authntcation_cubit.dart';

abstract class AuthntcationState extends Equatable {
  const AuthntcationState();

  @override
  List<Object> get props => [];
}

class AuthntcationInitial extends AuthntcationState {}

class AuthntcationLoading extends AuthntcationState {}

class AuthntcationError extends AuthntcationState {}

class AuthntcationSuccess extends AuthntcationState {
  final StudentModel student;

  const AuthntcationSuccess(this.student);

  @override
  List<Object> get props => [student];
}
