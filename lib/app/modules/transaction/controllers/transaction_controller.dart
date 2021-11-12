import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
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
import 'package:permission_handler/permission_handler.dart';
import 'package:share_plus/share_plus.dart';
import 'package:warmi/app/data/datalocal/session/auth_session_manager.dart';
import 'package:warmi/app/data/datasource/product/product_remote_data_source.dart';
import 'package:warmi/app/data/datasource/transactions/transaction_source_data_remote.dart';

import 'package:warmi/app/data/models/payment_method/payment_method_channel.dart' as PM;
import 'package:warmi/app/data/models/product/product.dart';
import 'package:warmi/app/data/models/transactions/transaction_model.dart';
import 'package:warmi/app/modules/history_sales/controllers/history_sales_controller.dart';
import 'package:warmi/app/modules/owner/product/controllers/product_controller.dart';
import 'package:warmi/app/modules/owner/settings/controllers/discount_controller.dart';
import 'package:warmi/app/modules/owner/settings/controllers/payment_method_controller.dart';
import 'package:warmi/app/modules/owner/settings/controllers/printer_controller.dart';
import 'package:warmi/app/modules/transaction/controllers/cart_controller.dart';
import 'package:warmi/app/modules/wigets/layouts/dialog/dialog_loading.dart';
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

class TransactionController extends GetxController with SingleGetTickerProviderMixin {
  //TODO: Implement TransactionController
  var productController = Get.put(ProductController());
  Rx<LoadingState> loadingState = LoadingState.loading.obs;
  Rx<TextEditingController> searchC = TextEditingController().obs;
  var listSearchProduct = List<DataProduct>.empty().obs;
  var discountController = Get.put(DiscountController());
  var printerC = Get.isRegistered<PrinterController>() ? Get.find<PrinterController>() : Get.put(PrinterController());
  final List<Tab> tabs = <Tab>[
    Tab(text: "Semua"),
    Tab(text: "Paket"),
  ];

  final List<Tab> tabsCheckout = <Tab>[
    Tab(text: "Tunai"),
    Tab(text: "Non Tunai"),
  ];
  late TabController tabController;
  PageController controllerPage = PageController(keepPage: false, initialPage: 0);
  RxInt initialIndex = 0.obs;
  RxInt index = 0.obs;
  late TabController tabControllerCheckout;
  PageController controllerPageCheckout = PageController(keepPage: false, initialPage: 0);
  RxInt initialIndexCheckout = 0.obs;
  RxInt indexCheckout = 0.obs;
  RxString title = "List Kontak".obs;
  DataTransaction? detailTransaction;
  Rx<AuthSessionManager> auth = AuthSessionManager().obs;



  List<DataTransaction> listTransaction = [];
  void getTransaction({String? statusTransaction})async{
    if(listTransaction.isNotEmpty) listTransaction.clear();
    await TransactionRemoteDataSource().getTransaction(statusTransaction: "pending").then((value) {
      listTransaction=value.data!;

    });


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

      if (_updateInfo!.updateAvailability == UpdateAvailability.updateAvailable) {
        InAppUpdate.performImmediateUpdate().catchError((e) {
          print(e);
        });
      }
    }).catchError((e) {
      print(e);
    });
  }

  Future<void> initAdmob() async {
    var box =GetStorage();
    print("Success Load loadad");
    // if(box.read(MyString.STATUS_NAME)=="FREE") {
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
   // }



  }

  @override
  void onInit() {
    checkForUpdate();
    getTransaction();
    initAdmob();
    discountController.getDiscountDataSource();
    Get.lazyPut<CartController>(() => CartController());
    tabController = TabController(vsync: this, length: tabs.length);
    tabControllerCheckout = TabController(vsync: this, length: tabsCheckout.length);
    productController.getProduct().then((value) {
      loadingState(LoadingState.empty);
    });
    discountController.getDiscountDataSource();
    super.onInit();
  }

  @override
  void dispose() {
    tabController.dispose();
    tabControllerCheckout.dispose();
    listSearchProduct.clear();
    listTransaction.clear();
    var box =GetStorage();
    if(box.read(MyString.STATUS_NAME)=="FREE"){
      bannerAd.dispose();
      interstitialAd.dispose();
    }
    super.dispose();
  }

  void getSearchProduct(String name) async {
    loadingState(LoadingState.loading);
    await ProductRemoteDataSource().getSearchProduct(name: name).then((value) {
      listSearchProduct(value.data);
      loadingState(LoadingState.empty);
      checkProductInCart();

    });
    searchC.refresh();
    listSearchProduct.refresh();
  }

  void checkProductInCart() async {
    var cartC = Get.find<CartController>();
    if (cartC.listCart.length > 0) {
      cartC.listCart.forEach((element) {
        listSearchProduct.forEach((item) {
          if (element.dataProduct == item) {
            item.productInCart = true;
            listSearchProduct.refresh();
            update();
          }
        });
      });
      listSearchProduct.refresh();
    }
  }

  void scanBarcode() async {
    String barcodeScanRes = await FlutterBarcodeScanner.scanBarcode("#ff6666", 'Batal', true, ScanMode.BARCODE);
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
    pay.value = cashC.value.text.isEmpty || cashC.value.text == "" ? 0.0 : double.tryParse(cashC.value.text.split(" ").last.replaceAll(".", ""))!;
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
    pay.value = cashC.value.text.isEmpty ? 0.0 : double.tryParse(cashC.value.text.split(" ").last.replaceAll(".", ""))!;
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
    pay.value = cashC.value.text.isEmpty ? 0.0 : double.tryParse(cashC.value.text.split(" ").last.replaceAll(".", ""))!;
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
    var conCart = Get.find<CartController>();
    double calc = pay.value - conCart.totalShopping.value;
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
    var conCart = Get.find<CartController>();
    var conProd = Get.find<ProductController>();

    if (paymentMethod.value.paymentmethodid == null) {
      double calc = pay.value - conCart.totalShopping.value;
      if (pay < conCart.totalShopping.value) {
        showSnackBar(snackBarType: SnackBarType.INFO, title: "Pembayaran", message: "Pembayaran Kurang ${formatCurrency.format(calc)}");
      } else {
        loadingBuilder();
        print("asdas");
        await TransactionRemoteDataSource()
            .storeTransaction(
                customerPartnerID: conCart.customer.value.customerpartnerid,
                dateTransaction: DateFormat("yyyy-MM-dd").format(conCart.dateTransaction.value),
                discountID: conCart.dataDiscount == null ? null : conCart.dataDiscount!.discountId.toString(),
                paymentMethodID: paymentMethod.value.paymentmethodid,
                listCart: conCart.listCart,
                paymentMethodStatus: "done",
                priceOff: conCart.dataDiscount == null ? null : double.tryParse(conCart.dataDiscount!.discountMaxPriceOff!),
                totalTransaction: conCart.totalShopping.value,
                transactionPay: pay.value,
                transactionReceived: cashReceived.value,
                transactionStatus: "success")
            .then((value) {
          Get.back();

          if (value.status) {
            conCart.listCart.clear();
            productController.listProduct.forEach((element) {
              element.productInCart=false;
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
          }else{
            showSnackBar(snackBarType: SnackBarType.INFO,title: "Transaksi",message: value.message.split("=>").last);
          }
        });
      }
    }
    else {
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
              customerPartnerID: conCart.customer.value.customerpartnerid,
              dateTransaction: DateFormat("yyyy-MM-dd").format(conCart.dateTransaction.value),
              discountID: conCart.dataDiscount == null ? null : conCart.dataDiscount!.discountId.toString(),
              paymentMethodID: paymentMethod.value.paymentmethodid,
              listCart: conCart.listCart,
              paymentMethodStatus: "done",
              priceOff: conCart.dataDiscount == null ? null : double.tryParse(conCart.dataDiscount!.discountMaxPriceOff!),
              totalTransaction: conCart.totalShopping.value,
              transactionPay: 0,
              transactionReceived: 0,
              transactionStatus: "success")
          .then((value) {
        Get.back();

        if (value.status) {
          conCart.listCart.clear();
          detailTransaction = DataTransaction.fromJson(value.data);
          productController.listProduct.forEach((element) {
            element.productInCart=false;
          });
          Get.toNamed(Routes.TRANSACTION_SUCCESS, arguments: pass);
          printerC.printTicketPurchase(dataTransaction: detailTransaction);


        }else{
          showSnackBar(snackBarType: SnackBarType.INFO,title: "Transaksi",message: value.message.split("=>").last);
        }
      });
    }
  }

  void changeStatusTransaction({DataTransaction? dataTransaction}) async {
    var conCart = Get.find<CartController>();
    if (paymentMethod.value.paymentmethodid == null) {
      double calc = pay.value - conCart.totalShopping.value;
      if (pay < conCart.totalShopping.value) {
        showSnackBar(snackBarType: SnackBarType.INFO, title: "Pembayaran", message: "Pembayaran Kurang ${formatCurrency.format(calc)}");
      } else {
        print(pay.value);
        print(cashReceived.value);
        loadingBuilder();
        await TransactionRemoteDataSource()
            .changeStatusTransaction(
                transactionPaymentDate: DateFormat("yyyy-MM-dd").format(DateTime.now()),
                paymentMethodID: paymentMethod.value.paymentmethodid,
                listCart: conCart.listCart,
                paymentMethodStatus: "done",
                transactionPay: pay.value,
                transactionID: dataTransaction!.transactionid.toString(),
                transactionReceived: cashReceived.value,
                transactionStatus: "success")
            .then((value) {
          Get.back();
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
              transactionPaymentDate: DateFormat("yyyy-MM-dd").format(DateTime.now()),
              paymentMethodID: paymentMethod.value.paymentmethodid,
              listCart: conCart.listCart,
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
    printerC.printTicketPurchase(dataTransaction: detailTransaction);
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
                        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: detailTransaction!.transactionstatus!.contains("pending") ? MyColor.colorRedFlatDark : MyColor.colorPrimary,
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
                      "Catatan",
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
                      "Waktu",
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
                      "Metode Pembayaran",
                      style: blackTextTitle.copyWith(fontSize: 14.sp),
                    )),
                    Flexible(
                        child: Text(
                      detailTransaction!.paymentMethod == null ? 'Cash' : "${detailTransaction!.paymentMethod!.type!.paymentmethodtypename.toString().titleCase} -  ${detailTransaction!.paymentMethod!.paymentmethodname.toString().capitalize}",
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
                      "Status Pembayaran",
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
                      "Kasir",
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
                        "Pelanggan",
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
                                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(100), color: MyColor.colorOrange),
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
                                    crossAxisAlignment: CrossAxisAlignment.start,
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
                              if ((int.tryParse(product.detailtransactionsubtotal!)! - product.priceafterdiscount!) > 0)
                                Text(
                                  "-  Rp ${formatCurrency.format(int.tryParse(product.detailtransactionsubtotal!)! - product.priceafterdiscount!)}",
                                  style: blackTextFont.copyWith(color: MyColor.colorRedFlat),
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
                          "Diskon",
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
                            style: blackTextTitle.copyWith(color: MyColor.colorRedFlat),
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
                        "Total Bayar",
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
                            "Bayar",
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
                            "Kembalian",
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
                    "Power By DPOS",
                    style: blackTextTitle.copyWith(fontStyle: FontStyle.italic, fontWeight: FontWeight.w400, color: MyColor.colorBlackT50),
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
      await ExternalPath.getExternalStoragePublicDirectory(ExternalPath.DIRECTORY_PICTURES).then((value) {
        dir = value;
      });
      File file = new File('$dir/${detailTransaction!.transactionid}' + '.png');
      await file.writeAsBytes(capturedImage);
      Share.shareFiles(['$dir/${detailTransaction!.transactionid}' + '.png'], text: '${detailTransaction!.transactionid}');
    });
  }
}
