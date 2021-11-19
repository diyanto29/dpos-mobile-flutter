class MyString {
  //BaseUrl
  static final String api_url_dev = "http://apidprod.mudahkan.com/v1/";

  // static final String api_url_dev="http://apiddev.mudahkan.com/v1/";
  // static final String api_url_dev="http://192.168.100.36:8080/v1/";
  // static final String api_url_dev="http://192.168.109.95:8080/v1/";
  static const String api_siskohat =
      "https://haji.kemenag.go.id/haji-pintar/api-siskohat/siskohat";
  static const String api_jadwal_sholat = "https://api.pray.zone/v2/";
  static const String api_url_prod = "https://";

  //base url raja ongkir
  static final String api_raja_ongkir = 'https://pro.rajaongkir.com/api';

  //key raja ongkir
  //account pro
  static final String key_raja_ongkir = '40fbe32cfe21a5dbdf329135167d3c6b';

  //endpoint api
  static final getTypeBusiness = api_url_dev + "business/category";
  static final login = api_url_dev + "users/login";
  static final loginCashier = api_url_dev + "employee/login";
  static final registerUser = api_url_dev + "register";
  static final updatePassword = api_url_dev + "users/reset_password";

  //type Order
  static final getTypeOrder = api_url_dev + "order";
  static final addOrUpdateTypeOrder = api_url_dev + "order/store";
  static final deleteTypeOrder = api_url_dev + "order/delete";

  static final updateBusiness = api_url_dev + "business/store";
  static final updateUsers = api_url_dev + "users/update";
  static final getBusinessUser = api_url_dev + "business";
  static final getCategoryByStore = api_url_dev + "category_product";
  static final insertCategoryByStore = api_url_dev + "category_product/store";
  static final deleteCategoryByStore = api_url_dev + "category_product/delete";
  static final getStore = api_url_dev + "outlet";
  static final insertStore = api_url_dev + "outlet/store";
  static final deleteStore = api_url_dev + "outlet/delete";
  static final insertDiscount = api_url_dev + "event/discount/store";
  static final getDiscount = api_url_dev + "event/discount";
  static final deleteDiscount = api_url_dev + "event/discount/delete";
  static final getUnitProduct = api_url_dev + "unit_product";
  static final insertProduct = api_url_dev + "product/store";
  static final getProduct = api_url_dev + "product";
  static final deleteProduct = api_url_dev + "product/delete";
  static final getPaymentMehtod = api_url_dev + "payment_method";
  static final updatePaymentMethodByUser =
      api_url_dev + "payment_method/update_by_user";
  static final getPrinter = api_url_dev + "printer";
  static final storePrinter = api_url_dev + "printer/store";
  static final deletePrinter = api_url_dev + "printer/delete";
  static final getInvoice = api_url_dev + "struk-settings";
  static final storeInvoice = api_url_dev + "struk-settings/store";

  static final storeTransaction = api_url_dev + "transaction/store";
  static final getTransaction = api_url_dev + "transaction";
  static final getReportTransaction =
      api_url_dev + "transaction/report_transaction";
  static final changeStatusTransaction =
      api_url_dev + "transaction/change_status_payment";

  //employees
  static final getEmployees = api_url_dev + "employee";
  static final storeEmployees = api_url_dev + "employee/store";
  static final deleteEmployees = api_url_dev + "employee/delete";

  // tax service
  static final getTaxService = api_url_dev + "tax_service";
  static final postTaxService = api_url_dev + "tax_service/store";

  // static final updatePaymentMethodByUser=api_url_dev+"payment_method/update_by_user";
  // static final updatePaymentMethodByUser=api_url_dev+"payment_method/update_by_user";

  static final getCustomer = api_url_dev + "customer_partner";
  static final updateOrCreateCustomer = api_url_dev + "customer_partner/store";
  static final deleteCustomer = api_url_dev + "customer_partner/delete";

  //StatusCode
  static const String statusSuccess = "Success";
  static const String statusError = "Error";

  //App
  static const String appName = "WARMI";
  static const String appSlogan =
      "Nikmati segala kemudahahan layanan publik yang tersedia, dari keagamaan dan bursa kerja.";
  static const String CONFIG_AGORA_APP_ID = "43f24d4e21414f30af5d04c2f3836e4b";
  static const String CONFIG_BASE_PATH = "storage/emulated/0/ALMA";
  static const String PATH_ROUTE = "Image";
  static const String PATH_TUGAS = "Tugas";
  static const String PATH_FORUM = "Forum";
  static const String PATH_RAPORT = "Rapor";
  static const String PATH_KITAB = "Kitab Suci";
  static const double DEFAULT_PADDING = 16.0;
  static const String DEFAULT_PRINTER = 'defaultPrinter';
  static const String PRINTER_PAPER = 'printerPaper';
  static const String PRINTER_TYPE = 'printerType';
  static const String FONT_HEADER = 'fontHeader';
  static const String FONT_FOOTER = 'fontFooter';
  static const String FONT_CONTENT = 'fontContent';
  static const String FONT_TOTAL = 'fontTotal';
  static const String TYPE_FONT_HEADER = 'typeFontHeader';
  static const String TYPE_FONT_FOOTER = 'typeFontFooter';
  static const String TYPE_FONT_CONTENT = 'typeFontContent';
  static const String TYPE_FONT_TOTAL = 'typeFontTotal';

  //navtigation
  // static const String homeTitleBottomNavBar = 'Beranda';
  // static const String orderTitleBottomNavBar = 'Pesanan';
  // static const String reportTitleBottomNavBar = 'Laporan';
  // static const String profileTitleBottomNavBar = 'Pengaturan';

  //dialog title
  static const String dialogTitleRegister = "Buat Akun Bisnismu";

  //GetStorge

  //session user
  static const String USER_ID = "userId";
  static const String TOKEN = "token";
  static const String USER_FULLNAME = "userFullName";
  static const String USER_NO_HP = "userNoHp";
  static const String USER_EMAIL = "userEmail";
  static const String USER_USERNAME = "userUsername";
  static const String USER_PHOTO = "userPhoto";
  static const String STORE_COUNT = "storeCount";

  //session role user
  static const String ROLE_ID = "roleId";
  static const String ROLE_NAME = "roleName";
  static const String USER_ID_OWNER = "userIdOwner";

  //session type account
  static const String STATUS_CODE_ID = "statuCodeId";
  static const String STATUS_NAME = "statusName";
  static const String EXPIRED_DATE = "expiredDate";

  //session type store
  static const String STORE_ID = "storeId";
  static const String STORE_NAME = "storeName";
  static const String STORE_ADDRESS = "storeAddress";

  //store type business
  static const String BUSINESS_ID = "businessId";
  static const String BUSINESS_NAME = "businessName";
  static const String BUSINESS_CATEGORY_NAME = "businessCategoryName";
  static const String BUSINESS_CATEGORY_ID = "businessCategoryId";
  static const String BUSINESS_CREW_TOTAL = "businessCrewTotal";
  static const String BUSINESS_BRANCH = "businessBranch";
  static const String BUSINESS_WEBSITE_ID = "businessWebsiteId";
  static const String BUSINESS_LOGO = "businessLogo";
  static const String BUSINESS_CONTACT = "businessContact";

  static const String LOGO_BUSINESS = "logoBusiness";
  static const String FOOTER_TEXT = "footerText";
  static const String LOGO_DPOS = "logoDpos";

  static const String DEFAULT_LANGUAGE = 'defaultLanguage';

  // SESSION TAX SERVICE
  static const String TAX_PERCENTAGE = 'taxPercentage';
  static const String TAX_STATUS = 'taxStatus';
  static const String SERVICE_PERCENTAGE = 'servicePercentage';
  static const String SERVICE_STATUS = 'serviceStatus';
  static const String INCLUDE_COUNT_TAX_SERVICE = 'includeCountTaxService';
}
