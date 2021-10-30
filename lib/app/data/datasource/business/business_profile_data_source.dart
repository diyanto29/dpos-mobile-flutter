import 'dart:convert';
import 'dart:io';

import 'package:api_cache_manager/api_cache_manager.dart';
import 'package:api_cache_manager/models/cache_db_model.dart';
import 'package:dio/dio.dart';
import 'package:warmi/app/data/datalocal/session/auth_session_manager.dart';
import 'package:warmi/app/data/models/business/type_business.dart';
import 'package:warmi/core/errors/exceptions.dart';
import 'package:warmi/core/globals/global_string.dart';
import 'package:warmi/core/network/base_dio.dart';

class BusinessProfileDataSource extends BaseDio {
  AuthSessionManager authSessionManager = AuthSessionManager();

  Future<dynamic> getBusinessProfile() async {
    try {
      print('aini');
      response = await dio.get("${MyString.getBusinessUser}",
          options: Options(headers: {"Authorization": "Bearer ${authSessionManager.token}"}));
      await APICacheManager().addCacheData(APICacheDBModel(key: 'API_BUSINESS_USER', syncData: jsonEncode(response!.data)));
      return response!.data;
    } on DioError catch (e) {

      var isCacheExist = await APICacheManager().isAPICacheKeyExist('API_BUSINESS_USER');
      var cacheData=await APICacheManager().getCacheData('API_BUSINESS_USER');
      var result= TypeBusinessModel.fromJson(jsonDecode(cacheData.syncData));
      return result.data;
    }
  }

  Future<bool> updateBusinessProfile(
      {required String businessName,
      required TypeBusiness typeBusiness,
      String? crewTotal,
      String? branch,
      String? websiteName,
      String? contact,
      File? pathLogo,
      String? fileName}) async {
    try {

      var formData;

      if(pathLogo!=null){
      formData=  FormData.fromMap({
          "id": "${authSessionManager.businessId}",
          "name": "$businessName",
          "category_id": "${typeBusiness.businessCategoryId}",
          "website_name": "$websiteName",
          "crew_total": "$crewTotal",
          "branch": "$branch",
          "contact": "$contact",
          "logo": await MultipartFile.fromFile(pathLogo.path,
              filename: pathLogo.path.isNotEmpty ? pathLogo.path.split('/').last : '...'),
        });
      }else{
       formData= FormData.fromMap({
          "id": "${authSessionManager.businessId}",
          "name": "$businessName",
          "category_id": "${typeBusiness.businessCategoryId}",
          "website_name": "$websiteName",
          "crew_total": "$crewTotal",
          "branch": "$branch",
          "contact": "$contact",
          "logo": null,
        });
      }

      response = await dio.post("${MyString.updateBusiness}", data: formData,
      options: Options(
        contentType: 'application/json;multipart/form-data',
        headers: {"Authorization": "Bearer ${authSessionManager.token}"}
      ));
      return true;
    } on DioError catch (e) {
      print(e);
      throw ServerException();
    }
  }
}
