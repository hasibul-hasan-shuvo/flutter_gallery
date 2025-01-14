import 'package:flutter_gallery/app/data/data_source/local/gallery_local_data_source.dart';
import 'package:flutter_gallery/app/domain/model/album.dart';
import 'package:flutter_gallery/app/domain/repository/gallery_repository.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: GalleryRepository)
class GalleryRepositoryImpl implements GalleryRepository {
  final GalleryLocalDataSource localDataSource;

  GalleryRepositoryImpl(
    @Named('localDataSource') this.localDataSource,
  );

  @override
  Future<List<Album>> getAlbums() {
    return localDataSource.getAlbums();
  }
}
