import 'package:get/get.dart';
import 'package:warmi/app/modules/choose_store/controller/choose_store_controller.dart';
import 'package:warmi/app/modules/history_sales/controllers/history_sales_controller.dart';
import 'package:warmi/app/modules/login/controllers/login_controller.dart';
import 'package:warmi/app/modules/login_employee/controllers/login_employee_controller.dart';
import 'package:warmi/app/modules/navigation/controllers/navigation_controller.dart';
import 'package:warmi/app/modules/owner/home/controllers/home_controller.dart';
import 'package:warmi/app/modules/owner/outlet/controllers/outlet_controller.dart';
import 'package:warmi/app/modules/owner/product/controllers/product_controller.dart';
import 'package:warmi/app/modules/owner/report/controllers/report_controller.dart';
import 'package:warmi/app/modules/owner/settings/controllers/language_setting_controller.dart';
import 'package:warmi/app/modules/owner/settings/controllers/profile_controller.dart';
import 'package:warmi/app/modules/owner/settings/controllers/setting_controller.dart';
import 'package:warmi/app/modules/owner/settings/controllers/discount_controller.dart';
import 'package:warmi/app/modules/owner/settings/controllers/employees_controller.dart';
import 'package:warmi/app/modules/owner/settings/controllers/invoce_controller.dart';
import 'package:warmi/app/modules/owner/settings/controllers/payment_method_controller.dart';
import 'package:warmi/app/modules/owner/settings/controllers/printer_controller.dart';
import 'package:warmi/app/modules/owner/settings/controllers/product_category_controller.dart';
import 'package:warmi/app/modules/owner/settings/controllers/setup_business_controller.dart';
import 'package:warmi/app/modules/owner/settings/controllers/tax_service_controller.dart';
import 'package:warmi/app/modules/owner/settings/controllers/type_order_controller.dart';
import 'package:warmi/app/modules/register/controllers/register_controller.dart';
import 'package:warmi/app/modules/splash/controllers/splash_controller.dart';
import 'package:warmi/app/modules/transaction/controllers/customer_controller.dart';
import 'package:warmi/app/modules/transaction/controllers/transaction_controller.dart';

class LazyBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NavigationController>(() => NavigationController());
    Get.lazyPut<HomeController>(() => HomeController());
    Get.lazyPut<HistorySalesController>(() => HistorySalesController());
    Get.lazyPut<ReportController>(() => ReportController());
    Get.lazyPut<SettingController>(() => SettingController());
    Get.lazyPut<OutletController>(() => OutletController());
    Get.lazyPut<HistorySalesController>(() => HistorySalesController());
    Get.lazyPut<LoginController>(() => LoginController());
    Get.lazyPut<ProductController>(() => ProductController());
    Get.lazyPut<SetupBusinessController>(() => SetupBusinessController());
    Get.lazyPut<EmployeesController>(() => EmployeesController());
    Get.lazyPut<ProductCategoryController>(() => ProductCategoryController());
    Get.lazyPut<TypeOrderController>(() => TypeOrderController());
    Get.lazyPut<PaymentMethodController>(() => PaymentMethodController());
    Get.lazyPut<DiscountController>(() => DiscountController());
    Get.lazyPut<InvoiceController>(() => InvoiceController());
    Get.lazyPut<PrinterController>(() => PrinterController());
    Get.lazyPut<RegisterController>(() => RegisterController());
    Get.lazyPut<SplashController>(() => SplashController());
    Get.lazyPut<TransactionController>(() => TransactionController());
    Get.lazyPut<CustomerController>(() => CustomerController());
    Get.lazyPut<ProfileController>(() => ProfileController());
    Get.lazyPut<LoginEmployeeController>(() => LoginEmployeeController());
    Get.lazyPut<ChooseStoreController>(() => ChooseStoreController());
    Get.lazyPut<LanguageSettingController>(() => LanguageSettingController());
    Get.lazyPut<TaxServiceController>(() => TaxServiceController());
  }
}
