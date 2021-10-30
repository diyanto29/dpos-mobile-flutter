// To parse this JSON data, do
//
//     final ProductModel = ProductModelFromJson(jsonString);

import 'dart:convert';

import 'package:equatable/equatable.dart';

ProductSearchModel ProductSearchModelFromJson(String str) => ProductSearchModel.fromJson(json.decode(str));

String ProductSearchModelToJson(ProductSearchModel data) => json.encode(data.toJson());

class ProductSearchModel {
  ProductSearchModel({
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
  List<DataProduct>? data;

  factory ProductSearchModel.fromJson(Map<String, dynamic> json) => ProductSearchModel(
    status: json["status"],
    code: json["code"],
    message: json["message"],
    totalData: json["total_data"],
    data: List<DataProduct>.from(json["data"].map((x) => DataProduct.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "code": code,
    "message": message,
    "total_data": totalData,
    "data": List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class DataProduct  extends Equatable{
  DataProduct({
    this.productId,
    this.productName,
    this.productStok,
    this.productPriceReseller,
    this.productWeight,
    this.productUnitId,
    this.productPhoto,
    this.productWidth,
    this.productDimention,
    this.storeId,
    this.categoryId,
    this.distributionId,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.productStatus,
    this.productPriceModal,
    this.productDescription,
    this.productHeight,
    this.productBarcode,
    this.productSold,
    this.productPrice,
    this.productStokStatus,
    this.productPriceByOrderType,
    this.productPriceJson,
    this.productSku,
    this.outlet,
    this.category,
    this.productInCart=false
  });

  String? productId;
  String? productName;
  String? productStok;
  String? productPriceReseller;
  String? productWeight;
  String? productUnitId;
  String? productPhoto;
  String? productWidth;
  String? productDimention;
  String? storeId;
  String? categoryId;
  dynamic distributionId;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic deletedAt;
  String? productStatus;
  String? productPriceModal;
  String? productDescription;
  String? productHeight;
  String? productBarcode;
  dynamic productSold;
  int? productPrice;
  String?  productStokStatus;
  String? productPriceByOrderType;
  List<dynamic>? productPriceJson;
  String? productSku;
  Outlet? outlet;
  Category? category;
  bool productInCart;

  factory DataProduct.fromJson(Map<String, dynamic> json) => DataProduct(
    productId: json["PRODUCT_ID"],
    productName: json["PRODUCT_NAME"],
    productStok: json["PRODUCT_STOK"],
    productPriceReseller: json["PRODUCT_PRICE_RESELLER"] == null ? null : json["PRODUCT_PRICE_RESELLER"],
    productWeight: json["PRODUCT_WEIGHT"] == null ? null : json["PRODUCT_WEIGHT"],
    productUnitId: json["PRODUCT_UNIT_ID"],
    productPhoto: json["PRODUCT_PHOTO"],
    productWidth: json["PRODUCT_WIDTH"] == null ? null : json["PRODUCT_WIDTH"],
    productDimention: json["PRODUCT_DIMENTION"] == null ? null : json["PRODUCT_DIMENTION"],
    storeId: json["STORE_ID"],
    categoryId: json["CATEGORY_ID"],
    distributionId: json["DISTRIBUTION_ID"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    deletedAt: json["deleted_at"],
    productStatus: json["PRODUCT_STATUS"],
    productPriceModal: json["PRODUCT_PRICE_MODAL"],
    productDescription: json["PRODUCT_DESCRIPTION"],
    productHeight: json["PRODUCT_HEIGHT"] == null ? null : json["PRODUCT_HEIGHT"],
    productBarcode: json["PRODUCT_BARCODE"],
    productSold: json["PRODUCT_SOLD"],
    productPrice: json["PRODUCT_PRICE"],
    productStokStatus: json["PRODUCT_STOK_STATUS"],
    productPriceByOrderType: json["PRODUCT_PRICE_BY_ORDER_TYPE"],
    productPriceJson: List<dynamic>.from(json["PRODUCT_PRICE_JSON"].map((x) => x)),
    productSku: json["PRODUCT_SKU"],
    outlet: Outlet.fromJson(json["outlet"]),
    category:json["category"] == null ? null : Category.fromJson(json["category"]),
    productInCart:false
  );

  Map<String, dynamic> toJson() => {
    "PRODUCT_ID": productId,
    "PRODUCT_NAME": productName,
    "PRODUCT_STOK": productStok,
    "PRODUCT_PRICE_RESELLER": productPriceReseller == null ? null : productPriceReseller,
    "PRODUCT_WEIGHT": productWeight == null ? null : productWeight,
    "PRODUCT_UNIT_ID": productUnitId,
    "PRODUCT_PHOTO": productPhoto,
    "PRODUCT_WIDTH": productWidth == null ? null : productWidth,
    "PRODUCT_DIMENTION": productDimention == null ? null : productDimention,
    "STORE_ID": storeId,
    "CATEGORY_ID": categoryId,
    "DISTRIBUTION_ID": distributionId,
    "created_at": createdAt!.toIso8601String(),
    "updated_at": updatedAt!.toIso8601String(),
    "deleted_at": deletedAt,
    "PRODUCT_STATUS": productStatus,
    "PRODUCT_PRICE_MODAL": productPriceModal,
    "PRODUCT_DESCRIPTION": productDescription,
    "PRODUCT_HEIGHT": productHeight == null ? null : productHeight,
    "PRODUCT_BARCODE": productBarcode,
    "PRODUCT_SOLD": productSold,
    "PRODUCT_PRICE": productPrice,
    "PRODUCT_STOK_STATUS": productStokStatus,
    "PRODUCT_PRICE_BY_ORDER_TYPE": productPriceByOrderType,
    "PRODUCT_PRICE_JSON": List<dynamic>.from(productPriceJson!.map((x) => x)),
    "PRODUCT_SKU": productSku,
    "outlet": outlet!.toJson(),
    "category": category!.toJson(),
  };

  @override
  // TODO: implement props
  List<Object?> get props => [productId];
}

class Category {
  Category({
    this.categoryId,
    this.categoryName,
    this.categoryIcon,
    this.createdAt,
    this.updatedAt,
    this.storeId,
  });

  String? categoryId;
  String? categoryName;
  String? categoryIcon;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? storeId;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
    categoryId: json["CATEGORY_ID"],
    categoryName: json["CATEGORY_NAME"],
    categoryIcon: json["CATEGORY_ICON"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    storeId: json["STORE_ID"] == null ? null : json["STORE_ID"],
  );

  Map<String, dynamic> toJson() => {
    "CATEGORY_ID": categoryId,
    "CATEGORY_NAME": categoryName,
    "CATEGORY_ICON": categoryIcon,
    "created_at": createdAt!.toIso8601String(),
    "updated_at": updatedAt!.toIso8601String(),
    "STORE_ID": storeId == null ? null : storeId,
  };
}

class Outlet {
  Outlet({
    this.storeId,
    this.storeName,
    this.storeDescription,
    this.addressId,
    this.userId,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  String? storeId;
  String? storeName;
  dynamic storeDescription;
  String? addressId;
  String? userId;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic deletedAt;

  factory Outlet.fromJson(Map<String, dynamic> json) => Outlet(
    storeId: json["STORE_ID"],
    storeName: json["STORE_NAME"],
    storeDescription: json["STORE_DESCRIPTION"],
    addressId: json["ADDRESS_ID"],
    userId: json["USER_ID"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    deletedAt: json["deleted_at"],
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
  };
}
