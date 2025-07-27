import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

class CameraScreen extends StatefulWidget {
  final List<CameraDescription>? cameras;

  const CameraScreen({super.key, this.cameras});

  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  CameraController? _cameraController;
  Future<void>? _cameraValue;

  @override
  void initState() {
    super.initState();
    if (widget.cameras != null && widget.cameras!.isNotEmpty) {
      _cameraController =
          CameraController(widget.cameras![0], ResolutionPreset.high);
      _cameraValue = _cameraController!.initialize();
    }
  }

  @override
  void dispose() {
    _cameraController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.cameras == null || widget.cameras!.isEmpty) {
      return const Scaffold(
        body: Center(child: Text("No camera available")),
      );
    }

    return Scaffold(
      body: Stack(
        children: [
          FutureBuilder(
            future: _cameraValue,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return CameraPreview(_cameraController!);
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            },
          ),
          Positioned(
            bottom: 0.0,
            child: Container(
              color: Colors.black,
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.all(12),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.flash_off,
                            color: Colors.white, size: 28),
                        onPressed: () {
                          // TODO: Flash logic
                        },
                      ),
                      InkWell(
                        onTap: () {
                          // TODO: Capture photo
                        },
                        child: const Icon(Icons.panorama_fish_eye,
                            color: Colors.white, size: 70),
                      ),
                      IconButton(
                        icon: const Icon(Icons.flip_camera_ios,
                            color: Colors.white, size: 28),
                        onPressed: () {
                          // TODO: Switch camera
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    "Hold for Video, tap for photo",
                    style: TextStyle(color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
