import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class CameraManager {
  List<CameraDescription> _cameras = <CameraDescription>[];

  CameraManager._privateConstructor();

  static final CameraManager instance = CameraManager._privateConstructor();

  List<CameraDescription> get cameras => _cameras;

  init() async {
    try {
      _cameras = await availableCameras();
    } on CameraException catch (e) {
      print(e.description);
    }
  }
}

class CameraApp extends StatelessWidget {
  const CameraApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF5C795B),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop(); // Add navigation logic as needed
          },
        ),
        title: const Text('Home'),
        centerTitle: true,
      ),
      body: CameraPreviewScreen(cameras: CameraManager.instance.cameras),
    ));
  }
}
 
class CameraPreviewScreen extends StatefulWidget {
  final List<CameraDescription> cameras;

  const CameraPreviewScreen({
    Key? key,
    required this.cameras,
  }) : super(key: key);

  @override
  _CameraPreviewScreenState createState() => _CameraPreviewScreenState();
}

class _CameraPreviewScreenState extends State<CameraPreviewScreen> {
  late CameraController controller;

  @override
  void initState() {
    super.initState();
    controller = CameraController(widget.cameras[0], ResolutionPreset.max);
    controller.initialize().then((_) {
      if (!mounted) return;
      setState(() {});
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void _takePicture() async {
    try {
      final XFile file = await controller.takePicture();
      print('Picture saved at ${file.path}');

      // Save the image to a permanent location
      const String savedImagePath =
          'image.jpg'; // Replace with your desired path
      await file.saveTo(savedImagePath);
      print('Picture saved to: $savedImagePath');
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!controller.value.isInitialized) {
      return Container();
    }
    return Material(
        child: Stack(
      children: [
        Center(
          child: AspectRatio(
            aspectRatio: controller.value.aspectRatio,
            child: CameraPreview(controller),
          ),
        ),
        Align(
            alignment: Alignment.bottomCenter,
            child: ClipOval(
                child: Container(
                    color: Colors.white,
                    child: IconButton(
                      icon: const Icon(Icons.camera),
                      onPressed: _takePicture,
                    )))),
      ],
    ));
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CameraManager.instance.init();
  runApp(const CameraApp());
}
