import 'package:flutter_gallery/app/presentation/modules/albums/view/albums_page.dart';
import 'package:flutter_gallery/app/presentation/modules/permission/view/permission_page.dart';
import 'package:flutter_gallery/app/presentation/modules/photo/view/photo_page.dart';
import 'package:flutter_gallery/app/presentation/modules/photos/view/photos_page.dart';
import 'package:flutter_gallery/app/presentation/modules/splash/view/splash_page.dart';
import 'package:go_router/go_router.dart';

part 'routes.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: _Paths.splash,
  routes: [
    GoRoute(
      path: _Paths.splash,
      name: AppRoutes.splash,
      builder: (context, state) => const SplashPage(),
    ),
    GoRoute(
      path: _Paths.permission,
      name: AppRoutes.permission,
      builder: (context, state) => const PermissionPage(),
    ),
    GoRoute(
      path: _Paths.albums,
      name: AppRoutes.albums,
      builder: (context, state) => const AlbumsPage(),
    ),
    GoRoute(
      path: _Paths.photos,
      name: AppRoutes.photos,
      builder: (context, state) {
        String albumName = state.pathParameters['albumName'] ?? '';
        return PhotosPage(albumName: albumName);
      },
    ),
    GoRoute(
      path: _Paths.photo,
      name: AppRoutes.photo,
      builder: (context, state) {
        String? photoPath = state.pathParameters['photoPath'];
        return PhotoPage(photoPath: photoPath);
      },
    ),
  ],
);
