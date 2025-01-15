import 'package:flutter/material.dart';
import 'package:flutter_gallery/app/domain/model/album.dart';
import 'package:flutter_gallery/app/presentation/core/extensions/context_extensions.dart';
import 'package:flutter_gallery/app/presentation/core/utils/app_values.dart';

class AlbumCardView extends StatelessWidget {
  final Album album;

  const AlbumCardView({
    super.key,
    required this.album,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(AppValues.halfRadius),
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image.file(
            album.thumbnail,
            fit: BoxFit.cover,
          ),
          Positioned(
            child: Container(
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: Colors.black54,
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    album.name,
                    style: context.textTheme.titleSmall?.copyWith(
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    '${album.totalImageCount} ${context.localizations.photos}',
                    style: context.textTheme.bodySmall?.copyWith(
                      color: Colors.white70,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
