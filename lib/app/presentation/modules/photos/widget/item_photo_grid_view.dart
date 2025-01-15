import 'package:flutter/material.dart';
import 'package:flutter_gallery/app/domain/model/photo.dart';

class ItemPhotoGridView extends StatelessWidget {
  final Photo photo;

  const ItemPhotoGridView({
    super.key,
    required this.photo,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8.0),
      child: Image.file(
        photo.imageFile,
        fit: BoxFit.cover,
      ),
    );
  }
}
