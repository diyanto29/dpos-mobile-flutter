import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:in_app_update/in_app_update.dart';
import 'package:warmi/app/data/datalocal/session/auth_session_manager.dart';
import 'package:warmi/app/modules/history_sales/views/history_sales_view.dart';

import 'package:warmi/app/modules/owner/home/views/home_view.dart';
import 'package:warmi/app/modules/owner/outlet/controllers/outlet_controller.dart';
import 'package:warmi/app/modules/owner/report/views/report_view.dart';
import 'package:warmi/app/modules/owner/report/views/reporting_view.dart';
import 'package:warmi/app/modules/owner/settings/views/setting_view.dart';

class NavigationController extends GetxController {
  final count = 0.obs;
  final indexNavigation = 0.obs;
  var auth = AuthSessionManager().obs;
  final List<Widget> pageList = [HomeView(), HistorySalesView(), ReportingView(), SettingView()];
  AppUpdateInfo? _updateInfo;

  Future<void> checkForUpdate() async {
    InAppUpdate.checkForUpdate().then((info) {

        _updateInfo = info;


      if (_updateInfo!.updateAvailability == UpdateAvailability.updateAvailable) {
        InAppUpdate.performImmediateUpdate().catchError((e) {
          print(e);
        });
      }
    }).catchError((e) {
      print(e);
    });
  }

  @override
  void onInit() {
    checkForUpdate();
    auth(AuthSessionManager());
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}

  void increment() => count.value++;

  void changeIndexNavigation(int index) {
    indexNavigation(index);
  }

  void getSession(){
    auth(AuthSessionManager());
  }
}
