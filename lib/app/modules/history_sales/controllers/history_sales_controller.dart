import 'dart:io';
import 'dart:typed_data';

import 'package:external_path/external_path.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import 'package:warmi/app/data/datalocal/session/auth_session_manager.dart';
import 'package:warmi/app/data/datasource/transactions/transaction_source_data_remote.dart';
import 'package:warmi/app/data/models/transactions/transaction_model.dart';
import 'package:warmi/app/modules/owner/settings/controllers/printer_controller.dart';
import 'package:warmi/app/modules/transaction/controllers/cart_controller.dart';
import 'package:warmi/app/modules/transaction/controllers/transaction_controller.dart';
import 'package:warmi/app/modules/wigets/package/screenshoot/screenshot.dart';
import 'package:warmi/app/routes/app_pages.dart';
import 'package:warmi/core/utils/enum.dart';

class HistorySalesController extends GetxController with SingleGetTickerProviderMixin {
  //TODO: Implement HistorySalesController
  final List<Tab> tabs = <Tab>[
     Tab(text: "Semua"),
     Tab(text: "Lunas"),
     Tab(text: "Menunggu Pembayaran"),
     // Tab(text: "Utang"),
     Tab(text: "Dibatalkan"),
  ];

  late TabController tabController;
  PageController controllerPage =
  PageController(keepPage: false, initialPage: 0);
  RxInt initialIndex = 0.obs;
  RxInt index = 0.obs;

  var printerC = Get.isRegistered<PrinterController>()
      ? Get.find<PrinterController>() :Get.put(PrinterController());

  ScreenshotController screenshotController=ScreenshotController();
  Rx<AuthSessionManager> auth=AuthSessionManager().obs;



  final count = 0.obs;
  @override
  void onInit() {
    tabController = TabController(vsync: this, length: tabs.length);

    super.onInit();
  }

  @override
  void onReady() {

    super.onReady();
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  void onClose() {}
  void increment() => count.value++;



  List<DataTransaction> listTransaction = [];

  LoadingState loadingState = LoadingState.loading;

  void getTransaction({String? statusTransaction,String? statusPayment})async{
    loadingState=LoadingState.loading;

    if(listTransaction.isNotEmpty) listTransaction.clear();

    await TransactionRemoteDataSource().getTransaction(statusPayment: statusPayment,statusTransaction: statusTransaction).then((value) {
      listTransaction=value.data!;
    });
    loadingState=LoadingState.empty;
    update();
  }

  RxInt subTotal=0.obs;

  void getSubtotal(DataTransaction dataTransaction)async{
    subTotal(0);
    dataTransaction.detail!.forEach((element) {
      subTotal.value= (subTotal.value+ int.tryParse(element.detailtransactionsubtotal.toString())!)  - (int.tryParse(element.detailtransactionsubtotal!)! - element.priceafterdiscount!);

    });
    print(subTotal.value);
  }

  void testPrint(DataTransaction dataTransaction)async{
    printerC.printTicketPurchase(dataTransaction: dataTransaction);
  }

  void sendInvoice({String? id})async{
    screenshotController.capture().then((Uint8List? image) async{
      var dir;
      await ExternalPath.getExternalStoragePublicDirectory(ExternalPath.DIRECTORY_PICTURES).then((value) {
        dir=value;
      });
      File file = new File('$dir/$id'+'.png');
      await file.writeAsBytes(image!);
      Share.shareFiles(['$dir/$id'+'.png'], text: '$id');



    }).catchError((onError) {
      print(onError);
    });
  }


  void checkoutNow(DataTransaction dataTransaction)async{
    var checkoutC=Get.find<TransactionController>();
    var cartC = Get.find<CartController>();
    cartC.totalShopping(double.tryParse(dataTransaction.transactiontotal!));
    Map<dynamic,dynamic> data={
      "from" : "history",
      "data" : dataTransaction
    };
    Get.toNamed(Routes.CHECKOUT_PAGE,arguments: data);
  }






}
