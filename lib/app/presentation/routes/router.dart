import 'package:flutter_gallery/app/presentation/modules/home/home_page.dart';
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
      path: _Paths.home,
      name: AppRoutes.home,
      builder: (context, state) => HomePage(),
    ),
  ],
);
