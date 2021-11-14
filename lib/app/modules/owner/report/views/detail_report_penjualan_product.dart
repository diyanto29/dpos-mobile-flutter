import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:warmi/app/modules/owner/report/controllers/report_controller.dart';
import 'package:warmi/core/globals/global_color.dart';

import '../../../../../main.dart';

class DetailReportSellingProduct extends GetWidget<ReportController> {
  const DetailReportSellingProduct({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyColor.colorPrimary,
        title: Text(
          'detail_penjualan'.tr,
        ),
      ),
      body: GetBuilder<ReportController>(builder: (logic) {
        return Padding(
            padding: const EdgeInsets.all(20.0),
            child: SingleChildScrollView(
              child: DataTable(
                  sortAscending: true,
                  sortColumnIndex: 0,
                  showBottomBorder: true,
                  columnSpacing: Get.width * 0.14,
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
