import 'package:flutter_gallery/app/presentation/modules/home/home_page.dart';
import 'package:go_router/go_router.dart';

part 'routes.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: _Paths.home,
  routes: [
    GoRoute(
      path: _Paths.home,
      name: AppRoutes.home,
      builder: (context, state) => HomePage(),
    ),
  ],
);
