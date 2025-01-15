import 'package:flutter_gallery/app/data/data_source/local/gallery_local_data_source.dart';
import 'package:flutter_gallery/app/data/repository/gallery_repository_impl.dart';
import 'package:flutter_gallery/app/domain/model/album.dart';
import 'package:flutter_gallery/app/domain/model/photo.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'gallery_repository_test.mocks.dart';

@GenerateMocks([GalleryLocalDataSource])
void main() {
  late MockGalleryLocalDataSource mockLocalDataSource;
  late GalleryRepositoryImpl repository;

  setUp(() {
    mockLocalDataSource = MockGalleryLocalDataSource();
    repository = GalleryRepositoryImpl(mockLocalDataSource);
  });

  group('GetAlbums', () {
    test('Should return a list of albums when localDataSource provides data',
        () async {
      final expectedAlbums = [
        Album(
          name: 'Recents',
          thumbnailPath: '/var/mobile/Media/DCIM/100APPLE/IMG_0080.PNG',
          totalImageCount: 22,
        ),
        Album(
          name: 'Heir',
          thumbnailPath:
              '/var/mobile/Media/PhotoData/PhotoCloudSharingData/20507421539/0030859C-0D44-4C85-9A9D-E02C6CDC07F3/100CLOUD/IMG_0001.heic',
          totalImageCount: 1,
        ),
      ];

      when(mockLocalDataSource.getAlbums())
          .thenAnswer((_) async => expectedAlbums);

      final result = await repository.getAlbums();

      expect(result, expectedAlbums);
      verify(mockLocalDataSource.getAlbums()).called(1);
    });

    test('Should return an empty list when localDataSource returns empty',
        () async {
      when(mockLocalDataSource.getAlbums()).thenAnswer((_) async => []);

      final result = await repository.getAlbums();

      expect(result, isEmpty);
      verify(mockLocalDataSource.getAlbums()).called(1);
    });
  });

  group('GetImagesByAlbumName', () {
    const albumName = 'Recents';

    test('Should return a list of photos when localDataSource provides data',
        () async {
      final expectedPhotos = [
        Photo(path: '/var/mobile/Media/DCIM/100APPLE/IMG_0080.PNG'),
        Photo(
            path:
                '/var/mobile/Media/PhotoData/CPLAssets/group364/1A7690F1-7F06-4C4F-A233-5569A75EBA11.JPG'),
        Photo(path: '/var/mobile/Media/DCIM/100APPLE/IMG_0077.PNG'),
      ];

      when(mockLocalDataSource.getImagesByAlbumName(albumName))
          .thenAnswer((_) async => expectedPhotos);

      final result = await repository.getImagesByAlbumName(albumName);

      expect(result, expectedPhotos);
      verify(mockLocalDataSource.getImagesByAlbumName(albumName)).called(1);
    });

    test('Should return an empty list when localDataSource returns empty',
        () async {
      when(mockLocalDataSource.getImagesByAlbumName(albumName))
          .thenAnswer((_) async => []);

      final result = await repository.getImagesByAlbumName(albumName);

      expect(result, isEmpty);
      verify(mockLocalDataSource.getImagesByAlbumName(albumName)).called(1);
    });
  });
}
