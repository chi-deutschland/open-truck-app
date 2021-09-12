import 'package:flutter/cupertino.dart';

class CameraProvider extends ChangeNotifier {
  bool isBusy = false;

  bool getCameraStatus() {
    return isBusy;
  }

  void setCameraStatus() {
    isBusy = true;
  }

  void toggleCameraStatus() {
    isBusy ? false : true;
  }
}
