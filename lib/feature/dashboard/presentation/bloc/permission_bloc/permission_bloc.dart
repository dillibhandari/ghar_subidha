import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:permission_handler/permission_handler.dart';
part 'permission_event.dart';
part 'permission_state.dart';

class PermissionBloc extends Bloc<PermissionEvent, PermissionState> {
  PermissionBloc() : super(PermissionInitial()) {
    on<PermissionEvent>((event, emit) {});
    on<CheckPermission>(_checkPermission);
    on<OpenSettings>(_openSettings);
  }

  FutureOr<void> _checkPermission(
      CheckPermission event, Emitter<PermissionState> emit) async {
    final Permission permission = event.permissionType == Permission.camera
        ? Permission.camera
        : Permission.location;
    emit(PermissionLoading());
    if (await permission.isDenied) {
      final result = await permission.request();
      if (result.isGranted) {
        emit(PermissionGranted());
      } else if (result.isDenied) {
        emit(PermissionDenied());
      } else if (result.isPermanentlyDenied) {
        emit(PermissionPermanentlyDenied());
      }
    } else {
      if (await permission.isGranted) {
        emit(PermissionGranted());
      }
    }
  }

  FutureOr<void> _openSettings(
      OpenSettings event, Emitter<PermissionState> emit) {
    openAppSettings();
  }
}
