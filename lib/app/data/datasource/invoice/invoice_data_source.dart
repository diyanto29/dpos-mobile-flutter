import 'dart:convert';

import 'package:api_cache_manager/models/cache_db_model.dart';
import 'package:api_cache_manager/utils/cache_manager.dart';
import 'package:dio/dio.dart';
import 'package:warmi/app/data/datalocal/session/auth_session_manager.dart';
import 'package:warmi/app/data/models/invoice/invoice_model.dart';
import 'package:warmi/core/errors/exceptions.dart';
import 'package:warmi/core/globals/global_string.dart';
import 'package:warmi/core/network/base_dio.dart';
import 'package:warmi/core/network/response_message.dart';

class InvoiceDataRemote extends BaseDio {
  AuthSessionManager auth = AuthSessionManager();
  Options? options;

  InvoiceDataRemote() {
    options = new Options(headers: {"Authorization": "Bearer ${auth.token}"});
  }

  Future<InvoiceModel> getInvoice() async {
    try {
      response = await dio.get("${MyString.getInvoice}", queryParameters: {"user_id": "${auth.userIdOwner}"}, options: options);
      await APICacheManager().addCacheData(APICacheDBModel(key: 'API_INVOICE_MODEL', syncData: jsonEncode(response!.data)));
      return InvoiceModel.fromJson(response!.data);
    } on DioError catch (e) {
      print(e);
      var cacheData = await APICacheManager().getCacheData('API_INVOICE_MODEL');
      var result = InvoiceModel.fromJson(jsonDecode(cacheData.syncData));
      return result;
    }
  }

  Future<ResponseMessage> storeInvoice({String? footerText, bool? logo, bool? logoDpos}) async {
    try {
      response = await dio.post("${MyString.storeInvoice}",
          data: {
            "footer_text": "$footerText",
            "cetak_logo_struk": "$logo",
            "cetak_logo_dpos": "$logoDpos",
            "user_id": "${auth.userIdOwner}",
          },
          options: options);
      return ResponseMessage(message: response!.data['message'], status: response!.data['status'], data: response!.data['data']);
    } on DioError catch (e) {
      print(e);
      return throw ServerException();
    }
  }
}
