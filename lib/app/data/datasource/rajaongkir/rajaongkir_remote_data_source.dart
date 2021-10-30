import 'dart:convert';

import 'package:api_cache_manager/models/cache_db_model.dart';
import 'package:api_cache_manager/utils/cache_manager.dart';
import 'package:dio/dio.dart';
import 'package:warmi/app/data/models/rajaongkir/city.dart';
import 'package:warmi/app/data/models/rajaongkir/province.dart';
import 'package:warmi/app/data/models/rajaongkir/subdistrict.dart';
import 'package:warmi/core/errors/exceptions.dart';
import 'package:warmi/core/globals/global_string.dart';
import 'package:warmi/core/network/base_dio.dart';

class RajaOngkirRemoteDataSource extends BaseDio {
  Future<ProvinceModel> getProvince() async {
    try {
      response = await dio.get("${MyString.api_raja_ongkir}/province",
          options: Options(headers: {'key': "${MyString.key_raja_ongkir}"}));
      await APICacheManager().addCacheData(APICacheDBModel(key: 'API_RAJA_ONGKIR_PROVINCE', syncData: jsonEncode(response!.data)));
      return ProvinceModel.fromJson(response!.data);
    } on DioError catch (e) {
      print(e);
      var cacheData = await APICacheManager().getCacheData('API_RAJA_ONGKIR_PROVINCE');
      var result = ProvinceModel.fromJson(jsonDecode(cacheData.syncData));
      return result;
    }
  }

  Future<CityModel> getCity({String? provinceId}) async {
    try {
      response = await dio.get("${MyString.api_raja_ongkir}/city",
          queryParameters: {'province': "$provinceId"},
          options: Options(headers: {'key': "${MyString.key_raja_ongkir}"}));
      await APICacheManager().addCacheData(APICacheDBModel(key: 'API_RAJA_ONGKIR_CITY', syncData: jsonEncode(response!.data)));
      return CityModel.fromJson(response!.data);
    } on DioError catch (e) {
      print(e);
      var cacheData = await APICacheManager().getCacheData('API_RAJA_ONGKIR_CITY');
      var result = CityModel.fromJson(jsonDecode(cacheData.syncData));
      return result;
    }
  }

  Future<SubdistrictModel> getSubdistrict({String? cityId}) async {
    try {
      response = await dio.get("${MyString.api_raja_ongkir}/subdistrict",
          queryParameters: {'city': "$cityId"},
          options: Options(headers: {'key': "${MyString.key_raja_ongkir}"}));
      await APICacheManager().addCacheData(APICacheDBModel(key: 'API_RAJA_ONGKIR_SUBDISTRICT', syncData: jsonEncode(response!.data)));
      return SubdistrictModel.fromJson(response!.data);
    } on DioError catch (e) {
      print(e);
      var cacheData = await APICacheManager().getCacheData('API_RAJA_ONGKIR_SUBDISTRICT');
      var result = SubdistrictModel.fromJson(jsonDecode(cacheData.syncData));
      return result;
    }
  }
}
