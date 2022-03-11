import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:get/get.dart';
import 'package:horizontal_data_table/horizontal_data_table.dart';
import 'package:intl/intl.dart';
import 'package:warmi/app/modules/owner/report/controllers/report_controller.dart';
import 'package:warmi/app/modules/transaction/controllers/transaction_controller.dart';
import 'package:warmi/app/modules/wigets/layouts/dialog/bottom_dialog_category_report.dart';
import 'package:warmi/app/modules/wigets/layouts/dialog/bottom_dialog_outlet_report.dart';
import 'package:warmi/core/globals/global_color.dart';
import 'package:warmi/core/globals/global_string.dart';
import 'package:warmi/core/utils/enum.dart';
import 'package:warmi/core/utils/thema.dart';

// import 'package:horizontal_data_table/horizontal_data_table.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../../main.dart';

class ReportBySalesCategoryView extends StatefulWidget {
  @override
  _ReportBySalesCategoryViewState createState() =>
      _ReportBySalesCategoryViewState();
}

class _ReportBySalesCategoryViewState extends State<ReportBySalesCategoryView> {
  HDTRefreshController _hdtRefreshController = HDTRefreshController();
  var controllerTransaction = Get.isRegistered<TransactionController>()
      ? Get.find<TransactionController>()
      : Get.put(TransactionController());
  var controller = Get.isRegistered<ReportController>()
      ? Get.find<ReportController>()
      : Get.put(ReportController());
  static const int sortName = 0;
  static const int sortStatus = 1;
  bool isAscending = true;
  int sortType = sortName;

  @override
  void initState() {
    if(DateTime.now().month<10){
      controller.date="${DateTime.now().year}-0${DateTime.now().month }-01";
    }else{
      controller.date="${DateTime.now().year}-${DateTime.now().month }-01";
    }

    controller.startDate=DateFormat("yyyy-MM-dd", 'id-iD').format(DateTime.parse(controller.date));
    controller.endDate=DateFormat("yyyy-MM-dd", 'id-iD').format(DateTime.parse(controller.startDate).add(Duration(days: 30)));
    super.initState();
  }

  Future showBottomSheetOutlet() {
    return Get.bottomSheet(BottomDialogCategoryReport(),
        isScrollControlled: true, elevation: 3);
  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: MyColor.colorBackground,
        floatingActionButton:Row(
          mainAxisAlignment: MainAxisAlignment.center,

          children: [
            Container(
                margin: EdgeInsets.symmetric(vertical: 0),
                child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                        primary: MyColor.colorPrimary),
                    onPressed: () => controller.generateReportPDFBYCategory(),
                    icon: Icon(Icons.import_export),
                    label: Text('Export'))),
            Container(
                margin: EdgeInsets.symmetric(vertical: 10,horizontal: 10),
                child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                        primary: MyColor.colorBlue),
                    onPressed: () => controller.printReportByCategory(),
                    icon: Icon(Icons.print),
                    label: Text('Print'))),
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        resizeToAvoidBottomInset: true,
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
                                    'kategori_produk'.tr,
                                    style:
                                    blackTextFont.copyWith(fontSize: 14.sp),
                                  ),
                                ],
                              ),
                              Obx(() {
                                return Text(

                                  controller.listCategoryProduct[0].isChecked
                                      ? "semua_kategori".tr
                                      : "${controller.CategoryName}",
                                  style: blackTextFont.copyWith(
                                      fontWeight: FontWeight.bold),
                                  overflow: TextOverflow.ellipsis,
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
                          firstDate: DateTime(DateTime
                              .now()
                              .year - 5),
                          lastDate: DateTime(DateTime
                              .now()
                              .year + 5),
                          initialDateRange: DateTimeRange(
                            end: DateTime.parse(controller.date)
                                .add(Duration(days: 30)),
                            start: DateTime.parse(controller.date),
                          ),
                        );
                        var startDate = DateFormat("yyyy-MM-dd", 'id-iD')
                            .format(picked!.start);
                        var endDate =
                        DateFormat("yyyy-MM-dd", 'id-iD').format(picked.end);
                        List<dynamic> list = [];
                        controller.listCategoryProduct.forEach((element) {
                          if (element.categoryId != "all") {
                            if (element.isChecked) {
                              list.add({"category_id": element.categoryId});
                            }
                          }
                        });
                        controller.startDate = startDate;
                        controller.endDate = endDate;
                        controller.getReportTransactionByCategory(
                            startDate: startDate,
                            dueDate: endDate,
                            listStore: list);
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
        body: Obx(() {
          return controller.loadingStateCategory.value==LoadingState.loading ? Center(child: CircularProgressIndicator()):
          controller.reportTransactionByCategory.value.data==null ? Center(child: Text("data_kosong".tr)) :
          controller.reportTransactionByCategory.value.data!.isEmpty ? Center(child: Text("data_kosong".tr)) :

          Container(
            child: HorizontalDataTable(
              leftHandSideColumnWidth: 150,
              rightHandSideColumnWidth: 600,
              isFixedHeader: true,
              headerWidgets: _getTitleWidget(),
              leftSideItemBuilder: (BuildContext context, i) {
                var data = controller.reportTransactionByCategory.value.data!
                    [i];
                return Container(
                  child: Text(controller.reportTransactionByCategory.value.data!
                      [i].name!),
                  width: 200,
                  height: 52,
                  padding: EdgeInsets.fromLTRB(MyString.DEFAULT_PADDING, 0, 0, 10),
                  alignment: Alignment.centerLeft,
                );
              },
              rightSideItemBuilder: (BuildContext context, i) {
                var data = controller.reportTransactionByCategory.value.data![i];
                return Row(
                  children: <Widget>[

                    Container(
                      child: Text(data.category.toString()),
                      width: 150,
                      height: 52,
                      padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
                      alignment: Alignment.centerLeft,
                    ),
                    Container(
                      child: Text(data.count.toString()),
                      width: 80,
                      height: 52,
                      padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
                      alignment: Alignment.centerLeft,
                    ),
                    Container(
                      child: Text("${"${formatCurrency.format(data.sum!)}"}"),
                      width: 150,
                      height: 52,
                      padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
                      alignment: Alignment.centerLeft,
                    ),

                  ],
                );
              },
              itemCount: controller.reportTransactionByCategory.value.data!.length,
              rowSeparatorWidget: const Divider(
                color: Colors.black54,
                height: 1.0,
                thickness: 0.0,
              ),
              leftHandSideColBackgroundColor: Color(0xFFFFFFFF),
              rightHandSideColBackgroundColor: Color(0xFFFFFFFF),
              verticalScrollbarStyle: const ScrollbarStyle(
                thumbColor: MyColor.colorPrimary,
                isAlwaysShown: true,
                thickness: 4.0,
                radius: Radius.circular(5.0),
              ),
              // horizontalScrollbarStyle: const ScrollbarStyle(
              //   thumbColor: Colors.red,
              //   isAlwaysShown: true,
              //   thickness: 4.0,
              //   radius: Radius.circular(5.0),
              // ),
              enablePullToRefresh: false,
              // refreshIndicator: const WaterDropHeader(),
              refreshIndicatorHeight: 60,

              htdRefreshController: _hdtRefreshController,
            ),
            height: MediaQuery
                .of(context)
                .size
                .height,
          );
        }),
      ),
    );
  }


  List<Widget> _getTitleWidget() {
    return [
      _getTitleItemWidget('nama_produk'.tr, 200),
      _getTitleItemWidget('kategori_produk'.tr, 150),
      _getTitleItemWidget('terjual'.tr, 80),
      _getTitleItemWidget('total_transaksi'.tr, 150),
    ];
  }

  Widget _getTitleItemWidget(String label, double width) {
    return Container(
      child: Text(label, style: TextStyle(fontWeight: FontWeight.bold)),
      width: width,
      height: 56,
      padding: EdgeInsets.fromLTRB(MyString.DEFAULT_PADDING, 0, 0, 0),
      alignment: Alignment.centerLeft,
    );
  }


}


