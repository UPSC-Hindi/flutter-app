part of 'profile_cubit.dart';

@immutable
abstract class ProfileState {}

class ProfileInitial extends ProfileState {}

class ProfileLoading extends ProfileState {}

class ProfileSuccess extends ProfileState {
  final String profileImage;
  final String userName;
  ProfileSuccess({required this.profileImage, required this.userName});
}

class PrfileError extends ProfileState {}
