import 'dart:convert';

CategoryProductModel CategoryProductFromJson(String str) =>
    CategoryProductModel.fromJson(json.decode(str));

String CategoryProductToJson(CategoryProductModel data) =>
    json.encode(data.toJson());

class CategoryProductModel {
  CategoryProductModel({
    this.status,
    this.code,
    this.message,
    this.data,
  });

  bool? status;
  int? code;
  String? message;
  List<CategoryProduct>? data;

  factory CategoryProductModel.fromJson(Map<String, dynamic> json) =>
      CategoryProductModel(
        status: json["status"],
        code: json["code"],
        message: json["message"],
        data: List<CategoryProduct>.from(
            json["data"].map((x) => CategoryProduct.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "code": code,
        "message": message,
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class CategoryProduct {
  CategoryProduct({
    this.categoryId,
    this.categoryName,
    this.categoryIcon,
    this.createdAt,
    this.updatedAt,
    this.storeId,
    this.storeName,
    this.storeDescription,
    this.addressId,
    this.userId,
    this.deletedAt,
    this.store,
    this.isChecked = false,
  });

  String? categoryId;
  String? categoryName;
  String? categoryIcon;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? storeId;
  String? storeName;
  dynamic storeDescription;
  String? addressId;
  String? userId;
  dynamic deletedAt;
  Store? store;
  bool isChecked;

  factory CategoryProduct.fromJson(Map<String, dynamic> json) =>
      CategoryProduct(
        categoryId: json["CATEGORY_ID"] == null ? null : json["CATEGORY_ID"],
        categoryName:
            json["CATEGORY_NAME"] == null ? null : json["CATEGORY_NAME"],
        categoryIcon:
            json["CATEGORY_ICON"] == null ? null : json["CATEGORY_ICON"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        storeId: json["STORE_ID"],
        storeName: json["STORE_NAME"],
        storeDescription: json["STORE_DESCRIPTION"],
        addressId: json["ADDRESS_ID"],
        userId: json["USER_ID"],
        deletedAt: json["deleted_at"],
        store: Store.fromJson(json["store"]),
      );

  Map<String, dynamic> toJson() => {
        "CATEGORY_ID": categoryId == null ? null : categoryId,
        "CATEGORY_NAME": categoryName == null ? null : categoryName,
        "CATEGORY_ICON": categoryIcon == null ? null : categoryIcon,
        "created_at": createdAt!.toIso8601String(),
        "updated_at": updatedAt!.toIso8601String(),
        "STORE_ID": storeId,
        "STORE_NAME": storeName,
        "STORE_DESCRIPTION": storeDescription,
        "ADDRESS_ID": addressId,
        "USER_ID": userId,
        "deleted_at": deletedAt,
        "store": store!.toJson(),
      };
}

class Store {
  Store({
    this.storeId,
    this.storeName,
    this.storeDescription,
    this.addressId,
    this.userId,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.owner,
  });

  String? storeId;
  String? storeName;
  dynamic storeDescription;
  String? addressId;
  String? userId;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic deletedAt;
  Owner? owner;

  factory Store.fromJson(Map<String, dynamic> json) => Store(
        storeId: json["STORE_ID"],
        storeName: json["STORE_NAME"],
        storeDescription: json["STORE_DESCRIPTION"],
        addressId: json["ADDRESS_ID"],
        userId: json["USER_ID"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        deletedAt: json["deleted_at"],
        owner: json["owner"] == null ? null : Owner.fromJson(json["owner"]),
      );

  Map<String, dynamic> toJson() => {
        "STORE_ID": storeId,
        "STORE_NAME": storeName,
        "STORE_DESCRIPTION": storeDescription,
        "ADDRESS_ID": addressId,
        "USER_ID": userId,
        "created_at": createdAt!.toIso8601String(),
        "updated_at": updatedAt!.toIso8601String(),
        "deleted_at": deletedAt,
        "owner": owner == null ? null : owner!.toJson(),
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
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic userPhoto;
  dynamic deleteAt;
  dynamic createdBy;
  String? roleId;
  String? userUsername;
  String? userType;
  String? userGender;
  DateTime? expiredDate;

  factory Owner.fromJson(Map<String, dynamic> json) => Owner(
        userId: json["USER_ID"],
        userFullname: json["USER_FULLNAME"],
        userUuid: json["USER_UUID"],
        userVersionApp: json["USER_VERSION_APP"],
        userOsVersion: json["USER_OS_VERSION"],
        userStatus: json["USER_STATUS"],
        userNoHp: json["USER_NO_HP"],
        userEmail: json["USER_EMAIL"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
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
        "created_at": createdAt!.toIso8601String(),
        "updated_at": updatedAt!.toIso8601String(),
        "USER_PHOTO": userPhoto,
        "delete_at": deleteAt,
        "CREATED_BY": createdBy,
        "ROLE_ID": roleId,
        "USER_USERNAME": userUsername,
        "USER_TYPE": userType,
        "USER_GENDER": userGender,
        "EXPIRED_DATE":
            "${expiredDate!.year.toString().padLeft(4, '0')}-${expiredDate!.month.toString().padLeft(2, '0')}-${expiredDate!.day.toString().padLeft(2, '0')}",
      };
}
