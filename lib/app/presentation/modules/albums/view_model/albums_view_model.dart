import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gallery/app/domain/repository/gallery_repository.dart';
import 'package:injectable/injectable.dart';

import 'albums_event.dart';
import 'albums_state.dart';

@injectable
class AlbumsViewModel extends Bloc<AlbumsEvent, AlbumsState> {
  final GalleryRepository _galleryRepository;

  AlbumsViewModel(this._galleryRepository) : super(AlbumsInitial()) {
    on<FetchAlbumsEvent>(_onFetchAlbums);
  }

  Future<void> _onFetchAlbums(
      FetchAlbumsEvent event, Emitter<AlbumsState> emit) async {
    emit(AlbumsLoading());
    try {
      final albums = await _galleryRepository.getAlbums();
      emit(AlbumsLoaded(albums));
    } catch (e) {
      emit(AlbumsError(e.toString()));
    }
  }
}
