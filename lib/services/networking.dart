import 'package:dio/dio.dart';

class Networking {
  final String url;
  Dio client = Dio();
  Response? response;
  late String geoData;
  late String pieceReq;

  ///usual constructor
  Networking(this.url) {
    client = Dio();
  }

  Networking.geoLocation(this.url, this.geoData) {
    client = Dio(BaseOptions(baseUrl: url));
  }

  Networking.pieceReq(this.url, this.pieceReq) {
    client = Dio(BaseOptions(baseUrl: url));
  }

  Future<int> postGeoLocation() async {
    try {
      response = await client.post(url, data: geoData);
    } on DioError catch (e) {
      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx and is also not 304.

      if (e.response != null) {
        return e.response!.data;
      }
    }
    return Future.value(response!.statusCode);
  }

  Future postPieceReq() async {
    try {
      response = await client.post(url, data: pieceReq);
    } on DioError catch (e) {
      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx and is also not 304.
      if (e.response != null) {
        return e.response!.data;
      }
    }
    return response!.data;
  }
}
