part of 'permission_bloc.dart';

sealed class PermissionState extends Equatable {
  const PermissionState();

  @override
  List<Object> get props => [];
}

final class PermissionInitial extends PermissionState {}

class PermissionLoading extends PermissionState {}

class PermissionDenied extends PermissionState {}

class PermissionGranted extends PermissionState {}

class PermissionPermanentlyDenied extends PermissionState {}
