import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:warmi/app/data/datalocal/session/auth_session_manager.dart';
import 'package:warmi/app/data/models/customer/customer_model.dart';
import 'package:warmi/app/data/models/discount/discount.dart';
import 'package:warmi/core/errors/exceptions.dart';
import 'package:warmi/core/globals/global_string.dart';
import 'package:warmi/core/network/base_dio.dart';
import 'package:warmi/core/network/response_message.dart';

class CustomerRemoteDataSource extends BaseDio {
  AuthSessionManager auth = AuthSessionManager();
  Options? options;

  CustomerRemoteDataSource() {
    options = new Options(headers: {"Authorization": "Bearer ${auth.token}"});
  }

  Future<CustomerModel> getCustomer() async {
    try {
      response = await dio.get("${MyString.getCustomer}",
          queryParameters: {"user_id": "${auth.userIdOwner}"},
          options: options);
      return CustomerModel.fromJson(response!.data);
    } on DioError catch (e) {
      print(e);
      return throw ServerException();
    }
  }

  Future<ResponseMessage> createCustomer(
      {String? name,
      String? email,
      String? phoneNumber,
      String? address,
      String? id}) async {
    try {
      response = await dio.post("${MyString.updateOrCreateCustomer}",
          data: {
            "name": "$name",
            "email": "$email",
            "phone_number": "$phoneNumber",
            "address": "$address",
            "user_id": "${auth.userIdOwner}",
            if (id != null) "id": "$id"
          },
          options: options);
      return ResponseMessage(
          message: response!.data['message'],
          status: response!.data['status'],
          data: response!.data['data']);
    } on DioError catch (e) {
      print(e);
      return throw ServerException();
    }
  }

  Future<ResponseMessage> deleteCustomer({String? id}) async {
    try {
      response = await dio.delete("${MyString.deleteCustomer}/$id",
          queryParameters: {"user_id": "${auth.userIdOwner}"},
          options: options);

      return ResponseMessage(
          message: response!.data['message'], status: response!.data['status']);
    } on DioError catch (e) {
      print(e);
      return throw ServerException();
    }
  }
}
