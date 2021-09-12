import 'dart:typed_data';
import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_ml_kit/google_ml_kit.dart';

class OcrUtils {
  OcrUtils._();

  static Future<CameraDescription> getCamera(CameraLensDirection dir) async {
    return await availableCameras().then(
      (List<CameraDescription> cameras) => cameras.firstWhere(
        (CameraDescription camera) => camera.lensDirection == dir,
      ),
    );
  }

  static Future<dynamic> detect({
    required CameraImage image,
    required Future<dynamic> Function(InputImage image) detectInImage,
    required int imageRotation,
  }) async {
    return detectInImage(
      InputImage.fromBytes(
        inputImageData:
            _buildData(image, rotationIntToImageRotation(imageRotation)),
        bytes: _concatenatePlanes(image.planes),
      ),
    );
  }

  static Uint8List _concatenatePlanes(List<Plane> planes) {
    final WriteBuffer allBytes = WriteBuffer();
    for (Plane plane in planes) {
      allBytes.putUint8List(plane.bytes);
    }
    return allBytes.done().buffer.asUint8List();
  }

  static InputImageData _buildData(
    CameraImage image,
    InputImageRotation rotation,
  ) {
    return InputImageData(
      inputImageFormat:
          InputImageFormatMethods.fromRawValue(image.format.raw) ??
              InputImageFormat.NV21,
      size: Size(image.width.toDouble(), image.height.toDouble()),
      imageRotation: rotation,
      planeData: image.planes.map(
        (Plane plane) {
          return InputImagePlaneMetadata(
            bytesPerRow: plane.bytesPerRow,
            height: plane.height,
            width: plane.width,
          );
        },
      ).toList(),
    );
  }

  static InputImageRotation rotationIntToImageRotation(int rotation) {
    switch (rotation) {
      case 0:
        return InputImageRotation.Rotation_0deg;
      case 90:
        return InputImageRotation.Rotation_90deg;
      case 180:
        return InputImageRotation.Rotation_180deg;
      default:
        assert(rotation == 270);
        return InputImageRotation.Rotation_270deg;
    }
  }
}
