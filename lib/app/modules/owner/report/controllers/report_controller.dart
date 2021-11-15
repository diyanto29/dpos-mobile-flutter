import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:warmi/app/data/datasource/transactions/transaction_source_data_remote.dart';
import 'package:warmi/app/data/models/report_transaction/report_transaction.dart';

import 'package:warmi/core/utils/enum.dart';

class ReportController extends GetxController {
  TextEditingController controllerDate = TextEditingController();
  Rx<ReportTransaction> reportTransaction=ReportTransaction().obs;
  Rx<LoadingState> loadingState = LoadingState.loading.obs;


  @override
  void onInit() {
    init();
    super.onInit();
  }

  void init() {
    var date="${DateTime.now().year}-${DateTime.now().month}-01";
    var startDate=DateFormat("yyyy-MM-dd", 'id-iD').format(DateTime.parse(date));
    var endDate=DateFormat("yyyy-MM-dd", 'id-iD').format(DateTime.parse(startDate).add(Duration(days: 30)));
    controllerDate.text = DateFormat("dd MMMM yyyy", 'id-iD').format(DateTime.now()) + " - " + DateFormat("dd MMMM yyyy", 'id-iD').format(DateTime.now().add(Duration(days: 30)));
    getReportTransaction(startDate: startDate,dueDate: endDate);
    update();
  }

  void getReportTransaction({String? startDate,String? dueDate})async{
    loadingState(LoadingState.loading);
    await TransactionRemoteDataSource().getReportTransaction(startDate: startDate,dueDate: dueDate,type: "custom").then((value) {
      reportTransaction(value);
      controllerDate.text=DateFormat("dd MMMM yyyy", 'id-iD').format(DateTime.parse(startDate!))+ " - " + DateFormat("dd MMMM yyyy", 'id-iD').format(DateTime.parse(dueDate!));
      loadingState(LoadingState.empty);
      update();
    });
  }

}
