
import 'dart:io';

import 'package:dotted_decoration/dotted_decoration.dart';
import 'package:external_path/external_path.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:in_app_update/in_app_update.dart';
import 'package:intl/intl.dart';

import 'package:share_plus/share_plus.dart';
import 'package:warmi/app/data/datalocal/session/auth_session_manager.dart';
import 'package:warmi/app/data/datasource/product/category_product_remote_data_source.dart';
import 'package:warmi/app/data/datasource/product/product_remote_data_source.dart';
import 'package:warmi/app/data/datasource/transactions/transaction_source_data_remote.dart';
import 'package:warmi/app/data/models/customer/customer_model.dart';
import 'package:warmi/app/data/models/discount/discount.dart';

import 'package:warmi/app/data/models/payment_method/payment_method_channel.dart'
    as PM;
import 'package:warmi/app/data/models/product/cart.dart';
import 'package:warmi/app/data/models/product/category_product.dart';

import 'package:warmi/app/data/models/product/product.dart';
import 'package:warmi/app/data/models/transactions/transaction_model.dart';
import 'package:warmi/app/modules/history_sales/controllers/history_sales_controller.dart';
import 'package:warmi/app/modules/owner/product/controllers/product_controller.dart';
import 'package:warmi/app/modules/owner/settings/controllers/discount_controller.dart';
import 'package:warmi/app/modules/owner/settings/controllers/payment_method_controller.dart';
import 'package:warmi/app/modules/owner/settings/controllers/printer_controller.dart';
import 'package:warmi/app/modules/owner/settings/controllers/setup_business_controller.dart';
import 'package:warmi/app/modules/transaction/controllers/cart_controller.dart';
import 'package:warmi/app/modules/transaction/views/mobile/product_view_transaction.dart';
import 'package:warmi/app/modules/wigets/layouts/dialog/dialog_loading.dart';
import 'package:warmi/app/modules/wigets/layouts/dialog/dialog_question.dart';
import 'package:warmi/app/modules/wigets/layouts/dialog/dialog_snackbar.dart';
import 'package:warmi/app/modules/wigets/package/screenshoot/screenshot.dart';
import 'package:warmi/app/routes/app_pages.dart';
import 'package:warmi/core/globals/global_color.dart';
import 'package:warmi/core/globals/global_string.dart';
import 'package:warmi/core/utils/admob_helpers.dart';
import 'package:warmi/core/utils/admob_helpers.dart';
import 'package:warmi/core/utils/enum.dart';
import 'package:warmi/core/utils/thema.dart';
import 'package:warmi/main.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:recase/recase.dart';

class TransactionController extends GetxController
    with SingleGetTickerProviderMixin {
  //TODO: Implement TransactionController
  var productController = Get.put(ProductController());
  Rx<LoadingState> loadingState = LoadingState.loading.obs;
  Rx<LoadingState> loadingStateCategory = LoadingState.loading.obs;
  Rx<TextEditingController> searchC = TextEditingController().obs;
  var listSearchProduct = List<DataProduct>.empty().obs;
  var discountController = Get.put(DiscountController());
  var printerC = Get.isRegistered<PrinterController>()
      ? Get.find<PrinterController>()
      : Get.put(PrinterController());
  List<Tab> tabs = [];

  final List<Tab> tabsCheckout = <Tab>[
    Tab(text: 'tunai'.tr.tr),
    Tab(text: 'non_tunai'.tr),
  ];
  TabController? tabController;
  PageController controllerPage =
      PageController(keepPage: false, initialPage: 0);
  RxInt initialIndex = 0.obs;
  RxInt index = 0.obs;
  TabController? tabControllerCheckout;
  PageController controllerPageCheckout =
      PageController(keepPage: false, initialPage: 0);
  RxInt initialIndexCheckout = 0.obs;
  RxInt indexCheckout = 0.obs;
  RxString title = "List Kontak".obs;
  DataTransaction? detailTransaction;
  Rx<AuthSessionManager> auth = AuthSessionManager().obs;


  List<DataTransaction> listTransaction = [];

  void getTransaction({String? statusTransaction}) async {
    if (listTransaction.isNotEmpty) listTransaction.clear();
    await TransactionRemoteDataSource()
        .getTransaction(statusTransaction: "pending")
        .then((value) {
      listTransaction = value.data!;
    });

    update();
  }

  //list category
  var listCategoryProduct = List<CategoryProduct>.empty().obs;
  Rx<String> idCategory = "".obs;

  Future getCategoryProductDataSource() async {
    loadingStateCategory(LoadingState.loading);
    listCategoryProduct
        .add(CategoryProduct(categoryName: 'semua'.tr, categoryId: 'all',isChecked: true));

    await CategoryProductRemoteDataSource().getCategoryProduct().then((value) {
      listCategoryProduct.addAll(value.data!);
      update();
      // if (value.data!.length > 0) {
      //   listCategoryProduct.forEach((element) {
      //     tabs.add(Tab(
      //       text: element.categoryName.toString().titleCase,
      //     ));
      //     update();
      //   });
      // }
    });

    // tabController = TabController(vsync: this, length: tabs.length);
    // print("ini tab " + tabs.length.toString());
    loadingStateCategory(LoadingState.empty);
    update();
  }

  //

  void onTapCategory(int i) {
    listCategoryProduct.forEach((element) {
      element.isChecked = false;
      update();
    });
    listCategoryProduct[i].isChecked = true;
    if (listCategoryProduct[i].categoryId == 'all') {
      idCategory.value = 'all';

      update();
    } else {
      idCategory.value = listCategoryProduct[i].categoryId!;
      getSearchProduct(searchC.value.text,idCategory: idCategory.value);
      update();
    }
    listCategoryProduct.refresh();
  }
  Widget getPage(){
    if(idCategory.value=="all" || idCategory.value.isEmpty){
      return ProductTransactionView();
    }else{
      return ProductTransactionView(idCategory: idCategory.value,);
    }
  }

  void setTabName() {
    tabs = <Tab>[
      Tab(text: 'semua'.tr),
      Tab(text: 'paket'.tr),
    ];
    update();
  }

  AppUpdateInfo? _updateInfo;
  late BannerAd bannerAd;

  bool isBannerAdReady = false;

  late InterstitialAd interstitialAd;

  bool isInterstitialAdReady = false;

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

  Future<void> initAdmob() async {
    var box = GetStorage();
    print("Success Load loadad");
    if (box.read(MyString.STATUS_NAME) == "FREE") {
      bannerAd = BannerAd(
          // Change Banner Size According to Ur Need
          size: AdSize.mediumRectangle,
          adUnitId: AdmobHelpers.bannerAdUnitId,
          listener: BannerAdListener(onAdLoaded: (_) {
            isBannerAdReady = true;
            print("Success Load Admon");
            update();
          }, onAdFailedToLoad: (ad, LoadAdError error) {
            print("Failed to Load A Banner Ad${error.message}");
            isBannerAdReady = false;

            ad.dispose();
            update();
          }),
          request: AdRequest())
        ..load();
      //Interstitial Ads
      InterstitialAd.load(
          adUnitId: AdmobHelpers.interstitialAdUnitId,
          request: AdRequest(),
          adLoadCallback: InterstitialAdLoadCallback(onAdLoaded: (ad) {
            this.interstitialAd = ad;
            isInterstitialAdReady = true;
            update();
          }, onAdFailedToLoad: (LoadAdError error) {
            print("failed to Load Interstitial Ad ${error.message}");
          }));
    }
  }

  @override
  void onInit() async {
    businessController.getBusinessProfileDataSource();
    getTransaction();
    setTabName();
    if (GetPlatform.isAndroid) {
      initAdmob();
      checkForUpdate();
    }
    //categori
    await getCategoryProductDataSource();

    //catgori
    discountController.getDiscountDataSource();


    tabControllerCheckout =
        TabController(vsync: this, length: tabsCheckout.length);
    productController.getProduct().then((value) {
      loadingState(LoadingState.empty);
    });


    update();
    discountController.getDiscountDataSource();
    super.onInit();
  }

  @override
  void dispose() {
    tabController!.dispose();
    tabControllerCheckout!.dispose();
    listSearchProduct.clear();
    listTransaction.clear();
    var box = GetStorage();
    if (box.read(MyString.STATUS_NAME) == "FREE") {
      bannerAd.dispose();
      interstitialAd.dispose();
    }

    super.dispose();
  }

  void getSearchProduct(String name, {String? idCategory}) async {
    loadingState(LoadingState.loading);
    // print("Katog "+idCategory!);
    await ProductRemoteDataSource()
        .getSearchProduct(name: name, idCategory: idCategory)
        .then((value) {
      listSearchProduct(value.data);
      loadingState(LoadingState.empty);
      checkProductInCart();
    });
    searchC.refresh();
    listSearchProduct.refresh();
  }

  void checkProductInCart() async {

    if (listCart.length > 0) {
      print("Aa");
      listCart.forEach((element) {
        listSearchProduct.forEach((item) {
          if (element.dataProduct == item) {
            item.productInCart = true;
            listSearchProduct.refresh();
            update();
          }
        });
      });
      listSearchProduct.refresh();
    }else{
      print("b");
    }
  }

  void scanBarcode() async {
    String barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
        "#ff6666", 'batal'.tr, true, ScanMode.BARCODE);
    print(barcodeScanRes);
    print("ini barcoed");
    if (barcodeScanRes != "-1") {
      searchC.value.text = barcodeScanRes;
      getSearchProduct(barcodeScanRes);
    }
  }

  Rx<TextEditingController> cashC = TextEditingController().obs;
  RxDouble pay = 0.0.obs;
  RxDouble cashReceived = 0.0.obs;
  RxBool is20 = false.obs;
  RxBool is50 = false.obs;
  RxBool is100 = false.obs;
  RxBool isPassed = false.obs;
  var paymentMethod = PM.Payment_method().obs;

  void getPayMoney20() async {
    pay.value = cashC.value.text.isEmpty || cashC.value.text == ""
        ? 0.0
        : double.tryParse(
            cashC.value.text.split(" ").last.replaceAll(".", ""))!;
    if (is20.value) {
      paymentMethod.value = PM.Payment_method();
      update();
      if (isPassed.value) {
        pay(0.0);
      }
      isPassed(false);

      pay.value += 20000;
    } else
      pay.value -= 20000;

    cashC.value.text = "Rp " + formatCurrency.format(pay.value);
    getCashReceived();
  }

  void getPayMoney50() async {
    pay.value = cashC.value.text.isEmpty
        ? 0.0
        : double.tryParse(
            cashC.value.text.split(" ").last.replaceAll(".", ""))!;
    if (is50.value) {
      paymentMethod.value = PM.Payment_method();
      update();
      if (isPassed.value) {
        pay(0.0);
      }
      isPassed(false);
      pay.value += 50000;
    } else
      pay.value -= 50000;

    cashC.value.text = "Rp " + formatCurrency.format(pay.value);
    getCashReceived();
  }

  void getPayMoney100() async {
    pay.value = cashC.value.text.isEmpty
        ? 0.0
        : double.tryParse(
            cashC.value.text.split(" ").last.replaceAll(".", ""))!;
    if (is100.value) {
      paymentMethod.value = PM.Payment_method();
      update();
      if (isPassed.value) {
        pay(0.0);
      }
      isPassed(false);
      pay.value += 100000;
    } else
      pay.value -= 100000;

    cashC.value.text = "Rp " + formatCurrency.format(pay.value);
    getCashReceived();
  }

  void getMoneyPassed(double cash) async {
    if (isPassed.value) {
      pay(cash);
      is20(false);
      is50(false);
      is100(false);
      paymentMethod.value = PM.Payment_method();
      update();
    } else
      pay(0.0);
    cashC.value.text = "Rp " + formatCurrency.format(pay.value);
    getCashReceived();
  }

  void getCashReceived() async {

    double calc = pay.value - totalShopping.value;
    cashReceived.value = calc.isNegative ? 0.0 : calc;
  }

  void setPaymentMethod({required PM.Payment_method payment_method}) {
    paymentMethod(payment_method);
    update();
    is20(false);
    is50(false);
    is100(false);
    isPassed(false);
    pay(0.0);
    cashC.value.text = "Rp " + formatCurrency.format(pay.value);
    getCashReceived();
  }

  void storeTransaction() async {
    var conProd = Get.find<ProductController>();

    if (paymentMethod.value.paymentmethodid == null) {
      double calc = pay.value - totalShopping.value;
      if (pay < totalShopping.value) {
        showSnackBar(
            snackBarType: SnackBarType.INFO,
            title: 'pembayaran'.tr,
            message: "Pembayaran Kurang ${formatCurrency.format(calc)}");
      } else {
        loadingBuilder();
        print("asdas");
        await TransactionRemoteDataSource()
            .storeTransaction(
                customerPartnerID: customer.value.customerpartnerid,
                dateTransaction: DateFormat("yyyy-MM-dd")
                    .format(dateTransaction.value),
                discountID: dataDiscount == null
                    ? null
                    : dataDiscount!.discountId.toString(),
                paymentMethodID: paymentMethod.value.paymentmethodid,
                listCart: listCart,
                paymentMethodStatus: "done",
                priceOff: dataDiscount == null
                    ? null
                    : double.tryParse(
                        dataDiscount!.discountMaxPriceOff!),
                totalTransaction: totalShopping.value,
                transactionPay: pay.value,
                transactionReceived: cashReceived.value,
                transactionStatus: "success")
            .then((value) {
          Get.back();

          if (value.status) {
            listCart.clear();
            productController.listProduct.forEach((element) {
              element.productInCart = false;
            });
            Map<dynamic, dynamic> pass;
            pass = {
              "type": "cash",
              "from": "cart",
              "cash_received": cashReceived,
            };
            detailTransaction = DataTransaction.fromJson(value.data);

            Get.toNamed(Routes.TRANSACTION_SUCCESS, arguments: pass);
            printerC.printTicketPurchase(dataTransaction: detailTransaction);
          } else {
            showSnackBar(
                snackBarType: SnackBarType.INFO,
                title: 'transaksi'.tr,
                message: value.message.split("=>").last);
          }
        });
      }
    } else {
      var paymentC = Get.find<PaymentMethodController>();
      Map<dynamic, dynamic> pass = {};
      paymentC.listPaymentMethod.forEach((element) {
        element.paymentMethod!.forEach((item) {
          if (item.paymentmethodid == paymentMethod.value.paymentmethodid) {
            pass = {
              "type": element.paymentmethodtypename,
              "from": "cart",
              "cash_received": cashReceived,
            };
          }
        });
      });
      if (paymentMethod.value.paymentmethodid == null) {
        pass = {
          "type": "Cash",
          "from": "cart",
          "cash_received": cashReceived,
        };
      }
      loadingBuilder();
      await TransactionRemoteDataSource()
          .storeTransaction(
              customerPartnerID: customer.value.customerpartnerid,
              dateTransaction: DateFormat("yyyy-MM-dd")
                  .format(dateTransaction.value),
              discountID: dataDiscount == null
                  ? null
                  : dataDiscount!.discountId.toString(),
              paymentMethodID: paymentMethod.value.paymentmethodid,
              listCart: listCart,
              paymentMethodStatus: "done",
              priceOff: dataDiscount == null
                  ? null
                  : double.tryParse(dataDiscount!.discountMaxPriceOff!),
              totalTransaction: totalShopping.value,
              transactionPay: 0,
              transactionReceived: 0,
              transactionStatus: "success")
          .then((value) {
        Get.back();

        if (value.status) {
          listCart.clear();
          detailTransaction = DataTransaction.fromJson(value.data);
          productController.listProduct.forEach((element) {
            element.productInCart = false;
          });
          Get.toNamed(Routes.TRANSACTION_SUCCESS, arguments: pass);
          printerC.printTicketPurchase(dataTransaction: detailTransaction);
        } else {
          showSnackBar(
              snackBarType: SnackBarType.INFO,
              title: 'transaksi'.tr,
              message: value.message.split("=>").last);
        }
      });
    }
  }

  void changeStatusTransaction(
      {DataTransaction? dataTransaction,
      String? type = "checkout",
      String? reasonCancel}) async {

    if (paymentMethod.value.paymentmethodid == null) {
      double calc = pay.value - totalShopping.value;
      if (pay < totalShopping.value && type == "checkout") {
        showSnackBar(
            snackBarType: SnackBarType.INFO,
            title: 'pembayaran'.tr,
            message: "Pembayaran Kurang ${formatCurrency.format(calc)}");
      } else {
        // print(pay.value);
        // print(cashReceived.value);
        loadingBuilder();
        await TransactionRemoteDataSource()
            .changeStatusTransaction(
                transactionPaymentDate:
                    DateFormat("yyyy-MM-dd").format(DateTime.now()),
                paymentMethodID: type == "checkout"
                    ? paymentMethod.value.paymentmethodid
                    : dataTransaction!.transactionpaymentmethodid.toString(),
                listCart: listCart,
                paymentMethodStatus: type == "checkout" ? "done" : "cancel",
                transactionPay: type == "checkout"
                    ? pay.value
                    : double.tryParse(dataTransaction!.transactionpay ?? "0"),
                transactionID: dataTransaction!.transactionid.toString(),
                transactionReceived: type == "checkout"
                    ? cashReceived.value
                    : double.tryParse(
                        dataTransaction.transactionreceived ?? "0"),
                transactionReasonCancel: reasonCancel,
                transactionStatus: type == "checkout" ? "success" : "cancel")
            .then((value) {
          Get.back();
          if (type == "checkout") {
            Map<dynamic, dynamic> pass;

            pass = {
              "type": "cash",
              "from": "history",
              "cash_received": cashReceived,
            };
            if (value.status) {
              DataTransaction data = DataTransaction.fromJson(value.data);
              detailTransaction = DataTransaction.fromJson(value.data);
              Get.toNamed(Routes.TRANSACTION_SUCCESS, arguments: pass);
              printerC.printTicketPurchase(dataTransaction: data);
            }
          } else {
            Get.back();
            Get.back();
            getTransaction();
          }
        });
      }
    } else {
      var paymentC = Get.find<PaymentMethodController>();
      Map<dynamic, dynamic> pass = {};
      paymentC.listPaymentMethod.forEach((element) {
        element.paymentMethod!.forEach((item) {
          if (item.paymentmethodid == paymentMethod.value.paymentmethodid) {
            pass = {
              "type": element.paymentmethodtypename,
              "from": "history",
              "cash_received": cashReceived,
            };
          }
        });
      });

      loadingBuilder();
      await TransactionRemoteDataSource()
          .changeStatusTransaction(
              transactionPaymentDate:
                  DateFormat("yyyy-MM-dd").format(DateTime.now()),
              paymentMethodID: paymentMethod.value.paymentmethodid,
              listCart: listCart,
              paymentMethodStatus: "done",
              transactionPay: pay.value,
              transactionID: dataTransaction!.transactionid.toString(),
              transactionReceived: cashReceived.value,
              transactionStatus: "success")
          .then((value) {
        Get.back();

        if (value.status) {
          Get.toNamed(Routes.TRANSACTION_SUCCESS, arguments: pass);
          DataTransaction data = DataTransaction.fromJson(value.data);
          detailTransaction = DataTransaction.fromJson(value.data);
          printerC.printTicketPurchase(
            dataTransaction: data,
          );
        }
      });
    }
  }

  void printNow() async {
    printerC.printTicketPurchase(
        dataTransaction: detailTransaction, printCopy: true);
  }

  ScreenshotController screenshotController = ScreenshotController();

  void sendInvoice() async {
    var controller = Get.find<HistorySalesController>();
    controller.getSubtotal(detailTransaction!);
    screenshotController
        .captureFromWidget(
      MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          body: Container(
            color: MyColor.colorBackground,
            child: ListView(
              padding: EdgeInsets.all(MyString.DEFAULT_PADDING + 4),
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Flexible(
                        child: Text(
                      "Rp ${formatCurrency.format(int.tryParse(detailTransaction!.transactiontotal!))}",
                      style: blackTextTitle.copyWith(fontSize: 20.sp),
                    )),
                    Flexible(
                      child: Container(
                        alignment: Alignment.center,
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: detailTransaction!.transactionstatus!
                                  .contains("pending")
                              ? MyColor.colorRedFlatDark
                              : MyColor.colorPrimary,
                        ),
                        child: Text(
                          "${detailTransaction!.transactionstatus.toString().titleCase}",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Container(decoration: DottedDecoration()),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Flexible(
                        child: Text(
                      'catatan'.tr,
                      style: blackTextTitle.copyWith(fontSize: 14.sp),
                    )),
                    Flexible(
                        child: Text(
                      detailTransaction!.transactionnote ?? "-",
                      style: blackTextTitle.copyWith(fontSize: 14.sp),
                    )),
                  ],
                ),
                SizedBox(
                  height: 14,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Flexible(
                        child: Text(
                      'waktu'.tr,
                      style: blackTextTitle.copyWith(fontSize: 14.sp),
                    )),
                    Flexible(
                        child: Text(
                      "${DateFormat('EEEE, dd MMM yyyy HH:mm:ss', 'id-ID').format(DateTime.parse(detailTransaction!.createdAt!))}",
                      style: blackTextTitle.copyWith(fontSize: 14.sp),
                    )),
                  ],
                ),
                SizedBox(
                  height: 14,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Flexible(
                        child: Text(
                      'metode_pembayaran'.tr,
                      style: blackTextTitle.copyWith(fontSize: 14.sp),
                    )),
                    Flexible(
                        child: Text(
                      detailTransaction!.paymentMethod == null
                          ? 'Cash'
                          : "${detailTransaction!.paymentMethod!.type!.paymentmethodtypename.toString().titleCase} -  ${detailTransaction!.paymentMethod!.paymentmethodname.toString().capitalize}",
                      style: blackTextTitle.copyWith(fontSize: 14.sp),
                    )),
                  ],
                ),
                SizedBox(
                  height: 14,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Flexible(
                        child: Text(
                      'status_pembayaran'.tr,
                      style: blackTextTitle.copyWith(fontSize: 14.sp),
                    )),
                    Flexible(
                        child: Text(
                      "${detailTransaction!.transactionpaymentstatus.toString().titleCase}",
                      style: blackTextTitle.copyWith(fontSize: 14.sp),
                    )),
                  ],
                ),
                SizedBox(
                  height: 14,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Flexible(
                        child: Text(
                      'kasir'.tr,
                      style: blackTextTitle.copyWith(fontSize: 14.sp),
                    )),
                    Flexible(
                        child: Text(
                      "${detailTransaction!.createdBy!.userfullname!}",
                      style: blackTextTitle.copyWith(fontSize: 14.sp),
                    )),
                  ],
                ),
                SizedBox(
                  height: 14,
                ),
                if (detailTransaction!.customerDetail != null)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Flexible(
                          child: Text(
                        'pelanggan'.tr,
                        style: blackTextTitle.copyWith(fontSize: 14.sp),
                      )),
                      Flexible(
                          child: Text(
                        "${detailTransaction!.customerDetail['CUSTOMER_PARTNER_NAME'].toString().titleCase}",
                        style: blackTextTitle.copyWith(fontSize: 14.sp),
                      )),
                    ],
                  ),
                if (detailTransaction!.customerDetail != null)
                  SizedBox(
                    height: 20,
                  ),
                Container(decoration: DottedDecoration()),
                SizedBox(
                  height: 20,
                ),
                ListView.builder(
                  itemCount: detailTransaction!.detail!.length,
                  shrinkWrap: true,
                  physics: ClampingScrollPhysics(),
                  itemBuilder: (c, i) {
                    var product = detailTransaction!.detail![i];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Flexible(
                              flex: 3,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    height: 30,
                                    width: 30,
                                    padding: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(100),
                                        color: MyColor.colorOrange),
                                    alignment: Alignment.center,
                                    child: Text(
                                      (i + 1).toString(),
                                      style: whiteTextTitle,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Flexible(
                                      child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        product.product!.productname!,
                                        style: blackTextFont,
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        "${product.detailtransactionqtyproduct} x Rp ${formatCurrency.format(product.detailtransactionpriceproduct!)}",
                                        style: blackTextFont,
                                      )
                                    ],
                                  ))
                                ],
                              )),
                          Flexible(
                              child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                "Rp ${formatCurrency.format(int.tryParse(product.detailtransactionsubtotal!))}",
                                style: blackTextFont,
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              if ((int.tryParse(
                                          product.detailtransactionsubtotal!)! -
                                      product.priceafterdiscount!) >
                                  0)
                                Text(
                                  "-  Rp ${formatCurrency.format(int.tryParse(product.detailtransactionsubtotal!)! - product.priceafterdiscount!)}",
                                  style: blackTextFont.copyWith(
                                      color: MyColor.colorRedFlat),
                                ),
                            ],
                          ))
                        ],
                      ),
                    );
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                Container(decoration: DottedDecoration()),
                Obx(() {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 20.0, top: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Flexible(
                            flex: 3,
                            child: Text(
                              "Sub Total",
                              style: blackTextFont,
                            )),
                        Flexible(
                            child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              "Rp ${formatCurrency.format(controller.subTotal.value)}",
                              style: blackTextTitle,
                            )
                          ],
                        ))
                      ],
                    ),
                  );
                }),
                Padding(
                  padding: const EdgeInsets.only(bottom: 20.0, top: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Flexible(
                        flex: 3,
                        child: Text(
                          'diskon'.tr,
                          style: blackTextFont,
                        ),
                      ),
                      Flexible(
                          child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            "- Rp ${formatCurrency.format(int.tryParse(detailTransaction!.transactionpriceoffvoucher ?? "0"))}",
                            style: blackTextTitle.copyWith(
                                color: MyColor.colorRedFlat),
                          )
                        ],
                      ))
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(decoration: DottedDecoration()),
                SizedBox(
                  height: 10,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Text(
                        'total_bayar'.tr,
                        style: blackTextFont,
                      ),
                    ),
                    Flexible(
                        child: Text(
                      "Rp ${formatCurrency.format(int.tryParse(detailTransaction!.transactiontotal!))}",
                      style: blackTextTitle,
                    ))
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                if (detailTransaction!.paymentMethod == null)
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                              child: Text(
                            'bayar'.tr,
                            style: blackTextFont,
                          )),
                          Flexible(
                              child: Text(
                            "Rp ${formatCurrency.format(int.tryParse(detailTransaction!.transactionpay!))}",
                            style: blackTextTitle,
                          ))
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(decoration: DottedDecoration()),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                              child: Text(
                            'kembalian'.tr,
                            style: blackTextFont,
                          )),
                          Flexible(
                              child: Text(
                            "Rp ${formatCurrency.format(int.tryParse(detailTransaction!.transactionreceived!))}",
                            style: blackTextTitle,
                          ))
                        ],
                      ),
                    ],
                  ),
                SizedBox(
                  height: 40,
                ),
                Center(
                  child: Text(
                    "Powered by DPOS",
                    style: blackTextTitle.copyWith(
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.w400,
                        color: MyColor.colorBlackT50),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    )
        .then((capturedImage) async {
      var dir;
      await ExternalPath.getExternalStoragePublicDirectory(
              ExternalPath.DIRECTORY_PICTURES)
          .then((value) {
        dir = value;
      });
      File file = new File('$dir/${detailTransaction!.transactionid}' + '.png');
      await file.writeAsBytes(capturedImage);
      Share.shareFiles(['$dir/${detailTransaction!.transactionid}' + '.png'],
          text: '${detailTransaction!.transactionid}');
    });
  }


  //For controller Cart Transakasctio



  final businessController = Get.find<SetupBusinessController>();

  var listCart = List<CartModel>.empty().obs;
  RxDouble totalCart = 0.0.obs;
  RxDouble totalShopping = 0.0.obs;
  DataDiscount? dataDiscount;
  var customer = DataCustomer().obs;
  Rx<DateTime> dateTransaction = DateTime.now().obs;
  TextEditingController notedC = TextEditingController();



  Future<List<CartModel>> addCart(DataProduct dataProduct) async {
    bool newCart = false;

    totalCart(0);
    if (listCart.isNotEmpty) {

      for (var item in listCart) {
        var index = listCart.indexOf(item);
        if (item.dataProduct == dataProduct) {
          item.qty = item.qty! + 1;
          item.subTotal = item.subTotal! + dataProduct.productPrice!;
          newCart = false;

          break;
        } else {
          newCart = true;
        }
      }

      if (newCart) {
        listCart.add(CartModel(dataProduct: dataProduct, qty: 1, subTotal: (1 * dataProduct.productPrice!)));
        newCart = false;
      }

      for (var product in productController.listProduct) {
        listCart.forEach((element) {
          if (product == element.dataProduct) {
            product.productInCart = true;
          }
        });
      }
      productController.listProduct.refresh();
      if(listSearchProduct.isNotEmpty) {
        print("ada");
        for (var product in listSearchProduct) {
          listCart.forEach((element) {
            if (product == element.dataProduct) {
              product.productInCart = true;
            }
          });

        }
        listSearchProduct.refresh();
      }

      listCart.forEach((element) {
        totalCart.value += element.subTotal!;
      });

      getSubTotal();
      return listCart;
    } else {
      print("asas");
      listCart.add(CartModel(dataProduct: dataProduct, qty: 1, subTotal: (1 * dataProduct.productPrice!)));
      for (var product in productController.listProduct) {
        listCart.forEach((element) {
          if (product == element.dataProduct) {
            product.productInCart = true;
          }
        });
      }
      productController.listProduct.refresh();
      productController.listProduct.refresh();
      getSubTotal();
    }
    listCart.forEach((element) {
      totalCart.value += element.subTotal!;
    });
    print("adad");
    print(listCart.length);
    getSubTotal();
    return listCart;
  }

  void getSubTotal() {
    totalCart(0);
    totalShopping(0);
    print("asda");
    var transC = Get.isRegistered<TransactionController>() ? Get.find<TransactionController>() : Get.put(TransactionController());
    transC.checkProductInCart();
    listCart.forEach((element) {
      if (element.discount == null) {
        totalCart.value += element.subTotal!;
      } else {
        if (element.discount!.discountType == 'price') {
          if (int.parse(element.discount!.discountMaxPriceOff!) >= element.subTotal!) {
            totalCart.value = totalCart.value - 0;
          } else {
            totalCart.value = totalCart.value + (element.subTotal! - int.parse(element.discount!.discountMaxPriceOff!));
          }
        } else {
          if (element.discount!.discountMaxPriceOff == "0" || element.discount!.discountMaxPriceOff == null) {
            double discount = element.subTotal! * (int.parse(element.discount!.discountPercent!) / 100);

            totalCart.value = totalCart.value + (element.subTotal! - discount);
          } else {
            double discount = element.subTotal! * (int.parse(element.discount!.discountPercent!) / 100);
            if (discount >= double.parse(element.discount!.discountMaxPriceOff!)) {
              totalCart.value = totalCart.value + (element.subTotal! - double.parse(element.discount!.discountMaxPriceOff!));
            } else {
              totalCart.value = totalCart.value + (element.subTotal! - discount);
            }
          }
        }
      }
    });
    // totalShopping(totalCart.value);

    //get total diskon

    if (dataDiscount == null) {
      totalShopping.value = totalCart.value + 0;
    } else {
      if (dataDiscount!.discountType == 'price') {
        if (int.parse(dataDiscount!.discountMaxPriceOff!) >= totalCart.value) {
          totalShopping.value = 0;
        } else {
          double? a = double.tryParse(dataDiscount!.discountMaxPriceOff!);
          totalShopping.value = totalCart.value - a!;
        }
      } else {
        if (dataDiscount!.discountMaxPriceOff == "0" || dataDiscount!.discountMaxPriceOff == null) {
          double discount = totalCart.value * (int.parse(dataDiscount!.discountPercent!) / 100);

          totalShopping.value = totalCart.value - discount;
        } else {
          double discount = totalCart.value * (int.parse(dataDiscount!.discountPercent!) / 100);
          if (discount >= double.parse(dataDiscount!.discountMaxPriceOff!)) {
            totalShopping.value = (totalCart.value - double.parse(dataDiscount!.discountMaxPriceOff!));
          } else {
            totalShopping.value = totalCart.value - discount;
          }
        }
      }
    }
  }

  Future<List<CartModel>> removeQty(CartModel? cartModel) async {
    if (cartModel!.qty! > 1) {
      listCart.forEach((element) {
        if (element.dataProduct == cartModel.dataProduct) {
          element.qty = element.qty! - 1;
          element.subTotal = element.qty! * element.dataProduct!.productPrice!;
          listCart.refresh();
          update();
        }
      });
    }
    getSubTotal();
    update();

    return listCart;
  }

  Future<List<CartModel>> addQty(CartModel? cartModel) async {
    listCart.forEach((element) {
      if (element.dataProduct == cartModel!.dataProduct) {
        element.qty = element.qty! + 1;
        element.subTotal = element.qty! * element.dataProduct!.productPrice!;
        listCart.refresh();
        update();
      }
    });
    getSubTotal();

    return listCart;
  }

  Future<List<CartModel>> addDiscount({CartModel? cartModel, bool allProduct = false, required DataDiscount dataDiscount}) async {
    if (allProduct) {
      this.dataDiscount = dataDiscount;
      getSubTotal();
      listCart.refresh();
      return listCart;
    } else {
      listCart.forEach((element) {
        if (element.dataProduct == cartModel!.dataProduct) {
          if (element.discount != null) {
            if (element.discount!.discountType == 'price') {
              if (int.parse(element.discount!.discountMaxPriceOff!) >= element.subTotal!) {
                totalCart.value = totalCart.value + element.dataProduct!.productPrice!;
              } else {
                totalCart.value = totalCart.value + int.parse(element.discount!.discountMaxPriceOff!);
              }
            } else {
              if (element.discount!.discountMaxPriceOff == "0" || element.discount!.discountMaxPriceOff == null) {
                double discount = element.subTotal! * (int.parse(element.discount!.discountPercent!) / 100);
                totalCart.value = totalCart.value + discount;
              } else {
                double discount = element.subTotal! * (int.parse(element.discount!.discountPercent!) / 100);
                print(discount);
                if (discount >= double.parse(element.discount!.discountMaxPriceOff!)) {
                  totalCart.value = totalCart.value + double.parse(element.discount!.discountMaxPriceOff!);
                } else {
                  totalCart.value = totalCart.value + discount;
                }
              }
            }
          }

          element.discount = dataDiscount;
          if (dataDiscount.discountType == 'price') {
            if (int.parse(dataDiscount.discountMaxPriceOff!) >= element.subTotal!) {
              totalCart.value = totalCart.value - element.dataProduct!.productPrice!;
            } else {
              totalCart.value = totalCart.value - int.parse(dataDiscount.discountMaxPriceOff!);
            }
          } else {
            if (dataDiscount.discountMaxPriceOff == "0" || dataDiscount.discountMaxPriceOff == null) {
              double discount = element.subTotal! * (int.parse(dataDiscount.discountPercent!) / 100);
              totalCart.value = totalCart.value - discount;
            } else {
              double discount = element.subTotal! * (int.parse(dataDiscount.discountPercent!) / 100);
              print(discount);
              if (discount >= double.parse(dataDiscount.discountMaxPriceOff!)) {
                totalCart.value = totalCart.value - double.parse(dataDiscount.discountMaxPriceOff!);
              } else {
                totalCart.value = totalCart.value - discount;
              }
            }
          }
          listCart.refresh();
        }
      });
      // totalShopping(totalCart.value);
      getSubTotal();
      return listCart;
    }
  }

  Future<List<CartModel>> deleteDiscount({CartModel? cartModel, bool allProduct = false, required DataDiscount dataDiscount}) async {
    if (allProduct) {
      this.dataDiscount = null;
      print("hao");
      totalShopping(totalCart.value);
      return listCart;
    } else {
      listCart.forEach((element) {
        if (element.dataProduct == cartModel!.dataProduct) {
          element.discount = null;
        }
        listCart.refresh();
      });

      getSubTotal();
      print("hg");

      return listCart;
    }
  }

  Future<List<CartModel>> deleteCart({CartModel? cartModel}) async {
    showDialogQuestion(
        title: 'Hapus Keranjang',
        message: 'apakah_anda_yakin'.tr + ' ?',
        clickYes: () {
          Get.back();
          listCart.remove(cartModel);
          getSubTotal();

          for (var product in productController.listProduct) {
            if (product == cartModel!.dataProduct) {
              product.productInCart = false;
            }
          }
          productController.listProduct.refresh();
          productController.listSearchProduct.refresh();
        });

    return listCart;
  }

  Future<List<CartModel>> deleteCartFormListProduct(DataProduct dataProduct) async {
    for (var product in productController.listProduct) {
      if (product == dataProduct) {
        product.productInCart = false;
      }
    }
    CartModel? cartModel;
    for (var cart in listCart) {
      if (cart.dataProduct == dataProduct) {
        cartModel=cart;

      }
    }
    listCart.remove(cartModel);
    listCart.refresh();

    getSubTotal();

    productController.listProduct.refresh();
    productController.listSearchProduct.refresh();

    return listCart;
  }

  Future<void> removeCustomer() async {
    customer.value.customerpartnername = null;
    update();
  }

  Future<void> addCustomer(DataCustomer dataCustomer) async {
    customer.value = dataCustomer;
    update();
  }

  void storeTransactionPending({String? statusPaymentMethod, String? statusTransaction}) async {
    loadingBuilder();
    var box = GetStorage();
    await TransactionRemoteDataSource()
        .storeTransaction(
        customerPartnerID: customer.value.customerpartnerid,
        dateTransaction: DateFormat("yyyy-MM-dd").format(dateTransaction.value),
        discountID: dataDiscount == null ? null : dataDiscount!.discountId.toString(),
        paymentMethodID: "asd",
        listCart: listCart,
        transactionNoted: notedC.text,
        paymentMethodStatus: "Pending",
        priceOff: dataDiscount == null ? null : double.tryParse(dataDiscount!.discountMaxPriceOff!),
        totalTransaction: totalShopping.value,
        transactionPay: 0,
        transactionReceived: 0,
        transactionStatus: "Pending")
        .then((value) {
      Get.back();
      if (value.status) {
        getTransaction();

        Get.back();
        Get.back();
        Get.back();
        if (box.read(MyString.ROLE_NAME) != "Pemilik Toko") {
          Get.offAllNamed(Routes.INDEX_TRANSACTION);
          showSnackBar(snackBarType: SnackBarType.SUCCESS, title: 'transaksi'.tr, message: 'Transaksi Berhasil Disimpan');
        }
        showSnackBar(snackBarType: SnackBarType.SUCCESS, title: 'transaksi'.tr, message: 'Transaksi Berhasil Disimpan');
      }
    });
  }









//For Controller Cart Transaction

















}
