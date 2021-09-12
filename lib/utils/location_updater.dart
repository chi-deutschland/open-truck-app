import 'package:trucker_app/models/request_models.dart';
import 'package:trucker_app/services/networking.dart';
import 'package:location/location.dart';
import 'package:trucker_app/utils/device_info.dart';

class LocationUpdater {
  late String lat;
  late String lon;
  late String url = "https://trucker.chi-deutschland.cloud/geolocation?app_id=";
  DeviceInfo deviceInfo = DeviceInfo();

  Future<int> updateLocation(LocationData input) async {
    LocationToJsonConverter locHelper = LocationToJsonConverter();
    String androidId = await deviceInfo.getAndroidId();
    Networking network = Networking.geoLocation(
        url + androidId + "&driver_id=OM123&truck_id=FCH2022",
        locHelper.convert(input));
    var locationUpdateResponse = network.postGeoLocation();
    return locationUpdateResponse;
  }
}
