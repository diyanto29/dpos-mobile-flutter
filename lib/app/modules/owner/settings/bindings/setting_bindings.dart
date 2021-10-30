import 'package:get/get.dart';
import 'package:warmi/app/modules/owner/settings/controllers/discount_controller.dart';
import 'package:warmi/app/modules/owner/settings/controllers/employees_controller.dart';
import 'package:warmi/app/modules/owner/settings/controllers/invoce_controller.dart';
import 'package:warmi/app/modules/owner/settings/controllers/payment_method_controller.dart';
import 'package:warmi/app/modules/owner/settings/controllers/printer_controller.dart';
import 'package:warmi/app/modules/owner/settings/controllers/printer_controller.dart';
import 'package:warmi/app/modules/owner/settings/controllers/product_category_controller.dart';
import 'package:warmi/app/modules/owner/settings/controllers/setup_business_controller.dart';
import 'package:warmi/app/modules/owner/settings/controllers/type_order_controller.dart';

class SettingBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SetupBusinessController>(
          () => SetupBusinessController(),
    );
    Get.lazyPut<EmployeesController>(
          () => EmployeesController(),
    );
    Get.lazyPut<ProductCategoryController>(
          () => ProductCategoryController(),
    );
    Get.lazyPut<TypeOrderController>(
          () => TypeOrderController(),
    );

    Get.lazyPut<PaymentMethodController>(
          () => PaymentMethodController(),
    );

    Get.lazyPut<DiscountController>(
          () => DiscountController(),
    );
    Get.lazyPut<InvoiceController>(
          () => InvoiceController(),
    );
    Get.lazyPut <PrinterController> (
            () => PrinterController()
    );
  }

}