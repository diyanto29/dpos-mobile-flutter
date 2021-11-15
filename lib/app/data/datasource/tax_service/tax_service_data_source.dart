import 'dart:convert';

import 'package:api_cache_manager/api_cache_manager.dart';
import 'package:api_cache_manager/models/cache_db_model.dart';
import 'package:dio/dio.dart';
import 'package:warmi/app/data/datalocal/session/auth_session_manager.dart';
import 'package:warmi/app/data/models/tax_service/model_tax_service.dart';
import 'package:warmi/core/errors/exceptions.dart';
import 'package:warmi/core/globals/global_string.dart';
import 'package:warmi/core/network/base_dio.dart';
import 'package:warmi/core/network/response_message.dart';

class TaxServiceDataSource extends BaseDio {
  AuthSessionManager auth = AuthSessionManager();
  Options? options;

  TaxServiceDataSource() {
    options = new Options(headers: {"Authorization": "Bearer ${auth.token}"});
  }

  Future<ModelTaxService> getTaxService() async {
    try {
      response = await dio.get("${MyString.getTaxService}",
          queryParameters: {"user_id": "${auth.userId}"}, options: options);
      await APICacheManager().addCacheData(APICacheDBModel(
          key: 'API_TAX_SERVICE', syncData: jsonEncode(response!.data)));
      return ModelTaxService.fromJson(response!.data);
    } on DioError catch (e) {
      print(e);
      var cacheData = await APICacheManager().getCacheData('API_TAX_SERVICE');
      var result = ModelTaxService.fromJson(jsonDecode(cacheData.syncData));
      return result;
    }
  }

  Future<ResponseMessage> postAddTaxService({
    required String taxPercent,
    required bool taxStatus,
    required String servicePercent,
    required bool serviceStatus,
    required bool includeCountTaxService,
  }) async {
    try {
      Map<dynamic, dynamic> data = {
        "tax_percentage": taxPercent,
        "tax_type": 'percent',
        "tax_status": taxStatus,
        "service_percentage": servicePercent,
        "service_type": 'percent',
        "service_status": serviceStatus,
        "include_count_tax_service": includeCountTaxService,
        "user_id": auth.userId,
      };
      response = await dio.post("${MyString.postTaxService}",
          data: jsonEncode(data), options: options);
      return ResponseMessage(
          message: response!.data['message'],
          status: response!.data['status'],
          data: response!.data['data']);
    } on DioError catch (e) {
      print(e);
      return ResponseMessage(
          message: 'Error from API',
          status: false,
          data: null);
    }
  }
}
