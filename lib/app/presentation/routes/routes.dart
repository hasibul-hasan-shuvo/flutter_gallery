part of 'router.dart';

abstract class AppRoutes {
  static const String splash = 'splash';
  static const String permission = 'permission';
  static const String albums = 'albums';
  static const String photos = 'photos';
  static const String photo = 'photo';
}

abstract class _Paths {
  static const String splash = '/splash';
  static const String permission = '/permission';
  static const String albums = '/albums';
  static const String photos = '/photos/:albumName';
  static const String photo = '/photo/:photoPath';
}
