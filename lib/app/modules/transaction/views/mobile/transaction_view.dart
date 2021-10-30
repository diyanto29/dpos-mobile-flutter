import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_icons/line_icon.dart';
import 'package:warmi/app/modules/transaction/controllers/cart_controller.dart';

import 'package:warmi/app/modules/transaction/controllers/transaction_controller.dart';
import 'package:warmi/app/modules/transaction/views/mobile/product_view_transaction.dart';
import 'package:warmi/app/modules/wigets/layouts/dialog/bottom_dialog_cart.dart';
import 'package:warmi/app/routes/app_pages.dart';
import 'package:warmi/core/globals/global_color.dart';

import 'package:warmi/core/utils/thema.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:warmi/main.dart';

class TransactionView extends StatefulWidget {
  const TransactionView({Key? key}) : super(key: key);

  @override
  _TransactionViewState createState() => _TransactionViewState();
}

class _TransactionViewState extends State<TransactionView> {
  var controller = Get.put(TransactionController());
  var cartController = Get.find<CartController>();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColor.colorBackground,
      appBar: AppBar(
        backgroundColor: MyColor.colorPrimary,
        title: Text('Penjualan',),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Flexible(
                flex: 5,
                child: Container(
                  margin: const EdgeInsets.only(top: 10, bottom: 10, left: 10, right: 10),
                  child: TextField(
                    controller: controller.searchC.value,
                    style: TextStyle(height: 0.9, fontSize: 14),
                    onChanged: (v){
                      controller.getSearchProduct(v);
                    },
                    decoration: InputDecoration(

                        hintText: "Cari Produk disini...",
                        hintStyle: TextStyle(fontSize: 12, color: Colors.grey[600]),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          borderSide: BorderSide(width: 1, color: MyColor.colorBlackT50),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          borderSide: BorderSide(width: 1, color: MyColor.colorPrimary),
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: Colors.red, width: 0.1)),
                        suffixIcon: Icon(
                          Icons.search,
                          color: Colors.grey[400],
                        )),
                  ),
                ),
              ),
              Flexible(
                  flex: 1,
                  child: IconButton(
                    onPressed: () => controller.scanBarcode(),
                    icon: LineIcon.barcode(
                      color: MyColor.colorBlackT50,
                    ),
                    iconSize: 30,
                  )),
              Flexible(
                  flex: 1,
                  child: IconButton(
                    onPressed: () {},
                    icon: LineIcon.fileAlt(
                      color: MyColor.colorBlackT50,
                    ),
                    iconSize: 30,
                  ))
            ],
          ),
          TabBar(
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
            labelStyle: blackTextFont.copyWith(fontSize: 12, fontWeight: FontWeight.bold),
            controller: controller.tabController,
          ),
          SizedBox(
            height: 10,
          ),
          Expanded(
            child: PageView(
              onPageChanged: (v) {
                controller.tabController.index = v;
              },
              controller: controller.controllerPage,
              children: controller.tabs.map<Widget>((Tab tab) {
                if (tab.text == "Semua") {
                  return ProductTransactionView();
                } else if (tab.text == "Lunas") {
                  return Container();
                } else {
                  return Container();
                }
              }).toList(),
            ),
          ),
          Obx(() {
            return Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  height: 8.h,
                  width: double.infinity,
                  child: ElevatedButton(
                      child: ListTile(
                        leading: Container(
                          height: 45,
                          width: 45,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100), color: MyColor.colorWhite),
                          padding: EdgeInsets.all(10),
                          child: Text(
                            "${cartController.listCart.length}",
                            style: blackTextFont.copyWith(
                                color: MyColor.colorPrimary, fontWeight: FontWeight.bold),
                          ),
                        ),
                        trailing: LineIcon.arrowCircleRight(color: MyColor.colorWhite,),
                        title: Text(
                          "Rp. ${formatCurrency.format(cartController.totalCart.value)}",
                          style: GoogleFonts.droidSans(fontSize: 6.w,
                              color: MyColor.colorWhite,
                              fontWeight: FontWeight.bold),
                        ),
                      ),

                      style: ElevatedButton.styleFrom(
                          elevation: 1,
                          primary: MyColor.colorPrimary,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25))),
                      onPressed: () => Get.toNamed(Routes.CART_TRANSACTION))),
            );
          })
        ],
      ),
    );
  }

  Future showBottomSheetOutlet() {
    return Get.bottomSheet(BottomDialogCart(), isScrollControlled: true, elevation: 3);
  }
}
