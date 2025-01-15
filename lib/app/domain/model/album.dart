import 'dart:io';

class Album {
  final String name;
  final String thumbnailPath;
  final File thumbnail;
  final int totalImageCount;

  Album({
    required this.name,
    required this.thumbnailPath,
    required this.totalImageCount,
  }) : thumbnail = File(thumbnailPath);
}
