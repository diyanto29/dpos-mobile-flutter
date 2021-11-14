import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:warmi/core/globals/global_string.dart';
import 'package:warmi/core/utils/enum.dart';

class LanguageSettingController extends GetxController {
  Rx<LanguageEnum> languageEnum = LanguageEnum.indonesia.obs;
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
    } else if (languageEnum.value == LanguageEnum.indonesia) {
      var locale = Locale('id');
      Get.updateLocale(locale);
      box.write(MyString.DEFAULT_LANGUAGE, LanguageEnum.indonesia.toString());
      print(box.read(MyString.DEFAULT_LANGUAGE));
    }
  }
}
