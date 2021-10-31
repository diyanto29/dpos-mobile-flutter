import 'dart:convert';
import 'package:api_cache_manager/models/cache_db_model.dart';
import 'package:api_cache_manager/utils/cache_manager.dart';
import 'package:dio/dio.dart';
import 'package:warmi/app/data/datalocal/session/auth_session_manager.dart';
import 'package:warmi/app/data/models/product/cart.dart';
import 'package:warmi/app/data/models/transactions/transaction_model.dart';
import 'package:warmi/core/errors/exceptions.dart';
import 'package:warmi/core/globals/global_string.dart';
import 'package:warmi/core/network/base_dio.dart';
import 'package:warmi/core/network/response_message.dart';

class TransactionRemoteDataSource extends BaseDio {
  AuthSessionManager auth = AuthSessionManager();
  Options? options;

  TransactionRemoteDataSource() {
    options = new Options(headers: {"Authorization": "Bearer ${auth.token}"});
  }

  Future<ResponseMessage> storeTransaction(
      {String? dateTransaction,
      double? totalTransaction,
      String? paymentMethodID,
      String? paymentMethodStatus,
      String? transactionPaymentDate,
      String? transactionStatus,
      String? discountID,
      double? priceOff,
      double? transactionPay,
      double? transactionReceived,
      String? customerPartnerID,
      String? transactionNoted,
      List<CartModel>? listCart}) async {
    try {
      List<dynamic> listProduct = [];
      listCart!.forEach((item) {
        double discount = 0;
        double afterDiscount = 0;
        if (item.discount != null) {
          if (item.discount!.discountType == "percent") {
            if (item.discount!.discountMaxPriceOff == "0" || item.discount!.discountMaxPriceOff == null) {
              discount = item.subTotal! * (int.parse(item.discount!.discountPercent!) / 100);
              afterDiscount = item.subTotal! - discount;
            } else {
              double discount = item.subTotal! * (int.parse(item.discount!.discountPercent!) / 100);
              if (discount >= double.parse(item.discount!.discountMaxPriceOff!)) {
                afterDiscount = (item.subTotal! - double.parse(item.discount!.discountMaxPriceOff!));
              } else {
                afterDiscount = item.subTotal! - discount;
              }
            }
          }
        }

        listProduct.add({
          "product_id": "${item.dataProduct!.productId}",
          "product_qty": item.qty,
          "product_price": item.dataProduct!.productPrice,
          "total_weight": item.dataProduct!.productWeight,
          "discount_code": item.discount == null ? null : item.discount!.discountId,
          "sub_total": item.subTotal,
          "discount": item.discount == null
              ? null
              : item.discount!.discountType == "price"
                  ? item.discount!.discountMaxPriceOff
                  : discount,
          "price_after_discount": afterDiscount
        });
      });

      Map<dynamic, dynamic> data = {
        if (auth.roleName == "Pemilik Toko") "user_id": "${auth.userId}" else "user_id": null,
        if (auth.roleName != "Pemilik Toko") "employe_id": "${auth.userId}" else "user_id": null,
        "store_id": "${auth.storeId}",
        "transaction_note": transactionNoted,
        "transaction_date": dateTransaction,
        "transaction_total": totalTransaction,
        "transaction_payment_method_id": paymentMethodID,
        "transaction_payment_status": paymentMethodStatus,
        "transaction_payment_date": transactionPaymentDate,
        "transaction_status": transactionStatus,
        "transaction_voucher_id": discountID,
        "transaction_price_off_voucher": priceOff,
        "transaction_pay": transactionPay,
        "transaction_received": transactionReceived,
        "customer_partner_id": customerPartnerID,
        "products": listProduct
      };
      print(jsonEncode(data));
      response = await dio.post(MyString.storeTransaction, data: jsonEncode(data), options: options);
      return ResponseMessage(message: response!.data['message'], status: response!.data['status'], data: response!.data['data']);
    } on DioError catch (e) {
      print(e);
      throw ServerException();
    }
  }

  Future<TransactionModel> getTransaction({bool userID = false, String? statusTransaction, String? statusPayment}) async {
    try {
      response = await dio.get("${MyString.getTransaction}",
          queryParameters: {"store_id": "${auth.storeId}",
            if (auth.roleName.toString() != "Pemilik Toko") "employe_id": "${auth.userId}",
            if (statusTransaction != null) "transaction_status": "$statusTransaction", if (statusPayment != null)
              "transaction_payment_status": "${statusPayment}"},
          options: options);
      await APICacheManager().addCacheData(APICacheDBModel(key: 'API_TRANSACTION_MODEL', syncData: jsonEncode(response!.data)));
      return TransactionModel.fromJson(response!.data);
    } on DioError catch (e) {
      print(e);
      var cacheData = await APICacheManager().getCacheData('API_TRANSACTION_MODEL');
      var result = TransactionModel.fromJson(jsonDecode(cacheData.syncData));
      return result;
    }
  }

  Future<ResponseMessage> changeStatusTransaction({String? paymentMethodID, String? paymentMethodStatus, String? transactionPaymentDate, String? transactionStatus, double? transactionPay, String? transactionID, double? transactionReceived, List<CartModel>? listCart}) async {
    try {
      Map<dynamic, dynamic> data = {
        if (auth.roleName == "Pemilik Toko") "user_id": "${auth.userId}" else "user_id": null,
        if (auth.roleName == "Pemilik Toko") "employe_id": null else "user_id": "${auth.userId}",
        "store_id": "${auth.storeId}",
        "transaction_payment_method_id": paymentMethodID,
        "transaction_payment_status": paymentMethodStatus,
        "transaction_payment_date": transactionPaymentDate,
        "transaction_status": transactionStatus,
        "transaction_id": transactionID,
        "transaction_pay": transactionPay,
        "transaction_received": transactionReceived,
      };
      print(jsonEncode(data));
      response = await dio.post(MyString.changeStatusTransaction, data: jsonEncode(data), options: options);
      return ResponseMessage(message: response!.data['message'], status: response!.data['status'], data: response!.data['data']);
    } on DioError catch (e) {
      print(e);
      throw ServerException();
    }
  }
}
