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

class BottomDialogCategoryReport extends StatefulWidget {
  const BottomDialogCategoryReport({Key? key}) : super(key: key);

  @override
  State<BottomDialogCategoryReport> createState() => _BottomDialogCategoryReportState();
}

class _BottomDialogCategoryReportState extends State<BottomDialogCategoryReport> {
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
              child: Obx(() {
                return ListView(
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
                    controller.listCategoryProduct.length==0
                        ? Center(
                      child: CircularProgressIndicator(),
                    )
                        : ListView.builder(
                        itemCount: controller.listCategoryProduct.length,
                        physics: ClampingScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (c, i) {
                          var data = controller.listCategoryProduct[i];
                          return CheckboxListTile(
                                        title: Text(data.categoryName.toString().titleCase),
                                        value: data.isChecked,
                                        onChanged: (newValue) {
                                          controller.checkedCategory(data);
                                        },
                                        controlAffinity: ListTileControlAffinity.leading,  //  <-- leading Checkbox
                                      );
                        }),
                    // SizedBox(height: 30,),
                    // GeneralButton(label: "Simpan", onPressed: (){})
                  ],
                );
              }),
            );
          },
        );
  }
}
