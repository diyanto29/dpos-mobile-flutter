import 'package:get/get.dart';
import 'package:warmi/app/modules/history_sales/controllers/history_sales_controller.dart';
import 'package:warmi/app/modules/owner/home/controllers/home_controller.dart';
import 'package:warmi/app/modules/owner/outlet/controllers/outlet_controller.dart';
import 'package:warmi/app/modules/owner/report/controllers/report_controller.dart';
import 'package:warmi/app/modules/owner/settings/controllers/setting_controller.dart';


import '../controllers/navigation_controller.dart';

class NavigationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NavigationController>(
      () => NavigationController(),
    );
    Get.lazyPut<HomeController>(
      () => HomeController(),
    );
    Get.lazyPut<HistorySalesController>(
      () => HistorySalesController(),
    );
    Get.lazyPut<ReportController>(
      () => ReportController(),
    );
    Get.lazyPut<SettingController>(
          () => SettingController(),
    );
    Get.lazyPut<OutletController>(
          () => OutletController(),
    );


  }
}
