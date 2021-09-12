import 'package:flutter/cupertino.dart';

class TourDetailsProvider extends ChangeNotifier {
  bool isLoaded = true;

  ///master detected, so make the camera button green
  void makeCaptureButtonGreen() {
    isLoaded = true;
    notifyListeners();
  }

  /// make the camera button red
  void makeCaptureButtonRed() {
    isLoaded = false;
    notifyListeners();
  }

  bool getLoadStatus() {
    return isLoaded;
  }
}
