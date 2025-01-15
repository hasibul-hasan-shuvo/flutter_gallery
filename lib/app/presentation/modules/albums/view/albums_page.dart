import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gallery/app/di/configureDependencies.dart';
import 'package:flutter_gallery/app/presentation/core/extensions/context_extensions.dart';
import 'package:flutter_gallery/app/presentation/core/utils/app_values.dart';
import 'package:flutter_gallery/app/presentation/modules/albums/view_model/albums_event.dart';
import 'package:flutter_gallery/app/presentation/modules/albums/view_model/albums_state.dart';
import 'package:flutter_gallery/app/presentation/modules/albums/view_model/albums_view_model.dart';
import 'package:flutter_gallery/app/presentation/modules/albums/widget/item_album_grid_view.dart';

class AlbumsPage extends StatelessWidget {
  const AlbumsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<AlbumsViewModel>()..add(FetchAlbumsEvent()),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            context.localizations.titleAlbums,
          ),
        ),
        body: BlocBuilder<AlbumsViewModel, AlbumsState>(
          builder: (context, state) {
            if (state is AlbumsLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is AlbumsLoaded) {
              return Padding(
                padding: const EdgeInsets.all(AppValues.padding),
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                  ),
                  itemCount: state.albums.length,
                  itemBuilder: (context, index) {
                    final album = state.albums[index];
                    return ItemAlbumGridView(album: album);
                  },
                ),
              );
            } else if (state is AlbumsError) {
              return Center(
                child: Text(
                  state.message,
                  style: context.textTheme.titleMedium
                      ?.copyWith(color: Colors.red),
                ),
              );
            }
            return Center(
              child: Text(
                context.localizations.messageNoAlbumsFound,
              ),
            );
          },
        ),
      ),
    );
  }
}
