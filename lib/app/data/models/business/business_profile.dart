// To parse this JSON data, do
//
//     final BusinessProfileModel = BusinessProfileModelFromJson(jsonString);

import 'dart:convert';

BusinessProfileModel BusinessProfileModelFromJson(String str) => BusinessProfileModel.fromJson(json.decode(str));

String BusinessProfileModelToJson(BusinessProfileModel data) => json.encode(data.toJson());

class BusinessProfileModel {
  BusinessProfileModel({
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
  BusinessUser? data;

  factory BusinessProfileModel.fromJson(Map<String, dynamic> json) => BusinessProfileModel(
    data: BusinessUser.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "code": code,
    "message": message,
    "total_data": totalData,
    "data": data!.toJson(),
  };
}

class BusinessUser {
  BusinessUser({
    this.businessId,
    this.businessName,
    this.businessCategoryId,
    this.businessCrewTotal,
    this.businessBranch,
    this.businessContact,
    this.createdAt,
    this.updatedAt,
    this.userId,
    this.businessLogo,
    this.businessWebsiteName,
    this.category,
  });

  String? businessId;
  String? businessName;
  String? businessCategoryId;
  String? businessCrewTotal;
  String? businessBranch;
  String? businessContact;
  String? createdAt;
  String? updatedAt;
  String? userId;
  String? businessLogo;
  String? businessWebsiteName;
  Category? category;

  factory BusinessUser.fromJson(Map<String, dynamic> json) => BusinessUser(
    businessId: json["BUSINESS_ID"],
    businessName: json["BUSINESS_NAME"],
    businessCategoryId: json["BUSINESS_CATEGORY_ID"],
    businessCrewTotal: json["BUSINESS_CREW_TOTAL"],
    businessBranch: json["BUSINESS_BRANCH"],
    businessContact: json["BUSINESS_CONTACT"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
    userId: json["USER_ID"],
    businessLogo: json["BUSINESS_LOGO"],
    businessWebsiteName: json["BUSINESS_WEBSITE_NAME"],
    category: Category.fromJson(json["category"]),
  );

  Map<String, dynamic> toJson() => {
    "BUSINESS_ID": businessId,
    "BUSINESS_NAME": businessName,
    "BUSINESS_CATEGORY_ID": businessCategoryId,
    "BUSINESS_CREW_TOTAL": businessCrewTotal,
    "BUSINESS_BRANCH": businessBranch,
    "BUSINESS_CONTACT": businessContact,
    "created_at": createdAt,
    "updated_at": updatedAt,
    "USER_ID": userId,
    "BUSINESS_LOGO": businessLogo,
    "BUSINESS_WEBSITE_NAME": businessWebsiteName,
    "category": category!.toJson(),
  };
}

class Category {
  Category({
    this.businessCategoryId,
    this.businessCategoryName,
    this.createdAt,
    this.updatedAt,
  });

  String? businessCategoryId;
  String? businessCategoryName;
  dynamic createdAt;
  dynamic updatedAt;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
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
