import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gallery/app/di/configureDependencies.dart';
import 'package:flutter_gallery/app/presentation/core/utils/app_images.dart';
import 'package:flutter_gallery/app/presentation/core/utils/app_values.dart';
import 'package:flutter_gallery/app/presentation/core/widgets/asset_image_view.dart';
import 'package:flutter_gallery/app/presentation/modules/splash/view_model/splash_view_model.dart';
import 'package:flutter_gallery/app/presentation/routes/router.dart';
import 'package:go_router/go_router.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<SplashViewModel>()..add(CheckPermissionEvent()),
      child: Scaffold(
        body: BlocListener<SplashViewModel, SplashState>(
          listener: (context, state) {
            if (state is SplashPermissionGranted) {
              _navigateToNextPage(
                context,
                AppRoutes.albums,
              );
            } else if (state is SplashPermissionDenied) {
              _navigateToNextPage(
                context,
                AppRoutes.permission,
              );
            }
          },
          child: Center(
            child: AssetImageView(
              fileName: AppImages.logo,
              height: AppValues.logoHeight,
              fit: BoxFit.fitHeight,
            ),
          ),
        ),
      ),
    );
  }

  void _navigateToNextPage(BuildContext context, String route) {
    Timer(Duration(milliseconds: 500), () {
      context.goNamed(route);
    });
  }
}
