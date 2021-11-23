import 'dart:convert';

import 'package:api_cache_manager/api_cache_manager.dart';
import 'package:api_cache_manager/models/cache_db_model.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:warmi/app/data/datalocal/session/auth_session_manager.dart';
import 'package:warmi/app/data/models/product/category_product.dart';
import 'package:warmi/core/errors/exceptions.dart';
import 'package:warmi/core/globals/global_string.dart';
import 'package:warmi/core/network/base_dio.dart';
import 'package:warmi/core/network/response_message.dart';

class CategoryProductRemoteDataSource extends BaseDio {
  AuthSessionManager auth = AuthSessionManager();
  Options? options;

  CategoryProductRemoteDataSource() {
    options = new Options(headers: {"Authorization": "Bearer ${auth.token}"});
  }

  Future<CategoryProductModel> getCategoryProduct() async {
    try {
      response = await dio.get("${MyString.getCategoryByStore}",
          queryParameters: {'store_id': "${auth.storeId}"}, options: options);
      if(GetPlatform.isAndroid){
        await APICacheManager().addCacheData(APICacheDBModel(
            key: 'API_CATEGORY_PRODUCT_MODEL',
            syncData: jsonEncode(response!.data)));
      }
      return CategoryProductModel.fromJson(response!.data);
    } on DioError catch (e) {
      print(e);
      var cacheData =
          await APICacheManager().getCacheData('API_CATEGORY_PRODUCT_MODEL');
      var result =
          CategoryProductModel.fromJson(jsonDecode(cacheData.syncData));
      return result;
    }
  }

  Future<ResponseMessage> createCategoryProduct(
      {String? id, String? name}) async {
    try {
      response = await dio.post(MyString.insertCategoryByStore,
          data: {
            "id": id == null
                ? "${auth.storeId + DateTime.now().millisecondsSinceEpoch.toString()}"
                : "$id",
            "store_id": "${auth.storeId}",
            "category_name": "$name",
          },
          options: options);
      return ResponseMessage(
          message: response!.data['message'], status: response!.data['status']);
    } on DioError catch (e) {
      print(e);
      throw ServerException();
    }
  }

  Future<ResponseMessage> deleteCategoryProduct({required String id}) async {
    try {
      response = await dio.post("${MyString.deleteCategoryByStore}/$id",
          options: options);
      return ResponseMessage(
          message: response!.data['message'], status: response!.data['status']);
    } on DioError catch (e) {
      print(e);
      throw ServerException();
    }
  }
}
