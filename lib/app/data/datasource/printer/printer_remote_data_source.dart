import 'dart:convert';

import 'package:api_cache_manager/models/cache_db_model.dart';
import 'package:api_cache_manager/utils/cache_manager.dart';
import 'package:dio/dio.dart';
import 'package:warmi/app/data/datalocal/session/auth_session_manager.dart';
import 'package:warmi/app/data/models/printer/printer_model.dart';
import 'package:warmi/core/errors/exceptions.dart';
import 'package:warmi/core/globals/global_string.dart';
import 'package:warmi/core/network/base_dio.dart';
import 'package:warmi/core/network/response_message.dart';

class PrinterRemoteDataSource extends BaseDio {
  AuthSessionManager auth = AuthSessionManager();
  Options? options;

  PrinterRemoteDataSource() {
    options = new Options(headers: {"Authorization": "Bearer ${auth.token}"});
  }

  Future<PrinterModel> getPrinterDevice() async {
    try {
      response = await dio.get("${MyString.getPrinter}", queryParameters: {"user_id": "${auth.userIdOwner}"}, options: options);
      await APICacheManager().addCacheData(APICacheDBModel(key: 'API_PRINTER_MODEL', syncData: jsonEncode(response!.data)));
      return PrinterModel.fromJson(response!.data);
    } on DioError catch (e) {
      print(e);
      var cacheData = await APICacheManager().getCacheData('API_PRINTER_MODEL');
      var result = PrinterModel.fromJson(jsonDecode(cacheData.syncData));
      return result;
    }
  }

  Future<ResponseMessage> storePrinter({String? printerName, String? printerMac, String? printerIp, String? paperType, String? printerId}) async {
    try {
      response = await dio.post("${MyString.storePrinter}",
          data: {
            "printer_name": "$printerName",
            "paper_type": "$paperType",
            "printer_mac": "$printerMac",
            "printer_ip": "$printerIp",
            "user_id": "${auth.userIdOwner}",
            if (printerId != null) "printer_id": "$printerId"
          },
          options: options);
      return ResponseMessage(message: response!.data['message'], status: response!.data['status'], data: response!.data['data']);
    } on DioError catch (e) {
      print(e);
      return throw ServerException();
    }
  }

  Future<ResponseMessage> deletePrinter({String? id}) async {
    try {
      response = await dio.delete("${MyString.deletePrinter}/$id",
          queryParameters: {"owner_id": "${auth.userId}"}, options: options);

      return ResponseMessage(message: response!.data['message'], status: response!.data['status']);
    } on DioError catch (e) {
      print(e);
      return throw ServerException();
    }
  }
}

