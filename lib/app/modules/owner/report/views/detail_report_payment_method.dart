import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:warmi/app/modules/owner/report/controllers/report_controller.dart';
import 'package:warmi/core/globals/global_color.dart';
import 'package:warmi/main.dart';

class DetailReportPaymentMethod extends GetWidget<ReportController> {
  const DetailReportPaymentMethod({Key? key}) : super(key: key);

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
                  columnSpacing: Get.mediaQuery.orientation==Orientation.landscape ? Get.width * 0.24 : Get.width * 0.14,

                  columns: <DataColumn>[
                    DataColumn(
                      label: Flexible(
                        child: Text("Pembayaran"),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'Jml.TRX',
                      ),

                    ),
                    DataColumn(
                      label: Text(
                        'Tot. TRX',
                      ),

                    ),
                  ],
                  rows: logic.reportTransaction.value.data!.paymentMethod!
                      .map<DataRow>((e) => DataRow(

                            cells: <DataCell>[
                              DataCell(Text("${e.paymentMethodAlias}")),
                              DataCell(Text("${e.count}")),
                              DataCell(Text("${formatCurrency.format(e.total)}")),
                            ],
                          ))
                      .toList()),
            ));
      }),
    );
  }
}
