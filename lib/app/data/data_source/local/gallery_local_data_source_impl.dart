import 'package:flutter_gallery/app/data/data_source/local/gallery_local_data_source.dart';
import 'package:flutter_gallery/app/domain/model/album.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: GalleryLocalDataSource)
class GalleryLocalDataSourceImpl implements GalleryLocalDataSource {
  @override
  Future<List<Album>> getAlbums() {
    return Future.value([]);
  }
}
