abstract class PhotosEvent {}

class FetchPhotosEvent extends PhotosEvent {
  final String albumName;

  FetchPhotosEvent(this.albumName);
}
