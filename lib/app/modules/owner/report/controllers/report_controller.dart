import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:warmi/app/data/datasource/transactions/transaction_source_data_remote.dart';
import 'package:warmi/app/data/models/report_transaction/report_tranasaction.dart';

class ReportController extends GetxController {
  TextEditingController controllerDate = TextEditingController();
  Rx<ReportTranasaction> reportTransaction=ReportTranasaction().obs;

  @override
  void onInit() {
    init();
    super.onInit();
  }

  void init() {
    var startDate=DateFormat("yyyy-MM-dd", 'id-iD').format(DateTime.now());
    var endDate=DateFormat("yyyy-MM-dd", 'id-iD').format(DateTime.now().add(Duration(days: 30)));
    controllerDate.text = DateFormat("dd MMMM yyyy", 'id-iD').format(DateTime.now()) + " - " + DateFormat("dd MMMM yyyy", 'id-iD').format(DateTime.now().add(Duration(days: 30)));
    getReportTransaction(startDate: startDate,dueDate: endDate);
    update();
  }

  void getReportTransaction({String? startDate,String? dueDate})async{
    await TransactionRemoteDataSource().getReportTransaction(startDate: startDate,dueDate: dueDate,type: "custom").then((value) {
      reportTransaction(value);
      controllerDate.text=DateFormat("dd MMMM yyyy", 'id-iD').format(DateTime.parse(startDate!))+ " - " + DateFormat("dd MMMM yyyy", 'id-iD').format(DateTime.parse(dueDate!));
      update();
    });
  }

}
