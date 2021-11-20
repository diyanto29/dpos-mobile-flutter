import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:get/get.dart';
import 'package:horizontal_data_table/horizontal_data_table.dart';
import 'package:intl/intl.dart';
import 'package:warmi/app/modules/owner/report/controllers/report_controller.dart';
import 'package:warmi/app/modules/transaction/controllers/customer_controller.dart';
import 'package:warmi/app/modules/transaction/controllers/customer_controller.dart';
import 'package:warmi/app/modules/transaction/controllers/customer_controller.dart';
import 'package:warmi/app/modules/transaction/controllers/transaction_controller.dart';
import 'package:warmi/app/modules/wigets/layouts/dialog/bottom_dialog_outlet_report.dart';
import 'package:warmi/core/globals/global_color.dart';
import 'package:warmi/core/globals/global_string.dart';
import 'package:warmi/core/utils/enum.dart';
import 'package:warmi/core/utils/thema.dart';

// import 'package:horizontal_data_table/horizontal_data_table.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../../main.dart';

class ReportByCustomer extends StatefulWidget {
  @override
  _ReportByCustomerState createState() =>
      _ReportByCustomerState();
}

class _ReportByCustomerState extends State<ReportByCustomer> {
  HDTRefreshController _hdtRefreshController = HDTRefreshController();

  var controller = Get.isRegistered<CustomerController>()
      ? Get.find<CustomerController>()
      : Get.put(CustomerController());
  static const int sortName = 0;
  static const int sortStatus = 1;
  bool isAscending = true;
  int sortType = sortName;

  @override
  void initState() {
    controller.getCustomerDataSource();
    super.initState();
  }

  Future showBottomSheetOutlet() {
    return Get.bottomSheet(BottomDialogOutletReport(),
        isScrollControlled: true, elevation: 3);
  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: MyColor.colorPrimary,
          title: Text('pelanggan'.tr),
        ),
        backgroundColor: MyColor.colorBackground,
        // floatingActionButton:Row(
        //   mainAxisAlignment: MainAxisAlignment.center,
        //
        //   children: [
        //     Container(
        //         margin: EdgeInsets.symmetric(vertical: 0),
        //         child: ElevatedButton.icon(
        //             style: ElevatedButton.styleFrom(
        //                 primary: MyColor.colorPrimary),
        //             onPressed: () {
        //               print("a");
        //               controller.generateReportPDF();
        //             },
        //             icon: Icon(Icons.import_export),
        //             label: Text('Export'))),
        //     // Container(
        //     //     margin: EdgeInsets.symmetric(vertical: 10,horizontal: 10),
        //     //     child: ElevatedButton.icon(
        //     //         style: ElevatedButton.styleFrom(
        //     //             primary: MyColor.colorBlue),
        //     //         onPressed: () => controller.printReport(type: "method"),
        //     //         icon: Icon(Icons.print),
        //     //         label: Text('Print'))),
        //   ],
        // ),
        // floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        resizeToAvoidBottomInset: true,

        body: Obx(() {
          return controller.loadingState.value==LoadingState.loading ? Center(child: CircularProgressIndicator()):
          controller.listCustomer.length==0 ? Center(child: Text("data_kosong".tr)) :

          Container(
            child: HorizontalDataTable(
              leftHandSideColumnWidth: 150,
              rightHandSideColumnWidth: 800,
              isFixedHeader: true,
              headerWidgets: _getTitleWidget(),
              leftSideItemBuilder: (BuildContext context, i) {

                return Container(
                  child: Text(controller.listCustomer
                      [i].customerpartnername!),
                  width: 150,
                  height: 52,
                  padding: EdgeInsets.fromLTRB(MyString.DEFAULT_PADDING, 0, 0, 10),
                  alignment: Alignment.centerLeft,
                );
              },
              rightSideItemBuilder: (BuildContext context, i) {
                var data = controller.listCustomer
                [i];
                return Row(
                  children: <Widget>[

                    Container(
                      child: Text(data.customerpartnernumber.toString()),
                      width: 120,
                      height: 52,
                      padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
                      alignment: Alignment.centerLeft,
                    ),
                    Container(
                      child: Text(data.customerpartneraddress.toString()),
                      width: 250,
                      height: 52,
                      padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
                      alignment: Alignment.centerLeft,
                    ),
                   Container(
                      child: Text(data.customerpartneremail.toString()),
                      width: 250,
                      height: 52,
                      padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
                      alignment: Alignment.centerLeft,
                    ),


                  ],
                );
              },
              itemCount: controller.listCustomer.length,
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
      _getTitleItemWidget('Nama Pelanggan', 150),
      _getTitleItemWidget('Nomor Telp', 120),
        _getTitleItemWidget('Alamat', 250),
        _getTitleItemWidget('Email', 250),
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


