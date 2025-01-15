part of 'permission_view_model.dart';

abstract class PermissionState {}

class PermissionInitial extends PermissionState {}

class PermissionRequesting extends PermissionState {}

class PermissionGranted extends PermissionState {}

class PermissionDenied extends PermissionState {}
