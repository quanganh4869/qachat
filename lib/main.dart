import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:whatapps/screens/CameraScreen.dart';
import 'package:whatapps/screens/homescreens.dart';

late List<CameraDescription> cameras;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  cameras = await availableCameras();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        fontFamily: 'OpenSans',
        primaryColor: Colors.green,
        colorScheme: ColorScheme.fromSwatch().copyWith(
          secondary: Colors.greenAccent,
        ),
      ),
      home: const Homescreens(), // ✅ Không cần truyền cameras
    );
  }
}
