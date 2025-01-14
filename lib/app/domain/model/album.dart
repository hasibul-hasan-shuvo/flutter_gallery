import 'dart:io';

class Album {
  final String albumName;
  final String thumbnailPath;
  final File thumbnail;
  final int totalImageCount;

  Album({
    required this.albumName,
    required this.thumbnailPath,
    required this.totalImageCount,
  }) : thumbnail = File(thumbnailPath);
}
