import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:warmi/app/modules/owner/report/controllers/report_controller.dart';
import 'package:warmi/core/globals/global_color.dart';

import '../../../../../main.dart';

class DetailReportSellingProduct extends GetWidget<ReportController> {
  const DetailReportSellingProduct({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var spacing=Get.mediaQuery.orientation==Orientation.landscape ? Get.width * 0.24 : Get.width * 0.14;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyColor.colorPrimary,
        title: Text(
          'detail_penjualan'.tr,
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
                    style: ElevatedButton.styleFrom(elevation: 1, primary: MyColor.colorPrimary, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
                    onPressed: () {
                    controller.printReport();
                    },
                  ),
                ),
              ),
              SizedBox(
                width: 10,
              ),
               Flexible(
                child: Container(
                  height: 50,
                  width: double.infinity,
                  child: ElevatedButton(
                    child: Text(
                      'kirim'.tr,
                      style: GoogleFonts.droidSans(fontSize: 16),
                    ),
                    style: ElevatedButton.styleFrom(elevation: 1, primary: MyColor.colorRedFlatDark, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
                    onPressed: () {
                      controller.generateReportPDF();
                    },
                  ),
                ),
              ),
            ],
          )),
      body: GetBuilder<ReportController>(builder: (logic) {
        return Padding(
            padding: const EdgeInsets.all(20.0),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                  sortAscending: true,
                  sortColumnIndex: 0,
                  showBottomBorder: true,
                  columnSpacing: spacing,
                  columns: <DataColumn>[
                    DataColumn(
                      label: Flexible(
                        child: Text('nama_produk'.tr),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'terjual'.tr,
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'Tot. TRX',
                      ),

                    ),
                  ],

                  rows: logic.reportTransaction.value.data!.penjualanProduk!
                      .map<DataRow>((e) => DataRow(
                            cells: <DataCell>[
                              DataCell(Text("${e.name}")),
                              DataCell(Text("${e.count}")),
                              DataCell(Text("${formatCurrency.format(e.sum!)}")),
                            ],
                          ))
                      .toList()),
            ));
      }),
    );
  }
}
