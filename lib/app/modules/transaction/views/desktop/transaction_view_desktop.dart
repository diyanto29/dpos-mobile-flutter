import 'package:badges/badges.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_statusbarcolor_ns/flutter_statusbarcolor_ns.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:line_icons/line_icon.dart';
import 'package:warmi/app/data/models/product/cart.dart';
import 'package:warmi/app/modules/history_sales/views/all_history.dart';
import 'package:warmi/app/modules/navigation/controllers/navigation_controller.dart';
import 'package:warmi/app/modules/owner/product/controllers/product_controller.dart';
import 'package:warmi/app/modules/transaction/controllers/cart_controller.dart';

import 'package:warmi/app/modules/transaction/controllers/transaction_controller.dart';
import 'package:warmi/app/modules/transaction/views/mobile/product_view_transaction.dart';
import 'package:warmi/app/modules/transaction/views/mobile/transaction_pending.dart';
import 'package:warmi/app/modules/wigets/layouts/dialog/bottom_dialog_cart.dart';
import 'package:warmi/app/modules/wigets/layouts/dialog/dialog_noted.dart';
import 'package:warmi/app/modules/wigets/layouts/dialog/dialog_snackbar.dart';
import 'package:warmi/app/modules/wigets/layouts/general_button.dart';
import 'package:warmi/app/modules/wigets/layouts/home/drawer_cashier.dart';
import 'package:warmi/app/modules/wigets/package/corolize_text_avatar/colorize_text_avatar.dart';
import 'package:warmi/app/modules/wigets/package/corolize_text_avatar/src/colorized_text_avatar.dart';
import 'package:warmi/app/routes/app_pages.dart';
import 'package:warmi/core/globals/global_color.dart';
import 'package:warmi/core/globals/global_string.dart';
import 'package:warmi/core/utils/enum.dart';

import 'package:warmi/core/utils/thema.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:warmi/main.dart';
import 'package:recase/recase.dart';

class TransactionViewDesktop extends StatefulWidget {
  const TransactionViewDesktop({Key? key}) : super(key: key);

  @override
  _TransactionViewDesktopState createState() => _TransactionViewDesktopState();
}

class _TransactionViewDesktopState extends State<TransactionViewDesktop> {
  final transactionController = Get.find<TransactionController>();
  var controller = Get.put(ProductController());

  var navC = Get.find<NavigationController>();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void dispose() {
    controller.listProduct.forEach((element) {
      element.productInCart = false;
    });
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    transactionController.checkProductInCart();
    // FlutterStatusbarcolor.setStatusBarColor(MyColor.colorPrimary);

    return Scaffold(
      key: _scaffoldKey,
      resizeToAvoidBottomInset: false,
      backgroundColor: MyColor.colorBackground,
      drawer: DrawerCustom(),
      body: Obx(() {
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            LayoutBuilder(builder: (context, constrain) {
              if (constrain.maxWidth >= 600) {
                return SizedBox(
                  height: 20,
                );
              } else {
                return SizedBox(
                  height: 30,
                );
              }
            }),
            Container(
              height: 60,
              width: double.infinity,
              decoration:
                  BoxDecoration(color: MyColor.colorPrimary, boxShadow: [
                BoxShadow(offset: Offset(0, 1), color: MyColor.colorBlackT50)
              ]),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Flexible(
                    flex: 10,
                    child: Row(
                      children: [
                        if (transactionController.auth.value.roleName !=
                            "Pemilik Toko")
                          IconButton(
                              onPressed: () =>
                                  _scaffoldKey.currentState!.openDrawer(),
                              icon: Icon(
                                Icons.menu,
                                color: Colors.white,
                              )),
                        Flexible(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextAvatar(
                              shape: Shape.Circular,
                              size: 20,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                              upperCase: true,
                              numberLetters: 2,
                              text: "${navC.auth.value.storeName}",
                            ),
                          ),
                        ),
                        Flexible(
                            child: Text(
                          "${navC.auth.value.storeName.titleCase}",
                          style: whiteTextFont,
                        )),
                        SizedBox(
                          width: 20,
                        ),
                        Flexible(
                          flex: 3,
                          child: Container(
                            height: 60,
                            width: 40.w,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: MyColor.colorSilver),
                            margin: const EdgeInsets.only(
                                top: 10, bottom: 10, left: 10, right: 10),
                            child: TextField(
                              controller: transactionController.searchC.value,
                              style: TextStyle(height: 0.9, fontSize: 14),
                              onChanged: (v) {
                                if(transactionController.idCategory.value=="all")
                                {
                                  print("Asda");
                                  transactionController.getSearchProduct(v);
                                }

                                else
                                  {
                                    transactionController.getSearchProduct(v,idCategory: transactionController.idCategory.value);
                                  }
                              },
                              decoration: InputDecoration(
                                  contentPadding:
                                      const EdgeInsets.only(top: 10, left: 10),
                                  hintText: 'cari_produk_disini'.tr + '...',
                                  hintStyle: TextStyle(
                                      fontSize: 12, color: Colors.grey[600]),
                                  fillColor: Colors.white,
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
                                      borderSide: BorderSide(
                                          color: MyColor.colorGrey,
                                          width: 0.1)),
                                  suffixIcon: transactionController
                                          .searchC.value.text.isNotEmpty
                                      ? IconButton(
                                          onPressed: () {
                                            setState(() {
                                              transactionController
                                                  .searchC.value.text = "";
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
                              onPressed: () =>
                                  transactionController.scanBarcode(),
                              icon: LineIcon.barcode(
                                color: MyColor.colorSilver,
                              ),
                              iconSize: 30,
                            )),
                        Flexible(
                            flex: 1,
                            child: IconButton(
                              onPressed: () {},
                              icon: LineIcon.archiveFile(
                                color: MyColor.colorSilver,
                              ),
                              iconSize: 30,
                            ))
                      ],
                    ),
                  ),
                  GetBuilder<TransactionController>(builder: (logic) {
                    return Flexible(
                        flex: 1,
                        child: logic.listTransaction.length == 0
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
                                position: BadgePosition.topEnd(top: 2, end: 3),
                                animationType: BadgeAnimationType.slide,
                                badgeColor: Colors.white,
                                toAnimate: true,
                                badgeContent:
                                    Text("${logic.listTransaction.length}"),
                                child: IconButton(
                                  onPressed: () => Get.to(TransactionPending()),
                                  icon: LineIcon.addToShoppingCart(
                                    color: MyColor.colorSilver,
                                  ),
                                  iconSize: 30,
                                ),
                              ));
                  })
                ],
              ),
            ),
            Expanded(
                child: Padding(
              padding: const EdgeInsets.only(right: 10, top: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                      child: ListView.builder(
                          itemCount:
                              transactionController.listCategoryProduct.length,
                          controller: ScrollController(),
                          itemBuilder: (c, i) {
                            var data =
                                transactionController.listCategoryProduct[i];
                            return ListTile(
                              onTap: ()=>transactionController.onTapCategory(i),
                              tileColor: Colors.white70,
                              shape: RoundedRectangleBorder(
                                  borderRadius: data.isChecked
                                      ? BorderRadius.only(
                                          topRight: Radius.circular(5),
                                          bottomRight: Radius.circular(10))
                                      : BorderRadius.all(Radius.zero)),
                              selected: data.isChecked,
                              selectedTileColor: MyColor.colorPrimary,
                              title:
                                  Text(data.categoryName.toString().titleCase,style: data.isChecked ? whiteTextTitle:blackTextTitle,),
                            );
                          })),
                  Expanded(
                      flex: 6,
                      child: Obx(() {
                        if(transactionController.idCategory.value=="all" && transactionController.searchC.value.text.isEmpty){
                          return GridView.builder(
                              gridDelegate:
                              const SliverGridDelegateWithMaxCrossAxisExtent(
                                  maxCrossAxisExtent: 150,
                                  childAspectRatio: 2 / 2.6,
                                  crossAxisSpacing: 10,
                                  mainAxisSpacing: 10),
                              itemCount: controller.listProduct.length,
                              shrinkWrap: true,
                              controller: ScrollController(),
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              itemBuilder: (c, i) {
                                return Card(
                                  color:
                                  controller.listProduct[i].productInCart
                                      ? MyColor.colorOrangeLight
                                      : null,
                                  elevation: 0.4,
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                      BorderRadius.circular(10)),
                                  child: InkWell(
                                    onTap: () {
                                      if (controller
                                          .listProduct[i].productInCart) {
                                        transactionController
                                            .deleteCartFormListProduct(
                                            controller.listProduct[i]);
                                      } else {
                                        if (controller.listProduct[i]
                                            .productStokStatus ==
                                            "true" &&
                                            controller.listProduct[i]
                                                .productStok ==
                                                "0")
                                          showSnackBar(
                                              snackBarType:
                                              SnackBarType.WARNING,
                                              message: "Stok Produk Kosong",
                                              title: 'produk'.tr);
                                        else
                                          transactionController.addCart(
                                              controller.listProduct[i]);
                                      }
                                    },
                                    child: Stack(
                                      children: [
                                        Positioned(
                                          top: 0,
                                          left: 0,
                                          right: 0,
                                          child: Column(
                                            mainAxisAlignment:
                                            MainAxisAlignment.center,
                                            crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                            children: [
                                              ClipRRect(
                                                borderRadius:
                                                BorderRadius.only(
                                                    topLeft:
                                                    Radius.circular(
                                                        10),
                                                    topRight:
                                                    Radius.circular(
                                                        10)),
                                                child: CachedNetworkImage(
                                                  imageUrl:
                                                  "${controller.listProduct[i].productPhoto}",
                                                  fit: BoxFit.cover,
                                                  height: 100,
                                                  width: double.infinity,
                                                  placeholder: (c, s) => Center(
                                                      child:
                                                      CircularProgressIndicator()),
                                                  errorWidget:
                                                      (context, s, o) =>
                                                      TextAvatar(
                                                        shape: Shape.Rectangle,
                                                        size: 50,
                                                        fontSize: 16.sp,
                                                        fontWeight:
                                                        FontWeight.w600,
                                                        upperCase: true,
                                                        numberLetters: 3,
                                                        text:
                                                        "${controller.listProduct[i].productName}",
                                                      ),
                                                ),
                                              ),
                                              SizedBox(
                                                height: 4,
                                              ),
                                              Text(
                                                "${controller.listProduct[i].productName}",
                                                style: TextStyle(
                                                    fontWeight:
                                                    FontWeight.w400,
                                                    fontSize: 12),
                                                textAlign: TextAlign.center,
                                                overflow:
                                                TextOverflow.visible,
                                              ),
                                              SizedBox(
                                                height: 4,
                                              ),
                                              Text(
                                                "Rp. ${formatCurrency.format(controller.listProduct[i].productPrice)}",
                                                style: TextStyle(
                                                    fontWeight:
                                                    FontWeight.bold),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Positioned(
                                            left: 0,
                                            right: 50,
                                            top: 0,
                                            child: Container(
                                              width: 100,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                  BorderRadius.only(
                                                      topLeft: Radius
                                                          .circular(10),
                                                      bottomRight:
                                                      Radius.circular(
                                                          10)),
                                                  color: Colors.green),
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 10,
                                                  vertical: 3),
                                              child: Text(
                                                controller.listProduct[i]
                                                    .productStokStatus ==
                                                    "true"
                                                    ? "${controller.listProduct[i].productStok} ${controller.listProduct[i].productUnitId!.length > 3 ? controller.listProduct[i].productUnitId!.substring(0, 3).titleCase : controller.listProduct[i].productUnitId.toString().titleCase}"
                                                    : "Tersedia",
                                                style: TextStyle(
                                                  fontSize: 10.sp,
                                                  color: Colors.white,
                                                ),
                                                overflow:
                                                TextOverflow.ellipsis,
                                              ),
                                            )),
                                        ...transactionController.listCart
                                            .map((element) {
                                          if (controller.listProduct[i]
                                              .productInCart &&
                                              element.dataProduct ==
                                                  controller.listProduct[i])
                                            return Positioned(
                                              child: Align(
                                                alignment: Alignment.center,
                                                child: Container(
                                                  height: 38,
                                                  width: 120,
                                                  margin: EdgeInsets.only(
                                                      top: 10,
                                                      left: 10,
                                                      right: 10),
                                                  padding:
                                                  EdgeInsets.symmetric(
                                                      horizontal: 3),
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                    BorderRadius.circular(
                                                        10),
                                                    color:
                                                    MyColor.colorSilver,
                                                  ),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                    children: [
                                                      InkWell(
                                                        onTap: () =>
                                                            transactionController
                                                                .removeQty(
                                                                element),
                                                        child: Container(
                                                          child:
                                                          LineIcon.minus(
                                                            color: Colors.red,
                                                          ),
                                                        ),
                                                      ),
                                                      Container(
                                                        child: Center(
                                                          child: FittedBox(
                                                            child: Text(
                                                              // "${data.listCart[i].qty}",
                                                              "${element.qty}",
                                                              style: GoogleFonts.roboto(
                                                                  fontSize:
                                                                  16,
                                                                  color: Colors
                                                                      .black),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      InkWell(
                                                        onTap: () =>
                                                            transactionController
                                                                .addQty(
                                                                element),
                                                        child: Container(
                                                          child:
                                                          LineIcon.plus(
                                                            color:
                                                            Colors.green,
                                                          ),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            );
                                          else
                                            return Container();
                                        }).toList(),
                                      ],
                                    ),
                                  ),
                                );
                              });
                        }
                        if(transactionController.idCategory.value=="all" && transactionController.searchC.value.text.isNotEmpty){
                          return GridView.builder(
                              gridDelegate:
                              const SliverGridDelegateWithMaxCrossAxisExtent(
                                  maxCrossAxisExtent: 150,
                                  childAspectRatio: 2 / 2.6,
                                  crossAxisSpacing: 10,
                                  mainAxisSpacing: 10),
                              itemCount: transactionController
                                  .listSearchProduct.length,
                              shrinkWrap: true,
                              controller: ScrollController(),
                              padding:
                              EdgeInsets.symmetric(horizontal: 10),
                              itemBuilder: (c, i) {
                                return Card(
                                  color: transactionController
                                      .listSearchProduct[i]
                                      .productInCart
                                      ? MyColor.colorOrangeLight
                                      : null,
                                  elevation: 0.4,
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                      BorderRadius.circular(10)),
                                  child: InkWell(
                                    onTap: () {
                                      if (transactionController
                                          .listSearchProduct[i]
                                          .productInCart) {
                                        transactionController
                                            .deleteCartFormListProduct(
                                            transactionController
                                                .listSearchProduct[i]);
                                      } else {
                                        if (transactionController
                                            .listSearchProduct[i]
                                            .productStokStatus ==
                                            "true" &&
                                            transactionController
                                                .listSearchProduct[i]
                                                .productStok ==
                                                "0")
                                          showSnackBar(
                                              snackBarType:
                                              SnackBarType.WARNING,
                                              message:
                                              "Stok Produk Kosong",
                                              title: 'produk'.tr);
                                        else
                                          transactionController.addCart(
                                              transactionController
                                                  .listSearchProduct[i]);
                                      }
                                    },
                                    child: Stack(
                                      children: [
                                        Positioned(
                                          top: 0,
                                          left: 0,
                                          right: 0,
                                          child: Column(
                                            mainAxisAlignment:
                                            MainAxisAlignment.center,
                                            crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                            children: [
                                              ClipRRect(
                                                borderRadius:
                                                BorderRadius.only(
                                                    topLeft: Radius
                                                        .circular(10),
                                                    topRight: Radius
                                                        .circular(
                                                        10)),
                                                child: CachedNetworkImage(
                                                  imageUrl:
                                                  "${transactionController.listSearchProduct[i].productPhoto}",
                                                  fit: BoxFit.cover,
                                                  height: 100,
                                                  width: double.infinity,
                                                  placeholder: (c, s) =>
                                                      Center(
                                                          child:
                                                          CircularProgressIndicator()),
                                                  errorWidget:
                                                      (context, s, o) =>
                                                      TextAvatar(
                                                        shape:
                                                        Shape.Rectangle,
                                                        size: 50,
                                                        fontSize: 16.sp,
                                                        fontWeight:
                                                        FontWeight.w600,
                                                        upperCase: true,
                                                        numberLetters: 3,
                                                        text:
                                                        "${transactionController.listSearchProduct[i].productName}",
                                                      ),
                                                ),
                                              ),
                                              SizedBox(
                                                height: 4,
                                              ),
                                              Text(
                                                "${transactionController.listSearchProduct[i].productName}",
                                                style: TextStyle(
                                                    fontWeight:
                                                    FontWeight.w400,
                                                    fontSize: 12),
                                                textAlign:
                                                TextAlign.center,
                                                overflow:
                                                TextOverflow.visible,
                                              ),
                                              SizedBox(
                                                height: 4,
                                              ),
                                              Text(
                                                "Rp. ${formatCurrency.format(transactionController.listSearchProduct[i].productPrice)}",
                                                style: TextStyle(
                                                    fontWeight:
                                                    FontWeight.bold),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Positioned(
                                            left: 0,
                                            right: 50,
                                            top: 0,
                                            child: Container(
                                              width: 100,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                  BorderRadius.only(
                                                      topLeft: Radius
                                                          .circular(
                                                          10),
                                                      bottomRight: Radius
                                                          .circular(
                                                          10)),
                                                  color: Colors.green),
                                              padding:
                                              EdgeInsets.symmetric(
                                                  horizontal: 10,
                                                  vertical: 3),
                                              child: Text(
                                                transactionController
                                                    .listSearchProduct[
                                                i]
                                                    .productStokStatus ==
                                                    "true"
                                                    ? "${transactionController.listSearchProduct[i].productStok} ${transactionController.listSearchProduct[i].productUnitId!.length > 3 ? transactionController.listSearchProduct[i].productUnitId!.substring(0, 3).titleCase : transactionController.listSearchProduct[i].productUnitId.toString().titleCase}"
                                                    : "Tersedia",
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.white,
                                                ),
                                                overflow:
                                                TextOverflow.ellipsis,
                                              ),
                                            )),
                                        ...transactionController.listCart
                                            .map((element) {
                                          if (transactionController
                                              .listSearchProduct[i]
                                              .productInCart &&
                                              element.dataProduct ==
                                                  transactionController
                                                      .listSearchProduct[i])
                                            return Positioned(
                                              child: Align(
                                                alignment:
                                                Alignment.center,
                                                child: Container(
                                                  height: 38,
                                                  width: 120,
                                                  margin: EdgeInsets.only(
                                                      top: 10,
                                                      left: 10,
                                                      right: 10),
                                                  padding: EdgeInsets
                                                      .symmetric(
                                                      horizontal: 3),
                                                  decoration:
                                                  BoxDecoration(
                                                    borderRadius:
                                                    BorderRadius
                                                        .circular(10),
                                                    color: MyColor
                                                        .colorSilver,
                                                  ),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                    children: [
                                                      InkWell(
                                                        onTap: () =>
                                                            transactionController
                                                                .removeQty(
                                                                element),
                                                        child: Container(
                                                          child: LineIcon
                                                              .minus(
                                                            color: Colors
                                                                .red,
                                                          ),
                                                        ),
                                                      ),
                                                      Container(
                                                        child: Center(
                                                          child:
                                                          FittedBox(
                                                            child: Text(
                                                              // "${data.listCart[i].qty}",
                                                              "${element.qty}",
                                                              style: GoogleFonts.roboto(
                                                                  fontSize:
                                                                  16,
                                                                  color: Colors
                                                                      .black),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      InkWell(
                                                        onTap: () =>
                                                            transactionController
                                                                .addQty(
                                                                element),
                                                        child: Container(
                                                          child: LineIcon
                                                              .plus(
                                                            color: Colors
                                                                .green,
                                                          ),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            );
                                          else
                                            return Container();
                                        }).toList()
                                      ],
                                    ),
                                  ),
                                );
                              });
                        }
                        if(transactionController.idCategory.value!="all" && transactionController.searchC.value.text.isNotEmpty){
                          return GridView.builder(
                              gridDelegate:
                              const SliverGridDelegateWithMaxCrossAxisExtent(
                                  maxCrossAxisExtent: 150,
                                  childAspectRatio: 2 / 2.6,
                                  crossAxisSpacing: 10,
                                  mainAxisSpacing: 10),
                              itemCount: transactionController
                                  .listSearchProduct.length,
                              shrinkWrap: true,
                              controller: ScrollController(),
                              padding:
                              EdgeInsets.symmetric(horizontal: 10),
                              itemBuilder: (c, i) {
                                return Card(
                                  color: transactionController
                                      .listSearchProduct[i]
                                      .productInCart
                                      ? MyColor.colorOrangeLight
                                      : null,
                                  elevation: 0.4,
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                      BorderRadius.circular(10)),
                                  child: InkWell(
                                    onTap: () {
                                      if (transactionController
                                          .listSearchProduct[i]
                                          .productInCart) {
                                        transactionController
                                            .deleteCartFormListProduct(
                                            transactionController
                                                .listSearchProduct[i]);
                                      } else {
                                        if (transactionController
                                            .listSearchProduct[i]
                                            .productStokStatus ==
                                            "true" &&
                                            transactionController
                                                .listSearchProduct[i]
                                                .productStok ==
                                                "0")
                                          showSnackBar(
                                              snackBarType:
                                              SnackBarType.WARNING,
                                              message:
                                              "Stok Produk Kosong",
                                              title: 'produk'.tr);
                                        else
                                          transactionController.addCart(
                                              transactionController
                                                  .listSearchProduct[i]);
                                      }
                                    },
                                    child: Stack(
                                      children: [
                                        Positioned(
                                          top: 0,
                                          left: 0,
                                          right: 0,
                                          child: Column(
                                            mainAxisAlignment:
                                            MainAxisAlignment.center,
                                            crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                            children: [
                                              ClipRRect(
                                                borderRadius:
                                                BorderRadius.only(
                                                    topLeft: Radius
                                                        .circular(10),
                                                    topRight: Radius
                                                        .circular(
                                                        10)),
                                                child: CachedNetworkImage(
                                                  imageUrl:
                                                  "${transactionController.listSearchProduct[i].productPhoto}",
                                                  fit: BoxFit.cover,
                                                  height: 100,
                                                  width: double.infinity,
                                                  placeholder: (c, s) =>
                                                      Center(
                                                          child:
                                                          CircularProgressIndicator()),
                                                  errorWidget:
                                                      (context, s, o) =>
                                                      TextAvatar(
                                                        shape:
                                                        Shape.Rectangle,
                                                        size: 50,
                                                        fontSize: 16.sp,
                                                        fontWeight:
                                                        FontWeight.w600,
                                                        upperCase: true,
                                                        numberLetters: 3,
                                                        text:
                                                        "${transactionController.listSearchProduct[i].productName}",
                                                      ),
                                                ),
                                              ),
                                              SizedBox(
                                                height: 4,
                                              ),
                                              Text(
                                                "${transactionController.listSearchProduct[i].productName}",
                                                style: TextStyle(
                                                    fontWeight:
                                                    FontWeight.w400,
                                                    fontSize: 12),
                                                textAlign:
                                                TextAlign.center,
                                                overflow:
                                                TextOverflow.visible,
                                              ),
                                              SizedBox(
                                                height: 4,
                                              ),
                                              Text(
                                                "Rp. ${formatCurrency.format(transactionController.listSearchProduct[i].productPrice)}",
                                                style: TextStyle(
                                                    fontWeight:
                                                    FontWeight.bold),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Positioned(
                                            left: 0,
                                            right: 50,
                                            top: 0,
                                            child: Container(
                                              width: 100,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                  BorderRadius.only(
                                                      topLeft: Radius
                                                          .circular(
                                                          10),
                                                      bottomRight: Radius
                                                          .circular(
                                                          10)),
                                                  color: Colors.green),
                                              padding:
                                              EdgeInsets.symmetric(
                                                  horizontal: 10,
                                                  vertical: 3),
                                              child: Text(
                                                transactionController
                                                    .listSearchProduct[
                                                i]
                                                    .productStokStatus ==
                                                    "true"
                                                    ? "${transactionController.listSearchProduct[i].productStok} ${transactionController.listSearchProduct[i].productUnitId!.length > 3 ? transactionController.listSearchProduct[i].productUnitId!.substring(0, 3).titleCase : transactionController.listSearchProduct[i].productUnitId.toString().titleCase}"
                                                    : "Tersedia",
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.white,
                                                ),
                                                overflow:
                                                TextOverflow.ellipsis,
                                              ),
                                            )),
                                        ...transactionController.listCart
                                            .map((element) {
                                          if (transactionController
                                              .listSearchProduct[i]
                                              .productInCart &&
                                              element.dataProduct ==
                                                  transactionController
                                                      .listSearchProduct[i])
                                            return Positioned(
                                              child: Align(
                                                alignment:
                                                Alignment.center,
                                                child: Container(
                                                  height: 38,
                                                  width: 120,
                                                  margin: EdgeInsets.only(
                                                      top: 10,
                                                      left: 10,
                                                      right: 10),
                                                  padding: EdgeInsets
                                                      .symmetric(
                                                      horizontal: 3),
                                                  decoration:
                                                  BoxDecoration(
                                                    borderRadius:
                                                    BorderRadius
                                                        .circular(10),
                                                    color: MyColor
                                                        .colorSilver,
                                                  ),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                    children: [
                                                      InkWell(
                                                        onTap: () =>
                                                            transactionController
                                                                .removeQty(
                                                                element),
                                                        child: Container(
                                                          child: LineIcon
                                                              .minus(
                                                            color: Colors
                                                                .red,
                                                          ),
                                                        ),
                                                      ),
                                                      Container(
                                                        child: Center(
                                                          child:
                                                          FittedBox(
                                                            child: Text(
                                                              // "${data.listCart[i].qty}",
                                                              "${element.qty}",
                                                              style: GoogleFonts.roboto(
                                                                  fontSize:
                                                                  16,
                                                                  color: Colors
                                                                      .black),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      InkWell(
                                                        onTap: () =>
                                                            transactionController
                                                                .addQty(
                                                                element),
                                                        child: Container(
                                                          child: LineIcon
                                                              .plus(
                                                            color: Colors
                                                                .green,
                                                          ),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            );
                                          else
                                            return Container();
                                        }).toList()
                                      ],
                                    ),
                                  ),
                                );
                              });
                        }
                        if(transactionController.searchC.value.text.isEmpty && transactionController.listSearchProduct.isEmpty){
                          return GridView.builder(
                              gridDelegate:
                              const SliverGridDelegateWithMaxCrossAxisExtent(
                                  maxCrossAxisExtent: 150,
                                  childAspectRatio: 2 / 2.6,
                                  crossAxisSpacing: 10,
                                  mainAxisSpacing: 10),
                              itemCount: controller.listProduct.length,
                              shrinkWrap: true,
                              controller: ScrollController(),
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              itemBuilder: (c, i) {
                                return Card(
                                  color:
                                  controller.listProduct[i].productInCart
                                      ? MyColor.colorOrangeLight
                                      : null,
                                  elevation: 0.4,
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                      BorderRadius.circular(10)),
                                  child: InkWell(
                                    onTap: () {
                                      if (controller
                                          .listProduct[i].productInCart) {
                                        transactionController
                                            .deleteCartFormListProduct(
                                            controller.listProduct[i]);
                                      } else {
                                        if (controller.listProduct[i]
                                            .productStokStatus ==
                                            "true" &&
                                            controller.listProduct[i]
                                                .productStok ==
                                                "0")
                                          showSnackBar(
                                              snackBarType:
                                              SnackBarType.WARNING,
                                              message: "Stok Produk Kosong",
                                              title: 'produk'.tr);
                                        else
                                          transactionController.addCart(
                                              controller.listProduct[i]);
                                      }
                                    },
                                    child: Stack(
                                      children: [
                                        Positioned(
                                          top: 0,
                                          left: 0,
                                          right: 0,
                                          child: Column(
                                            mainAxisAlignment:
                                            MainAxisAlignment.center,
                                            crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                            children: [
                                              ClipRRect(
                                                borderRadius:
                                                BorderRadius.only(
                                                    topLeft:
                                                    Radius.circular(
                                                        10),
                                                    topRight:
                                                    Radius.circular(
                                                        10)),
                                                child: CachedNetworkImage(
                                                  imageUrl:
                                                  "${controller.listProduct[i].productPhoto}",
                                                  fit: BoxFit.cover,
                                                  height: 100,
                                                  width: double.infinity,
                                                  placeholder: (c, s) => Center(
                                                      child:
                                                      CircularProgressIndicator()),
                                                  errorWidget:
                                                      (context, s, o) =>
                                                      TextAvatar(
                                                        shape: Shape.Rectangle,
                                                        size: 50,
                                                        fontSize: 16.sp,
                                                        fontWeight:
                                                        FontWeight.w600,
                                                        upperCase: true,
                                                        numberLetters: 3,
                                                        text:
                                                        "${controller.listProduct[i].productName}",
                                                      ),
                                                ),
                                              ),
                                              SizedBox(
                                                height: 4,
                                              ),
                                              Text(
                                                "${controller.listProduct[i].productName}",
                                                style: TextStyle(
                                                    fontWeight:
                                                    FontWeight.w400,
                                                    fontSize: 12),
                                                textAlign: TextAlign.center,
                                                overflow:
                                                TextOverflow.visible,
                                              ),
                                              SizedBox(
                                                height: 4,
                                              ),
                                              Text(
                                                "Rp. ${formatCurrency.format(controller.listProduct[i].productPrice)}",
                                                style: TextStyle(
                                                    fontWeight:
                                                    FontWeight.bold),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Positioned(
                                            left: 0,
                                            right: 50,
                                            top: 0,
                                            child: Container(
                                              width: 100,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                  BorderRadius.only(
                                                      topLeft: Radius
                                                          .circular(10),
                                                      bottomRight:
                                                      Radius.circular(
                                                          10)),
                                                  color: Colors.green),
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 10,
                                                  vertical: 3),
                                              child: Text(
                                                controller.listProduct[i]
                                                    .productStokStatus ==
                                                    "true"
                                                    ? "${controller.listProduct[i].productStok} ${controller.listProduct[i].productUnitId!.length > 3 ? controller.listProduct[i].productUnitId!.substring(0, 3).titleCase : controller.listProduct[i].productUnitId.toString().titleCase}"
                                                    : "Tersedia",
                                                style: TextStyle(
                                                  fontSize: 10.sp,
                                                  color: Colors.white,
                                                ),
                                                overflow:
                                                TextOverflow.ellipsis,
                                              ),
                                            )),
                                        ...transactionController.listCart
                                            .map((element) {
                                          if (controller.listProduct[i]
                                              .productInCart &&
                                              element.dataProduct ==
                                                  controller.listProduct[i])
                                            return Positioned(
                                              child: Align(
                                                alignment: Alignment.center,
                                                child: Container(
                                                  height: 38,
                                                  width: 120,
                                                  margin: EdgeInsets.only(
                                                      top: 10,
                                                      left: 10,
                                                      right: 10),
                                                  padding:
                                                  EdgeInsets.symmetric(
                                                      horizontal: 3),
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                    BorderRadius.circular(
                                                        10),
                                                    color:
                                                    MyColor.colorSilver,
                                                  ),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                    children: [
                                                      InkWell(
                                                        onTap: () =>
                                                            transactionController
                                                                .removeQty(
                                                                element),
                                                        child: Container(
                                                          child:
                                                          LineIcon.minus(
                                                            color: Colors.red,
                                                          ),
                                                        ),
                                                      ),
                                                      Container(
                                                        child: Center(
                                                          child: FittedBox(
                                                            child: Text(
                                                              // "${data.listCart[i].qty}",
                                                              "${element.qty}",
                                                              style: GoogleFonts.roboto(
                                                                  fontSize:
                                                                  16,
                                                                  color: Colors
                                                                      .black),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      InkWell(
                                                        onTap: () =>
                                                            transactionController
                                                                .addQty(
                                                                element),
                                                        child: Container(
                                                          child:
                                                          LineIcon.plus(
                                                            color:
                                                            Colors.green,
                                                          ),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            );
                                          else
                                            return Container();
                                        }).toList(),
                                      ],
                                    ),
                                  ),
                                );
                              });
                        }
                        if(transactionController.listSearchProduct.isNotEmpty){
                          return GridView.builder(
                              gridDelegate:
                              const SliverGridDelegateWithMaxCrossAxisExtent(
                                  maxCrossAxisExtent: 150,
                                  childAspectRatio: 2 / 2.6,
                                  crossAxisSpacing: 10,
                                  mainAxisSpacing: 10),
                              itemCount: transactionController
                                  .listSearchProduct.length,
                              shrinkWrap: true,
                              controller: ScrollController(),
                              padding:
                              EdgeInsets.symmetric(horizontal: 10),
                              itemBuilder: (c, i) {
                                return Card(
                                  color: transactionController
                                      .listSearchProduct[i]
                                      .productInCart
                                      ? MyColor.colorOrangeLight
                                      : null,
                                  elevation: 0.4,
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                      BorderRadius.circular(10)),
                                  child: InkWell(
                                    onTap: () {
                                      if (transactionController
                                          .listSearchProduct[i]
                                          .productInCart) {
                                        transactionController
                                            .deleteCartFormListProduct(
                                            transactionController
                                                .listSearchProduct[i]);
                                      } else {
                                        if (transactionController
                                            .listSearchProduct[i]
                                            .productStokStatus ==
                                            "true" &&
                                            transactionController
                                                .listSearchProduct[i]
                                                .productStok ==
                                                "0")
                                          showSnackBar(
                                              snackBarType:
                                              SnackBarType.WARNING,
                                              message:
                                              "Stok Produk Kosong",
                                              title: 'produk'.tr);
                                        else
                                          transactionController.addCart(
                                              transactionController
                                                  .listSearchProduct[i]);
                                      }
                                    },
                                    child: Stack(
                                      children: [
                                        Positioned(
                                          top: 0,
                                          left: 0,
                                          right: 0,
                                          child: Column(
                                            mainAxisAlignment:
                                            MainAxisAlignment.center,
                                            crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                            children: [
                                              ClipRRect(
                                                borderRadius:
                                                BorderRadius.only(
                                                    topLeft: Radius
                                                        .circular(10),
                                                    topRight: Radius
                                                        .circular(
                                                        10)),
                                                child: CachedNetworkImage(
                                                  imageUrl:
                                                  "${transactionController.listSearchProduct[i].productPhoto}",
                                                  fit: BoxFit.cover,
                                                  height: 100,
                                                  width: double.infinity,
                                                  placeholder: (c, s) =>
                                                      Center(
                                                          child:
                                                          CircularProgressIndicator()),
                                                  errorWidget:
                                                      (context, s, o) =>
                                                      TextAvatar(
                                                        shape:
                                                        Shape.Rectangle,
                                                        size: 50,
                                                        fontSize: 16.sp,
                                                        fontWeight:
                                                        FontWeight.w600,
                                                        upperCase: true,
                                                        numberLetters: 3,
                                                        text:
                                                        "${transactionController.listSearchProduct[i].productName}",
                                                      ),
                                                ),
                                              ),
                                              SizedBox(
                                                height: 4,
                                              ),
                                              Text(
                                                "${transactionController.listSearchProduct[i].productName}",
                                                style: TextStyle(
                                                    fontWeight:
                                                    FontWeight.w400,
                                                    fontSize: 12),
                                                textAlign:
                                                TextAlign.center,
                                                overflow:
                                                TextOverflow.visible,
                                              ),
                                              SizedBox(
                                                height: 4,
                                              ),
                                              Text(
                                                "Rp. ${formatCurrency.format(transactionController.listSearchProduct[i].productPrice)}",
                                                style: TextStyle(
                                                    fontWeight:
                                                    FontWeight.bold),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Positioned(
                                            left: 0,
                                            right: 50,
                                            top: 0,
                                            child: Container(
                                              width: 100,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                  BorderRadius.only(
                                                      topLeft: Radius
                                                          .circular(
                                                          10),
                                                      bottomRight: Radius
                                                          .circular(
                                                          10)),
                                                  color: Colors.green),
                                              padding:
                                              EdgeInsets.symmetric(
                                                  horizontal: 10,
                                                  vertical: 3),
                                              child: Text(
                                                transactionController
                                                    .listSearchProduct[
                                                i]
                                                    .productStokStatus ==
                                                    "true"
                                                    ? "${transactionController.listSearchProduct[i].productStok} ${transactionController.listSearchProduct[i].productUnitId!.length > 3 ? transactionController.listSearchProduct[i].productUnitId!.substring(0, 3).titleCase : transactionController.listSearchProduct[i].productUnitId.toString().titleCase}"
                                                    : "Tersedia",
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.white,
                                                ),
                                                overflow:
                                                TextOverflow.ellipsis,
                                              ),
                                            )),
                                        ...transactionController.listCart
                                            .map((element) {
                                          if (transactionController
                                              .listSearchProduct[i]
                                              .productInCart &&
                                              element.dataProduct ==
                                                  transactionController
                                                      .listSearchProduct[i])
                                            return Positioned(
                                              child: Align(
                                                alignment:
                                                Alignment.center,
                                                child: Container(
                                                  height: 38,
                                                  width: 120,
                                                  margin: EdgeInsets.only(
                                                      top: 10,
                                                      left: 10,
                                                      right: 10),
                                                  padding: EdgeInsets
                                                      .symmetric(
                                                      horizontal: 3),
                                                  decoration:
                                                  BoxDecoration(
                                                    borderRadius:
                                                    BorderRadius
                                                        .circular(10),
                                                    color: MyColor
                                                        .colorSilver,
                                                  ),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                    children: [
                                                      InkWell(
                                                        onTap: () =>
                                                            transactionController
                                                                .removeQty(
                                                                element),
                                                        child: Container(
                                                          child: LineIcon
                                                              .minus(
                                                            color: Colors
                                                                .red,
                                                          ),
                                                        ),
                                                      ),
                                                      Container(
                                                        child: Center(
                                                          child:
                                                          FittedBox(
                                                            child: Text(
                                                              // "${data.listCart[i].qty}",
                                                              "${element.qty}",
                                                              style: GoogleFonts.roboto(
                                                                  fontSize:
                                                                  16,
                                                                  color: Colors
                                                                      .black),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      InkWell(
                                                        onTap: () =>
                                                            transactionController
                                                                .addQty(
                                                                element),
                                                        child: Container(
                                                          child: LineIcon
                                                              .plus(
                                                            color: Colors
                                                                .green,
                                                          ),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            );
                                          else
                                            return Container();
                                        }).toList()
                                      ],
                                    ),
                                  ),
                                );
                              });
                        }else{
                         return Center(
                            child: Text("Produk Kosong"),
                          );
                        }

                      })),
                  Expanded(
                      flex: 3,
                      child: Column(
                        children: [
                          Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                                color: MyColor.colorPrimary,
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    topRight: Radius.circular(10))),
                            padding: const EdgeInsets.all(8),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Transaksi Baru",
                                  style: whiteTextTitle,
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  DateFormat("EEEE, dd MMMM yyyy", 'id-ID')
                                      .format(DateTime.now()),
                                  style: whiteTextTitle.copyWith(
                                      color: MyColor.colorBlack5,
                                      fontSize: 12.sp),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                InkWell(
                                  onTap: () async {
                                    Get.toNamed(Routes.CUSTOMER_PAGE);
                                  },
                                  child: GetBuilder<TransactionController>(
                                      builder: (logic) {
                                    return Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Container(
                                          margin: EdgeInsets.only(top: 0),
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 10, vertical: 3),
                                          decoration: BoxDecoration(
                                              color: Colors.green,
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          child: Text(
                                            transactionController.customer.value
                                                        .customerpartnername ==
                                                    null
                                                ? 'pelanggan'.tr
                                                : transactionController.customer
                                                    .value.customerpartnername!,
                                            style: GoogleFonts.roboto(
                                                fontSize: 12.0,
                                                color: Colors.white),
                                          ),
                                        ),
                                        Visibility(
                                          visible: transactionController
                                                      .customer
                                                      .value
                                                      .customerpartnername ==
                                                  null
                                              ? false
                                              : true,
                                          child: InkWell(
                                            onTap: () {
                                              transactionController
                                                  .removeCustomer();
                                              print("a");
                                            },
                                            child: Container(
                                              margin: EdgeInsets.only(
                                                  top: 0, left: 10),
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 10, vertical: 3),
                                              decoration: BoxDecoration(
                                                  color: Colors.red,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
                                              child: Text(
                                                'hapus'.tr,
                                                style: GoogleFonts.roboto(
                                                    fontSize: 12.0,
                                                    color: Colors.white),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    );
                                  }),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                              child: Column(
                            children: [
                              Expanded(
                                child: MediaQuery.removePadding(
                                  context: context,
                                  removeTop: true,
                                  child: ListView.builder(
                                      itemCount:
                                          transactionController.listCart.length,
                                      shrinkWrap: true,
                                      physics: ClampingScrollPhysics(),
                                      controller: ScrollController(),
                                      itemBuilder: (c, i) => InkWell(
                                            onTap: () {
                                              addDiscount(
                                                  cart: transactionController
                                                      .listCart[i],
                                                  allProduct: false);
                                              FocusScopeNode currentFocus =
                                                  FocusScope.of(context);

                                              if (!currentFocus
                                                  .hasPrimaryFocus) {
                                                currentFocus.unfocus();
                                              }
                                            },
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  color: Colors.white),
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    bottom: 20.0,
                                                    top: 8,
                                                    left: 8,
                                                    right: 8),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Flexible(
                                                        flex: 3,
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Container(
                                                              height: 30,
                                                              width: 30,
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(8),
                                                              decoration: BoxDecoration(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              5),
                                                                  color: MyColor
                                                                      .colorOrange),
                                                              alignment:
                                                                  Alignment
                                                                      .center,
                                                              child: Text(
                                                                "${transactionController.listCart[i].qty}",
                                                                style: whiteTextTitle.copyWith(
                                                                    fontSize:
                                                                        10.sp,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              width: 10,
                                                            ),
                                                            Flexible(
                                                                child: Column(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .start,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Text(
                                                                  "${transactionController.listCart[i].dataProduct!.productName}",
                                                                  style: blackTextFont
                                                                      .copyWith(
                                                                          fontSize:
                                                                              12.sp),
                                                                ),
                                                                SizedBox(
                                                                  height: 4,
                                                                ),
                                                                if (transactionController
                                                                        .listCart[
                                                                            i]
                                                                        .discount ==
                                                                    null)
                                                                  Text(
                                                                    "Klik untuk tambah diskon",
                                                                    style: blackTextFont.copyWith(
                                                                        fontSize: GetPlatform.isWindows
                                                                            ? 10
                                                                                .sp
                                                                            : 12
                                                                                .sp,
                                                                        fontStyle:
                                                                            FontStyle.italic),
                                                                  )
                                                              ],
                                                            ))
                                                          ],
                                                        )),
                                                    Flexible(
                                                        flex: 2,
                                                        child: Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .end,
                                                          children: [
                                                            Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .end,
                                                              children: [
                                                                Text(
                                                                  "@ ${formatCurrency.format(transactionController.listCart[i].dataProduct!.productPrice)}",
                                                                  style: blackTextFont
                                                                      .copyWith(
                                                                          fontSize:
                                                                              12.sp),
                                                                ),
                                                                SizedBox(
                                                                  width: 10,
                                                                ),
                                                                InkWell(
                                                                  onTap: () {
                                                                    transactionController.deleteCart(
                                                                        cartModel:
                                                                            transactionController.listCart[i]);
                                                                    FocusScopeNode
                                                                        currentFocus =
                                                                        FocusScope.of(
                                                                            context);

                                                                    if (!currentFocus
                                                                        .hasPrimaryFocus) {
                                                                      currentFocus
                                                                          .unfocus();
                                                                    }
                                                                  },
                                                                  child:
                                                                      Container(
                                                                    child: Icon(
                                                                      Icons
                                                                          .delete,
                                                                      color: Colors
                                                                          .red,
                                                                      size: GetPlatform
                                                                              .isWindows
                                                                          ? 15.sp
                                                                          : 20.sp,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                            SizedBox(
                                                              height: 5,
                                                            ),
                                                            if (transactionController
                                                                    .listCart[i]
                                                                    .discount !=
                                                                null)
                                                              Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .end,
                                                                children: [
                                                                  Text(
                                                                    "${transactionController.listCart[i].discount!.discountType!.toLowerCase() == 'price' ? ' - Rp.' + formatCurrency.format(int.parse(transactionController.listCart[i].discount!.discountMaxPriceOff!)) : transactionController.listCart[i].discount!.discountPercent + '%'}",
                                                                    style: GoogleFonts.roboto(
                                                                        color: Colors
                                                                            .red,
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .bold,
                                                                        fontSize:
                                                                            12.sp),
                                                                  ),
                                                                  InkWell(
                                                                      onTap:
                                                                          () {
                                                                        setState(
                                                                            () {
                                                                          transactionController.deleteDiscount(
                                                                              dataDiscount: transactionController.listCart[i].discount!,
                                                                              cartModel: transactionController.listCart[i]);
                                                                          transactionController
                                                                              .listCart[i]
                                                                              .discount = null;
                                                                        });
                                                                      },
                                                                      child:
                                                                          Icon(
                                                                        Icons
                                                                            .clear,
                                                                        color: Colors
                                                                            .red,
                                                                        size:
                                                                            20,
                                                                      )),
                                                                ],
                                                              ),
                                                            if (transactionController
                                                                    .listCart[i]
                                                                    .discount !=
                                                                null)
                                                              if (transactionController
                                                                      .listCart[
                                                                          i]
                                                                      .discount!
                                                                      .discountType !=
                                                                  'price')
                                                                Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                              .fromLTRB(
                                                                          8,
                                                                          2,
                                                                          8,
                                                                          10),
                                                                  child: Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .end,
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .end,
                                                                    children: [
                                                                      Text(
                                                                        "Max Diskon : ",
                                                                        style: blackTextFont.copyWith(
                                                                            fontSize:
                                                                                11.sp),
                                                                      ),
                                                                      Text(
                                                                        "- Rp.${formatCurrency.format(int.parse(transactionController.listCart[i].discount!.discountMaxPriceOff!))}",
                                                                        style: GoogleFonts.roboto(
                                                                            color:
                                                                                Colors.red,
                                                                            fontWeight: FontWeight.bold,
                                                                            fontSize: 11.sp),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                )
                                                          ],
                                                        ))
                                                  ],
                                                ),
                                              ),
                                            ),
                                          )),
                                ),
                              ),
                              Card(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                elevation: 0.4,
                                child: Container(
                                  padding: const EdgeInsets.all(8),
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            "Sub Total",
                                            style: GoogleFonts.roboto(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 12.sp),
                                          ),
                                          Text(
                                            "Rp.${formatCurrency.format(transactionController.totalCart.value)}",
                                            style: GoogleFonts.roboto(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 12.sp),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      InkWell(
                                        onTap: () =>
                                            addDiscount(allProduct: true),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Text(
                                              'diskon'.tr,
                                              style: GoogleFonts.roboto(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 12.sp),
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                transactionController
                                                            .dataDiscount !=
                                                        null
                                                    ? Text(
                                                        "${transactionController.dataDiscount?.discountType!.toLowerCase() == 'price' ? ' - Rp.' + formatCurrency.format(int.parse(transactionController.dataDiscount!.discountMaxPriceOff!)) : transactionController.dataDiscount?.discountPercent + '%'}",
                                                        style:
                                                            GoogleFonts.roboto(
                                                                color:
                                                                    Colors.red,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize:
                                                                    12.sp),
                                                      )
                                                    : Icon(
                                                        Icons
                                                            .arrow_forward_ios_rounded,
                                                        size: 15,
                                                      ),
                                                SizedBox(
                                                  width: 4,
                                                ),
                                                Visibility(
                                                  visible: transactionController
                                                              .dataDiscount ==
                                                          null
                                                      ? false
                                                      : true,
                                                  child: InkWell(
                                                      onTap: () {
                                                        setState(() {
                                                          transactionController
                                                              .deleteDiscount(
                                                                  dataDiscount:
                                                                      transactionController
                                                                          .dataDiscount!,
                                                                  allProduct:
                                                                      true);
                                                        });
                                                      },
                                                      child: Icon(
                                                        Icons.clear,
                                                        color: Colors.red,
                                                        size: 20,
                                                      )),
                                                )
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      transactionController.dataDiscount != null
                                          ? transactionController.dataDiscount!
                                                      .discountType !=
                                                  'price'
                                              ? Padding(
                                                  padding:
                                                      const EdgeInsets.fromLTRB(
                                                          0, 2, 0, 0),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      Text("Max Diskon"),
                                                      Text(
                                                        "- Rp.${formatCurrency.format(int.parse(transactionController.dataDiscount!.discountMaxPriceOff!))}",
                                                        style:
                                                            GoogleFonts.roboto(
                                                                color:
                                                                    Colors.red,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                      ),
                                                    ],
                                                  ),
                                                )
                                              : Container()
                                          : Container(),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Flexible(
                                            flex: 2,
                                            child: Container(
                                              height: GetPlatform.isWindows
                                                  ? 80
                                                  : 40,
                                              width: GetPlatform.isWindows
                                                  ? 80
                                                  : 40,
                                              decoration: BoxDecoration(
                                                  color: MyColor.colorRedFlat,
                                                  borderRadius:
                                                      BorderRadius.circular(5)),
                                              child: IconButton(
                                                color: Colors.white,
                                                onPressed: () =>
                                                    showDialogNoted(
                                                        title:
                                                            'Masukan Catatan',
                                                        message: 'coba',
                                                        clickYes: () {
                                                          transactionController
                                                              .storeTransactionPending();
                                                        }),
                                                icon: Icon(Icons.save),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Flexible(
                                            flex: 7,
                                            child: GeneralButton(
                                              label:
                                                  " Rp ${formatCurrency.format(transactionController.totalShopping.value)}",
                                              borderRadius: 5,
                                              fontSize: 16.sp,
                                              onPressed: () {
                                                Map<dynamic, dynamic> data = {
                                                  "from": "cart",
                                                  "data": null
                                                };
                                                if (transactionController
                                                    .listCart.isEmpty) {
                                                  showSnackBar(
                                                      snackBarType:
                                                          SnackBarType.INFO,
                                                      message:
                                                          "Keranjang Masih Kosong",
                                                      title: 'transaksi'.tr);
                                                } else {
                                                  Get.toNamed(
                                                      Routes.CHECKOUT_TABLET,
                                                      arguments: data);
                                                }
                                              },
                                              height: GetPlatform.isWindows
                                                  ? 80
                                                  : 45,
                                            ),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              )
                            ],
                          )),
                        ],
                      ))
                ],
              ),
            ))
          ],
        );
      }),
    );
  }

  void addDiscount({CartModel? cart, bool allProduct = false}) {
    transactionController.discountController;
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) => Container(
        height: Get.height * 0.9,
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        child: Obx(() {
          return Column(
            children: [
              Center(
                  child: Text("Daftar Diskon Tersedia",
                      style: GoogleFonts.roboto(fontWeight: FontWeight.bold))),
              transactionController.discountController.listDiscount.length == 0
                  ? Padding(
                      padding: const EdgeInsets.only(top: 250),
                      child: Column(
                        children: [
                          Center(
                            child: Text("Diskon Kosong"),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          GeneralButton(
                            label: 'tambah_diskon'.tr,
                            onPressed: () => Get.toNamed(Routes.ADD_DISCOUNT),
                            height: 30,
                            width: 200,
                          )
                        ],
                      ),
                    )
                  : Expanded(
                      child: ListView.builder(
                          itemCount: transactionController
                              .discountController.listDiscount.length,
                          shrinkWrap: true,
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          physics: ClampingScrollPhysics(),
                          itemBuilder: (c, i) {
                            return Card(
                              elevation: 2,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ListTile(
                                  onTap: () {
                                    transactionController.addDiscount(
                                        dataDiscount: transactionController
                                            .discountController.listDiscount[i],
                                        allProduct: allProduct,
                                        cartModel: cart);
                                    Get.back();
                                  },
                                  dense: true,
                                  title: Text(
                                      "${transactionController.discountController.listDiscount[i].discountName}"),
                                  subtitle: transactionController
                                              .discountController
                                              .listDiscount[i]
                                              .discountType ==
                                          "percent"
                                      ? transactionController
                                                      .discountController
                                                      .listDiscount[i]
                                                      .discountMaxPriceOff ==
                                                  "0" ||
                                              transactionController
                                                      .discountController
                                                      .listDiscount[i]
                                                      .discountMaxPriceOff ==
                                                  null
                                          ? Container()
                                          : Text(
                                              "Max. Discount Rp ${formatCurrency.format(int.parse(transactionController.discountController.listDiscount[i].discountMaxPriceOff!))}",
                                              style: GoogleFonts.roboto(
                                                  fontWeight: FontWeight.bold),
                                            )
                                      : Container(),
                                  trailing: Text(
                                    transactionController.discountController
                                                .listDiscount[i].discountType ==
                                            "percent"
                                        ? "${transactionController.discountController.listDiscount[i].discountPercent}%"
                                        : "Rp ${formatCurrency.format(int.parse(transactionController.discountController.listDiscount[i].discountMaxPriceOff!))}",
                                    style: GoogleFonts.roboto(
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            );
                          }),
                    )
            ],
          );
        }),
      ),
    );
  }

  Future showBottomSheetOutlet() {
    return Get.bottomSheet(BottomDialogCart(),
        isScrollControlled: true, elevation: 3);
  }
}
