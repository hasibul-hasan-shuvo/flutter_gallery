import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gallery/app/domain/repository/gallery_repository.dart';
import 'package:injectable/injectable.dart';

part 'splash_event.dart';
part 'splash_state.dart';

@injectable
class SplashViewModel extends Bloc<SplashEvent, SplashState> {
  late final GalleryRepository _galleryRepository;

  SplashViewModel({
    required GalleryRepository galleryRepository,
  }) : super(SplashInitial()) {
    _galleryRepository = galleryRepository;
    on<CheckPermissionEvent>(_onCheckPermission);
  }

  Future<void> _onCheckPermission(
      CheckPermissionEvent event, Emitter<SplashState> emit) async {
    try {
      final isGranted = await _galleryRepository.checkGalleryPermission();
      if (isGranted) {
        emit(SplashPermissionGranted());
      } else {
        emit(SplashPermissionDenied());
      }
    } catch (e) {
      emit(SplashError(e.toString()));
    }
  }
}
