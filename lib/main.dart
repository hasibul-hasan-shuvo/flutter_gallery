import 'package:flutter/material.dart';
import 'package:flutter_gallery/app/app.dart';
import 'package:flutter_gallery/app/di/configureDependencies.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await configureDependencies();

  runApp(const App());
}
