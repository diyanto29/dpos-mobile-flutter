import 'dart:ui';

import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_icons/line_icon.dart';
import 'package:warmi/app/modules/history_sales/views/all_history.dart';
import 'package:warmi/app/modules/owner/settings/controllers/product_category_controller.dart';
import 'package:warmi/app/modules/transaction/controllers/cart_controller.dart';

import 'package:warmi/app/modules/transaction/controllers/transaction_controller.dart';
import 'package:warmi/app/modules/transaction/views/mobile/product_view_transaction.dart';
import 'package:warmi/app/modules/transaction/views/mobile/transaction_pending.dart';
import 'package:warmi/app/modules/wigets/layouts/dialog/bottom_dialog_cart.dart';
import 'package:warmi/app/modules/wigets/layouts/home/drawer_cashier.dart';
import 'package:warmi/app/routes/app_pages.dart';
import 'package:warmi/core/globals/global_color.dart';
import 'package:warmi/core/utils/enum.dart';

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
  var controllerCategory = Get.put(ProductCategoryController());
  var cartController = Get.isRegistered<CartController>()
      ? Get.find<CartController>()
      : Get.put(CartController());


  @override
  void initState() {
    if(this.mounted){
      print("ini state");
      setState(() {
        controller.idCategory.value="";
        controller.idCategory.refresh();
        print(controller.idCategory.value);

      });
    }
    super.initState();
  }
  @override
  void dispose() {

    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return GetBuilder<TransactionController>(builder: (logic) {
      return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: MyColor.colorBackground,
        appBar: AppBar(
          backgroundColor: MyColor.colorPrimary,
          title: Text(
            'penjualan'.tr,
          ),
          automaticallyImplyLeading:
          controller.auth.value.roleName == "Pemilik Toko" ? false : true,
          actions: [
            controller.listTransaction.length == 0
                ? IconButton(
              onPressed: () {},
              icon: LineIcon.addToShoppingCart(
                color: MyColor.colorSilver,
              ),
              iconSize: 30,
            )
                : Badge(
              elevation: 1,
              shape: BadgeShape.circle,
              animationDuration: Duration(seconds: 3),
              position: BadgePosition.topEnd(top: 2, end: 7),
              animationType: BadgeAnimationType.slide,
              badgeColor: Colors.white,
              badgeContent: Text("${controller.listTransaction.length}"),
              child: IconButton(
                onPressed: () => Get.to(TransactionPending()),
                icon: LineIcon.addToShoppingCart(
                  color: MyColor.colorSilver,
                ),
                iconSize: 30,
              ),
            )
          ],
        ),
        drawer: controller.auth.value.roleName == "Pemilik Toko"
            ? null
            : DrawerCustom(),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Obx(() {
              return Row(
                children: [
                  Flexible(
                    flex: 5,
                    child: Container(
                      margin: const EdgeInsets.only(
                          top: 10, bottom: 10, left: 10, right: 10),
                      child: TextField(
                        controller: controller.searchC.value,
                        style: TextStyle(height: 0.9, fontSize: 14),
                        onSubmitted: (v) {},
                        onChanged: (v) {
                          print("asda");
                          controller.getSearchProduct(
                              v);
                        },
                        decoration: InputDecoration(
                            hintText: 'cari_produk_disini'.tr + '...',
                            hintStyle: TextStyle(
                                fontSize: 12, color: Colors.grey[600]),
                            enabledBorder: OutlineInputBorder(
                              borderRadius:
                              BorderRadius.all(Radius.circular(10)),
                              borderSide: BorderSide(
                                  width: 1, color: MyColor.colorBlackT50),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius:
                              BorderRadius.all(Radius.circular(10)),
                              borderSide: BorderSide(
                                  width: 1, color: MyColor.colorPrimary),
                            ),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide:
                                BorderSide(color: Colors.red, width: 0.1)),
                            suffixIcon: controller.searchC.value.text.isNotEmpty
                                ? IconButton(
                                onPressed: () {
                                  setState(() {
                                    controller.searchC.value.text = "";
                                  });
                                },
                                icon: Icon(
                                  Icons.cancel,
                                  color: Colors.grey[400],
                                ))
                                : Icon(
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
              );
            }),
            GetBuilder<TransactionController>(builder: (logic) {
              return controller.loadingStateCategory.value == LoadingState.loading
                  ? Container()
                  : TabBar(

                unselectedLabelColor: MyColor.colorBlackT50,
                indicatorColor: MyColor.colorPrimary,
                labelColor: MyColor.colorPrimary,


                indicatorSize: TabBarIndicatorSize.label,
                automaticIndicatorColorAdjustment: true,
                isScrollable: true,
                padding: EdgeInsets.symmetric(horizontal: 20),
                physics: NeverScrollableScrollPhysics(),
                // indicator: new BubbleTabIndicator(
                //   indicatorHeight: 25.0,
                //   indicatorColor: MyColor.colorPrimary,
                //   tabBarIndicatorSize: TabBarIndicatorSize.tab,
                // ),
                onTap: (v) {
                  controller.controllerPage.jumpToPage(v);
                  controller.index(v);
                  if(v==0)
                    controller.idCategory(null);
                },

                tabs: controller.tabs,
                labelStyle: blackTextFont.copyWith(
                    fontSize: 12, fontWeight: FontWeight.bold),
                controller: controller.tabController,
              );
            }),
            SizedBox(
              height: 10,
            ),

            // Container(
            //   width: 100,
            //   height: 40,
            //   decoration: BoxDecoration(
            //     borderRadius: BorderRadius.circular(6),
            //     image: DecorationImage(
            //       image: ExactAssetImage("assets/foods.jpg"),
            //       fit: BoxFit.cover,
            //     ),
            //   ),
            //   child: ClipRRect(
            //     // make sure we apply clip it properly
            //     child: BackdropFilter(
            //       filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
            //       child: Container(
            //         alignment: Alignment.center,
            //         decoration: BoxDecoration(
            //           borderRadius: BorderRadius.circular(6),
            //           color: Colors.black.withOpacity(0.2),
            //         ),
            //         child: Text(
            //           "Beverage",
            //           maxLines: 2,
            //           overflow: TextOverflow.ellipsis,
            //           textAlign: TextAlign.center,
            //           style: TextStyle(
            //               fontWeight: FontWeight.bold, color: Colors.white),
            //         ),
            //       ),
            //     ),
            //   ),
            // ),
            GetBuilder<TransactionController>(builder: (logic) {
              return Expanded(
                child: PageView(
                  onPageChanged: (v) {
                    print(v);
                    if(v==0){
                      controller.idCategory.value="";

                      print("Ini Kateogri "+controller.idCategory.value);
                    }else{
                      var category = controller.listCategoryProduct.where((
                          p0) =>
                          p0.categoryName!.toLowerCase().contains(
                              controller.tabs[v].text!.toLowerCase())).toList();
                      var idCategory = category.length > 0 ? category[0]
                          .categoryId : null;
                      print("disni");
                      print(idCategory);
                      controller.idCategory(idCategory);
                    }
                    controller.tabController!.index = v;
                  },
                  controller: controller.controllerPage,
                  allowImplicitScrolling: true,

                  children: controller.tabs.map<Widget>((Tab tab) {
                    if (tab.text == 'semua'.tr) {
                      controller.idCategory.value="";
                      print("Ini Kateogri "+controller.idCategory.value);
                      return ProductTransactionView();
                    } else if (tab.text == 'paket'.tr) {
                      return Container();
                    } else {
                      var category = controller.listCategoryProduct.where((
                          p0) =>
                          p0.categoryName!.toLowerCase().contains(
                              tab.text.toString().toLowerCase())).toList();
                      var idCategory = category.length > 0 ? category[0]
                          .categoryId : null;
                      print("disni");
                      if(tab.text!='semua'.tr){
                        controller.idCategory(idCategory);
                      }
                      return ProductTransactionView(idCategory: controller.idCategory.value,);
                    }
                  }).toList(),
                ),
              );
            }),
            Obx(() {
              return Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    height: 9.h,
                    width: double.infinity,
                    child: ElevatedButton(
                        child: ListTile(
                          leading: Container(
                            height: 6.h,
                            width: 10.w,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: MyColor.colorWhite),
                            padding: EdgeInsets.all(10),
                            child: Text(
                              "${cartController.listCart.length}",
                              style: blackTextFont.copyWith(
                                  color: MyColor.colorPrimary,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          trailing: LineIcon.arrowCircleRight(
                            color: MyColor.colorWhite,
                          ),
                          title: Text(
                            "Rp. ${formatCurrency.format(
                                cartController.totalCart.value)}",
                            style: GoogleFonts.droidSans(
                                fontSize: 6.w,
                                color: MyColor.colorWhite,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                            elevation: 1,
                            primary: MyColor.colorPrimary,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10))),
                        onPressed: () => Get.toNamed(Routes.CART_TRANSACTION))),
              );
            })
          ],
        ),
      );
    });
  }

  Future showBottomSheetOutlet() {
    return Get.bottomSheet(BottomDialogCart(),
        isScrollControlled: true, elevation: 3);
  }
}
