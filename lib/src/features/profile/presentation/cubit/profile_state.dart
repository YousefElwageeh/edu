part of 'profile_cubit.dart';

abstract class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object> get props => [];
}

class ProfileInitial extends ProfileState {}

class ProfileLoading extends ProfileState {}

class ProfileError extends ProfileState {
  final String message;

  const ProfileError(this.message);

  @override
  List<Object> get props => [message];
}

class ProfileLoaded extends ProfileState {
  final List<TodaySchedule> todaySchedule;

  const ProfileLoaded(this.todaySchedule);

  @override
  List<Object> get props => [todaySchedule];
}
