import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'src/app.dart';

Future<void> main() async {
  await dotenv.load(fileName: "config.env");
  runApp(const App());
}
