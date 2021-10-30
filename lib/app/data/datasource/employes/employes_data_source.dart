import 'dart:convert';
import 'dart:math';

import 'package:api_cache_manager/models/cache_db_model.dart';
import 'package:api_cache_manager/utils/cache_manager.dart';
import 'package:dio/dio.dart';
import 'package:warmi/app/data/datalocal/session/auth_session_manager.dart';
import 'package:warmi/app/data/models/employes/employes_model.dart';
import 'package:warmi/core/globals/global_string.dart';
import 'package:warmi/core/network/base_dio.dart';
import 'package:warmi/core/network/response_message.dart';

class EmployeesDataSource extends BaseDio {
  AuthSessionManager auth = AuthSessionManager();
  Options? options;

  EmployeesDataSource() {
    options = new Options(headers: {"Authorization": "Bearer ${auth.token}"});
  }

  Future<EmployesModel> getEmployees() async {
    try {
      response = await dio.get("${MyString.getEmployees}", queryParameters: {"owner_id": "${auth.userIdOwner}"}, options: options);
      await APICacheManager().addCacheData(APICacheDBModel(key: 'API_EMPLOYEES_MODEL', syncData: jsonEncode(response!.data)));
      return EmployesModel.fromJson(response!.data);
    } on DioError catch (e) {
      print(e);
      var cacheData = await APICacheManager().getCacheData('API_EMPLOYEES_MODEL');
      var result = EmployesModel.fromJson(jsonDecode(cacheData.syncData));
      return result;
    }
  }

  Future<ResponseMessage> storeEmployees({String? employeesID, String? name, String? phoneNumber, String? pin,String? address}) async {
    try {
      Map<String, dynamic> data = {
        if (employeesID != null)
        "employe_id": "$employeesID",
        "name": "$name",
        "phone_number": "$phoneNumber",
        if(pin!="******")"pin": "$pin",
        "address" : "$address",
        "owner_id": "${auth.userIdOwner}"};
      response = await dio.post("${MyString.storeEmployees}", data: jsonEncode(data), options: options);
      return ResponseMessage(message: response!.data['message'], status: response!.data['status'], data: response!.data['data']);
    } on DioError catch (e) {
      print(e);
      return ResponseMessage(message: 'Error On API', status: false, data: response!.data['data']);
    }
  }


  Future<ResponseMessage> deleteEmployees({String? id}) async {
    try {
      response = await dio.delete("${MyString.deleteEmployees}/$id",
          queryParameters: {"owner_id": "${auth.userId}"}, options: options);

      return ResponseMessage(message: response!.data['message'], status: response!.data['status']);
    } on DioError catch (e) {
      print(e);
      return ResponseMessage(message: 'Erorr On API', status: response!.data['status']);
    }
  }
}
