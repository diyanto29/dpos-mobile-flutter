import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_statusbarcolor_ns/flutter_statusbarcolor_ns.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:warmi/app/modules/history_sales/controllers/history_sales_controller.dart';
import 'package:warmi/app/modules/navigation/controllers/navigation_controller.dart';
import 'package:warmi/app/modules/owner/home/controllers/home_controller.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:warmi/app/modules/wigets/layouts/card_order.dart';
import 'package:warmi/app/modules/wigets/layouts/carousel_slider.dart';
import 'package:warmi/app/modules/wigets/layouts/dialog/bottom_dialog_outlet.dart';
import 'package:warmi/app/modules/wigets/layouts/home/card_button_action.dart';
import 'package:warmi/app/modules/wigets/layouts/home/card_header_home.dart';
import 'package:warmi/app/routes/app_pages.dart';
import 'package:warmi/core/globals/global_color.dart';
import 'package:warmi/core/globals/global_string.dart';
import 'package:warmi/core/utils/enum.dart';
import 'package:warmi/core/utils/thema.dart';
import 'package:recase/recase.dart';

import '../../../../../main.dart';

class HomeView extends GetWidget<HomeController> {
  @override
  Widget build(BuildContext context) {
    FlutterStatusbarcolor.setStatusBarColor(MyColor.colorPrimary);
    var navigationC = Get.find<NavigationController>();
    var historySalesC = Get.isRegistered<HistorySalesController>() ? Get.find<HistorySalesController>() : Get.put(HistorySalesController());

    return SafeArea(
      child: Scaffold(
        backgroundColor: MyColor.colorLine.withOpacity(0.2),
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
                  decoration: BoxDecoration(borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10.0), bottomRight: Radius.circular(10)), color: MyColor.colorPrimary.withOpacity(controller.scrollOpacity.value)
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
                  right: controller.scrollOpacity.value < 1.0 ? 0 : MyString.DEFAULT_PADDING,
                  left: controller.scrollOpacity.value < 1.0 ? 0 : MyString.DEFAULT_PADDING,
                  child: controller.scrollOpacity.value < 1.0
                      ? Container()
                      : Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                    color: MyColor.colorWhite,
                                  ),
                                  Text(
                                    'toko_anda'.tr,
                                    style: whiteTextTitle.copyWith(fontSize: 14.sp),
                                  ),
                                ],
                              ),
                              Text(
                                " ${navigationC.auth.value.storeName.titleCase}",
                                style: whiteTextTitle.copyWith(fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                        ),
                      ),
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
                                IconButton(onPressed: ()=>controller.logOut(), icon: Icon(
                                  IconlyLight.logout,
                                  color: MyColor.colorWhite,
                                ))
                              ],
                            ),
                          ))
                    ],
                  ));
            }),
            Positioned(
                top: 8.h,
                right: MyString.DEFAULT_PADDING,
                left: MyString.DEFAULT_PADDING,
                bottom: 0,
                child: NotificationListener<ScrollNotification>(
                  onNotification: (ScrollNotification scrollInfo) {
                    var scroll = scrollInfo.metrics.pixels;
                    // print(scroll);

                    if (scrollInfo.metrics.pixels == 0.0) {
                      controller.scrollOpacity(1.0);
                      FlutterStatusbarcolor.setStatusBarColor(MyColor.colorPrimary);
                    }
                    if (scroll < 101.4604048295443 && scroll > 40.0) {
                      controller.scrollOpacity(0.6);
                    }
                    if (scroll < 129.06471946022475 && scroll > 40.0) {
                      controller.scrollOpacity(0.3);
                    }
                    if (scroll < 269.4393643465884 && scroll > 40.0) {
                      controller.scrollOpacity(0.0);
                      FlutterStatusbarcolor.setStatusBarColor(Colors.grey.withOpacity(0.4));
                    }

                    return true;
                  },
                  child: MediaQuery.removePadding(
                    context: Get.context!,
                    removeTop: true,
                    child: ListView(
                      children: [
                        CarouselSliderCustom(),
                        SizedBox(
                          height: 15,
                        ),
                        Text(
                          'pendapatan_bulanan'.tr,
                          style: blackTextTitle.copyWith(fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        GetBuilder<HomeController>(builder: (logic) {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              CardHeaderHome(
                                colorBackground: MyColor.colorBlue.withOpacity(0.2),
                                imgUrl: "assets/icons/receive_dollar.png",
                                textCard: "Rp. ${formatCurrency.format(controller.reportTranasaction.value.data==null ?0 : controller.reportTranasaction.value.data!.ringkasanTransaksi!.totalAll )}",
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              CardHeaderHome(
                                colorBackground: MyColor.colorOrange.withOpacity(0.2),
                                imgUrl: "assets/icons/purchase_order.png",
                                textCard: "${controller.reportTranasaction.value.data==null ?0 : controller.reportTranasaction.value.data!.ringkasanTransaksi!.success} Orders",
                              )
                            ],
                          );
                        }),
                        SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Text(
                          'menu_fav'.tr,
                          style: blackTextTitle,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        //lanscape
                        LayoutBuilder(
                          builder: (context, constraints) {
                            if (constraints.maxWidth >= 600) {
                              return GridView.count(
                                crossAxisSpacing: 10,
                                crossAxisCount: 8,
                                physics: ClampingScrollPhysics(),
                                // childAspectRatio: 8/5,

                                shrinkWrap: true,
                                children: [
                                  CardButtonAction(
                                    onPressed: () => Get.toNamed(Routes.INDEX_TRANSACTION),
                                    icon: 'assets/icons/new_order.png',
                                    colorBackground: MyColor.colorOrange,
                                    labelIcon: 'jualan'.tr,
                                  ),
                                  CardButtonAction(
                                    onPressed: () => Get.toNamed(Routes.PRODUCT),
                                    icon: 'assets/icons/product.png',
                                    colorBackground: MyColor.colorOrange,
                                    labelIcon: 'produk'.tr,
                                  ),
                                  CardButtonAction(
                                    onPressed: () => Get.toNamed(Routes.OUTLET),
                                    icon: 'assets/icons/store_shop.png',
                                    colorBackground: MyColor.colorOrange,
                                    labelIcon: 'outlet'.tr,
                                  ),
                                  CardButtonAction(
                                    onPressed: () => Get.toNamed(Routes.EMPLOYEES),
                                    icon: "assets/icons/employees.png",
                                    colorBackground: MyColor.colorOrange,
                                    labelIcon: 'karyawan'.tr,
                                  ),
                                  CardButtonAction(
                                    onPressed: () {},
                                    icon: 'assets/icons/shopping_promo.png',
                                    colorBackground: MyColor.colorOrange,
                                    labelIcon: 'paket_promo'.tr,
                                  ),
                                  CardButtonAction(
                                    onPressed: () => Get.toNamed(Routes.DISCOUNT),
                                    icon: 'assets/icons/discount.png',
                                    colorBackground: MyColor.colorOrange,
                                    labelIcon: 'diskon'.tr,
                                  ),
                                  CardButtonAction(
                                    onPressed: () => Get.toNamed(Routes.OUTLET_ONLINE),
                                    icon: 'assets/icons/mobile_order.png',
                                    colorBackground: MyColor.colorOrange,
                                    labelIcon: 'Online Order',
                                  ),
                                  CardButtonAction(
                                    onPressed: () => Get.toNamed(Routes.PRINTER_PAGE),
                                    icon: 'assets/icons/printer.png',
                                    colorBackground: MyColor.colorOrange,
                                    labelIcon: 'Printer',
                                  ),
                                ],
                              );
                            } else {
                              return Column(
                                children: [
                                  GridView.count(
                                    crossAxisSpacing: 5,
                                    crossAxisCount: 4,
                                    physics: ClampingScrollPhysics(),
                                    // childAspectRatio: 8/5,

                                    shrinkWrap: true,
                                    children: [
                                      CardButtonAction(
                                        onPressed: () => Get.toNamed(Routes.INDEX_TRANSACTION),
                                        icon: 'assets/icons/new_order.png',
                                        colorBackground: MyColor.colorOrange,
                                        labelIcon: 'jualan'.tr,
                                      ),
                                      CardButtonAction(
                                        onPressed: () => Get.toNamed(Routes.PRODUCT),
                                        icon: 'assets/icons/product.png',
                                        colorBackground: MyColor.colorOrange,
                                        labelIcon: 'produk'.tr,
                                      ),
                                      CardButtonAction(
                                        onPressed: () => Get.toNamed(Routes.OUTLET),
                                        icon: 'assets/icons/store_shop.png',
                                        colorBackground: MyColor.colorOrange,
                                        labelIcon: 'outlet'.tr,
                                      ),
                                      CardButtonAction(
                                        onPressed: () => Get.toNamed(Routes.EMPLOYEES),
                                        icon: "assets/icons/employees.png",
                                        colorBackground: MyColor.colorOrange,
                                        labelIcon: 'karyawan'.tr,
                                      ),
                                    ],
                                  ),
                                  GridView.count(
                                    crossAxisSpacing: 2,
                                    crossAxisCount: 4,
                                    physics: ClampingScrollPhysics(),
                                    // childAspectRatio: 8/5,

                                    shrinkWrap: true,
                                    children: [
                                      CardButtonAction(
                                        onPressed: () {},
                                        icon: 'assets/icons/shopping_promo.png',
                                        colorBackground: MyColor.colorOrange,
                                        labelIcon: 'paket_promo'.tr,
                                      ),
                                      CardButtonAction(
                                        onPressed: () => Get.toNamed(Routes.DISCOUNT),
                                        icon: 'assets/icons/discount.png',
                                        colorBackground: MyColor.colorOrange,
                                        labelIcon: 'diskon'.tr,
                                      ),
                                      CardButtonAction(
                                        onPressed: () => Get.toNamed(Routes.OUTLET_ONLINE),
                                        icon: 'assets/icons/mobile_order.png',
                                        colorBackground: MyColor.colorOrange,
                                        labelIcon: 'pesanan_online'.tr,
                                      ),
                                      CardButtonAction(
                                        onPressed: () => Get.toNamed(Routes.PRINTER_PAGE),
                                        icon: 'assets/icons/printer.png',
                                        colorBackground: MyColor.colorOrange,
                                        labelIcon: 'Printer',
                                      ),
                                    ],
                                  )
                                ],
                              );
                            }
                          },
                        ),

                        SizedBox(
                          height: 15,
                        ),
                        Text(
                          'transaksi_terakhir'.tr,
                          style: blackTextTitle,
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        GetBuilder<HistorySalesController>(builder: (logic) {
                          return historySalesC.loadingStateLast == LoadingState.loading
                              ? Center(child: CircularProgressIndicator())
                              : historySalesC.listTransactionLast.length == 0
                              ? Center(
                            child: Text('data_kosong'.tr),
                          )
                              : ListView.builder(
                              shrinkWrap: true,
                              itemCount: historySalesC.listTransactionLast.length > 3 ? 3 : historySalesC.listTransactionLast.length,
                              physics: ClampingScrollPhysics(),
                              itemBuilder: (c, i) {
                                var data = historySalesC.listTransactionLast[i];
                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 8),
                                  child: CardOrder(
                                    orderClick: () => Get.toNamed(Routes.DETAIL_HISTORY_TRANSACTION, arguments: data),
                                    orderStore: Image.asset(
                                      "assets/food.png",
                                      height: 100,
                                    ),
                                    orderNumber: "${data.transactionid!.split('-')[0]}",
                                    outlet: "${data.outlet!
                                        .storename
                                        .toString()
                                        .titleCase}",
                                    totalOrders: "Rp. ${formatCurrency.format(int.tryParse(data.transactiontotal!))}",
                                    qtyOrders: "${data.detailCount}",
                                    orderColorStatus: data.transactionstatus!.contains("pending") ? MyColor.colorRedFlatDark : MyColor.colorPrimary,
                                    noted: data.transactionstatus!.contains("pending") ? data.transactionnote : null,
                                    orderDate: "${DateFormat('dd MMM yyyy', 'id-ID').format(DateTime.parse(data.createdAt!))}",
                                    orderStatus: "${data.transactionstatus
                                        .toString()
                                        .titleCase}",
                                    cashier: data.createdBy == null ? "asdad" : "${data.createdBy!
                                        .userfullname
                                        .toString()
                                        .titleCase}",
                                    showCashier: true,
                                  ),
                                );
                              });
                        }),
                      ],
                    ),
                  ),
                )),
            Obx(() {
              return Positioned(
                  top: 0.6.h,
                  right: controller.scrollOpacity.value < 1.0 ? 0 : MyString.DEFAULT_PADDING,
                  left: controller.scrollOpacity.value < 1.0 ? 0 : MyString.DEFAULT_PADDING,
                  child: controller.scrollOpacity.value < 1.0
                      ? Container(
                    height: 60,
                    padding: EdgeInsets.only(left: 20, top: 10, right: 10),
                    decoration: BoxDecoration(color: MyColor.colorWhite, boxShadow: [BoxShadow(color: MyColor.colorBlackT50, offset: Offset(0, 3), blurRadius: 3)]),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                      'toko_anda'.tr,
                                      style: blackTextFont.copyWith(fontSize: 14.sp),
                                    ),
                                  ],
                                ),
                                Text(
                                  " ${navigationC.auth.value.storeName}",
                                  style: blackTextFont.copyWith(fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                          ),
                        ),
                        Flexible(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(
                                    IconlyLight.notification,
                                    color: MyColor.colorBlack,
                                  ),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  IconButton(icon: Icon(
                                    IconlyLight.logout,
                                    color: MyColor.colorBlack,
                                  ),onPressed: ()=> ()=>controller.logOut(),),

                                ],
                              ),
                            ))
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

  Future showBottomSheetOutlet() {
    return Get.bottomSheet(BottomDialogOutlet(), isScrollControlled: true, elevation: 3);
  }
}
