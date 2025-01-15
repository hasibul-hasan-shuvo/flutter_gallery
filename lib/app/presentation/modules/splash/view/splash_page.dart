import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gallery/app/di/configureDependencies.dart';
import 'package:flutter_gallery/app/presentation/core/utils/app_images.dart';
import 'package:flutter_gallery/app/presentation/core/utils/app_values.dart';
import 'package:flutter_gallery/app/presentation/core/widgets/asset_image_view.dart';
import 'package:flutter_gallery/app/presentation/modules/splash/view_model/splash_viewmodel.dart';

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
              print("Permission granted");
            } else if (state is SplashPermissionDenied) {
              print("Permission denied");
            }
          },
          child: Center(
            child: AssetImageView(
              fileName: AppImages.logo,
              height: AppValues.splashLogoHeight,
              fit: BoxFit.fitHeight,
            ),
          ),
        ),
      ),
    );
  }
}
