import 'package:flutter_gallery/app/domain/model/album.dart';
import 'package:flutter_gallery/app/domain/model/image.dart';

abstract class GalleryRepository {
  Future<bool> checkGalleryPermission();
  Future<bool> requestGalleryPermission();
  Future<List<Album>> getAlbums();
  Future<List<Image>> getImagesByAlbumName(String albumName);
}
