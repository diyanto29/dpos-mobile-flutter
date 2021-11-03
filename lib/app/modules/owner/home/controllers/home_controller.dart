import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:warmi/app/data/datasource/transactions/transaction_source_data_remote.dart';

import 'package:warmi/app/data/models/report_transaction/report_transaction.dart';
import 'package:warmi/app/modules/history_sales/controllers/history_sales_controller.dart';
import 'package:warmi/app/modules/wigets/layouts/dialog/dialog_question.dart';
import 'package:warmi/app/routes/app_pages.dart';
import 'package:warmi/core/globals/global_string.dart';

class HomeController extends GetxController{


  final RxInt currentSlider=0.obs;
  final CarouselController carouselController=CarouselController();
  Rx<ReportTransaction> reportTranasaction=ReportTransaction().obs;
   var imageSliders=List<Widget>.empty().obs;
  var historySalesC = Get.isRegistered<HistorySalesController>()
      ? Get.find<HistorySalesController>() :Get.put(HistorySalesController());

   RxDouble scrollOpacity=1.0.obs;


  @override
  void onInit() {
  imageSliders.add(Image.asset("assets/Banner1.jpg",fit: BoxFit.fitWidth,width:  10000,));
  imageSliders.add(Image.asset("assets/Banner2.jpg",fit: BoxFit.fitWidth,width: 200.w,));
  imageSliders.add(Image.asset("assets/Banner3.jpg",fit :BoxFit.fitWidth,width: 200.w,));
  historySalesC.getTransaction();
  getReportTransaction();
  print("home");
    super.onInit();
  }


  void getReportTransaction()async{
    var date="${DateTime.now().year}-${DateTime.now().month}-01";
    var startDate=DateFormat("yyyy-MM-dd", 'id-iD').format(DateTime.parse(date));
    var endDate=DateFormat("yyyy-MM-dd", 'id-iD').format(DateTime.now().add(Duration(days: 30)));
    await TransactionRemoteDataSource().getReportTransaction(startDate: startDate,dueDate: endDate,type: "custom").then((value) {
      reportTranasaction(value);
      update();
    });
  }
  void logOut(){
    var box=GetStorage();
    showDialogQuestion(title: 'Keluar', message: 'Apakah Anda Yakin ? ', clickYes: (){
      box.remove(MyString.USER_ID);
      Get.offAllNamed(Routes.LOGIN_CHOOISE);
    });
  }



}