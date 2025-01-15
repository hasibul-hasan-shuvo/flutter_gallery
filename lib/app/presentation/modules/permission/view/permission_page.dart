import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gallery/app/di/configureDependencies.dart';
import 'package:flutter_gallery/app/presentation/core/extensions/context_extensions.dart';
import 'package:flutter_gallery/app/presentation/core/utils/app_images.dart';
import 'package:flutter_gallery/app/presentation/core/utils/app_values.dart';
import 'package:flutter_gallery/app/presentation/core/widgets/asset_image_view.dart';
import 'package:flutter_gallery/app/presentation/modules/permission/view_model/permission_view_model.dart';

class PermissionPage extends StatelessWidget {
  const PermissionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<PermissionViewModel>(),
      child: Scaffold(
        body: BlocListener<PermissionViewModel, PermissionState>(
          listener: (context, state) {
            if (state is PermissionGranted) {
              // Navigate to albums
            } else if (state is PermissionDenied) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    context.localizations.messagePermissionDenied,
                  ),
                  behavior: SnackBarBehavior.floating,
                ),
              );
            }
          },
          child: BlocBuilder<PermissionViewModel, PermissionState>(
            builder: (context, state) {
              return Padding(
                padding: const EdgeInsets.all(AppValues.padding),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    AssetImageView(
                      fileName: AppImages.permissionPageLogo,
                      height: AppValues.logoHeight,
                      fit: BoxFit.fitHeight,
                    ),
                    const SizedBox(height: AppValues.largeMargin),
                    Text(
                      context.localizations.titlePermissionPage,
                      style: context.textTheme.titleMedium,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: AppValues.halfMargin),
                    Text(
                      context.localizations.messagePermissionPage,
                      style: context.textTheme.bodyMedium,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: AppValues.largeMargin),
                    ElevatedButton(
                      onPressed: () {
                        context
                            .read<PermissionViewModel>()
                            .add(RequestPermissionEvent());
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.greenAccent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24),
                        ),
                        padding: const EdgeInsets.all(AppValues.buttonPadding),
                      ),
                      child: Text(
                        context.localizations.buttonTextPermissionAccess,
                        style: context.textTheme.titleMedium,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
