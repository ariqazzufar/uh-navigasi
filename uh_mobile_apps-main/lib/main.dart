import 'package:flutter/material.dart';
import 'app.dart';

export 'app.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  PaintingBinding.instance.imageCache.maximumSize = 40;
  PaintingBinding.instance.imageCache.maximumSizeBytes = 20 * 1024 * 1024;
  runApp(const MyApp());
}
