import 'package:get/get.dart';

import '../controllers/history_sales_controller.dart';

class HistorySalesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HistorySalesController>(
      () => HistorySalesController(),
    );
  }
}
