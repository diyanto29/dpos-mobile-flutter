import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:warmi/app/modules/owner/report/controllers/report_controller.dart';
import 'package:warmi/core/globals/global_color.dart';

class DetailReportSellingProduct extends GetWidget<ReportController> {
  const DetailReportSellingProduct({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyColor.colorPrimary,
        title: Text(
          "Detail Penjualan",
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
                        child: Text("Nama Produk"),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'Terjual',
                      ),
                    ),
                  ],
                  rows: logic.reportTransaction.value.data!.products!
                      .map<DataRow>((e) => DataRow(
                            cells: <DataCell>[
                              DataCell(Text("${e.productname}")),
                              DataCell(Text("${e.productsold}")),
                            ],
                          ))
                      .toList()),
            ));
      }),
    );
  }
}
