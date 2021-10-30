import 'dart:convert';

import 'package:api_cache_manager/models/cache_db_model.dart';
import 'package:api_cache_manager/utils/cache_manager.dart';
import 'package:dio/dio.dart';
import 'package:warmi/app/data/models/business/type_business.dart';
import 'package:warmi/core/globals/global_string.dart';
import 'package:warmi/core/network/base_dio.dart';

class BusinessDataSource extends BaseDio {

  Future<List<TypeBusiness>?> getTypeBusiness() async {
    try {
      response = await dio.get("${MyString.getTypeBusiness}");
      await APICacheManager().addCacheData(APICacheDBModel(key: 'API_CATEGORY_BUSINESS', syncData: jsonEncode(response!.data)));
      TypeBusinessModel result = TypeBusinessModel.fromJson(response!.data);
      return result.data;
    } on DioError catch (e) {
      print('asdasd');
      var isCacheExist = await APICacheManager().isAPICacheKeyExist('API_CATEGORY_BUSINESS');
      var cacheData = await APICacheManager().getCacheData('API_CATEGORY_BUSINESS');
      var result = TypeBusinessModel.fromJson(jsonDecode(cacheData.syncData));
      return result.data;
    }
  }
}
