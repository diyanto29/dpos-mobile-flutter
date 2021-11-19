import 'dart:convert';

import 'package:external_path/external_path.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';
import 'package:pdf/pdf.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:share_plus/share_plus.dart';
import 'package:warmi/app/data/datalocal/session/auth_session_manager.dart';
import 'package:warmi/app/data/datasource/outlet/outlet_remote_data_source.dart';
import 'package:warmi/app/data/datasource/transactions/transaction_source_data_remote.dart';
import 'package:warmi/app/data/models/outlet/outlet.dart';
import 'package:warmi/app/data/models/report_transaction/report_transaction.dart';
import 'package:warmi/app/modules/owner/settings/controllers/printer_controller.dart';
import 'package:warmi/core/globals/global_color.dart';
import 'package:recase/recase.dart';

import 'package:warmi/core/utils/enum.dart';
import 'dart:io';

import 'package:pdf/widgets.dart' as pw;
import 'package:warmi/main.dart';

class ReportController extends GetxController {
  TextEditingController controllerDate = TextEditingController();
  Rx<ReportTransaction> reportTransaction=ReportTransaction().obs;
  Rx<LoadingState> loadingState = LoadingState.loading.obs;
  var date,startDate,endDate;
  var listOutlet = List<DataOutlet>.empty().obs;


  var printerC = Get.isRegistered<PrinterController>()
      ? Get.find<PrinterController>()
      : Get.put(PrinterController());

  List<MultiSelectItem<DataOutlet>> item=[];

  RxString storeName="".obs;


  @override
  void onInit() {
    init();
    super.onInit();
  }

  void getOutletDataSource() async {
    var locale=Get.locale;
    print(locale);
    loadingState(LoadingState.loading);
    listOutlet.add(DataOutlet(
      storeName: "semua_outlet".tr,
      storeId: "all",
      isChecked: true
    ));
    await OutletRemoteDataSource().getOutlet().then((value) {
      listOutlet.addAll(value.data!);
    });

    listOutlet.forEach((element) {
      element.isChecked=true;
    });
    listOutlet.refresh();
    print(item.length);
    print('hai Report');
    loadingState(LoadingState.empty);
  }
  void init() {
    getOutletDataSource();
     date="${DateTime.now().year}-${DateTime.now().month}-01";
     startDate=DateFormat("yyyy-MM-dd", 'id-iD').format(DateTime.parse(date));
     endDate=DateFormat("yyyy-MM-dd", 'id-iD').format(DateTime.parse(startDate).add(Duration(days: 30)));
    controllerDate.text = DateFormat("dd MMMM yyyy", 'id-iD').format(DateTime.now()) + " - " + DateFormat("dd MMMM yyyy", 'id-iD').format(DateTime.now().add(Duration(days: 30)));

    getReportTransaction(startDate: startDate,dueDate: endDate);
    update();
  }

  void getReportTransaction({String? startDate,String? dueDate,List<dynamic>? listStore})async{
    loadingState(LoadingState.loading);
    await TransactionRemoteDataSource().getReportTransaction(startDate: startDate,dueDate: dueDate,type: "all",listStore: listStore).then((value) {
      reportTransaction(value);
      controllerDate.text=DateFormat("dd MMMM yyyy", 'id-iD').format(DateTime.parse(startDate!))+ " - " + DateFormat("dd MMMM yyyy", 'id-iD').format(DateTime.parse(dueDate!));
      loadingState(LoadingState.empty);
      update();
    });
  }

  void checkedOutlet(DataOutlet dataOutlet)async{
    if(dataOutlet.storeId=="all" && dataOutlet.isChecked){
      listOutlet.forEach((element) {
        element.isChecked=false;
      });
    }else if(dataOutlet.storeId=="all" && !dataOutlet.isChecked){
      listOutlet.forEach((element) {
        element.isChecked=true;
      });
    }else{
      int tot=0;
      listOutlet.forEach((element) {
        if(element.storeId==dataOutlet.storeId){
          element.isChecked=!element.isChecked;
        }
      });
      listOutlet.forEach((element) {
        if(element.isChecked  && element.storeId!="all"){
          tot++;
        }
      });

      print(listOutlet.length-1);
      if((listOutlet.length-1)==tot){
        listOutlet[0].isChecked=true;
      }else{
        listOutlet[0].isChecked=false;
      }

    }

    List<dynamic> list=[];
    listOutlet.forEach((element) {
      if(element.storeId!="all"){
        if(element.isChecked) {
          storeName("${element.storeName},");
          list.add({"store_id": element.storeId});
        }
      }
    });
  getReportTransaction(listStore: list,startDate: startDate,dueDate: endDate);
    listOutlet.refresh();
  }

  setLocale(){
    listOutlet[0].storeName="semua_outlet".tr;
  }

  void printReport({String? type}) async {
    printerC.printTicketPurchaseReport(reportTransaction.value,startDate: startDate,endDate: endDate,type: type);
  }

  void generateReportPDF({String type="sales"})async{
    final pdf = pw.Document();
    var tableHeaders = [
      'nama_produk'.tr,
      'terjual'.tr,
      'total_transaksi'.tr
    ];
    var tableHeadersMethod = [
      'metode_pembayaran'.tr,
      'terjual'.tr,
      'total_transaksi'.tr
    ];
    List<Product> products=[];
    int jum=0;
   if(type=="sales")
     reportTransaction.value.data!.penjualanProduk!.forEach((element) {

       products.add(Product(element.name!, int.tryParse(element.count.toString())!,double.tryParse(element.sum.toString())!));
       jum+=element.sum!;
     });
   else
     reportTransaction.value.data!.paymentMethod!.forEach((element) {

       products.add(Product(element.paymentMethodAlias.toString().titleCase, int.tryParse(element.count.toString())!,double.tryParse(element.total.toString())!));
       jum+=element.total!;
     });

    pdf.addPage(

      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        header: (pw.Context context) =>   pw.Column(
            mainAxisAlignment: pw.MainAxisAlignment.start,
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children:[

            ]
        ),
        build: (pw.Context context) => [
          pw.Center(
            child: type=="sales"? pw.Text('LAPORAN PENJUALAN By Produk') : pw.Text('LAPORAN PENJUALAN By Metode Pembayaran'),
          ),
          pw.SizedBox(height: 10),
          pw.Center(
            child: pw.Text('Periode'),
          ),
          pw.SizedBox(height: 10),
          pw.Center(
            child: pw.Text('$startDate - $endDate'),
          ),
          pw.SizedBox(height: 10),
          pw.Text("Tgl Cetak : "+ DateFormat("EEEE, dd MMMM yyyy","${Get.locale}").format(DateTime.now())),
          pw.SizedBox(height: 20),
          pw.Text("pembuat".tr+" : "+ AuthSessionManager().userFullName),
          pw.SizedBox(height: 20),

          pw.Text(listOutlet[0].isChecked ?  "toko".tr+" : "+ "semua_outlet".tr : "toko".tr+" : "+ storeName.value),
          pw.SizedBox(height: 20),
          pw.Table.fromTextArray(
            border: null,
            cellAlignment: pw.Alignment.centerLeft,
            headerDecoration: pw.BoxDecoration(
              borderRadius: const pw.BorderRadius.all(pw.Radius.circular(2)),
              color: PdfColors.deepOrange,
            ),
            headerHeight: 25,
            cellHeight: 40,
            cellAlignments: {
              0: pw.Alignment.centerLeft,
              1: pw.Alignment.centerLeft,
              2: pw.Alignment.centerRight,
              3: pw.Alignment.center,
              4: pw.Alignment.centerRight,
            },
            headerStyle: pw.TextStyle(
              color: PdfColors.white,
              fontSize: 10,
              fontWeight: pw.FontWeight.bold,
            ),
            cellStyle: const pw.TextStyle(
              color: PdfColors.black,
              fontSize: 10,
            ),
            rowDecoration: pw.BoxDecoration(
              border: pw.Border(
                bottom: pw.BorderSide(
                  color: PdfColors.deepOrange,
                  width: .5,
                ),
              ),
            ),
            headers: type=="sales"  ? List<String>.generate(
              tableHeaders.length,
                  (col) => tableHeaders[col],
            ): List<String>.generate(
              tableHeadersMethod.length,
                  (col) => tableHeadersMethod[col],
            ),
            data: type=="sales" ? List<List<String>>.generate(
              reportTransaction.value.data!.penjualanProduk!.length,
                  (row) => List<String>.generate(
                tableHeaders.length,
                    (col) => products[row].getIndex(col),
              ),
            )  : List<List<String>>.generate(
              reportTransaction.value.data!.paymentMethod!.length,
                  (row) => List<String>.generate(
                tableHeadersMethod.length,
                    (col) => products[row].getIndex(col),
              ),
            ),
          ),

          pw.SizedBox(height: 20),
          pw.Text("penjualan_kotor".tr+" : "+ formatCurrency.format(reportTransaction.value.data!.ringkasanTransaksi!.totalAll)),
          pw.SizedBox(height: 10),
          pw.Text("Transaksi Cash"+" : "+ formatCurrency.format(reportTransaction.value.data!.ringkasanTransaksi!.totalCash)),
          pw.SizedBox(height: 10),
          pw.Text("Diskon"+" : "+ formatCurrency.format(reportTransaction.value.data!.ringkasanTransaksi!.allDisc)),
          pw.SizedBox(height: 10),
          pw.Text("pembatalan".tr+" : "+ formatCurrency.format(reportTransaction.value.data!.ringkasanTransaksi!.cancel)),
          pw.SizedBox(height: 10),
          pw.Text("penjualan_bersih".tr+" : "+ formatCurrency.format(reportTransaction.value.data!.ringkasanTransaksi!.neto)),
          pw.SizedBox(height: 20),
        ],



      ),
    );

    await Permission.storage.request().then((value) async {
      if (value.isGranted) {
        var dir;
        await ExternalPath.getExternalStoragePublicDirectory(ExternalPath.DIRECTORY_DOWNLOADS).then((value) {
          dir = value;


        });

        final targetFile = Directory('$dir/laporan-penjualan-$startDate-$endDate.pdf');
        if(targetFile.existsSync()) {
          targetFile.deleteSync(recursive: true);
        }

        final file = File('$dir/laporan-penjualan-$startDate-$endDate.pdf');

        await file.writeAsBytes(await pdf.save());
        Share.shareFiles(['$dir/laporan-penjualan-$startDate-$endDate.pdf'], text: "laporan-penjualan-$startDate-$endDate.pdf");
      }
    });

  }

}

class Product {
  const Product(
      this.productName,

      this.quantity,
      this.total,
      );

  final String productName;

  final int quantity;
  final double total;

  String getIndex(int index) {
    switch (index) {
      case 0:
        return productName;
      case 1:
        return quantity.toString();
      case 2:
        return formatCurrency.format(total);
    }
    return '';
  }
}



