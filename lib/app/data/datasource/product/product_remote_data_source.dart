import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:warmi/app/data/datalocal/session/auth_session_manager.dart';
import 'package:warmi/app/data/models/product/list_type_order.dart';
import 'package:warmi/app/data/models/outlet/outlet.dart';
import 'package:warmi/app/data/models/product/category_product.dart';
import 'package:warmi/app/data/models/product/product.dart';
import 'package:warmi/app/data/models/product/satuan_product.dart';
import 'package:warmi/core/errors/exceptions.dart';
import 'package:warmi/core/globals/global_string.dart';
import 'package:warmi/core/network/base_dio.dart';
import 'package:warmi/core/network/response_message.dart';

class ProductRemoteDataSource extends BaseDio {
  AuthSessionManager auth = AuthSessionManager();
  Options? options;

  ProductRemoteDataSource() {
    options = new Options(headers: {"Authorization": "Bearer ${auth.token}"});
  }

  Future<ModelUnitProduct> getUnitProduct() async {
    try {
      response = await dio.get(MyString.getUnitProduct, options: options);

      return ModelUnitProduct.fromJson(response!.data);
    } on DioError catch (e) {
      print(e);
      return throw ServerException();
    }
  }

  Future<ProductModel> getProduct() async {
    try {
      response = await dio.get(MyString.getProduct,
          queryParameters: {"store_id": "${auth.storeId}"}, options: options);

      return ProductModel.fromJson(response!.data);
    } on DioError catch (e) {
      print(e);
      return throw ServerException();
    }
  }


  Future<ProductModel> getSearchProduct({String? name}) async {
    try {
      response = await dio.get(MyString.getProduct,
          queryParameters: {"store_id": "${auth.storeId}","name" : "$name"}, options: options);
      return ProductModel.fromJson(response!.data);
    } on DioError catch (e) {
      print(e);
      return throw ServerException();
    }
  }

  Future<ResponseMessage> deleteProduct({String? id}) async {
    try {
      Map<String, dynamic> data = {"product_id": "$id"};
      response =
          await dio.post("${MyString.deleteProduct}", data: jsonEncode(data), options: options);

      return ResponseMessage(message: response!.data['message'], status: response!.data['status']);
    } on DioError catch (e) {
      print(e);
      return throw ServerException();
    }
  }

  Future<ResponseMessage> insertProduct(
      {String? name,
      SatuanProduct? satuanProduct,
      bool? stockProductStatus,
      String? qtyStockProduct,
      String? priceProduct,
      bool? typeOrder,
      List<ListTypeOrder>? listTypeOrder,
      bool? storeAll,
      List<DataOutlet>? listOutlet,
      File? image,
      String? desc,
      String? modal,
      String? sku,
      CategoryProduct? categoryByStore,
      String? barcode,
      String? idProduct}) async {
    try {
      List<dynamic> listStored = [];
      listStored.add({
        "STORE_ID": auth.storeId,
        "STORE_NAME": auth.storeName,
      });
      // listOutlet!.forEach((element) {
      //   listStored.add({
      //     "STORE_ID": element.storeId,
      //     "STORE_NAME": element.storeName,
      //   });
      // });

      if (idProduct == null) {
        print(jsonEncode(listStored));
        if (image == null) {
          response = await dio.post("${MyString.insertProduct}",
              data: {
                "product_name": "$name",
                "product_price": typeOrder == true ? "${listTypeOrder![0].price}" : "$priceProduct",
                "is_by_order_type": "$typeOrder",
                "product_stok_status": "$stockProductStatus",
                "product_unit_product": "${satuanProduct!.unitProductName}",
                "product_status": "aktif",
                "product_stok": "$qtyStockProduct",
                "user_id": "${auth.userId}",
                "store": jsonEncode(listStored),
                // "price_json" : jsonEncode(typeOrderList),
                "product_description": "$desc",
                "product_price_modal": "$modal",
                "product_barcode": "$barcode",
                "sku": "$sku",
                "categori_id": "${categoryByStore!.categoryId}",
                "store_all": "${storeAll}"
              },
              options: options);
          return ResponseMessage(
              message: response!.data['message'], status: response!.data['status']);
        } else {
          var formdata = FormData.fromMap({
            "product_name": "$name",
            "product_price": typeOrder == true ? "${listTypeOrder![0].price}" : "$priceProduct",
            "is_by_order_type": "$typeOrder",
            "product_stok_status": "$stockProductStatus",
            "product_unit_product": "${satuanProduct!.unitProductName}",
            "product_status": "aktif",
            "product_barcode": "$barcode",
            "product_stok": "$qtyStockProduct",
            "user_id": "${auth.userId}",
            "store": jsonEncode(listStored),
            // "price_json" : jsonEncode(typeOrderList),
            "product_description": "$desc",
            "product_price_modal": "$modal",
            "sku": "$sku",
            "categori_id": "${categoryByStore!.categoryId}",
            "store_all": "${storeAll}",
            "product_photo": await MultipartFile.fromFile(image.path,
                filename: image.path.isNotEmpty ? image.path.split('/').last : '...'),
          });

          response = await dio.post("${MyString.insertProduct}",
              data: formdata,
              options: Options(
                  headers: {"Authorization": "Bearer ${auth.token}"},
                  contentType: "application/json;charset=utf-8;multipart/form-data"));
          return ResponseMessage(
              message: response!.data['message'], status: response!.data['status']);
        }
      } else {
        if (image == null) {
          response = await dio.post("${MyString.insertProduct}", data: {
            "product_name": "$name",
            "product_id": "$idProduct",
            "product_price": typeOrder == true ? "${listTypeOrder![0].price}" : "$priceProduct",
            "is_by_order_type": "$typeOrder",
            "product_stok_status": "$stockProductStatus",
            "product_unit_product": "${satuanProduct!.unitProductName}",
            "product_status": "aktif",
            "product_stok": "$qtyStockProduct",
            "user_id": "${auth.userId}",
            "store": jsonEncode(listStored),
            // "price_json" : jsonEncode(typeOrderList),
            "product_description": "$desc",
            "product_price_modal": "$modal",
            "product_barcode": "$barcode",
            "sku": "$sku",
            "categori_id": "${categoryByStore!.categoryId}",
            "store_all": "${storeAll}"
          },options: options);
          return ResponseMessage(
              message: response!.data['message'], status: response!.data['status']);
        } else {
          var formdata = FormData.fromMap({
            "product_name": "$name",
            "product_id": "$idProduct",
            "product_price": typeOrder == true ? "${listTypeOrder![0].price}" : "$priceProduct",
            "is_by_order_type": "$typeOrder",
            "product_stok_status": "$stockProductStatus",
            "product_unit_product": "${satuanProduct!.unitProductName}",
            "product_status": "aktif",
            "product_barcode": "$barcode",
            "product_stok": "$qtyStockProduct",
            "user_id": "${auth.userId}",
            "store": jsonEncode(listStored),
            // "price_json" : jsonEncode(typeOrderList),
            "product_description": "$desc",
            "product_price_modal": "$modal",
            "sku": "$sku",
            "categori_id": "${categoryByStore!.categoryId}",
            "store_all": "${storeAll}",
            "product_photo": await MultipartFile.fromFile(image.path,
                filename: image.path.isNotEmpty ? image.path.split('/').last : '...'),
          });

          response = await dio.post("${MyString.insertProduct}",
              data: formdata,
              options: Options(
                  headers: {"Authorization": "Bearer ${auth.token}"},
                  contentType: "application/json;charset=utf-8;multipart/form-data"));
          return ResponseMessage(
              message: response!.data['message'], status: response!.data['status']);
        }
      }
    } on DioError catch (e) {
      print(e);
      return throw ServerException();
    }
  }
}
