import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gallery/app/domain/repository/gallery_repository.dart';
import 'package:injectable/injectable.dart';

part 'permission_event.dart';
part 'permission_state.dart';

@injectable
class PermissionViewModel extends Bloc<PermissionEvent, PermissionState> {
  late final GalleryRepository _galleryRepository;

  PermissionViewModel({
    required GalleryRepository galleryRepository,
  }) : super(PermissionInitial()) {
    _galleryRepository = galleryRepository;
    on<RequestPermissionEvent>(_onRequestPermission);
  }

  Future<void> _onRequestPermission(
      RequestPermissionEvent event, Emitter<PermissionState> emit) async {
    try {
      final isGranted = await _galleryRepository.requestGalleryPermission();
      if (isGranted) {
        emit(PermissionGranted());
      } else {
        emit(PermissionDenied());
      }
    } catch (e) {
      emit(PermissionDenied());
    }
  }
}
