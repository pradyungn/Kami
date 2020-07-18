import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class CameraView extends StatefulWidget {
  @override
  _CameraViewState createState() => _CameraViewState();
}

class _CameraViewState extends State<CameraView> {
  CameraController _cc;
  bool _hasCamera = false;
  bool _loading = false;

  @override
  void initState() {
    super.initState();
    () async {
      final cams = await availableCameras();
      final cam = cams.firstWhere(
              (cam) => cam.lensDirection == CameraLensDirection.back) ??
          cams.first;
      if (cam != null) {
        setState(() {
          _hasCamera = true;
          _cc = CameraController(cam, ResolutionPreset.medium,
              enableAudio: false);
          _cc.initialize();
        });
      }
      setState(() {
        _loading = false;
      });
    }();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Take a picture of text'),
      ),
      body: _getBody(),
      backgroundColor: Colors.black,
    );
  }

  Widget _getBody() {
    if (_loading) {
      return Center(
        child: CircularProgressIndicator(value: -1),
      );
    } else {
      if (_hasCamera) {
        return Center(
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              AspectRatio(
                child: CameraPreview(_cc),
                aspectRatio: _cc.value.aspectRatio ?? 1,
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: FloatingActionButton(
                  child: const Icon(Icons.camera_alt),
                  onPressed: () => print('Take picture'),
                ),
              ),
            ],
          ),
        );
      } else {
        return Center(
          child: Column(
            children: [
              const Icon(
                Icons.warning,
                color: Colors.yellow,
                size: 96,
              ),
              const Text('No camera found'),
            ],
          ),
        );
      }
    }
  }
}
