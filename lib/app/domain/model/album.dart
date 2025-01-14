import 'dart:io';

class Album {
  final String albumName;
  final String thumbnailPath;
  final File thumbnail;

  Album({
    required this.albumName,
    required this.thumbnailPath,
  }) : thumbnail = File(thumbnailPath);
}
