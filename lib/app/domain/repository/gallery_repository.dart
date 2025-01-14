import 'package:flutter_gallery/app/domain/model/album.dart';

abstract class GalleryRepository {
  Future<List<Album>> getAlbums();
}
