import 'package:get/get.dart';
import 'package:warmi/app/modules/choose_store/view/choose_store_view.dart';
import 'package:warmi/app/modules/history_sales/views/detail_history_view.dart';
import 'package:warmi/app/modules/history_sales/views/history_sales_view.dart';
import 'package:warmi/app/modules/home/views/home_view.dart';
import 'package:warmi/app/modules/login/views/login_view.dart';
import 'package:warmi/app/modules/login_chooise/views/login_chooise_view.dart';
import 'package:warmi/app/modules/login_employee/views/login_employee_view.dart';
import 'package:warmi/app/modules/navigation/views/navigation_view.dart';
import 'package:warmi/app/modules/owner/outlet/views/outlet_form_input_view.dart';
import 'package:warmi/app/modules/owner/outlet/views/outlet_view.dart';
import 'package:warmi/app/modules/owner/product/views/add_product.dart';
import 'package:warmi/app/modules/owner/product/views/edit_product.dart';
import 'package:warmi/app/modules/owner/product/views/product_view.dart';
import 'package:warmi/app/modules/owner/report/views/detail_report_payment_method.dart';
import 'package:warmi/app/modules/owner/report/views/detail_report_penjualan_product.dart';
import 'package:warmi/app/modules/owner/settings/views/add_discount_view.dart';
import 'package:warmi/app/modules/owner/settings/views/change_password_view.dart';
import 'package:warmi/app/modules/owner/settings/views/discount_view.dart';
import 'package:warmi/app/modules/owner/settings/views/employees_view.dart';
import 'package:warmi/app/modules/owner/settings/views/invoice_view.dart';
import 'package:warmi/app/modules/owner/settings/views/language_view.dart';
import 'package:warmi/app/modules/owner/settings/views/outlet_online_view.dart';
import 'package:warmi/app/modules/owner/settings/views/payment_method_view.dart';
import 'package:warmi/app/modules/owner/settings/views/printer_view.dart';
import 'package:warmi/app/modules/owner/settings/views/product_category_view.dart';
import 'package:warmi/app/modules/owner/settings/views/profile_view.dart';
import 'package:warmi/app/modules/owner/settings/views/setup_business_view.dart';
import 'package:warmi/app/modules/owner/settings/views/tax_and_service.dart';
import 'package:warmi/app/modules/owner/settings/views/type_order_view.dart';
import 'package:warmi/app/modules/register/views/register_view.dart';
import 'package:warmi/app/modules/splash/views/splash_view.dart';
import 'package:warmi/app/modules/transaction/views/index.dart';
import 'package:warmi/app/modules/transaction/views/mobile/cart_transaction_view.dart';
import 'package:warmi/app/modules/transaction/views/mobile/checkout_view.dart';
import 'package:warmi/app/modules/transaction/views/mobile/customer_view.dart';
import 'package:warmi/app/modules/transaction/views/mobile/transaction_success_view.dart';
import 'package:warmi/app/modules/transaction/views/mobile/transaction_view.dart';
import 'package:warmi/app/modules/transaction/views/table/checkout_table_view.dart';
import 'package:warmi/di/depedency_injection.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SPLASH;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: LazyBindings(),
    ),
    GetPage(
      name: _Paths.SPLASH,
      page: () => SplashView(),
      binding: LazyBindings(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => LoginView(),
      binding: LazyBindings(),
    ),
    GetPage(
      name: _Paths.LOGIN_CHOOISE,
      page: () => LoginChooiseView(),
      binding: LazyBindings(),
    ),
    GetPage(
      name: _Paths.REGISTER,
      page: () => RegisterView(),
      binding: LazyBindings(),
    ),
    GetPage(
      name: _Paths.NAVIGATION,
      page: () => NavigationView(),
      binding: LazyBindings(),
    ),
    GetPage(
      name: _Paths.HISTORY_SALES,
      page: () => HistorySalesView(),
      binding: LazyBindings(),
    ),
    GetPage(
        name: _Paths.SETUP_BUSINESS,
        page: () => SetupBusinessView(),
        binding: LazyBindings(),
        transition: Transition.zoom),
    GetPage(
        name: _Paths.OUTLET,
        page: () => OutletView(),
        binding: LazyBindings(),
        transition: Transition.zoom),
    GetPage(
        name: _Paths.ADD_OUTLET,
        page: () => OutletFormInput(),
        binding: LazyBindings(),
        transition: Transition.fadeIn),
    GetPage(
        name: _Paths.CHANGE_PASSWORD,
        page: () => ChangePasswordView(),
        binding: LazyBindings(),
        transition: Transition.fadeIn),
    GetPage(
        name: _Paths.EMPLOYEES,
        page: () => EmployeesView(),
        binding: LazyBindings(),
        transition: Transition.fadeIn),
    GetPage(
        name: _Paths.PRODUCT_CATEGORY,
        page: () => ProductCategoryView(),
        binding: LazyBindings(),
        transition: Transition.fadeIn),
    GetPage(
        name: _Paths.TYPE_ORDER,
        page: () => TypeOrderView(),
        binding: LazyBindings(),
        transition: Transition.fadeIn),
    GetPage(
        name: _Paths.PAYMENT_METHOD,
        page: () => PaymentMethodView(),
        binding: LazyBindings(),
        transition: Transition.fadeIn),
    GetPage(
        name: _Paths.DISCOUNT,
        page: () => DiscountView(),
        binding: LazyBindings(),
        transition: Transition.fadeIn),
    GetPage(
        name: _Paths.ADD_DISCOUNT,
        page: () => AddDiscountView(),
        binding: LazyBindings(),
        transition: Transition.fadeIn),
    GetPage(
        name: _Paths.PRODUCT,
        page: () => ProductView(),
        binding: LazyBindings(),
        transition: Transition.leftToRightWithFade),
    GetPage(
        name: _Paths.ADD_PRODUCT,
        page: () => AddProductView(),
        binding: LazyBindings(),
        transition: Transition.leftToRightWithFade),
    GetPage(
        name: _Paths.EDIT_PRODUCT,
        page: () => EditProductView(),
        binding: LazyBindings(),
        transition: Transition.leftToRightWithFade),
    GetPage(
      name: _Paths.TRANSACTION,
      page: () => TransactionView(),
      transition: Transition.leftToRightWithFade,
      binding: LazyBindings(),
    ),
    GetPage(
      name: _Paths.CART_TRANSACTION,
      page: () => CardTransactionView(),
      transition: Transition.leftToRightWithFade,
      binding: LazyBindings(),
    ),
    GetPage(
      name: _Paths.CUSTOMER_PAGE,
      page: () => CustomerView(),
      transition: Transition.leftToRightWithFade,
      binding: LazyBindings(),
    ),
    GetPage(
      name: _Paths.INVOICE_PAGE,
      page: () => InvoiceView(),
      transition: Transition.leftToRightWithFade,
      binding: LazyBindings(),
    ),
    GetPage(
      name: _Paths.LANGUAGE_SETTING_PAGE,
      page: () => LanguageView(),
      transition: Transition.leftToRightWithFade,
      binding: LazyBindings(),
    ),
    GetPage(
      name: _Paths.PRINTER_PAGE,
      page: () => PrinterView(),
      transition: Transition.leftToRightWithFade,
      binding: LazyBindings(),
    ),
    GetPage(
      name: _Paths.CHECKOUT_PAGE,
      page: () => CheckoutView(),
      transition: Transition.leftToRightWithFade,
      binding: LazyBindings(),
    ),
    GetPage(
      name: _Paths.TRANSACTION_SUCCESS,
      page: () => TransactionSuccessView(),
      transition: Transition.leftToRightWithFade,
      binding: LazyBindings(),
    ),
    GetPage(
      name: _Paths.DETAIL_HISTORY_TRANSACTION,
      page: () => DetailHistoryView(),
      transition: Transition.leftToRightWithFade,
      binding: LazyBindings(),
    ),
    GetPage(
      name: _Paths.OUTLET_ONLINE,
      page: () => OutletOnlineView(),
      transition: Transition.leftToRightWithFade,
      binding: LazyBindings(),
    ),
    GetPage(
      name: _Paths.PROFILE_VIEW,
      page: () => ProfileView(),
      transition: Transition.leftToRightWithFade,
      binding: LazyBindings(),
    ),
    GetPage(
      name: _Paths.LOGIN_EMPLOYEE,
      page: () => LoginEmployeeView(),
      transition: Transition.zoom,
      binding: LazyBindings(),
    ),
    GetPage(
      name: _Paths.INDEX_TRANSACTION,
      page: () => IndexTransaction(),
      transition: Transition.zoom,
      binding: LazyBindings(),
    ),
    GetPage(
      name: _Paths.CHECKOUT_TABLET,
      page: () => CheckOutTableView(),
      transition: Transition.leftToRightWithFade,
      binding: LazyBindings(),
    ),
    GetPage(
      name: _Paths.CHOOSE_STORE,
      page: () => ChooseStoreView(),
      transition: Transition.leftToRightWithFade,
      binding: LazyBindings(),
    ),
    GetPage(
      name: _Paths.DETAIL_REPORT_SELLING_PRODUCT,
      page: () => DetailReportSellingProduct(),
      transition: Transition.leftToRightWithFade,
      binding: LazyBindings(),
    ),
    GetPage(
      name: _Paths.DETAIL_REPORT_PAYMENT_METHOD,
      page: () => DetailReportPaymentMethod(),
      transition: Transition.leftToRightWithFade,
      binding: LazyBindings(),
    ),
    GetPage(
      name: _Paths.TAX_SERVICE_VIEW,
      page: () => TaxAndServiceView(),
      transition: Transition.leftToRightWithFade,
      binding: LazyBindings(),
    ),
  ];
}
