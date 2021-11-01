import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:warmi/app/modules/owner/report/controllers/report_controller.dart';
import 'package:warmi/app/modules/wigets/layouts/dialog/bottom_dialog_outlet.dart';
import 'package:warmi/app/routes/app_pages.dart';
import 'package:warmi/core/globals/global_color.dart';
import 'package:warmi/core/utils/thema.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:warmi/main.dart';
import 'package:recase/recase.dart';

class ReportView extends GetWidget<ReportController> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: MyColor.colorBackground,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(130.0),
          child: Card(
            elevation: 2,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //   crossAxisAlignment: CrossAxisAlignment.start,
                  //   children: [
                  //     Flexible(
                  //       child: InkWell(
                  //         onTap: () => showBottomSheetOutlet(),
                  //         child: Column(
                  //           mainAxisAlignment: MainAxisAlignment.start,
                  //           crossAxisAlignment: CrossAxisAlignment.start,
                  //           children: [
                  //             Row(
                  //               mainAxisAlignment: MainAxisAlignment.start,
                  //               crossAxisAlignment: CrossAxisAlignment.center,
                  //               children: [
                  //                 Icon(
                  //                   Icons.keyboard_arrow_down_rounded,
                  //                   color: MyColor.colorBlack,
                  //                 ),
                  //                 Text(
                  //                   "Toko Anda",
                  //                   style: blackTextTitle.copyWith(fontSize: 14.sp),
                  //                 ),
                  //               ],
                  //             ),
                  //             Text(
                  //               " Toko Barokah",
                  //               style: blackTextTitle.copyWith(fontWeight: FontWeight.bold),
                  //             )
                  //           ],
                  //         ),
                  //       ),
                  //     ),
                  //     Flexible(
                  //         child: Padding(
                  //           padding: const EdgeInsets.all(8.0),
                  //           child: Row(
                  //             mainAxisAlignment: MainAxisAlignment.end,
                  //             crossAxisAlignment: CrossAxisAlignment.center,
                  //             children: [
                  //               Icon(
                  //                 IconlyLight.notification,
                  //                 color: MyColor.colorWhite,
                  //               ),
                  //               SizedBox(
                  //                 width: 15,
                  //               ),
                  //               Icon(
                  //                 IconlyLight.logout,
                  //                 color: MyColor.colorWhite,
                  //               )
                  //             ],
                  //           ),
                  //         ))
                  //   ],
                  // ),
                  SizedBox(height: 10,),
                  GetBuilder<ReportController>(builder: (logic) {
                    return TextField(
                      controller: controller.controllerDate,
                      onTap: () async {
                        DateTimeRange? picked = await showDateRangePicker(

                          context: Get.context!,
                          firstDate: DateTime(DateTime
                              .now()
                              .year - 5),
                          lastDate: DateTime(DateTime
                              .now()
                              .year + 5),
                          initialDateRange: DateTimeRange(
                            end: DateTime.now().add(Duration(days: 30)),
                            start: DateTime.now(),
                          ),
                        );
                        var startDate=DateFormat("yyyy-MM-dd", 'id-iD').format(picked!.start);
                        var endDate=DateFormat("yyyy-MM-dd", 'id-iD').format(picked.end);
                        controller.getReportTransaction(startDate: startDate,dueDate: endDate);
                      },
                      readOnly: true,
                      style: TextStyle(height: 0.9, fontSize: 14),
                      decoration: InputDecoration(
                          hintText: "01 April 2021 - 01 Mei 2021",
                          hintStyle:
                          TextStyle(fontSize: 12, color: MyColor.colorBlackT50),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            borderSide:
                            BorderSide(width: 1, color: MyColor.colorBlackT50),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            borderSide:
                            BorderSide(width: 1, color: MyColor.colorPrimary),
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
                    padding: EdgeInsets.symmetric(
                        horizontal: 10, vertical: 0),
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
                              Text(
                                  "Ringkasan",
                                  style: blackTextTitle
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
                                          "Penjualan Kotor",
                                          style: blackTextFont,
                                        ),
                                        SizedBox(
                                          height: 6,
                                        ),
                                        logic.reportTransaction.value.data == null ? CircularProgressIndicator() : Text(
                                          "Rp. ${formatCurrency.format(logic.reportTransaction.value.data!.totalIncomeTransaction!)}",
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
                                          "Uang Diterima",
                                          style: blackTextFont,
                                        ),
                                        SizedBox(
                                          height: 6,
                                        ),
                                        logic.reportTransaction.value.data == null ? CircularProgressIndicator() : Text(
                                          "Rp. ${formatCurrency.format(logic.reportTransaction.value.data!.totalIncomeTransaction!)}",
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
                                          "Diskon",
                                          style: blackTextFont,
                                        ),
                                        SizedBox(
                                          height: 6,
                                        ),
                                        logic.reportTransaction.value.data == null ? CircularProgressIndicator() : Text(
                                          "- Rp. ${formatCurrency.format(logic.reportTransaction.value.data!.totalDiscount!)}",
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
                                          "Pembatalan",
                                          style: blackTextFont,
                                        ),
                                        SizedBox(
                                          height: 6,
                                        ),
                                        Text(
                                          "- Rp. 0",
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
                                          "Penjualan Bersih",
                                          style: blackTextFont,
                                        ),
                                        SizedBox(
                                          height: 6,
                                        ),
                                        logic.reportTransaction.value.data == null ? CircularProgressIndicator() : Text(
                                          "Rp. ${formatCurrency.format((logic.reportTransaction.value.data!.totalBenefit! - logic.reportTransaction.value.data!.totalDiscount!))}",
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
                                          "Pesanan",
                                          style: blackTextFont,
                                        ),
                                        SizedBox(
                                          height: 6,
                                        ),
                                        logic.reportTransaction.value.data == null ? CircularProgressIndicator() : Text(
                                          "${logic.reportTransaction.value.data!.totalTransaction.toString()}",
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
                                onTap: ()=> Get.toNamed(Routes.DETAIL_REPORT_SELLING_PRODUCT),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Penjualan Produk",
                                      style: blackTextTitle,
                                    ),
                                    Icon(IconlyLight.arrowRightCircle, size: 25,)
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
                                return logic.reportTransaction.value.data==null ? Container(): ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: logic.reportTransaction.value.data!.products!.length > 3 ? 3 :logic.reportTransaction.value.data!.products!.length,
                                    physics: ClampingScrollPhysics(),
                                    itemBuilder: (c, i) {
                                      var data = logic.reportTransaction.value.data!.products![i];
                                      return ListTile(
                                        title: Text(
                                          "${data.productname
                                              .toString()
                                              .titleCase}",
                                          style: blackTextFont,
                                        ),
                                        subtitle: Divider(
                                          thickness: 1,
                                        ),
                                        trailing: Column(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            // Text(
                                            //   "Rp.100.000",
                                            //   style: blackTextTitle,
                                            // ),
                                            // SizedBox(
                                            //   height: 2,
                                            // ),
                                            Text(
                                              "${data.productsold} Terjual",
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
                                onTap: ()=> Get.toNamed(Routes.DETAIL_REPORT_PAYMENT_METHOD),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Metode Pembayaran",
                                      style: blackTextTitle,
                                    ),
                                    Icon(IconlyLight.arrowRightCircle, size: 25,)
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
                                 return logic.reportTransaction.value.data==null ? Container(): ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: logic.reportTransaction.value.data!.paymentMethod!.length > 3 ? 3 : logic.reportTransaction.value.data!.paymentMethod!.length ,
                                    physics: ClampingScrollPhysics(),
                                    itemBuilder: (c, i) {
                                      var data=logic.reportTransaction.value.data!.paymentMethod![i];
                                      return ListTile(
                                        title: Text(
                                          "${data.paymentMethod.toString().titleCase}",
                                          style: blackTextFont,
                                        ),
                                        subtitle: Divider(
                                          thickness: 1,
                                        ),
                                        trailing: Column(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Rp. ${formatCurrency.format(int.tryParse(data.nominalTransaction!))}",
                                              style: blackTextTitle,
                                            ),
                                            SizedBox(
                                              height: 2,
                                            ),
                                            Text(
                                              "${data.totalTransaction} Transaksi",
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
                      )
                    ],
                  ));
            })
          ],
        ),
      ),
    );
  }


  Future showBottomSheetOutlet() {
    return Get.bottomSheet(BottomDialogOutlet(), isScrollControlled: true, elevation: 3);
  }
}