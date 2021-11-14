import 'package:flutter/material.dart';
import 'package:flutter_statusbarcolor_ns/flutter_statusbarcolor_ns.dart';

import 'package:get/get.dart';
import 'package:warmi/app/modules/history_sales/views/all_history.dart';
import 'package:warmi/app/modules/wigets/layouts/home/drawer_cashier.dart';
import 'package:warmi/core/globals/global_color.dart';
import 'package:warmi/core/globals/global_string.dart';
import 'package:warmi/core/utils/thema.dart';

import '../controllers/history_sales_controller.dart';

class HistorySalesView extends GetWidget<HistorySalesController> {
  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: Scaffold(
        backgroundColor: MyColor.colorGrey,
        appBar: AppBar(
          backgroundColor: MyColor.colorPrimary,
          title: Text('riwayat_penjualan'.tr,),
          automaticallyImplyLeading: controller.auth.value.roleName=="Pemilik Toko" ? false : true,

        ),
        drawer: controller.auth.value.roleName=="Pemilik Toko" ? null : DrawerCustom(),
       body: Column(
         children: [
           // Container(
           //   height: 45,
           //
           //   margin: const EdgeInsets.only(top: 10, bottom: 7,left: 10,right: 5),
           //
           //   child: TextField(
           //     style: TextStyle(height: 0.9, fontSize: 14),
           //     decoration: InputDecoration(
           //         hintText: "Cari Pesanan disini...",
           //         hintStyle: TextStyle(
           //             fontSize: 12, color: Colors.grey[400]),
           //         enabledBorder: OutlineInputBorder(
           //           borderRadius:
           //           BorderRadius.all(Radius.circular(10)),
           //           borderSide:
           //           BorderSide(width: 1, color:MyColor.colorBlackT50),
           //         ),
           //         focusedBorder: OutlineInputBorder(
           //           borderRadius:
           //           BorderRadius.all(Radius.circular(10)),
           //           borderSide:
           //           BorderSide(width: 1, color: MyColor.colorPrimary),
           //         ),
           //         border: OutlineInputBorder(
           //             borderRadius: BorderRadius.circular(10),
           //             borderSide:
           //             BorderSide(color: Colors.red, width: 0.1)),
           //         suffixIcon: Icon(
           //           Icons.search,
           //           color: MyColor.colorBlackT50,
           //         )),
           //   ),
           // ),
           Container(
             child: TabBar(
               isScrollable: true,
               unselectedLabelColor: MyColor.colorBlackT50,
               indicatorColor: MyColor.colorPrimary,
               labelColor: MyColor.colorPrimary,
               indicatorSize: TabBarIndicatorSize.label,
               // indicator: new BubbleTabIndicator(
               //   indicatorHeight: 25.0,
               //   indicatorColor: MyColor.colorPrimary,
               //   tabBarIndicatorSize: TabBarIndicatorSize.tab,
               // ),
               onTap: (v) {
                 controller.controllerPage.jumpToPage(v);
                 controller.index(v);

               },
               tabs: controller.tabs,
               labelStyle: blackTextFont.copyWith(
                   fontSize: 12, fontWeight: FontWeight.bold),
               controller: controller.tabController,
             ),
           ),
           Expanded(
             child: Padding(
               padding: const EdgeInsets.symmetric(horizontal: MyString.DEFAULT_PADDING,vertical: 10),
               child: PageView(
                 physics: NeverScrollableScrollPhysics(),

                 onPageChanged: (v) {
                   controller.tabController.index = v;
                 },
                 controller: controller.controllerPage,
                 children: controller.tabs.map<Widget>((Tab tab) {
                   if (tab.text == 'semua'.tr) {
                     return AllHistory(statusTab: 'semua'.tr,);
                   } else if (tab.text == 'lunas'.tr) {
                     return AllHistory(statusTab: tab.text!,);
                   } else if (tab.text == 'menunggu_pembayaran'.tr) {
                     return AllHistory(statusTab: tab.text!,);
                   }
    // else if (tab.text == "Utang") {
                   //   return AllHistory(statusTab: tab.text!,);
                   // }
                   else if (tab.text == 'pembatalan'.tr) {
                     return AllHistory(statusTab: tab.text!,);
                   }  else {
                     return Container();
                   }
                 }).toList(),
               ),
             ),
           ),
         ],
       ),
      ),
    );
  }
}
