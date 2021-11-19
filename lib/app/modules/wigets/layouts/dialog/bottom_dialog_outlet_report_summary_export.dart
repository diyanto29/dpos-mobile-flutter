import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:warmi/app/modules/owner/outlet/controllers/outlet_controller.dart';
import 'package:warmi/app/modules/owner/report/controllers/report_controller.dart';
import 'package:warmi/app/modules/owner/report/controllers/report_controller.dart';
import 'package:warmi/app/modules/wigets/layouts/general_button.dart';
import 'package:warmi/core/globals/global_color.dart';
import 'package:warmi/core/globals/global_string.dart';
import 'package:warmi/core/utils/enum.dart';
import 'package:warmi/core/utils/thema.dart';
import 'package:recase/recase.dart';

import 'dialog_question.dart';

class BottomDialogOutletReportSummaryExport extends StatefulWidget {
  const BottomDialogOutletReportSummaryExport({Key? key}) : super(key: key);

  @override
  State<BottomDialogOutletReportSummaryExport> createState() => _BottomDialogOutletReportSummaryExportState();
}

class _BottomDialogOutletReportSummaryExportState extends State<BottomDialogOutletReportSummaryExport> {
  var controller =  Get.isRegistered<ReportController>()
  ? Get.find<ReportController>()
      : Get.put(ReportController());


  @override
  void initState() {

    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    var groupValue=1;
    return
        DraggableScrollableSheet(
          expand: false,
          minChildSize: 0.5,
          initialChildSize: 0.5,
          builder: (context, scrollController) {
            return Container(
              padding: EdgeInsets.all(MyString.DEFAULT_PADDING),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20.0),
                    topRight: Radius.circular(20.0),
                  ),
                  color: MyColor.colorWhite),
              child: ListView(
                  controller: scrollController,
                  physics: ClampingScrollPhysics(),
                  children: [
                    Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        margin: EdgeInsets.symmetric(vertical: 8),
                        height: 5.0,
                        width: 70.0,
                        decoration: BoxDecoration(
                            color: Colors.grey[400],
                            borderRadius: BorderRadius.circular(10.0)),
                      ),
                    ),
                   Card(
                     child: ListTile(
                       onTap: ()=> controller.generateReportPDF(),

                       title: Text("print_penjualan".tr),
                       subtitle: Text("ket_print".tr),
                     ),
                   ),
                    Card(
                      child: ListTile(
                        onTap: ()=> controller.generateReportPDF(type: "method"),
                       title: Text("print_metode_pembayaran".tr),
                        subtitle:  Text("ket_print".tr),
                   ),
                    )
                    // SizedBox(height: 30,),
                    // GeneralButton(label: "Simpan", onPressed: (){})
                  ],
                )

            );
          },
        );
  }
}
