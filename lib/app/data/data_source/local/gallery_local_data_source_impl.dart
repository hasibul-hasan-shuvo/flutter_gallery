import 'package:flutter/services.dart';
import 'package:flutter_gallery/app/data/data_source/local/gallery_local_data_source.dart';
import 'package:flutter_gallery/app/domain/model/album.dart';
import 'package:flutter_gallery/app/domain/model/photo.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: GalleryLocalDataSource)
class GalleryLocalDataSourceImpl implements GalleryLocalDataSource {
  static const platform = MethodChannel('com.example.flutter_gallery/gallery');

  @override
  Future<bool> checkGalleryPermission() {
    try {
      return platform.invokeMethod('checkPermissions').then((value) {
        return value as bool;
      });
    } on PlatformException catch (_) {
      return Future.value(false);
    }
  }

  @override
  Future<bool> requestGalleryPermission() {
    try {
      return platform.invokeMethod('requestPermissions').then((value) {
        return value as bool;
      });
    } on PlatformException catch (_) {
      return Future.value(false);
    }
  }

  @override
  Future<List<Album>> getAlbums() {
    try {
      return platform.invokeMethod('fetchAlbums').then((albums) {
        if (albums != null && albums is List) {
          List<Album> finalAlbums = [];

          for (var album in albums) {
            if (album['albumName'] != null &&
                album['albumName'] != '' &&
                album['thumbnailPath'] != null &&
                album['thumbnailPath'] != '') {
              finalAlbums.add(
                Album(
                  name: album['albumName'],
                  thumbnailPath: album['thumbnailPath'],
                  totalImageCount: album['totalImageCount'] ?? 0,
                ),
              );
            }
          }

          return finalAlbums;
        }

        return [];
      });
    } on PlatformException catch (_) {
      return Future.value([]);
    }
  }

  @override
  Future<List<Photo>> getImagesByAlbumName(String albumName) {
    try {
      return platform.invokeMethod(
        'fetchPhotos',
        {'albumName': albumName},
      ).then((images) {
        if (images != null && images is List) {
          List<Photo> finalImages = [];

          for (var image in images) {
            if (image != null && image != '') {
              finalImages.add(Photo(path: image));
            }
          }

          return finalImages;
        }

        return [];
      });
    } on PlatformException catch (_) {
      return Future.value([]);
    }
  }
}
