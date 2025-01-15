import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gallery/app/domain/repository/gallery_repository.dart';
import 'package:injectable/injectable.dart';

import 'photos_event.dart';
import 'photos_state.dart';

@injectable
class PhotosViewModel extends Bloc<PhotosEvent, PhotosState> {
  final GalleryRepository _galleryRepository;

  PhotosViewModel(this._galleryRepository) : super(PhotosInitial()) {
    on<FetchPhotosEvent>(_onFetchPhotos);
  }

  Future<void> _onFetchPhotos(
      FetchPhotosEvent event, Emitter<PhotosState> emit) async {
    emit(PhotosLoading());
    try {
      final photos =
          await _galleryRepository.getImagesByAlbumName(event.albumName);
      emit(PhotosLoaded(photos));
    } catch (e) {
      emit(PhotosError(e.toString()));
    }
  }
}
