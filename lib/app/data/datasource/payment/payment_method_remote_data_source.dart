import 'dart:convert';

import 'package:api_cache_manager/models/cache_db_model.dart';
import 'package:api_cache_manager/utils/cache_manager.dart';
import 'package:dio/dio.dart';
import 'package:warmi/app/data/datalocal/session/auth_session_manager.dart';
import 'package:warmi/app/data/models/payment_method/payment_method_channel.dart';
import 'package:warmi/core/errors/exceptions.dart';
import 'package:warmi/core/globals/global_string.dart';
import 'package:warmi/core/network/base_dio.dart';
import 'package:warmi/core/network/response_message.dart';

class PaymentMethodRemoteDataSource extends BaseDio {
  AuthSessionManager auth = AuthSessionManager();
  Options? options;

  PaymentMethodRemoteDataSource() {
    options = new Options(headers: {"Authorization": "Bearer ${auth.token}"});
  }

  Future<PaymentMethodChannel> getPaymentMethod() async {
    try {
      response = await dio.get("${MyString.getPaymentMehtod}",
          queryParameters: {"user_id": "${auth.userIdOwner}"}, options: options);
      await APICacheManager().addCacheData(APICacheDBModel(
          key: 'API_PAYMENT_METHOD', syncData: jsonEncode(response!.data)));
      return PaymentMethodChannel.fromJson(response!.data);
    } on DioError catch (e) {
      print(e);
      var cacheData =
          await APICacheManager().getCacheData('API_PAYMENT_METHOD');
      var result =
          PaymentMethodChannel.fromJson(jsonDecode(cacheData.syncData));
      return result;
    }
  }

  Future<ResponseMessage> updatePaymentMethod(
      {required List<DataPaymentMethod> paymentMethod}) async {
    try {
      List<dynamic> listPaymentMethod = [];
      List<dynamic> listPaymentMethodChannel = [];
      paymentMethod.forEach((channel) {
        if (channel.paymentmethodstatus!.toLowerCase() == 'disable') {
          listPaymentMethodChannel.add({
            "payment_method_type_id": channel.paymentmethodtypeid,
            "status": 0
          });
        } else {
          listPaymentMethodChannel.add({
            "payment_method_type_id": channel.paymentmethodtypeid,
            "status": 1
          });
        }

        channel.paymentMethod!.forEach((element) {
          if (element.status!.toLowerCase() == 'disable') {
            listPaymentMethod.add(
                {"payment_method_id": element.paymentmethodid, "status": 0});
          } else {
            listPaymentMethod.add(
                {"payment_method_id": element.paymentmethodid, "status": 1});
          }
        });
      });

      Map<String, dynamic> data = {
        "user_id": "${auth.userIdOwner}",
        "payment_method": listPaymentMethod,
        "payment_method_channel": listPaymentMethodChannel
      };
      response = await dio.post("${MyString.updatePaymentMethodByUser}",
          data: jsonEncode(data),
          queryParameters: {"user_id": "${auth.userIdOwner}"},
          options: options);

      return ResponseMessage(
          message: response!.data['message'],
          status: response!.data['status'],
          data: response!.data['data']);
    } on DioError catch (e) {
      print(e);
      throw ServerException();
    }
  }
}
