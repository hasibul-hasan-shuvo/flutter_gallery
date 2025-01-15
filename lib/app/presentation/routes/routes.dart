part of 'router.dart';

abstract class AppRoutes {
  static const String splash = 'splash';
  static const String permission = 'permission';
  static const String albums = 'albums';
  static const String photos = 'photos';
}

abstract class _Paths {
  static const String splash = '/splash';
  static const String permission = '/permission';
  static const String albums = '/albums';
  static const String photos = '/photos/:albumName';
}
