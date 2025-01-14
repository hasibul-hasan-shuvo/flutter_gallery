import 'package:flutter_gallery/app/data/data_source/local/gallery_local_data_source.dart';
import 'package:flutter_gallery/app/domain/model/album.dart';
import 'package:flutter_gallery/app/domain/model/image.dart';
import 'package:flutter_gallery/app/domain/repository/gallery_repository.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: GalleryRepository)
class GalleryRepositoryImpl implements GalleryRepository {
  final GalleryLocalDataSource localDataSource;

  GalleryRepositoryImpl(
    this.localDataSource,
  );

  @override
  Future<bool> checkGalleryPermission() {
    return localDataSource.checkGalleryPermission();
  }

  @override
  Future<bool> requestGalleryPermission() {
    return localDataSource.requestGalleryPermission();
  }

  @override
  Future<List<Album>> getAlbums() {
    return localDataSource.getAlbums();
  }

  @override
  Future<List<Image>> getImagesByAlbumName(String albumName) {
    return localDataSource.getImagesByAlbumName(albumName);
  }
}
