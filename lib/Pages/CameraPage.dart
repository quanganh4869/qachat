import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:whatapps/screens/CameraScreen.dart';

class CameraPage extends StatelessWidget {
  final List<CameraDescription>? cameras;

  const CameraPage({super.key, this.cameras});

  @override
  Widget build(BuildContext context) {
    return CameraScreen(cameras: cameras); 
  }
}
