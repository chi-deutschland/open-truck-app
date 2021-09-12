// To parse this JSON data, do
//
//     final pieceModel = pieceModelFromJson(jsonString);

import 'dart:convert';

PieceModel pieceModelFromJson(String str) =>
    PieceModel.fromJson(json.decode(str));

String pieceModelToJson(PieceModel data) => json.encode(data.toJson());

class PieceModel {
  PieceModel({
    required this.dimensions,
    required this.grossWeight,
    required this.id,
    required this.items,
    required this.serviceRequests,
    required this.shipment,
    required this.stackable,
  });

  Dimensions dimensions;
  GrossWeight grossWeight;
  String id;
  List<Item> items;
  List<ServiceRequest> serviceRequests;
  Shipment shipment;
  bool stackable;

  factory PieceModel.fromJson(Map<String, dynamic> json) => PieceModel(
        dimensions: Dimensions.fromJson(json["dimensions"]),
        grossWeight: GrossWeight.fromJson(json["gross_weight"]),
        id: json["id"],
        items: List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
        serviceRequests: List<ServiceRequest>.from(
            json["service_requests"].map((x) => ServiceRequest.fromJson(x))),
        shipment: Shipment.fromJson(json["shipment"]),
        stackable: json["stackable"],
      );

  Map<String, dynamic> toJson() => {
        "dimensions": dimensions.toJson(),
        "gross_weight": grossWeight.toJson(),
        "id": id,
        "items": List<dynamic>.from(items.map((x) => x.toJson())),
        "service_requests":
            List<dynamic>.from(serviceRequests.map((x) => x.toJson())),
        "shipment": shipment.toJson(),
        "stackable": stackable,
      };
}

class Dimensions {
  Dimensions({
    required this.height,
    required this.id,
    required this.length,
    required this.width,
  });

  GrossWeight height;
  String id;
  GrossWeight length;
  GrossWeight width;

  factory Dimensions.fromJson(Map<String, dynamic> json) => Dimensions(
        height: GrossWeight.fromJson(json["height"]),
        id: json["id"],
        length: GrossWeight.fromJson(json["length"]),
        width: GrossWeight.fromJson(json["width"]),
      );

  Map<String, dynamic> toJson() => {
        "height": height.toJson(),
        "id": id,
        "length": length.toJson(),
        "width": width.toJson(),
      };
}

class GrossWeight {
  GrossWeight({
    required this.id,
    required this.unit,
    required this.value,
  });

  String id;
  String unit;
  double value;

  factory GrossWeight.fromJson(Map<String, dynamic> json) => GrossWeight(
        id: json["id"],
        unit: json["unit"],
        value: json["value"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "unit": unit,
        "value": value,
      };
}

class Item {
  Item({
    required this.batchNumber,
    required this.id,
    required this.product,
  });

  String batchNumber;
  String id;
  Product product;

  factory Item.fromJson(Map<String, dynamic> json) => Item(
        batchNumber: json["batch_number"],
        id: json["id"],
        product: Product.fromJson(json["product"]),
      );

  Map<String, dynamic> toJson() => {
        "batch_number": batchNumber,
        "id": id,
        "product": product.toJson(),
      };
}

class Product {
  Product({
    required this.description,
    required this.id,
    required this.identifier,
  });

  String description;
  String id;
  String identifier;

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        description: json["description"],
        id: json["id"],
        identifier: json["identifier"],
      );

  Map<String, dynamic> toJson() => {
        "description": description,
        "id": id,
        "identifier": identifier,
      };
}

class ServiceRequest {
  ServiceRequest({
    required this.id,
    required this.type,
  });

  String id;
  String type;

  factory ServiceRequest.fromJson(Map<String, dynamic> json) => ServiceRequest(
        id: json["id"],
        type: json["type"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "type": type,
      };
}

class Shipment {
  Shipment({
    required this.grossWeight,
    required this.id,
    required this.waybillNumber,
  });

  GrossWeight grossWeight;
  String id;
  WaybillNumber waybillNumber;

  factory Shipment.fromJson(Map<String, dynamic> json) => Shipment(
        grossWeight: GrossWeight.fromJson(json["gross_weight"]),
        id: json["id"],
        waybillNumber: WaybillNumber.fromJson(json["waybill_number"]),
      );

  Map<String, dynamic> toJson() => {
        "gross_weight": grossWeight.toJson(),
        "id": id,
        "waybill_number": waybillNumber.toJson(),
      };
}

class WaybillNumber {
  WaybillNumber({
    required this.id,
    required this.number,
    required this.prefix,
    required this.type,
  });

  String id;
  int number;
  int prefix;
  String type;

  factory WaybillNumber.fromJson(Map<String, dynamic> json) => WaybillNumber(
        id: json["id"],
        number: json["number"],
        prefix: json["prefix"],
        type: json["type"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "number": number,
        "prefix": prefix,
        "type": type,
      };
}
