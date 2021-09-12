import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/services.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';

class IconUtils {
  static Future<BitmapDescriptor> createMarkerImageFromAsset() async {
    final Uint8List markerIcon =
        await getBytesFromAsset('assets/ic_car.png', 50);
    return BitmapDescriptor.fromBytes(markerIcon);
  }

  static Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }
}
