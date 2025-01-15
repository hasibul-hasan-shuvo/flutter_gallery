import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gallery/app/di/configureDependencies.dart';
import 'package:flutter_gallery/app/presentation/core/extensions/context_extensions.dart';
import 'package:flutter_gallery/app/presentation/modules/photos/view_model/photos_event.dart';
import 'package:flutter_gallery/app/presentation/modules/photos/view_model/photos_state.dart';
import 'package:flutter_gallery/app/presentation/modules/photos/view_model/photos_view_model.dart';
import 'package:flutter_gallery/app/presentation/modules/photos/widget/item_photo_grid_view.dart';

class PhotosPage extends StatelessWidget {
  final String albumName;

  const PhotosPage({
    super.key,
    required this.albumName,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<PhotosViewModel>()..add(FetchPhotosEvent(albumName)),
      child: Scaffold(
        appBar: AppBar(
          title: Text(albumName),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        body: BlocBuilder<PhotosViewModel, PhotosState>(
          builder: (context, state) {
            if (state is PhotosLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is PhotosLoaded) {
              return GridView.builder(
                padding: const EdgeInsets.all(8.0),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                ),
                itemCount: state.photos.length,
                itemBuilder: (context, index) {
                  final photo = state.photos[index];
                  return ItemPhotoGridView(photo: photo);
                },
              );
            } else if (state is PhotosError) {
              return Center(
                child: Text(
                  state.message,
                  style: context.textTheme.titleMedium?.copyWith(
                    color: context.colors.error,
                  ),
                ),
              );
            }
            return Center(
              child: Text(
                context.localizations.messageNoPhotosFound,
              ),
            );
          },
        ),
      ),
    );
  }
}
