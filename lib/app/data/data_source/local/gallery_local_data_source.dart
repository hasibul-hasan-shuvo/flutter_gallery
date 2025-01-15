import 'package:flutter_gallery/app/domain/model/album.dart';
import 'package:flutter_gallery/app/domain/model/photo.dart';

abstract class GalleryLocalDataSource {
  Future<bool> checkGalleryPermission();
  Future<bool> requestGalleryPermission();
  Future<List<Album>> getAlbums();
  Future<List<Photo>> getImagesByAlbumName(String albumName);
}
