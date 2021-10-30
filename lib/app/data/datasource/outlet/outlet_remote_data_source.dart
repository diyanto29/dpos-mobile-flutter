import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:warmi/app/data/datalocal/session/auth_session_manager.dart';
import 'package:warmi/app/data/models/outlet/outlet.dart';
import 'package:warmi/core/errors/exceptions.dart';
import 'package:warmi/core/globals/global_string.dart';
import 'package:warmi/core/network/base_dio.dart';
import 'package:warmi/core/network/response_message.dart';

class OutletRemoteDataSource extends BaseDio {
  AuthSessionManager auth = AuthSessionManager();

  Options? options;

  OutletRemoteDataSource() {
    options = new Options(headers: {"Authorization": "Bearer ${auth.token}"});
  }

  //get data from api
  Future<OutletModel> getOutlet() async {
    try {
      Response response;
      response = await dio.get(MyString.getStore, queryParameters: {"user_id": "${auth.userIdOwner}"},
      options: options);
      return OutletModel.fromJson(response.data);
    } on DioError catch (e) {
      print(e);
      throw ServerException();
    }
  }

  //send data outlet to api
  Future<ResponseMessage> insertOrUpdateStore(
      {bool edit = false, String? name, String? desc, String? storeId, Address? address,String? operationStart,String? operationClose}) async {
    try {
      Map<dynamic, dynamic> data = {};

        data = {
          "store_name": "$name",
          "store_description": "$desc",
          "operation_start" : "$operationStart",
          "operation_close" : "$operationClose",
          if(storeId!=null)   "store_id": "$storeId",
          "user_id": "${auth.userId}",
          "address": address != null ? address.toJson() : null
        };


      response = await dio.post(MyString.insertStore, data: data,options: options);
      return ResponseMessage(message: response!.data['message'], status: response!.data['status']);

    } on DioError catch (e) {
      print(e);
      throw ServerException();
    }
  }

//delete store
  Future<ResponseMessage> deleteStore({required String idStore}) async {
    Map<dynamic, dynamic> data = {"store_id": "$idStore"};
    try {
      response = await dio.post(MyString.deleteStore, data: jsonEncode(data),options: options);
      return ResponseMessage(message: response!.data['message'], status: response!.data['status']);
    } on DioError catch (e) {
      print(e);
      throw ServerException();
    }
  }
}
