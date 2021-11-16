import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:warmi/app/modules/history_sales/controllers/history_sales_controller.dart';
import 'package:warmi/app/modules/history_sales/controllers/history_sales_controller.dart';
import 'package:warmi/app/modules/history_sales/controllers/history_sales_controller.dart';
import 'package:warmi/app/modules/owner/report/controllers/report_controller.dart';
import 'package:warmi/app/modules/owner/report/controllers/report_controller.dart';
import 'package:warmi/app/modules/transaction/controllers/transaction_controller.dart';
import 'package:warmi/app/modules/transaction/controllers/transaction_controller.dart';
import 'package:warmi/app/modules/transaction/controllers/transaction_controller.dart';
import 'package:warmi/core/globals/global_string.dart';
import 'package:warmi/core/utils/enum.dart';

class LanguageSettingController extends GetxController {
  Rx<LanguageEnum> languageEnum = LanguageEnum.indonesia.obs;
  var transactionC = Get.isRegistered<TransactionController>()
      ? Get.find<TransactionController>()
      : Get.put(TransactionController());

  var historySaleC = Get.isRegistered<HistorySalesController>()
      ? Get.find<HistorySalesController>()
      : Get.put(HistorySalesController());
  var reportC = Get.isRegistered<ReportController>()
      ? Get.find<ReportController>()
      : Get.put(ReportController());
  var box = GetStorage();

  @override
  void onInit() {
    // TODO: implement onInit
    getDefaultLanguage();
    super.onInit();
  }

  void getDefaultLanguage() {
    if (box.read(MyString.DEFAULT_LANGUAGE) ==
        LanguageEnum.english.toString()) {
      languageEnum.value = LanguageEnum.english;
    } else {
      languageEnum.value = LanguageEnum.indonesia;
    }
  }

  void setLanguage() {
    if (languageEnum.value == LanguageEnum.english) {
      var locale = Locale('en', 'US');
      Get.updateLocale(locale);
      box.write(MyString.DEFAULT_LANGUAGE, LanguageEnum.english.toString());
      print(box.read(MyString.DEFAULT_LANGUAGE));
      transactionC.setTabName();
      historySaleC.setTabName();
      reportC.setLocale();
    } else if (languageEnum.value == LanguageEnum.indonesia) {
      var locale = Locale('id');
      Get.updateLocale(locale);
      transactionC.setTabName();
      historySaleC.setTabName();
      reportC.setLocale();
      box.write(MyString.DEFAULT_LANGUAGE, LanguageEnum.indonesia.toString());
      print(box.read(MyString.DEFAULT_LANGUAGE));
    }
  }
}
