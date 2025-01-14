import 'dart:io';

class Image {
  final String path;
  final File imageFile;

  Image({required this.path}) : imageFile = File(path);
}
