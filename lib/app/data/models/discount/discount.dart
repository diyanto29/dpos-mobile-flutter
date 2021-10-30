// To parse this JSON data, do
//
//     final DiscountModel = DiscountModelFromJson(jsonString);

import 'dart:convert';

DiscountModel DiscountModelFromJson(String str) => DiscountModel.fromJson(json.decode(str));

String DiscountModelToJson(DiscountModel data) => json.encode(data.toJson());

class DiscountModel {
  DiscountModel({
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
  List<DataDiscount>? data;

  factory DiscountModel.fromJson(Map<String, dynamic> json) => DiscountModel(
    status: json["status"],
    code: json["code"],
    message: json["message"],
    totalData: json["total_data"],
    data: List<DataDiscount>.from(json["data"].map((x) => DataDiscount.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "code": code,
    "message": message,
    "total_data": totalData,
    "data": List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class DataDiscount {
  DataDiscount({
    this.discountId,
    this.discountCode,
    this.discountPercent,
    this.discountStart,
    this.discountEnd,
    this.bannerPath,
    this.userId,
    this.discountName,
    this.discountDescription,
    this.createdAt,
    this.updatedAt,
    this.discountType,
    this.discountMaxPriceOff,
  });

  String? discountId;
  String? discountCode;
  dynamic discountPercent;
  dynamic discountStart;
  dynamic discountEnd;
  String? bannerPath;
  String? userId;
  String? discountName;
  String? discountDescription;
  String? createdAt;
  String? updatedAt;
  String? discountType;
  String? discountMaxPriceOff;

  factory DataDiscount.fromJson(Map<String, dynamic> json) => DataDiscount(
    discountId: json["DISCOUNT_ID"],
    discountCode: json["DISCOUNT_CODE"],
    discountPercent: json["DISCOUNT_PERCENT"],
    discountStart:json["DISCOUNT_START"]==null ? null : DateTime.parse(json["DISCOUNT_START"]),
    discountEnd: json["DISCOUNT_END"]==null ? null :DateTime.parse(json["DISCOUNT_END"]),
    bannerPath: json["BANNER_PATH"],
    userId: json["USER_ID"],
    discountName: json["DISCOUNT_NAME"],
    discountDescription: json["DISCOUNT_DESCRIPTION"],
    createdAt: json["CREATED_AT"],
    updatedAt: json["UPDATED_AT"],
    discountType: json["DISCOUNT_TYPE"],
    discountMaxPriceOff: json["DISCOUNT_MAX_PRICE_OFF"],
  );

  Map<String, dynamic> toJson() => {
    "DISCOUNT_ID": discountId,
    "DISCOUNT_CODE": discountCode,
    "DISCOUNT_PERCENT": discountPercent,
    "DISCOUNT_START": "${discountStart.year.toString().padLeft(4, '0')}-${discountStart.month.toString().padLeft(2, '0')}-${discountStart.day.toString().padLeft(2, '0')}",
    "DISCOUNT_END": "${discountEnd.year.toString().padLeft(4, '0')}-${discountEnd.month.toString().padLeft(2, '0')}-${discountEnd.day.toString().padLeft(2, '0')}",
    "BANNER_PATH": bannerPath,
    "USER_ID": userId,
    "DISCOUNT_NAME": discountName,
    "DISCOUNT_DESCRIPTION": discountDescription,
    "CREATED_AT": createdAt,
    "UPDATED_AT": updatedAt,
    "DISCOUNT_TYPE": discountType,
    "DISCOUNT_MAX_PRICE_OFF": discountMaxPriceOff,
  };
}
