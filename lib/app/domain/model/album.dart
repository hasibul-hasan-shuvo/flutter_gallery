import 'dart:io';

class Album {
  final String albumName;
  final String lastImagePath;
  final File lastImage;

  Album({
    required this.albumName,
    required this.lastImagePath,
  }) : lastImage = File(lastImagePath);
}
