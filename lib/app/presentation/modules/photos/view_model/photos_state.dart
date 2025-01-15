import 'package:flutter_gallery/app/domain/model/photo.dart';

abstract class PhotosState {}

class PhotosInitial extends PhotosState {}

class PhotosLoading extends PhotosState {}

class PhotosLoaded extends PhotosState {
  final List<Photo> photos;

  PhotosLoaded(this.photos);
}

class PhotosError extends PhotosState {
  final String message;

  PhotosError(this.message);
}
