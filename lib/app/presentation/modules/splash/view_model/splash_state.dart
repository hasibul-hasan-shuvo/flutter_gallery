part of 'splash_view_model.dart';

abstract class SplashState {}

class SplashInitial extends SplashState {}

class SplashPermissionGranted extends SplashState {}

class SplashPermissionDenied extends SplashState {}

class SplashError extends SplashState {
  final String message;

  SplashError(this.message);
}
