import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:trucker_app/config.dart';
import 'package:trucker_app/utils/barcode_detector_painter.dart';
import 'package:trucker_app/utils/ml_kit_ocr.dart';
import 'package:vibration/vibration.dart';

import 'piece_details.dart';

final GlobalKey<ScaffoldState> cameraKey = GlobalKey<ScaffoldState>();
CameraController? camera;

class CameraStream extends StatefulWidget {
  CameraStream({Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() => _CameraStreamState();
}

class _CameraStreamState extends State<CameraStream> {
  // Init
  // future temporary ocr scan results
  dynamic _scanResults;
  CustomPaint? customPaint;
  late String master;

  // temporary state that allows only ocr when previous task finished
  bool _isDetecting = false;
  // specifies which type should be detected e.g ocr, barcode, face, label
  final BarcodeScanner _barcodeScanner = GoogleMlKit.vision.barcodeScanner();
  String timestamp() => DateTime.now().millisecondsSinceEpoch.toString();
  late String imagePath;
  late InputImageRotation rotation;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  void _initializeCamera() async {
    final CameraDescription description =
        await OcrUtils.getCamera(CameraLensDirection.back);

    camera = CameraController(
      description,
      ResolutionPreset.max,
    );
    await camera!.initialize();
    await camera!.lockCaptureOrientation(DeviceOrientation.portraitUp);
    camera!.startImageStream((CameraImage image) async {
      if (_isDetecting) return;
      _isDetecting = true;
      // do OCRs
      OcrUtils.detect(
        image: image,
        detectInImage: _barcodeScanner.processImage,
        imageRotation: description.sensorOrientation,
      ).then(
        (dynamic results) {
          rotation = OcrUtils.rotationIntToImageRotation(
              description.sensorOrientation);
          if (mounted) {
            setState(() {
              _scanResults = results;
            });
          }
        },
      ).whenComplete(() {
        _isDetecting = false;
      });
    });
  }

  void onCameraButtonPress() async {
    HapticFeedback.heavyImpact();

    try {
      if (!camera!.value.isInitialized) {
        showInSnackBar('Error: select a camera first.');
        return null;
      }

      closeCameraAndStream();

      SchedulerBinding.instance!.addPostFrameCallback((_) {
        // add your code here.
        Navigator.popAndPushNamed(context, '/piece');
      });
    } on CameraException catch (e) {
      _showCameraException(e);
      return null;
    } catch (e) {
      // If an error occurs, log the error to the console.
    }
  }

  Widget _buildResults() {
    const Text noResultsText = Text('No results!');

    if (_scanResults == null ||
        camera == null ||
        !camera!.value.isInitialized) {
      return noResultsText;
    }
    CustomPainter painter;
    painter = BarcodeDetectorPainter(
        _scanResults, camera!.value.previewSize!, rotation);

    for (Barcode bc in _scanResults) {
      if (bc.type == BarcodeType.url) {
        closeCameraAndStream();

        WidgetsBinding.instance!.addPostFrameCallback((_) {
          Navigator.popAndPushNamed(context, '/piece');
        });
      }
    }

    return CustomPaint(
      painter: painter,
    );

    //if (_scanResults is! RecognisedText) return noResultsText;
  }

  Widget _buildImage() {
    final size = MediaQuery.of(context).size;
    //todo solve null check on a null value at this point
    double scale =
        camera != null ? size.aspectRatio * camera!.value.aspectRatio : 1;
    if (scale < 1) scale = 1 / scale;

    return Container(
      constraints: const BoxConstraints.expand(),
      child: camera == null
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Stack(
              fit: StackFit.expand,
              children: <Widget>[
                Transform.scale(
                  scale: scale ?? 1,
                  child: Center(child: CameraPreview(camera!)),
                ),
                _buildResults(),
              ],
            ),
    );
  }

  // Widget _detectedMAWBCell() {
  //   var screenSize = MediaQuery.of(context).size;
  //   return Positioned(
  //     top: 90,
  //     width: screenSize.width,
  //     height: _folded ? 0.01 : 44,
  //     child: ClipRect(
  //       child: BackdropFilter(
  //         filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
  //         child: AnimatedContainer(
  //           duration: Duration(milliseconds: 600),
  //           decoration: BoxDecoration(
  //             color: CupertinoTheme.of(context).primaryColor,
  //             borderRadius: BorderRadius.only(
  //                 bottomLeft: Radius.circular(15),
  //                 bottomRight: Radius.circular(15)),
  //           ),
  //           child: Row(
  //             children: [
  //               Expanded(
  //                 child: Container(
  //                   padding: EdgeInsets.only(left: 16),
  //                   child: _folded
  //                       ? null
  //                       : Row(
  //                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                           children: [
  //                             Align(
  //                               alignment: Alignment.centerLeft,
  //                               child: Padding(
  //                                 padding: EdgeInsets.only(left: 15),
  //                                 child: Text(
  //                                   'MAWB Nummer',
  //                                   style: TextStyle(
  //                                       fontSize: smallText,
  //                                       color: blackColor,
  //                                       fontFamily: sfproregular),
  //                                 ),
  //                               ),
  //                             ),
  //                             Align(
  //                               alignment: Alignment.centerRight,
  //                               child: Padding(
  //                                 padding: EdgeInsets.only(right: 15),
  //                                 child: Text(
  //                                   _currentUrl,
  //                                   style: TextStyle(
  //                                       fontSize: smallText,
  //                                       color: grayOpacityTextColor,
  //                                       fontFamily: sfproregular),
  //                                 ),
  //                               ),
  //                             ),
  //                           ],
  //                         ),
  //                 ),
  //               ),
  //             ],
  //           ),
  //         ),
  //       ),
  //     ),
  //   );
  // }

  Widget _mainContainer() {
    return Stack(
      children: [
        Center(
          child: _buildImage(),
        ),
        // _detectedMAWBCell(),
        // SingleTextButtonBottomBar(
        //   label: 'Barcode Scannen',
        //   blurStrengthX: 10,
        //   blurStrengthY: 10,
        //   borderColor: grayTextColor.withOpacity(0.1),
        //   barColor: CupertinoDynamicColor.resolve(
        //     CupertinoTheme.of(context).barBackgroundColor.withOpacity(0.6),
        //     context,
        //   ),
        //   textStyle: TextStyle(
        //       fontSize: bigText, color: blueColor, fontFamily: sfproregular),
        //   onTap: () {
        //     Vibration.vibrate();
        //     onCameraButtonPress();
        //   },
        //   height: 90,
        // )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    //master = Provider.of<MasterAirwayBillProvider>(context).getMaster();
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

  void showInSnackBar(String message) {
    //TODO maybe implement a better snackbar
    // ignore: deprecated_member_use
    //_scaffoldKey.currentState.showSnackBar(SnackBar(content: Text(message)));
  }

  void _showCameraException(CameraException e) {
    showInSnackBar('Error: ${e.code}\n${e.description}');
  }

  Future<bool> onBackPressed() {
    closeCameraAndStream();
    //Navigator.popAndPushNamed(context, "camera_stream");

    // Navigator.of(context).popAndPushNamed("camera_stream").then((value) {
    //   _initializeCamera();
    // });
    Navigator.pop(context);

    return Future.value(false);
  }

  @override
  void dispose() {
    super.dispose();
  }

  void closeCameraAndStream() async {
    if (camera!.value.isStreamingImages) {
      await camera!.stopImageStream();
    }
    await _barcodeScanner.close();
    await camera!.dispose();
    setState(() {
      camera = null;
      _scanResults = null;
    });
  }
}

void giveHapticFeedback() {
  SystemSound.play(SystemSoundType.click);
  HapticFeedback.lightImpact();
  Vibration.vibrate();
}
