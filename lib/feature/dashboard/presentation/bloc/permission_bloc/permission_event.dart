part of 'permission_bloc.dart';

sealed class PermissionEvent extends Equatable {
  const PermissionEvent();

  @override
  List<Object> get props => [];
}

class CheckPermission extends PermissionEvent {
  final Permission permissionType;
  const CheckPermission(this.permissionType);
}

class OpenSettings extends PermissionEvent{}