import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_statusbarcolor_ns/flutter_statusbarcolor_ns.dart';
import 'package:get/get.dart';
import 'package:warmi/app/modules/navigation/controllers/navigation_controller.dart';
import 'package:warmi/app/modules/owner/settings/controllers/setting_controller.dart';
import 'package:warmi/app/modules/owner/settings/views/dialog_settings.dart';
import 'package:warmi/app/modules/wigets/layouts/dialog/dialog_snackbar.dart';
import 'package:warmi/app/modules/wigets/layouts/general_button.dart';
import 'package:warmi/app/modules/wigets/layouts/settings/menu_action_button.dart';
import 'package:warmi/app/modules/wigets/package/corolize_text_avatar/src/colorized_text_avatar.dart';
import 'package:warmi/app/modules/wigets/package/corolize_text_avatar/src/constants/enums.dart';
import 'package:warmi/app/routes/app_pages.dart';
import 'package:warmi/core/globals/global_color.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:warmi/core/globals/global_string.dart';
import 'package:warmi/core/utils/enum.dart';
import 'package:warmi/core/utils/thema.dart';

class SettingView extends GetWidget<SettingController> {
  @override
  Widget build(BuildContext context) {
    FlutterStatusbarcolor.setStatusBarColor(MyColor.colorPrimary);
    var navC = Get.find<NavigationController>();
    return SafeArea(
      child: Scaffold(
        backgroundColor: MyColor.colorLine.withOpacity(0.1),
        body: Stack(
          children: [
            Positioned(
              right: 0,
              left: 0,
              top: 0,
              child: Obx(() {
                return Container(
                  height: 23.h,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(10.0),
                          bottomRight: Radius.circular(10)),
                      color: MyColor.colorPrimary
                          .withOpacity(controller.scrollOpacity.value)
                      // gradient: LinearGradient(colors: [
                      //   MyColor.colorPrimary,
                      //   MyColor.colorOrangeLight,
                      //   MyColor.colorOrangeLight,
                      // ], begin: Alignment.bottomCenter),
                      ),
                );
              }),
            ),
            Obx(() {
              return Positioned(
                  top: 1.h,
                  right: controller.scrollOpacity.value < 1.0
                      ? 0
                      : MyString.DEFAULT_PADDING,
                  left: controller.scrollOpacity.value < 1.0
                      ? 0
                      : MyString.DEFAULT_PADDING,
                  child: controller.scrollOpacity.value < 1.0
                      ? Container()
                      : Container());
            }),
            Obx(() {
              return Positioned(
                  top: controller.scrollOpacity.value < 1.0
                      ? 8.h
                      : MyString.DEFAULT_PADDING,
                  right: MyString.DEFAULT_PADDING,
                  left: MyString.DEFAULT_PADDING,
                  bottom: 0,
                  child: NotificationListener<ScrollNotification>(
                    onNotification: (ScrollNotification scrollInfo) {
                      var scroll = scrollInfo.metrics.pixels;

                      if (scrollInfo.metrics.pixels == 0.0) {
                        controller.scrollOpacity(1.0);
                        FlutterStatusbarcolor.setStatusBarColor(
                            MyColor.colorPrimary);
                      }
                      if (scroll < 101.4604048295443 && scroll > 40.0) {
                        controller.scrollOpacity(0.6);
                      }
                      if (scroll < 129.06471946022475 && scroll > 40.0) {
                        controller.scrollOpacity(0.3);
                      }
                      if (scroll < 269.4393643465884 && scroll > 40.0) {
                        controller.scrollOpacity(0.0);
                        FlutterStatusbarcolor.setStatusBarColor(
                            Colors.grey.withOpacity(0.4));
                      }

                      return true;
                    },
                    child: MediaQuery.removePadding(
                      context: Get.context!,
                      removeTop: true,
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                TextAvatar(
                                  shape: Shape.Circular,
                                  size: 60,
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.w600,
                                  upperCase: true,
                                  numberLetters: 2,
                                  text: "${navC.auth.value.userFullName}",
                                ),
                                SizedBox(
                                  width: 3.w,
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "${navC.auth.value.userFullName}",
                                      style: whiteTextFont.copyWith(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16.sp,
                                          letterSpacing: 0.5),
                                    ),
                                    SizedBox(
                                      height: 2,
                                    ),
                                    Text(
                                      "${navC.auth.value.userNoHp}",
                                      style: whiteTextFont.copyWith(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16.sp,
                                          letterSpacing: 0.5),
                                    )
                                  ],
                                )
                              ],
                            ),
                            SizedBox(
                              height: 4.h,
                            ),
                            Card(
                              elevation: 2,
                              shadowColor: MyColor.colorGrey,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10.0, vertical: 20.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Flexible(
                                        child: InkWell(
                                      onTap: () => showSnackBar(
                                          snackBarType: SnackBarType.INFO,
                                          title: 'Warmi Info',
                                          message: 'Fitur Masih Dalam Proses'),
                                      child: Column(
                                        children: [
                                          Icon(
                                            IconlyBold.wallet,
                                            size: 50,
                                            color: MyColor.colorPrimary,
                                          ),
                                          Text(
                                            'riwayat'.tr,
                                            style: blackTextTitle.copyWith(
                                                fontSize: 14.sp),
                                          )
                                        ],
                                      ),
                                    )),
                                    Flexible(
                                        child: InkWell(
                                      onTap: () =>
                                          Get.toNamed(Routes.SETUP_BUSINESS),
                                      child: Column(
                                        children: [
                                          Icon(
                                            IconlyBold.activity,
                                            size: 50,
                                            color: MyColor.colorPrimary,
                                          ),
                                          Text(
                                            'atur_bisnis'.tr,
                                            style: blackTextTitle.copyWith(
                                                fontSize: 14.sp),
                                          )
                                        ],
                                      ),
                                    )),
                                    Flexible(
                                        child: InkWell(
                                      onTap: () => showSnackBar(
                                          snackBarType: SnackBarType.INFO,
                                          title: 'Warmi Info',
                                          message: 'Fitur Masih Dalam Proses'),
                                      child: Column(
                                        children: [
                                          Icon(
                                            IconlyBold.upload,
                                            size: 50,
                                            color: MyColor.colorPrimary,
                                          ),
                                          Text(
                                            "Upgrade",
                                            style: blackTextTitle.copyWith(
                                                fontSize: 14.sp),
                                          )
                                        ],
                                      ),
                                    ))
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              'bisnismu'.tr,
                              style:
                                  blackTextTitle.copyWith(letterSpacing: 0.5),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            MenuActionButton(
                              onClick: () => Get.toNamed(Routes.PROFILE_VIEW),
                              statusIcon: true,
                              icon: "assets/icons/profile.png",
                              textButton: 'data_diri'.tr,
                              sizeIcon: 35,
                            ),

                            // MenuActionButton(
                            //   onClick: ()=> showSnackBar(snackBarType: SnackBarType.INFO,
                            //       title: 'Warmi Info',
                            //       message: 'Fitur Masih Dalam Proses'),
                            //   statusIcon: true,
                            //   icon: "assets/icons/bank.png",
                            //   textButton: "Akun Bank",
                            //   sizeIcon: 35,
                            // ),
                            MenuActionButton(
                              onClick: () =>
                                  Get.toNamed(Routes.CHANGE_PASSWORD),
                              statusIcon: true,
                              icon: "assets/icons/password.png",
                              textButton: 'ubah_kata_sandi'.tr,
                              sizeIcon: 35,
                            ),
                            // MenuActionButton(
                            //   onClick: ()=> showSnackBar(snackBarType: SnackBarType.INFO,
                            //       title: 'Warmi Info',
                            //       message: 'Fitur Masih Dalam Proses'),
                            //   statusIcon: true,
                            //   icon: "assets/icons/home_address.png",
                            //   textButton: "Daftar Alamat",
                            //   sizeIcon: 35,
                            // ),
                            MenuActionButton(
                              onClick: () => Get.toNamed(Routes.EMPLOYEES),
                              statusIcon: true,
                              icon: "assets/icons/employees.png",
                              textButton: 'daftar_karyawan'.tr,
                              sizeIcon: 35,
                            ),

                            MenuActionButton(
                              onClick: () => Get.toNamed(Routes.OUTLET),
                              statusIcon: true,
                              icon: "assets/icons/store_shop.png",
                              textButton: 'daftar_toko'.tr,
                              sizeIcon: 35,
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              'kelola_toko'.tr,
                              style:
                                  blackTextTitle.copyWith(letterSpacing: 0.5),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            MenuActionButton(
                              onClick: () => Get.toNamed(Routes.OUTLET_ONLINE),
                              statusIcon: true,
                              icon: "assets/icons/mobile_order.png",
                              textButton: 'toko_online'.tr,
                              sizeIcon: 35,
                            ),
                            MenuActionButton(
                              onClick: () =>
                                  Get.toNamed(Routes.PRODUCT_CATEGORY),
                              statusIcon: true,
                              icon: "assets/icons/product.png",
                              textButton: 'kategori_produk'.tr,
                              sizeIcon: 35,
                            ),
                            MenuActionButton(
                              onClick: () => Get.toNamed(Routes.PRODUCT),
                              statusIcon: true,
                              icon: "assets/icons/product.png",
                              textButton: 'kelola_produk'.tr,
                              sizeIcon: 35,
                            ),
                            MenuActionButton(
                              onClick: () => showSnackBar(
                                  snackBarType: SnackBarType.INFO,
                                  title: 'Warmi Info',
                                  message: 'Fitur Masih Dalam Proses'),
                              statusIcon: true,
                              icon: "assets/icons/shopping_promo.png",
                              textButton: 'paket_promo'.tr,
                              sizeIcon: 35,
                            ),
                            MenuActionButton(
                              onClick: () => Get.toNamed(Routes.DISCOUNT),
                              statusIcon: true,
                              icon: "assets/icons/discount.png",
                              textButton: 'daftar_diskon'.tr,
                              sizeIcon: 35,
                            ),
                            MenuActionButton(
                              onClick: () => Get.toNamed(Routes.TYPE_ORDER),
                              statusIcon: true,
                              icon: "assets/icons/online_shoping.png",
                              textButton: 'tipe_pesanan'.tr,
                              sizeIcon: 35,
                            ),
                            MenuActionButton(
                              onClick: () => Get.toNamed(Routes.PAYMENT_METHOD),
                              statusIcon: true,
                              icon: "assets/icons/mobile_payment.png",
                              textButton: 'metode_pembayaran'.tr,
                              sizeIcon: 35,
                            ),
                            MenuActionButton(
                              onClick: () => Get.toNamed(Routes.TAX_SERVICE_VIEW),
                              statusIcon: true,
                              icon: "assets/icons/tax.png",
                              textButton: 'tax_service'.tr,
                              sizeIcon: 35,
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              'pengaturan_aplikasi'.tr,
                              style:
                                  blackTextTitle.copyWith(letterSpacing: 0.5),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            MenuActionButton(
                              onClick: () => Get.toNamed(Routes.PRINTER_PAGE),
                              statusIcon: true,
                              icon: "assets/icons/printer.png",
                              textButton: "Printer",
                              sizeIcon: 35,
                            ),
                            MenuActionButton(
                              onClick: () => Get.toNamed(Routes.INVOICE_PAGE),
                              statusIcon: true,
                              icon: "assets/icons/purchase_order.png",
                              textButton: 'struk_pembelian'.tr,
                              sizeIcon: 35,
                            ),
                            MenuActionButton(
                              onClick: () =>
                                  Get.toNamed(Routes.LANGUAGE_SETTING_PAGE),
                              statusIcon: true,
                              icon: 'assets/icons/translate.png',
                              textButton: 'pengaturan_bahasa'.tr,
                              sizeIcon: 35,
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              'tentang_kami'.tr,
                              style:
                                  blackTextTitle.copyWith(letterSpacing: 0.5),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            MenuActionButton(
                              onClick: () => dialogBottomCallMe(),
                              statusIcon: true,
                              icon: "assets/icons/online_support.png",
                              textButton: 'hubungi_kami'.tr,
                              sizeIcon: 35,
                            ),
                            MenuActionButton(
                              onClick: () => dialogBottomAboutMe(
                                  version:
                                      "${controller.packageInfo!.version}+${controller.packageInfo!.buildNumber}"),
                              statusIcon: true,
                              icon: "assets/icons/info.png",
                              textButton: 'tentang_aplikasi'.tr,
                              sizeIcon: 35,
                            ),
                            MenuActionButton(
                              onClick: () => showSnackBar(
                                  snackBarType: SnackBarType.INFO,
                                  title: 'Warmi Info',
                                  message: 'Fitur Masih Dalam Proses'),
                              statusIcon: true,
                              icon: "assets/icons/feedback.png",
                              textButton: 'masukan'.tr,
                              sizeIcon: 35,
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: GeneralButton(
                                label: 'keluar'.tr,
                                onPressed: () => controller.logOut(),
                                height: 45,
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ));
            }),
            Obx(() {
              return Positioned(
                  top: 0,
                  right: controller.scrollOpacity.value < 1.0
                      ? 0
                      : MyString.DEFAULT_PADDING,
                  left: controller.scrollOpacity.value < 1.0
                      ? 0
                      : MyString.DEFAULT_PADDING,
                  child: controller.scrollOpacity.value < 1.0
                      ? AppBar(
                          backgroundColor: MyColor.colorWhite,
                          leading: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextAvatar(
                              shape: Shape.Circular,
                              size: 40,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                              upperCase: true,
                              numberLetters: 2,
                              text: "${navC.auth.value.userFullName}",
                            ),
                          ),
                          title: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${navC.auth.value.userFullName}",
                                style: blackTextTitle.copyWith(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16.sp,
                                    letterSpacing: 0.5),
                              ),
                              SizedBox(
                                height: 2,
                              ),
                              Text(
                                "${navC.auth.value.userNoHp}",
                                style: blackTextTitle.copyWith(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16.sp,
                                    letterSpacing: 0.5),
                              )
                            ],
                          ),
                        )
                      : Container());
            }),
          ],
        ),
      ),
    );
  }
}
