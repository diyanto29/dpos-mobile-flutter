// To parse this JSON data, do
//
//     final TypeOrderModel = TypeOrderModelFromJson(jsonString);

import 'dart:convert';

TypeOrderModel TypeOrderModelFromJson(String str) => TypeOrderModel.fromJson(json.decode(str));

String TypeOrderModelToJson(TypeOrderModel data) => json.encode(data.toJson());

class TypeOrderModel {
  TypeOrderModel({
    this.status,
    this.code,
    this.message,
    this.totalData,
    this.data,
  });

  bool? status;
  int? code;
  String? message;
  int? totalData;
  List<TypeOrder>? data;

  factory TypeOrderModel.fromJson(Map<String, dynamic> json) => TypeOrderModel(
    status: json["status"],
    code: json["code"],
    message: json["message"],
    totalData: json["total_data"],
    data: List<TypeOrder>.from(json["data"].map((x) => TypeOrder.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "code": code,
    "message": message,
    "total_data": totalData,
    "data": List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class TypeOrder {
  TypeOrder({
    this.orderTypeId,
    this.orderTypeName,
    this.storeId,
    this.createdAt,
    this.updatedAt,
  });

  String? orderTypeId;
  String? orderTypeName;
  String? storeId;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory TypeOrder.fromJson(Map<String, dynamic> json) => TypeOrder(
    orderTypeId: json["ORDER_TYPE_ID"],
    orderTypeName: json["ORDER_TYPE_NAME"],
    storeId: json["STORE_ID"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "ORDER_TYPE_ID": orderTypeId,
    "ORDER_TYPE_NAME": orderTypeName,
    "STORE_ID": storeId,
    "created_at": createdAt!.toIso8601String(),
    "updated_at": updatedAt!.toIso8601String(),
  };
}
