import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:warmi/app/modules/owner/report/controllers/report_controller.dart';
import 'package:warmi/app/modules/transaction/controllers/transaction_controller.dart';
import 'package:warmi/app/modules/wigets/layouts/dialog/bottom_dialog_outlet_report.dart';
import 'package:warmi/app/modules/wigets/layouts/dialog/bottom_dialog_outlet_report_summary_export.dart';
import 'package:warmi/app/modules/wigets/layouts/dialog/bottom_dialog_outlet_report_summary_print.dart';
import 'package:warmi/app/modules/wigets/layouts/home/drawer_cashier.dart';
import 'package:warmi/app/routes/app_pages.dart';
import 'package:warmi/core/globals/global_color.dart';
import 'package:warmi/core/utils/enum.dart';
import 'package:warmi/core/utils/thema.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:warmi/main.dart';
import 'package:recase/recase.dart';

class ReportView extends GetWidget<ReportController> {
  @override
  Widget build(BuildContext context) {
    var controllerTransaction = Get.put(TransactionController());
    final GlobalKey<ScaffoldState> _scaffoldKey =
        new GlobalKey<ScaffoldState>();
    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        backgroundColor: MyColor.colorBackground,
        floatingActionButton:Row(
          mainAxisAlignment: MainAxisAlignment.center,

          children: [
            Container(
                margin: EdgeInsets.symmetric(vertical: 10),
                child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                        primary: MyColor.colorPrimary),
                    onPressed: () {},
                    icon: Icon(Icons.import_export),
                    label: Text('Export'))),
            Container(
                margin: EdgeInsets.symmetric(vertical: 10,horizontal: 10),
                child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                        primary: MyColor.colorBlue),
                    onPressed: () => showBottomSheetPrint(),
                    icon: Icon(Icons.print),
                    label: Text('Print'))),
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        resizeToAvoidBottomInset: true,
        drawer: controllerTransaction.auth.value.roleName == "Pemilik Toko"
            ? null
            : DrawerCustom(),
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(140.0),
          child: Card(
            elevation: 2,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (controllerTransaction.auth.value.roleName !=
                          "Pemilik Toko")
                        Flexible(
                          child: IconButton(
                              onPressed: () =>
                                  _scaffoldKey.currentState!.openDrawer(),
                              icon: Icon(
                                Icons.menu,
                                color: MyColor.colorPrimary,
                              )),
                        ),
                      Flexible(
                        child: InkWell(
                          onTap: () => showBottomSheetOutlet(),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.keyboard_arrow_down_rounded,
                                    color: MyColor.colorBlack,
                                  ),
                                  Text(
                                    'toko_anda'.tr,
                                    style:
                                        blackTextFont.copyWith(fontSize: 14.sp),
                                  ),
                                ],
                              ),
                              Obx(() {
                                return Text(
                                  controller.listOutlet[0].isChecked
                                      ? "semua_outlet".tr
                                      : "${controller.storeName}",
                                  style: blackTextFont.copyWith(
                                      fontWeight: FontWeight.bold),
                                );
                              })
                            ],
                          ),
                        ),
                      ),
                      // Flexible(
                      //   child: controller.listOutlet.length==0 ? CircularProgressIndicator() :
                      //   ListView.builder(
                      //       itemCount: controller.listOutlet.length,
                      //       itemBuilder: (c,i){
                      //         var data=controller.listOutlet[i];
                      //         return CheckboxListTile(
                      //           title: Text("title text"),
                      //           value: data.isChecked,
                      //           onChanged: (newValue) {
                      //             controller.checkedOutlet(data);
                      //           },
                      //           controlAffinity: ListTileControlAffinity.leading,  //  <-- leading Checkbox
                      //         );
                      //       }),
                      // ),
                      Flexible(
                          child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              IconlyLight.notification,
                              color: MyColor.colorWhite,
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            Icon(
                              IconlyLight.logout,
                              color: MyColor.colorWhite,
                            )
                          ],
                        ),
                      ))
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  GetBuilder<ReportController>(builder: (logic) {
                    return TextField(
                      controller: controller.controllerDate,
                      onTap: () async {
                        DateTimeRange? picked = await showDateRangePicker(
                          context: Get.context!,
                          firstDate: DateTime(DateTime.now().year - 5),
                          lastDate: DateTime(DateTime.now().year + 5),
                          initialDateRange: DateTimeRange(
                            end: DateTime.parse(controller.date)
                                .add(Duration(days: 30)),
                            start: DateTime.parse(controller.date),
                          ),
                        );
                        var startDate = DateFormat("yyyy-MM-dd", 'id-iD')
                            .format(picked!.start);
                        var endDate = DateFormat("yyyy-MM-dd", 'id-iD')
                            .format(picked.end);
                        controller.startDate = startDate;
                        controller.endDate = endDate;
                        controller.getReportTransaction(
                            startDate: startDate, dueDate: endDate);
                      },
                      readOnly: true,
                      style: TextStyle(height: 0.9, fontSize: 14),
                      decoration: InputDecoration(
                          hintText: "01 April 2021 - 01 Mei 2021",
                          hintStyle: TextStyle(
                              fontSize: 12, color: MyColor.colorBlackT50),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            borderSide: BorderSide(
                                width: 1, color: MyColor.colorBlackT50),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            borderSide: BorderSide(
                                width: 1, color: MyColor.colorPrimary),
                          ),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide:
                                  BorderSide(color: Colors.red, width: 0.1)),
                          suffixIcon: Icon(
                            IconlyLight.calendar,
                            color: MyColor.colorBlackT50,
                          )),
                    );
                  })
                ],
              ),
            ),
          ),
        ),
        body: Column(
          children: [
            GetBuilder<ReportController>(builder: (logic) {
              return Expanded(
                  child: ListView(
                shrinkWrap: true,
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                physics: ClampingScrollPhysics(),
                children: [
                  Card(
                    elevation: 0.4,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('ringkasan'.tr, style: blackTextTitle),
                          SizedBox(
                            height: 10,
                          ),
                          Divider(
                            thickness: 1,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Flexible(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'penjualan_kotor'.tr,
                                      style: blackTextFont,
                                    ),
                                    SizedBox(
                                      height: 6,
                                    ),
                                    logic.loadingState == LoadingState.loading
                                        ? CircularProgressIndicator()
                                        : logic.reportTransaction.value.data ==
                                                null
                                            ? Text(
                                                "Rp 0",
                                                style: blackTextFont,
                                              )
                                            : Text(
                                                "Rp. ${formatCurrency.format(logic.reportTransaction.value.data!.ringkasanTransaksi!.totalAll!)}",
                                                style: blackTextTitle,
                                              ),
                                  ],
                                ),
                              ),
                              Flexible(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      'transaksi_tunai'.tr,
                                      style: blackTextFont,
                                    ),
                                    SizedBox(
                                      height: 6,
                                    ),
                                    logic.loadingState == LoadingState.loading
                                        ? CircularProgressIndicator()
                                        : logic.reportTransaction.value.data ==
                                                null
                                            ? Text(
                                                "Rp 0",
                                                style: blackTextFont,
                                              )
                                            : Text(
                                                "Rp. ${formatCurrency.format(logic.reportTransaction.value.data!.ringkasanTransaksi!.totalCash!)}",
                                                style: blackTextTitle,
                                              ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Flexible(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "diskon".tr,
                                      style: blackTextFont,
                                    ),
                                    SizedBox(
                                      height: 6,
                                    ),
                                    logic.loadingState == LoadingState.loading
                                        ? CircularProgressIndicator()
                                        : logic.reportTransaction.value.data ==
                                                null
                                            ? Text(
                                                "Rp 0",
                                                style: blackTextFont,
                                              )
                                            : Text(
                                                "- Rp. ${formatCurrency.format(logic.reportTransaction.value.data!.ringkasanTransaksi!.allDisc!)}",
                                                style: blackTextTitle,
                                              ),
                                  ],
                                ),
                              ),
                              Flexible(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      'pembatalan'.tr,
                                      style: blackTextFont,
                                    ),
                                    SizedBox(
                                      height: 6,
                                    ),
                                    logic.loadingState == LoadingState.loading
                                        ? CircularProgressIndicator()
                                        : logic.reportTransaction.value.data ==
                                                null
                                            ? Text(
                                                "Rp 0",
                                                style: blackTextFont,
                                              )
                                            : Text(
                                                "- Rp ${formatCurrency.format((logic.reportTransaction.value.data!.ringkasanTransaksi!.cancel!))}",
                                                style: blackTextTitle,
                                              ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Flexible(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'penjualan_bersih'.tr,
                                      style: blackTextFont,
                                    ),
                                    SizedBox(
                                      height: 6,
                                    ),
                                    logic.loadingState == LoadingState.loading
                                        ? CircularProgressIndicator()
                                        : logic.reportTransaction.value.data ==
                                                null
                                            ? Text(
                                                "Rp 0",
                                                style: blackTextFont,
                                              )
                                            : Text(
                                                "Rp. ${formatCurrency.format((logic.reportTransaction.value.data!.ringkasanTransaksi!.neto!))}",
                                                style: blackTextTitle,
                                              ),
                                  ],
                                ),
                              ),
                              Flexible(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      'total_transaksi'.tr,
                                      style: blackTextFont,
                                    ),
                                    SizedBox(
                                      height: 6,
                                    ),
                                    logic.loadingState == LoadingState.loading
                                        ? CircularProgressIndicator()
                                        : logic.reportTransaction.value.data ==
                                                null
                                            ? Text(
                                                "Rp 0",
                                                style: blackTextFont,
                                              )
                                            : Text(
                                                "${logic.reportTransaction.value.data!.ringkasanTransaksi!.success}",
                                                style: blackTextTitle,
                                              ),
                                  ],
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  Card(
                    elevation: 0.4,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          InkWell(
                            onTap: () => Get.toNamed(
                                Routes.DETAIL_REPORT_SELLING_PRODUCT),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  'penjualan_produk'.tr,
                                  style: blackTextTitle,
                                ),
                                Icon(
                                  IconlyLight.arrowRightCircle,
                                  size: 25,
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Divider(
                            thickness: 1,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          GetBuilder<ReportController>(builder: (logic) {
                            return logic.reportTransaction.value.data == null
                                ? Container()
                                : ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: logic.reportTransaction.value
                                                .data!.penjualanProduk!.length >
                                            3
                                        ? 3
                                        : logic.reportTransaction.value.data!
                                            .penjualanProduk!.length,
                                    physics: ClampingScrollPhysics(),
                                    itemBuilder: (c, i) {
                                      var data = logic.reportTransaction.value
                                          .data!.penjualanProduk![i];
                                      return ListTile(
                                        title: Text(
                                          "${data.name.toString().titleCase}",
                                          style: blackTextFont,
                                        ),
                                        subtitle: Divider(
                                          thickness: 1,
                                        ),
                                        trailing: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Rp ${formatCurrency.format((data.sum!))}",
                                              style: blackTextTitle,
                                            ),
                                            SizedBox(
                                              height: 2,
                                            ),
                                            Text(
                                              "${data.count}" +
                                                  ' ' +
                                                  'terjual'.tr,
                                              style: blackTextTitle,
                                            ),
                                          ],
                                        ),
                                      );
                                    });
                          })
                        ],
                      ),
                    ),
                  ),
                  Card(
                    elevation: 0.4,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          InkWell(
                            onTap: () => Get.toNamed(
                                Routes.DETAIL_REPORT_PAYMENT_METHOD),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  'metode_pembayaran'.tr,
                                  style: blackTextTitle,
                                ),
                                Icon(
                                  IconlyLight.arrowRightCircle,
                                  size: 25,
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Divider(
                            thickness: 1,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          GetBuilder<ReportController>(builder: (logic) {
                            return logic.reportTransaction.value.data == null
                                ? Container()
                                : ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: logic.reportTransaction.value
                                                .data!.paymentMethod!.length >
                                            3
                                        ? 3
                                        : logic.reportTransaction.value.data!
                                            .paymentMethod!.length,
                                    physics: ClampingScrollPhysics(),
                                    itemBuilder: (c, i) {
                                      var data = logic.reportTransaction.value
                                          .data!.paymentMethod![i];
                                      return ListTile(
                                        title: Text(
                                          "${data.paymentMethodAlias.toString().titleCase}",
                                          style: blackTextFont,
                                        ),
                                        subtitle: Divider(
                                          thickness: 1,
                                        ),
                                        trailing: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Rp. ${formatCurrency.format(data.total)}",
                                              style: blackTextTitle,
                                            ),
                                            SizedBox(
                                              height: 2,
                                            ),
                                            Text(
                                              "${data.count} " + 'transaksi'.tr,
                                              style: blackTextTitle,
                                            ),
                                          ],
                                        ),
                                      );
                                    });
                          }),
                        ],
                      ),
                    ),
                  ),


                ],
              ));
            }),
          ],
        ),
      ),
    );
  }

  Future showBottomSheetOutlet() {
    return Get.bottomSheet(BottomDialogOutletReport(),
        isScrollControlled: true, elevation: 3);
  }

  Future showBottomSheetPrint() {
    return Get.bottomSheet(BottomDialogOutletReportSummaryPrint(),
        isScrollControlled: true, elevation: 3);
  }

  Future showBottomSheetExport() {
    return Get.bottomSheet(BottomDialogOutletReportSummaryExport(),
        isScrollControlled: true, elevation: 3);
  }
}
