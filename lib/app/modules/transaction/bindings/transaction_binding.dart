import 'package:get/get.dart';
import 'package:warmi/app/modules/transaction/controllers/customer_controller.dart';

import '../controllers/transaction_controller.dart';

class TransactionBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TransactionController>(
      () => TransactionController(),
    );
    Get.lazyPut<CustomerController>(
      () => CustomerController(),
    );
  }
}
