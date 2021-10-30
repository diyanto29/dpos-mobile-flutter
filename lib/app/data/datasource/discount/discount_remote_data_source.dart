import 'dart:math';

import 'package:dio/dio.dart';
import 'package:warmi/app/data/datalocal/session/auth_session_manager.dart';
import 'package:warmi/app/data/models/discount/discount.dart';
import 'package:warmi/core/errors/exceptions.dart';
import 'package:warmi/core/globals/global_string.dart';
import 'package:warmi/core/network/base_dio.dart';
import 'package:warmi/core/network/response_message.dart';

class DiscountRemoteDataSource extends BaseDio {
  AuthSessionManager auth = AuthSessionManager();
  Options? options;

  DiscountRemoteDataSource() {
    options = new Options(headers: {"Authorization": "Bearer ${auth.token}"});
  }

  Future<DiscountModel> getDiscount() async {
    try {
      response = await dio.get("${MyString.getDiscount}",
          queryParameters: {"owner_id": "${auth.userId}"}, options: options);

      return DiscountModel.fromJson(response!.data);
    } on DioError catch (e) {
      print(e);
      return throw ServerException();
    }
  }

  Future<ResponseMessage> createDiscount(
      {String? name,
      bool? isPercent,
      String? maxPriceOff,
      String? percent,
      String? idDiscount}) async {
    try {
      Random random = new Random();
      int randomNumber = random.nextInt(100);

      response = await dio.post("${MyString.insertDiscount}",
          data: {
            "name": "$name",
            "is_percent": "$isPercent",
            "percent": "$percent",
            "code": "${randomNumber.toString()}",
            "max_price_off": "$maxPriceOff",
            "owner_id": "${auth.userId}",
            if (idDiscount != null) "id": "$idDiscount"
          },
          options: options);
      return ResponseMessage(
          message: response!.data['message'], status: response!.data['status']);
    } on DioError catch (e) {
      print(e);
      return throw ServerException();
    }
  }

  Future<ResponseMessage> deleteDiscount({String? id}) async {
    try {
      response = await dio.delete("${MyString.deleteDiscount}/$id",
          queryParameters: {"owner_id": "${auth.userId}"}, options: options);

      return ResponseMessage(message: response!.data['message'], status: response!.data['status']);
    } on DioError catch (e) {
      print(e);
      return throw ServerException();
    }
  }
}
