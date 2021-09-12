import 'dart:convert';

import 'package:location/location.dart';

class LocationToJsonConverter {
  String convert(LocationData input) {
    return "{\"latitude\":\"${input.latitude.toString()}\",\"longitude\":\"${input.longitude.toString()}\"}";
  }
}

class PieceRequest {
  String body = json.encode({
    "text":
        "https://forwarder.chi-deutschland.cloud/companies/apple/los/Piece_156927"
  });
}
