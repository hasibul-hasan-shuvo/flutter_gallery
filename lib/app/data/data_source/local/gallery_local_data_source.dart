import 'package:flutter_gallery/app/domain/model/album.dart';

abstract class GalleryLocalDataSource {
  Future<List<Album>> getAlbums();
}
