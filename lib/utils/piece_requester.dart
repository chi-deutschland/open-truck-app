import 'package:trucker_app/models/request_models.dart';
import 'package:trucker_app/services/networking.dart';
import 'package:trucker_app/utils/device_info.dart';

class PieceRequester {
  late String url = "https://trucker.chi-deutschland.cloud/piece?app_id=";
  DeviceInfo deviceInfo = DeviceInfo();

  Future pieceRequest() async {
    PieceRequest pieceReq = PieceRequest();
    String androidId = await deviceInfo.getAndroidId();
    Networking network = Networking.pieceReq(url + androidId, pieceReq.body);
    var pieceReqResponse = network.postPieceReq();
    return pieceReqResponse;
  }
}
