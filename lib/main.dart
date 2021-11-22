import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:intl/intl.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:warmi/core/globals/messages.dart';

import 'app/routes/app_pages.dart';
import 'core/globals/global_color.dart';
import 'di/depedency_injection.dart';

final formatCurrency =
    new NumberFormat.currency(locale: "id_ID", symbol: "", decimalDigits: 0);

void main() async {
  LazyBindings().dependencies();
  await GetStorage.init();
  if(GetPlatform.isAndroid){
    MobileAds.instance.initialize();
  }
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  var locale = Locale('id');

  runApp(
    ResponsiveSizer(
      builder: (context, orientation, screenType) => GetMaterialApp(
        title: "DPOS",
        theme: ThemeData(primaryColor: MyColor.colorOrangeDark),
        // translationsKeys: AppTranslation.translations,
        themeMode: ThemeMode.dark,
        debugShowCheckedModeBanner: false,
        initialRoute: AppPages.INITIAL,
        getPages: AppPages.routes,
        translations: Messages(),
        locale: locale,
      ),
    ),
  );
}
