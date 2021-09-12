import 'package:device_info/device_info.dart';

class DeviceInfo {
  final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
  String androidId = '';

  Future<String> getAndroidId() async {
    var build = await deviceInfoPlugin.androidInfo;
    androidId = build.androidId;
    return androidId;
  }
}
