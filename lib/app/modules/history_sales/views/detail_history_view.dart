import 'package:dotted_decoration/dotted_decoration.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:warmi/app/data/models/transactions/transaction_model.dart';
import 'package:warmi/app/modules/history_sales/controllers/history_sales_controller.dart';
import 'package:warmi/app/modules/transaction/controllers/transaction_controller.dart';
import 'package:warmi/app/modules/wigets/layouts/general_button.dart';
import 'package:warmi/app/modules/wigets/layouts/general_text_input.dart';
import 'package:warmi/app/modules/wigets/package/screenshoot/screenshot.dart';
import 'package:warmi/app/routes/app_pages.dart';
import 'package:warmi/core/globals/global_color.dart';
import 'package:warmi/core/globals/global_string.dart';
import 'package:warmi/core/utils/thema.dart';
import 'package:warmi/main.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:recase/recase.dart';

class DetailHistoryView extends GetWidget<HistorySalesController> {
  const DetailHistoryView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var data = Get.arguments as DataTransaction;
    controller.getSubtotal(data);

    return Scaffold(
      backgroundColor: MyColor.colorBackground,
      appBar: AppBar(
        backgroundColor: MyColor.colorPrimary,
        title: Text(
          "${data.transactionid}",
          style: whiteTextTitle,
        ),
      ),
      body: Screenshot(
        controller: controller.screenshotController,
        child: Container(
          color: MyColor.colorBackground,
          child: ListView(
            padding: const EdgeInsets.all(MyString.DEFAULT_PADDING + 4),
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Flexible(
                      child: Text(
                    "Rp ${formatCurrency.format(int.tryParse(data.transactiontotal!))}",
                    style: blackTextTitle.copyWith(fontSize: 20.sp),
                  )),
                  Flexible(
                    child: Container(
                      alignment: Alignment.center,
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: data.transactionstatus!.contains("pending")
                            ? MyColor.colorRedFlatDark
                            : data.transactionstatus!.toLowerCase() == "cancel"
                                ? Colors.red
                                : data.transactionstatus!.toLowerCase() ==
                                        "success"
                                    ? Colors.green
                                    : MyColor.colorPrimary,
                      ),
                      child: Text(
                        "${data.transactionstatus.toString().titleCase}",
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
                    data.transactionnote ?? "-",
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
                    "${DateFormat('EEEE, dd MMM yyyy HH:mm:ss', 'id-ID').format(DateTime.parse(data.createdAt!))}",
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
                    data.paymentMethod == null
                        ? 'Cash'
                        : "${data.paymentMethod!.type!.paymentmethodtypename.toString().titleCase} -  ${data.paymentMethod!.paymentmethodname.toString().capitalize}",
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
                    "${data.transactionpaymentstatus.toString().titleCase}",
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
                    "${data.createdBy!.userfullname!}",
                    style: blackTextTitle.copyWith(fontSize: 14.sp),
                  )),
                ],
              ),
              SizedBox(
                height: 14,
              ),
              if (data.transactionpaymentstatus!.toLowerCase() == "cancel")
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Flexible(
                        child: Text(
                      'alasan'.tr,
                      style: blackTextTitle.copyWith(fontSize: 14.sp),
                    )),
                    Flexible(
                        child: Text(
                      "${data.transactionReasonCancel}",
                      style: blackTextTitle.copyWith(fontSize: 14.sp),
                    )),
                  ],
                ),
              if (data.transactionpaymentstatus!.toLowerCase() == "cancel")
                SizedBox(
                  height: 14,
                ),
              if (data.customerDetail != null)
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
                      "${data.customerDetail['CUSTOMER_PARTNER_NAME'].toString().titleCase}",
                      style: blackTextTitle.copyWith(fontSize: 14.sp),
                    )),
                  ],
                ),
              if (data.customerDetail != null)
                SizedBox(
                  height: 20,
                ),
              Container(decoration: DottedDecoration()),
              SizedBox(
                height: 20,
              ),
              ListView.builder(
                itemCount: data.detail!.length,
                shrinkWrap: true,
                physics: ClampingScrollPhysics(),
                itemBuilder: (c, i) {
                  var product = data.detail![i];
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
                                      borderRadius: BorderRadius.circular(100),
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
              Visibility(
                visible: data.transactionpriceoffvoucher != null ? true : false,
                child: Padding(
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
                            "- Rp ${formatCurrency.format(int.tryParse(data.transactionpriceoffvoucher ?? "0"))}",
                            style: blackTextTitle.copyWith(
                                color: MyColor.colorRedFlat),
                          )
                        ],
                      ))
                    ],
                  ),
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
                    "Rp ${formatCurrency.format(int.tryParse(data.transactiontotal!))}",
                    style: blackTextTitle,
                  ))
                ],
              ),
              SizedBox(
                height: 15,
              ),
              if (data.paymentMethod == null)
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
                          "Rp ${formatCurrency.format(int.tryParse(data.transactionpay!))}",
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
                          "Rp ${formatCurrency.format(int.tryParse(data.transactionreceived!))}",
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
              ),
              SizedBox(
                height: 10,
              ),
              if (data.transactionpaymentstatus!.toLowerCase() != 'cancel')
                TextButton(
                    onPressed: () {
                      showDialogCancel(
                          title: "Transaksi",
                          message: "Batalkan Transaksi",
                          dataTransaction: data);
                    },
                    child: Text(
                      'batal'.tr,
                      style: TextStyle(color: Colors.red),
                    ))
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
          margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          height: 50,
          width: double.infinity,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              Flexible(
                child: Container(
                  height: 50,
                  width: double.infinity,
                  child: ElevatedButton(
                    child: Text(
                      'cetak'.tr,
                      style: GoogleFonts.droidSans(fontSize: 16),
                    ),
                    style: ElevatedButton.styleFrom(
                        elevation: 1,
                        primary: MyColor.colorPrimary,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10))),
                    onPressed: () {
                      controller.testPrint(data);
                    },
                  ),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              data.transactionstatus!.contains('pending')
                  ? Flexible(
                      child: Container(
                        height: 50,
                        width: double.infinity,
                        child: ElevatedButton(
                          child: Text(
                            'bayar_sekarang'.tr,
                            style: GoogleFonts.droidSans(fontSize: 16),
                          ),
                          style: ElevatedButton.styleFrom(
                              elevation: 1,
                              primary: MyColor.colorRedFlatDark,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10))),
                          onPressed: () => controller.checkoutNow(data),
                        ),
                      ),
                    )
                  : Flexible(
                      child: Container(
                        height: 50,
                        width: double.infinity,
                        child: ElevatedButton(
                          child: Text(
                            'kirim'.tr,
                            style: GoogleFonts.droidSans(fontSize: 16),
                          ),
                          style: ElevatedButton.styleFrom(
                              elevation: 1,
                              primary: MyColor.colorRedFlatDark,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10))),
                          onPressed: () =>
                              controller.sendInvoice(id: data.transactionid),
                        ),
                      ),
                    ),
            ],
          )),
    );
  }

  Future<dynamic> showDialogCancel(
      {required String title,
      required String message,
      required DataTransaction dataTransaction}) {
    final controllerTransaciton = Get.isRegistered<TransactionController>()
        ? Get.find<TransactionController>()
        : Get.put(TransactionController());
    TextEditingController controllerReason = TextEditingController();
    return Get.dialog(
      AlertDialog(
        title: Text(title),
        content: Container(
          height: 100,
          child: GeneralTextInput(
              controller: controllerReason,
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
              labelTextInputBox: 'catatan'.tr,
              descTextInputBox: 'Masukan Catatan Pembatalan'),
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        actions: [
          GeneralButton(
              height: 45,
              width: double.infinity,
              label: 'simpan'.tr,
              onPressed: () {
                controllerTransaciton.changeStatusTransaction(
                    dataTransaction: dataTransaction,
                    type: "cancel",
                    reasonCancel: controllerReason.text);
              }),
        ],
      ),
    );
  }
}
