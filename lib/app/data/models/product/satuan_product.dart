// To parse this JSON data, do
//
//     final modelUnitProduct = modelUnitProductFromJson(jsonString);

import 'dart:convert';

ModelUnitProduct modelUnitProductFromJson(String str) => ModelUnitProduct.fromJson(json.decode(str));

String modelUnitProductToJson(ModelUnitProduct data) => json.encode(data.toJson());

class ModelUnitProduct {
  ModelUnitProduct({
    this.status,
    this.code,
    this.message,
    this.data,
  });

  bool? status;
  int? code;
  String? message;
  List<SatuanProduct>? data;

  factory ModelUnitProduct.fromJson(Map<String, dynamic> json) => ModelUnitProduct(
    status: json["status"],
    code: json["code"],
    message: json["message"],
    data: List<SatuanProduct>.from(json["data"].map((x) => SatuanProduct.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "code": code,
    "message": message,
    "data": List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class SatuanProduct {
  SatuanProduct({
    this.unitProductId,
    this.unitProductName,
    this.createdAt,
    this.updatedAt,
  });

  String? unitProductId;
  String? unitProductName;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory SatuanProduct.fromJson(Map<String, dynamic> json) => SatuanProduct(
    unitProductId: json["UNIT_PRODUCT_ID"],
    unitProductName: json["UNIT_PRODUCT_NAME"],
    createdAt: DateTime.parse(json["CREATED_AT"]),
    updatedAt: DateTime.parse(json["UPDATED_AT"]),
  );

  Map<String, dynamic> toJson() => {
    "UNIT_PRODUCT_ID": unitProductId,
    "UNIT_PRODUCT_NAME": unitProductName,
    "CREATED_AT": createdAt!.toIso8601String(),
    "UPDATED_AT": updatedAt!.toIso8601String(),
  };
}
