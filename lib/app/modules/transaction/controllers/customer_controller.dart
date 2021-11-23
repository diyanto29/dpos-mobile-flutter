import 'package:external_path/external_path.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:recase/recase.dart';
import 'package:share_plus/share_plus.dart';
import 'package:warmi/app/data/datalocal/session/auth_session_manager.dart';
import 'package:warmi/app/data/datasource/customer/customer_remote_datasource.dart';
import 'package:warmi/app/data/models/customer/customer_model.dart';
import 'package:warmi/app/modules/wigets/layouts/dialog/dialog_loading.dart';
import 'package:warmi/app/modules/wigets/layouts/dialog/dialog_snackbar.dart';
import 'package:warmi/core/network/base_dio.dart';
import 'package:warmi/core/utils/enum.dart';
import 'dart:io';

import 'package:pdf/widgets.dart' as pw;

class CustomerController extends GetxController {
  Rx<TextEditingController> searchC = TextEditingController().obs;
  TextEditingController nameC = TextEditingController();
  TextEditingController emailC = TextEditingController();
  TextEditingController phoneNumberC = TextEditingController();
  TextEditingController addressC = TextEditingController();
  Rx<LoadingState> loadingState = LoadingState.loading.obs;

  var listCustomer = List<DataCustomer>.empty().obs;
  var listSearchCustomer = List<DataCustomer>.empty().obs;
  Rx<AuthSessionManager> auth=AuthSessionManager().obs;

  @override
  void onInit() {
    getCustomerDataSource();
    super.onInit();
  }

  void getCustomerDataSource() async {
    loadingState(LoadingState.loading);
    await CustomerRemoteDataSource().getCustomer().then((value) {
      listCustomer(value.data);
    });
    loadingState(LoadingState.empty);
  }

  void createCustomer({String? id}) async {
    if (nameC.value.text.isEmpty || phoneNumberC.value.text.isEmpty) {
      showSnackBar(
          snackBarType: SnackBarType.INFO,
          message: "Kolom harus Diisi",
          title: 'pelanggan'.tr);
      return;
    }
    loadingBuilder();
    await CustomerRemoteDataSource()
        .createCustomer(
            name: nameC.text,
            address: addressC.text,
            email: emailC.text,
            phoneNumber: phoneNumberC.text,
            id: id)
        .then((value) {
      if (value.status) {
        searchC.value.text = '';
        listCustomer.insert(0, DataCustomer.fromJson(value.data));
        Get.back();
        Get.back();
        showSnackBar(
            snackBarType: SnackBarType.WARNING,
            title: 'pelanggan'.tr,
            message: 'Data Berhasil Disimpan');
      } else {
        showSnackBar(
            snackBarType: SnackBarType.ERROR,
            title: 'pelanggan'.tr,
            message: "${value.message}");
      }
    });
  }

  void deleteCustomer(String? id) async {
    loadingBuilder();
    await CustomerRemoteDataSource().deleteCustomer(id: id).then((value) {
      Get.back();
      Get.back();
      if (value.status) getCustomerDataSource();
      showSnackBar(
          snackBarType: SnackBarType.SUCCESS,
          title: 'pelanggan'.tr,
          message: value.message);
    });
  }

  void searchCustomer(String keyword) async {
    loadingState(LoadingState.loading);
    await listSearchCustomer(listCustomer
        .where((item) =>
            item.customerpartnername
                .toString()
                .toLowerCase()
                .contains(keyword.toLowerCase()) ||
            item.customerpartnernumber
                .toString()
                .toLowerCase()
                .contains(keyword.toLowerCase()))
        .toList());
    loadingState(LoadingState.empty);
  }

  void generateReportPDF()async{
    print("A");
    final pdf = pw.Document();


    var tableHeadersMethod = [
      'Nama Pelanggan',
      "Nomor Telp"
      "Alamat",

    ];
    List<CUSTOMER> customer=[];
    int jum=0;

      listCustomer.forEach((element) {

        customer.add(CUSTOMER(element.customerpartnername.toString().titleCase,element.customerpartnernumber!,element.customerpartneraddress!));

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
            child:  pw.Text('LAPORAN DATA PELANGGAN'),
          ),
          pw.SizedBox(height: 10),

          pw.Text("Tgl Cetak : "+ DateFormat("EEEE, dd MMMM yyyy","${Get.locale}").format(DateTime.now())),
          pw.SizedBox(height: 20),
          pw.Text("pembuat".tr+" : "+ AuthSessionManager().userFullName),
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
              1: pw.Alignment.centerRight,
              2: pw.Alignment.center
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
            headers:  List<String>.generate(
              tableHeadersMethod.length,
                  (col) => tableHeadersMethod[col],
            ),
            data:  List<List<String>>.generate(
              listCustomer.length,
                  (row) => List<String>.generate(
                tableHeadersMethod.length,
                    (col) => customer[row].getIndex(col),
              ),
            ),
          ),

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

        final targetFile = Directory('$dir/laporan-data-pelanggan.pdf');
        if(targetFile.existsSync()) {
          targetFile.deleteSync(recursive: true);
        }

        final file = File('$dir/laporan-data-pelanggan.pdf');

        await file.writeAsBytes(await pdf.save());
        // if(targetFile.existsSync()) {
          Share.shareFiles(['$dir/laporan-data-pelanggan.pdf'], text: "laporan-data-pelanggan.pdf");
        // }

      }
    });

  }
}

class CUSTOMER {
  const CUSTOMER(this.name, this.phoneNumber, this.address);

  final String name;
  final String phoneNumber;
  final String address;


  String getIndex(int index) {
    switch (index) {
      case 0:
        return name;
      case 1:
        return phoneNumber;
      case 2:
        return address;

    }
    return '';
  }
}
