// To parse this JSON data, do
//
//     final OutletModel = OutletModelFromJson(jsonString);

import 'dart:convert';

OutletModel OutletModelFromJson(String str) => OutletModel.fromJson(json.decode(str));

String OutletModelToJson(OutletModel data) => json.encode(data.toJson());

class OutletModel {
  OutletModel({
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
  List<DataOutlet>? data;

  factory OutletModel.fromJson(Map<String, dynamic> json) => OutletModel(
    status: json["status"],
    code: json["code"],
    message: json["message"],
    totalData: json["total_data"],
    data: List<DataOutlet>.from(json["data"].map((x) => DataOutlet.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "code": code,
    "message": message,
    "total_data": totalData,
    "data": List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class DataOutlet {
  DataOutlet({
    this.storeId,
    this.storeName,
    this.storeDescription,
    this.addressId,
    this.userId,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.address,
    this.owner,
    this.orderType,
    this.storeoperationstart,
    this.storeoperationclose,
    this.storeoperationstatus,
  });

  String? storeId;
  String? storeName;
  String? storeDescription;
  String? addressId;
  String? userId;
  String? createdAt;
  String? updatedAt;
  dynamic deletedAt;
  Address? address;
  dynamic storeoperationstart;
  dynamic storeoperationclose;
  dynamic storeoperationstatus;
  Owner? owner;
  List<OrderType>? orderType;

  factory DataOutlet.fromJson(Map<String, dynamic> json) => DataOutlet(
    storeId: json["STORE_ID"],
    storeName: json["STORE_NAME"],
    storeDescription: json["STORE_DESCRIPTION"] == null ? null : json["STORE_DESCRIPTION"],
    addressId: json["ADDRESS_ID"],
    userId: json["USER_ID"],
    createdAt: json["created_at"],
    storeoperationstart : json['STORE_OPERATION_START'],
    storeoperationclose : json['STORE_OPERATION_CLOSE'],
    storeoperationstatus : json['STORE_OPERATION_STATUS'],
  updatedAt: json["updated_at"],
    deletedAt: json["deleted_at"],
    address: json["address"] == null ? null : Address.fromJson(json["address"]),
    owner: Owner.fromJson(json["owner"]),
    orderType: List<OrderType>.from(json["order_type"].map((x) => OrderType.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "STORE_ID": storeId,
    "STORE_NAME": storeName,
    "STORE_DESCRIPTION": storeDescription == null ? null : storeDescription,
    "ADDRESS_ID": addressId,
    "USER_ID": userId,
    "created_at": createdAt,
    "updated_at": updatedAt,
    "deleted_at": deletedAt,
    "address": address == null ? null : address!.toJson(),
    "owner": owner!.toJson(),
    "order_type": List<dynamic>.from(orderType!.map((x) => x.toJson())),
  };
}

class Address {
  Address({
    this.addressId,
    this.addressProvinceId,
    this.addressProvinceName,
    this.addressCityId,
    this.addressCityName,
    this.addressSubdistrictId,
    this.addressSubdistrictName,
    this.addressPoscode,
    this.userId,
    this.addressNoTelp,
    this.addressType,
    this.addressAlias,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  String? addressId;
  int? addressProvinceId;
  String? addressProvinceName;
  int? addressCityId;
  String? addressCityName;
  int? addressSubdistrictId;
  String? addressSubdistrictName;
  String? addressPoscode;
  String? userId;
  String? addressNoTelp;
  String? addressType;
  String? addressAlias;
  String? createdAt;
  String? updatedAt;
  dynamic deletedAt;

  factory Address.fromJson(Map<String, dynamic> json) => Address(
    addressId: json["ADDRESS_ID"],
    addressProvinceId: json["ADDRESS_PROVINCE_ID"],
    addressProvinceName: json["ADDRESS_PROVINCE_NAME"],
    addressCityId: json["ADDRESS_CITY_ID"],
    addressCityName: json["ADDRESS_CITY_NAME"],
    addressSubdistrictId: json["ADDRESS_SUBDISTRICT_ID"],
    addressSubdistrictName: json["ADDRESS_SUBDISTRICT_NAME"],
    addressPoscode: json["ADDRESS_POSCODE"],
    userId: json["USER_ID"],
    addressNoTelp: json["ADDRESS_NO_TELP"],
    addressType: json["ADDRESS_TYPE"],
    addressAlias: json["ADDRESS_ALIAS"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
    deletedAt: json["deleted_at"],
  );

  Map<String, dynamic> toJson() => {
    "address_id": addressId,
    "address_province_id": addressProvinceId,
    "address_province_name": addressProvinceName,
    "address_city_id": addressCityId,
    "address_city_name": addressCityName,
    "address_subdistrict_id": addressSubdistrictId,
    "address_subdistrict_name": addressSubdistrictName,
    "address_poscode": addressPoscode,
    "user_id": userId,
    "address_no_telp": addressNoTelp,
    "address_type": addressType,
    "address_alias": addressAlias,
    "created_at": createdAt,
    "updated_at": updatedAt,
    "deleted_at": deletedAt,
  };
}

class OrderType {
  OrderType({
    this.orderTypeId,
    this.orderTypeName,
    this.storeId,
    this.createdAt,
    this.updatedAt,
  });

  String? orderTypeId;
  String? orderTypeName;
  String? storeId;
  String? createdAt;
  String? updatedAt;

  factory OrderType.fromJson(Map<String, dynamic> json) => OrderType(
    orderTypeId: json["ORDER_TYPE_ID"],
    orderTypeName: json["ORDER_TYPE_NAME"],
    storeId: json["STORE_ID"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
  );

  Map<String, dynamic> toJson() => {
    "ORDER_TYPE_ID": orderTypeId,
    "ORDER_TYPE_NAME": orderTypeName,
    "STORE_ID": storeId,
    "created_at": createdAt,
    "updated_at": updatedAt,
  };
}

class Owner {
  Owner({
    this.userId,
    this.userFullname,
    this.userUuid,
    this.userVersionApp,
    this.userOsVersion,
    this.userStatus,
    this.userNoHp,
    this.userEmail,
    this.createdAt,
    this.updatedAt,
    this.userPhoto,
    this.deleteAt,
    this.createdBy,
    this.roleId,
    this.userUsername,
    this.userType,
    this.userGender,
    this.expiredDate,
  });

  String? userId;
  String? userFullname;
  String? userUuid;
  String? userVersionApp;
  String? userOsVersion;
  String? userStatus;
  String? userNoHp;
  String? userEmail;
  String? createdAt;
  String? updatedAt;
  dynamic userPhoto;
  dynamic deleteAt;
  dynamic createdBy;
  String? roleId;
  String? userUsername;
  String? userType;
  String? userGender;
  DateTime? expiredDate;

  factory Owner.fromJson(Map<String?, dynamic> json) => Owner(
    userId: json["USER_ID"],
    userFullname: json["USER_FULLNAME"],
    userUuid: json["USER_UUID"],
    userVersionApp: json["USER_VERSION_APP"],
    userOsVersion: json["USER_OS_VERSION"],
    userStatus: json["USER_STATUS"],
    userNoHp: json["USER_NO_HP"],
    userEmail: json["USER_EMAIL"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
    userPhoto: json["USER_PHOTO"],
    deleteAt: json["delete_at"],
    createdBy: json["CREATED_BY"],
    roleId: json["ROLE_ID"],
    userUsername: json["USER_USERNAME"],
    userType: json["USER_TYPE"],
    userGender: json["USER_GENDER"],
    expiredDate: DateTime.parse(json["EXPIRED_DATE"]),
  );

  Map<String, dynamic> toJson() => {
    "USER_ID": userId,
    "USER_FULLNAME": userFullname,
    "USER_UUID": userUuid,
    "USER_VERSION_APP": userVersionApp,
    "USER_OS_VERSION": userOsVersion,
    "USER_STATUS": userStatus,
    "USER_NO_HP": userNoHp,
    "USER_EMAIL": userEmail,
    "created_at": createdAt,
    "updated_at": updatedAt,
    "USER_PHOTO": userPhoto,
    "delete_at": deleteAt,
    "CREATED_BY": createdBy,
    "RsOLE_ID": roleId,
    "USER_USERNAME": userUsername,
    "USER_TYPE": userType,
    "USER_GENDER": userGender,
    "EXPIRED_DATE": "${expiredDate!.year.toString().padLeft(4, '0')}-${expiredDate!.month.toString().padLeft(2, '0')}-${expiredDate!.day.toString().padLeft(2, '0')}",
  };
}
