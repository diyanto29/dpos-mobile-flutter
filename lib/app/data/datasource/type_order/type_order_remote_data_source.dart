import 'package:dio/dio.dart';
import 'package:warmi/app/data/datalocal/session/auth_session_manager.dart';
import 'package:warmi/app/data/models/type_order/type_order.dart';
import 'package:warmi/core/errors/exceptions.dart';
import 'package:warmi/core/globals/global_string.dart';
import 'package:warmi/core/network/base_dio.dart';

class TypeOrderRemoteDataSource extends BaseDio {
  AuthSessionManager authSessionManager = AuthSessionManager();

  Future<TypeOrderModel> getTypeOrder() async {
    try {
      response = await dio.get("${MyString.getTypeOrder}",
          queryParameters: {'id': "${authSessionManager.storeId}"});
      return TypeOrderModel.fromJson(response!.data);
    } on DioError catch (e) {
      print(e);
      throw ServerException();
    }
  }

  Future<bool> createOrUpdateTypeOrder({String? id, String? name}) async {
    try {
      Map<String, dynamic> data = {
        "name": "$name",
        "store_id": "${authSessionManager.storeId}",
        "id": id
      };
      response = await dio.post("${MyString.addOrUpdateTypeOrder}",
          data: data,
          options: Options(headers: {
            "Authorization": "Bearer ${authSessionManager.token}"
          }));
      if (response!.data['status']) {
        return true;
      } else {
        return false;
      }
    } on DioError catch (e) {
      print(e);
      throw ServerException();
    }
  }

  Future<bool> deleteTypeOrder({String? id}) async {
    try {
      response = await dio.post("${MyString.deleteTypeOrder}/$id",
          options: Options(headers: {
            "Authorization": "Bearer ${authSessionManager.token}"
          }));
      if (response!.data['status']) {
        return true;
      } else {
        return false;
      }
    } on DioError catch (e) {
      print(e);
      throw ServerException();
    }
  }
}
