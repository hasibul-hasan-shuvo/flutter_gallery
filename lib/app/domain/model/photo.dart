import 'dart:io';

class Photo {
  final String path;
  final File imageFile;

  Photo({required this.path}) : imageFile = File(path);
}
