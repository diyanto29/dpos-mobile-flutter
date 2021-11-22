import 'dart:ui';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:in_app_update/in_app_update.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:warmi/app/data/datasource/business/business_data_source.dart';
import 'package:warmi/app/routes/app_pages.dart';
import 'package:warmi/core/globals/global_string.dart';
import 'package:warmi/core/utils/enum.dart';

class SplashController extends GetxController {
  AppUpdateInfo? _updateInfo;

  Future<void> checkForUpdate() async {
    InAppUpdate.checkForUpdate().then((info) {
      _updateInfo = info;

      if (_updateInfo!.updateAvailability ==
          UpdateAvailability.updateAvailable) {
        InAppUpdate.performImmediateUpdate().catchError((e) {
          print(e);
        });
      }
    }).catchError((e) {
      print(e);
    });
  }

  @override
  void onInit() async {
    print("init");
    if(GetPlatform.isAndroid){
      checkForUpdate();

      await Permission.storage.request();
    }
    BusinessDataSource().getTypeBusiness();

    checkSessionLogin();
    super.onInit();
  }

  @override
  void onReady() {
    print("hg");
    super.onReady();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void onClose() {}

  Future<void> checkSessionLogin() async {
    print("hhhhhhhhhhhhhhhhhhh");
    GetStorage box = GetStorage();
    print(box.hasData(MyString.DEFAULT_LANGUAGE));
    if (box.hasData(MyString.DEFAULT_LANGUAGE)) {
      if (box.read(MyString.DEFAULT_LANGUAGE) == LanguageEnum.english.toString()) {
        initializeDateFormatting('en_US');
        Get.updateLocale(Locale('en', 'US'));
        print('INI ENGLISH');
      } else {
        initializeDateFormatting('id_ID');
        Get.updateLocale(Locale('id'));
        print('INI INDONESIA');
      }
      print('INI PRINT ADA DATA');
    } else {
      initializeDateFormatting('id_ID');
      Get.updateLocale(Locale('id'));
      box.write(MyString.DEFAULT_LANGUAGE, LanguageEnum.indonesia.toString());
      print('INI INDONESIA DATA KOSONG');
    }
    print(box.read(MyString.DEFAULT_LANGUAGE));

      box.writeIfNull(MyString.TYPE_FONT_HEADER, 2);
      box.writeIfNull(MyString.FONT_HEADER, 'size1');
      box.writeIfNull(MyString.TYPE_FONT_FOOTER, 2);
      box.writeIfNull(MyString.FONT_FOOTER, 'size1');
      box.writeIfNull(MyString.TYPE_FONT_CONTENT, 2);
      box.writeIfNull(MyString.FONT_CONTENT, 'size1');
      box.writeIfNull(MyString.TYPE_FONT_TOTAL, 2);
      box.writeIfNull(MyString.FONT_TOTAL, 'size1');



    Future.delayed(Duration(seconds: 1), () {

      if (box.hasData(MyString.USER_ID)) {
        if (box
            .read(MyString.ROLE_NAME)
            .toString()
            .toLowerCase()
            .contains('pemilik toko')) {
          Get.offAllNamed(Routes.NAVIGATION);
        } else {
          Get.offAllNamed(Routes.INDEX_TRANSACTION);
        }
      } else {
        Get.offAllNamed(Routes.LOGIN_CHOOISE);
      }
    });
  }
}
