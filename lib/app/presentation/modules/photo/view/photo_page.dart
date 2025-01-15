import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gallery/app/di/configureDependencies.dart';
import 'package:flutter_gallery/app/presentation/core/utils/app_values.dart';
import 'package:flutter_gallery/app/presentation/modules/photo/view_model/photo_view_model.dart';
import 'package:go_router/go_router.dart';

class PhotoPage extends StatelessWidget {
  final String? photoPath;

  const PhotoPage({
    super.key,
    required this.photoPath,
  });

  @override
  Widget build(BuildContext context) {
    print(photoPath);
    return BlocProvider(
      create: (_) => getIt<PhotoViewModel>(),
      child: Scaffold(
        body: Stack(
          children: [
            BlocListener<PhotoViewModel, PhotoState>(
              listener: (context, state) {},
              child: Container(
                color: Colors.black,
                child: Center(
                  child: photoPath != null
                      ? Image.file(
                          File(photoPath!),
                          fit: BoxFit.cover,
                        )
                      : Icon(
                          Icons.image_not_supported_outlined,
                          size: AppValues.logoHeight,
                        ),
                ),
              ),
            ),
            IconButton(
              onPressed: () {
                context.pop();
              },
              icon: Icon(
                Icons.chevron_left,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
