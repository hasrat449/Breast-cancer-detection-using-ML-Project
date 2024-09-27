import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:camera/camera.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomeScreen(cameras: [],),
      debugShowCheckedModeBanner: true,
    );
  }
}

class HomeScreen extends StatefulWidget {
  final List<CameraDescription> cameras;

  const HomeScreen({Key? key, required this.cameras}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Uint8List? _imageBytes;
  late CameraController _controller;

  @override
  void initState() {
    super.initState();
    _initializeCameraController();
  }

  Future<void> _initializeCameraController() async {
    _controller = CameraController(widget.cameras[0], ResolutionPreset.medium);

    try {
      await _controller.initialize();
      if (mounted) {
        setState(() {});
      }
    } catch (e) {
      print('Error initializing camera controller: $e');
    }
  }

  Future<void> _getImage(ImageSource source) async {
    if (source == ImageSource.camera) {
      var cameraStatus = await Permission.camera.request();
      if (cameraStatus != PermissionStatus.granted) {
        print('Camera permission denied');
        return;
      }
    }

    final picker = ImagePicker();
    try {
      final pickedFile = await picker.pickImage(source: source);

      if (pickedFile != null) {
        if (kIsWeb) {
          final bytes = await pickedFile.readAsBytes();
          setState(() {
            _imageBytes = bytes.buffer.asUint8List();
          });
        } else {
          setState(() {
            _imageBytes =
                File(pickedFile.path!).readAsBytesSync().buffer.asUint8List();
          });
        }
      }
    } catch (e) {
      print('Error picking image: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!_controller.value.isInitialized) {
      return Container();
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Screen'),
        backgroundColor: Color(0xFFfde4d2), // Set AppBar background color
      ),
      body: Container(
        color: Color(0xFFFFF7D9), // Set the background color
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Welcome to Your App!',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Container(
              height: 300,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
              ),
              child: _imageBytes != null
                  ? kIsWeb
                  ? Image.memory(
                _imageBytes!,
                fit: BoxFit.cover,
              )
                  : Image.memory(
                _imageBytes!,
                fit: BoxFit.cover,
              )
                  : const Center(
                child: Text('Select an image'),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () => _getImage(ImageSource.gallery),
                  child: const Text('Gallery'),
                  style: ElevatedButton.styleFrom(
                    primary: Color(0xFFfde4d2),
                    fixedSize: Size(130, 40), // Set button color
                  ),
                ),
                ElevatedButton(
                  onPressed: () => _getImage(ImageSource.camera),
                  child: const Text('Camera'),
                  style: ElevatedButton.styleFrom(
                    primary: Color(0xFFfde4d2),
                    fixedSize: Size(130, 40), // Set button color
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
