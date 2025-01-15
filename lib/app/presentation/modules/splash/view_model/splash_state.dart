part of 'splash_viewmodel.dart';

abstract class SplashState {}

class SplashInitial extends SplashState {}

class SplashPermissionGranted extends SplashState {}

class SplashPermissionDenied extends SplashState {}

class SplashError extends SplashState {
  final String message;

  SplashError(this.message);
}
