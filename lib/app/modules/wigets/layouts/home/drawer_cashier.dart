import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_icons/line_icon.dart';
import 'package:warmi/app/modules/owner/settings/controllers/setting_controller.dart';
import 'package:warmi/app/modules/transaction/controllers/transaction_controller.dart';
import 'package:warmi/app/routes/app_pages.dart';
import 'package:recase/recase.dart';

class DrawerCustom extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var controller = Get.isRegistered<TransactionController>()
        ? Get.find<TransactionController>()
        : Get.put(TransactionController());
    var controllerSetting = Get.isRegistered<SettingController>()
        ? Get.find<SettingController>()
        : Get.put(SettingController());
    return Drawer(
      elevation: 2,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          UserAccountsDrawerHeader(
            decoration: BoxDecoration(color: Colors.deepOrange),
            accountName: Text("${controller.auth.value.userFullName}"),
            accountEmail:
                Text(controller.auth.value.storeName.toString().titleCase),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Theme.of(context).platform == TargetPlatform.iOS
                  ? Colors.deepOrange
                  : Colors.white,
              child: Text(
                controller.auth.value.userFullName.substring(0, 1),
                style: TextStyle(fontSize: 40.0),
              ),
            ),
          ),
          Expanded(
            flex: 8,
            child: MediaQuery.removePadding(
              context: context,
              removeTop: true,
              child: ListView(
                shrinkWrap: true,
                children: [
                  ListTile(
                    onTap: () => Get.offAllNamed(Routes.INDEX_TRANSACTION),
                    leading: Icon(
                      Icons.shopping_bag_outlined,
                      color: Colors.deepOrange,
                    ),
                    title: Text(
                      "kasir".tr,
                      style: GoogleFonts.roboto(fontWeight: FontWeight.bold),
                    ),
                    trailing: Icon(
                      Icons.keyboard_arrow_right,
                      color: Colors.black,
                    ),
                    dense: true,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Divider(
                      thickness: 1,
                    ),
                  ),
                  ListTile(
                    onTap: () => Get.toNamed(Routes.CHOOSE_STORE),
                    leading: LineIcon.store(
                      color: Colors.deepOrange,
                    ),
                    title: Text(
                      "ganti_toko".tr,
                      style: GoogleFonts.roboto(fontWeight: FontWeight.bold),
                    ),
                    trailing: Icon(
                      Icons.keyboard_arrow_right,
                      color: Colors.black,
                    ),
                    dense: true,
                  ),
                  ListTile(
                    onTap: () {
                      Get.toNamed(Routes.HISTORY_SALES);
                    },
                    leading: Icon(
                      Icons.receipt_long,
                      color: Colors.deepOrange,
                    ),
                    title: Text(
                      'riwayat_penjualan'.tr,
                      style: GoogleFonts.roboto(fontWeight: FontWeight.bold),
                    ),
                    trailing: Icon(
                      Icons.keyboard_arrow_right,
                      color: Colors.black,
                    ),
                    dense: true,
                  ),
                  ListTile(
                    onTap: () {
                      Get.toNamed(Routes.REPORT_VIEW);
                    },
                    leading: Icon(
                      Icons.receipt_long,
                      color: Colors.deepOrange,
                    ),
                    title: Text(
                      'laporan'.tr,
                      style: GoogleFonts.roboto(fontWeight: FontWeight.bold),
                    ),
                    trailing: Icon(
                      Icons.keyboard_arrow_right,
                      color: Colors.black,
                    ),
                    dense: true,
                  ),
                  ListTile(
                    onTap: () {
                      Get.toNamed(Routes.OUTLET_ONLINE);
                    },
                    leading: Icon(
                      Icons.store,
                      color: Colors.deepOrange,
                    ),
                    title: Text(
                      "toko_online".tr,
                      style: GoogleFonts.roboto(fontWeight: FontWeight.bold),
                    ),
                    trailing: Icon(
                      Icons.keyboard_arrow_right,
                      color: Colors.black,
                    ),
                    dense: true,
                  ),
                  ListTile(
                    onTap: () {
                      Get.toNamed(Routes.PRINTER_PAGE);
                    },
                    leading: Icon(
                      Icons.print,
                      color: Colors.deepOrange,
                    ),
                    title: Text(
                      "Printer Setting",
                      style: GoogleFonts.roboto(fontWeight: FontWeight.bold),
                    ),
                    trailing: Icon(
                      Icons.keyboard_arrow_right,
                      color: Colors.black,
                    ),
                    dense: true,
                  ),
                  ListTile(
                    onTap: () {
                      Get.toNamed(Routes.LANGUAGE_SETTING_PAGE);
                    },
                    leading: Icon(
                      Icons.app_settings_alt_rounded,
                      color: Colors.deepOrange,
                    ),
                    title: Text(
                      'pengaturan_bahasa'.tr,
                      style: GoogleFonts.roboto(fontWeight: FontWeight.bold),
                    ),
                    trailing: Icon(
                      Icons.keyboard_arrow_right,
                      color: Colors.black,
                    ),
                    dense: true,
                  ),
                  ListTile(
                    onTap: () => controllerSetting.logOut(),
                    leading: Icon(
                      Icons.exit_to_app,
                      color: Colors.deepOrange,
                    ),
                    title: Text(
                      'keluar'.tr,
                      style: GoogleFonts.roboto(fontWeight: FontWeight.bold),
                    ),
                    trailing: Icon(
                      Icons.keyboard_arrow_right,
                      color: Colors.black,
                    ),
                    dense: true,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Divider(
                      thickness: 1,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
