import 'dart:io';

import 'package:flutter/services.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:trucker_app/config.dart';
import 'package:animated_button/animated_button.dart';
import 'package:trucker_app/screens/pic_preview.dart';

final GlobalKey<ScaffoldState> cameraKey = GlobalKey<ScaffoldState>();
CameraController? cameraController;

class PiecePhotoScreen extends StatefulWidget {
  const PiecePhotoScreen({Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() => _PiecePhotoScreenState();
}

class _PiecePhotoScreenState extends State<PiecePhotoScreen> {
  late InputImageRotation rotation;
  bool isReady = false;

  @override
  void initState() {
    WidgetsFlutterBinding.ensureInitialized();
    super.initState();
    _initializeCamera();
  }

  static Future<CameraDescription> getCamera(CameraLensDirection dir) async {
    return await availableCameras().then(
      (List<CameraDescription> cameras) => cameras.firstWhere(
        (CameraDescription camera) => camera.lensDirection == dir,
      ),
    );
  }

  void _initializeCamera() async {
    try {
      final CameraDescription description =
          await getCamera(CameraLensDirection.back);

      cameraController = CameraController(
        description,
        ResolutionPreset.max,
      );
      await cameraController!.initialize();
      await cameraController!
          .lockCaptureOrientation(DeviceOrientation.portraitUp);
    } on CameraException catch (_) {
      // do something on error.
    }
    if (!mounted) return;
    setState(() {
      isReady = true;
    });
  }

  void onCameraButtonPress() async {
    // camera!.stopImageStream();
    HapticFeedback.heavyImpact();

    try {
      if (!cameraController!.value.isInitialized) {
        showInSnackBar('Error: select a camera first.');
        return null;
      }

      final image = await cameraController!.takePicture();
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => PicturePreviewScreen(
            // Pass the automatically generated path to
            // the DisplayPictureScreen widget.
            imagePath: image.path,
          ),
        ),
      );
    } on CameraException catch (e) {
      _showCameraException(e);
      return null;
    } catch (e) {}
  }

  Widget _buildImage() {
    final size = MediaQuery.of(context).size;
    double scale = cameraController != null
        ? size.aspectRatio * cameraController!.value.aspectRatio
        : 1;
    if (scale < 1) scale = 1 / scale;

    return Container(
      constraints: const BoxConstraints.expand(),
      child: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Transform.scale(
            scale: scale ?? 1,
            child: Center(
              child: isReady == false
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : CameraPreview(cameraController!),
            ),
          ),
        ],
      ),
    );
  }

  Widget _mainContainer() {
    return Stack(
      children: [
        Center(
          child: _buildImage(),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: AnimatedButton(
              child: const Icon(CupertinoIcons.camera),
              color: Colors.lightGreen,
              shape: BoxShape.circle,
              onPressed: onCameraButtonPress),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        transitionBetweenRoutes: true,
        backgroundColor:
            CupertinoTheme.of(context).barBackgroundColor.withOpacity(0.6),
        leading: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: onBackPressed,
              child: const Icon(
                CupertinoIcons.back,
                color: blueColor,
              ),
            ),
            GestureDetector(
              onTap: onBackPressed,
              child: const Text(
                'Ladung',
                style: topBarTextStyle,
              ),
            ),
          ],
        ),
      ),
      child: _mainContainer(),
    );
  }

  void showInSnackBar(String message) {}

  void _showCameraException(CameraException e) {
    showInSnackBar('Error: ${e.code}\n${e.description}');
  }

  Future<bool> onBackPressed() {
    Navigator.pop(context);

    return Future.value(false);
  }

  @override
  void dispose() {
    super.dispose();
  }
}
