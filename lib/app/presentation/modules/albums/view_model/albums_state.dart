import 'package:flutter_gallery/app/domain/model/album.dart';

abstract class AlbumsState {}

class AlbumsInitial extends AlbumsState {}

class AlbumsLoading extends AlbumsState {}

class AlbumsLoaded extends AlbumsState {
  final List<Album> albums;

  AlbumsLoaded(this.albums);
}

class AlbumsError extends AlbumsState {
  final String message;

  AlbumsError(this.message);
}
