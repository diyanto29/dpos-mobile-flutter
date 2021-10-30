// To parse this JSON data, do
//
//     final TypeBusinessModel = TypeBusinessModelFromJson(jsonString);

import 'dart:convert';

TypeBusinessModel TypeBusinessModelFromJson(String str) => TypeBusinessModel.fromJson(json.decode(str));

String TypeBusinessModelToJson(TypeBusinessModel data) => json.encode(data.toJson());

class TypeBusinessModel {
  TypeBusinessModel({
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
  List<TypeBusiness>? data;

  factory TypeBusinessModel.fromJson(Map<String, dynamic> json) => TypeBusinessModel(
    status: json["status"],
    code: json["code"],
    message: json["message"],
    totalData: json["total_data"],
    data: List<TypeBusiness>.from(json["data"].map((x) => TypeBusiness.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "code": code,
    "message": message,
    "total_data": totalData,
    "data": List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class TypeBusiness {
  TypeBusiness({
    this.businessCategoryId,
    this.businessCategoryName,
    this.createdAt,
    this.updatedAt,
  });

  String? businessCategoryId;
  String? businessCategoryName;
  dynamic createdAt;
  dynamic updatedAt;

  factory TypeBusiness.fromJson(Map<String, dynamic> json) => TypeBusiness(
    businessCategoryId: json["BUSINESS_CATEGORY_ID"],
    businessCategoryName: json["BUSINESS_CATEGORY_NAME"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
  );

  Map<String, dynamic> toJson() => {
    "BUSINESS_CATEGORY_ID": businessCategoryId,
    "BUSINESS_CATEGORY_NAME": businessCategoryName,
    "created_at": createdAt,
    "updated_at": updatedAt,
  };
}
