import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:line_icons/line_icon.dart';
import 'package:warmi/app/modules/owner/product/controllers/product_controller.dart';
import 'package:warmi/app/modules/transaction/controllers/cart_controller.dart';
import 'package:warmi/app/modules/transaction/controllers/transaction_controller.dart';
import 'package:warmi/app/modules/wigets/layouts/dialog/dialog_snackbar.dart';
import 'package:warmi/app/modules/wigets/layouts/general_button.dart';
import 'package:warmi/app/modules/wigets/package/corolize_text_avatar/colorize_text_avatar.dart';
import 'package:warmi/app/routes/app_pages.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:warmi/core/globals/global_color.dart';
import 'package:warmi/core/utils/enum.dart';

import '../../../../../main.dart';

class ProductTransactionView extends StatefulWidget {
  final String? idCategory;

  const ProductTransactionView({Key? key, this.idCategory}) : super(key: key);
  @override
  State<ProductTransactionView> createState() => _ProductTransactionViewState();
}

class _ProductTransactionViewState extends State<ProductTransactionView> {
  final cartController =
       Get.find<CartController>();

  final controller = Get.isRegistered<ProductController>()
      ? Get.find<ProductController>()
      : Get.put(ProductController());
  final transactionController = Get.find<TransactionController>();

  @override
  void initState() {
    print(widget.idCategory);
    if(widget.idCategory!=null){
      transactionController.getSearchProduct(transactionController.searchC.value.text,idCategory: widget.idCategory);
    }else{

    }
    super.initState();
  }

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
    // if(widget.idCategory!=null){
    //   transactionController.getSearchProduct(transactionController.searchC.value.text,idCategory: widget.idCategory);
    // }else{
    //
    // }
    return Obx(() {
      return transactionController.searchC.value.text.isEmpty && widget.idCategory==null
          ? controller.listProduct.length == 0
              ? Center(
                  child: GeneralButton(
                    label: 'Tambah Data',
                    onPressed: () => Get.toNamed(Routes.ADD_PRODUCT),
                    height: 40,
                    width: 150,
                  ),
                )
              : ListView.builder(
                  itemCount: controller.listProduct.length,
                  shrinkWrap: true,
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  physics: ClampingScrollPhysics(),
                  itemBuilder: (c, i) {
                    return Card(
                      color: controller.listProduct[i].productInCart
                          ? MyColor.colorOrangeLight
                          : null,
                      elevation: 0.4,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(
                          onTap: () {
                            if (controller.listProduct[i].productInCart) {
                              cartController.deleteCartFormListProduct(
                                  controller.listProduct[i]);
                            } else {
                              if (controller.listProduct[i].productStokStatus ==
                                      "true" &&
                                  controller.listProduct[i].productStok == "0")
                                showSnackBar(
                                    snackBarType: SnackBarType.WARNING,
                                    message: "Stok Produk Kosong",
                                    title: 'produk'.tr);
                              else
                                cartController
                                    .addCart(controller.listProduct[i]);
                            }
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Flexible(
                                      flex: 5,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(100),
                                            child: CachedNetworkImage(
                                              imageUrl:
                                                  "${controller.listProduct[i].productPhoto}",
                                              fit: BoxFit.cover,
                                              width: 60,
                                              height: 60,
                                              placeholder: (c, s) => Center(
                                                  child:
                                                      CircularProgressIndicator()),
                                              errorWidget: (context, s, o) =>
                                                  TextAvatar(
                                                shape: Shape.Circular,
                                                size: 30,
                                                fontSize: 16.sp,
                                                fontWeight: FontWeight.w600,
                                                upperCase: true,
                                                numberLetters: 3,
                                                text:
                                                    "${controller.listProduct[i].productName}",
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Flexible(
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "${controller.listProduct[i].productName}",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 16),
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                Container(
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      color: Colors.green),
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 10,
                                                      vertical: 3),
                                                  child: Text(
                                                    controller.listProduct[i]
                                                                .productStokStatus ==
                                                            "true"
                                                        ? "${controller.listProduct[i].productStok} ${controller.listProduct[i].productUnitId}"
                                                        : "Tersedia",
                                                    style: TextStyle(
                                                        fontSize: 12,
                                                        color: Colors.white),
                                                  ),
                                                )
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    ...cartController.listCart.map((element) {
                                      if (controller
                                              .listProduct[i].productInCart &&
                                          element.dataProduct ==
                                              controller.listProduct[i])
                                        return Flexible(
                                          flex: 2,
                                          child: GetBuilder<CartController>(
                                              builder: (logic) {
                                            return Container(
                                              height: 38,
                                              width: 120,
                                              margin: EdgeInsets.only(
                                                  top: 10, left: 10, right: 10),
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 3),
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                color: MyColor.colorSilver,
                                              ),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  InkWell(
                                                    onTap: () => cartController
                                                        .removeQty(element),
                                                    child: Container(
                                                      child: LineIcon.minus(
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
                                                          style: GoogleFonts
                                                              .roboto(
                                                                  fontSize: 16,
                                                                  color: Colors
                                                                      .black),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  InkWell(
                                                    onTap: () => cartController
                                                        .addQty(element),
                                                    child: Container(
                                                      child: LineIcon.plus(
                                                        color: Colors.green,
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            );
                                          }),
                                        );
                                      else
                                        return Container();
                                    }).toList(),
                                    if (!controller
                                        .listProduct[i].productInCart)
                                      Flexible(
                                        flex: 2,
                                        child: Text(
                                          "Rp. ${formatCurrency.format(controller.listProduct[i].productPrice)}",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                      )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  })
          : transactionController.loadingState.value==LoadingState.loading ? Center(child: CircularProgressIndicator()): transactionController.listSearchProduct.length == 0
              ? Center(
                  child: Text("Produk Kosong"),
                )
              : ListView.builder(
                  itemCount: transactionController.listSearchProduct.length,
                  shrinkWrap: true,
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  physics: ClampingScrollPhysics(),
                  itemBuilder: (c, i) {
                    return Card(
                      color: transactionController
                              .listSearchProduct[i].productInCart
                          ? MyColor.colorOrangeLight
                          : null,
                      elevation: 0.4,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(
                          onTap: () {
                            if (transactionController
                                .listSearchProduct[i].productInCart) {
                              cartController.deleteCartFormListProduct(
                                  transactionController.listSearchProduct[i]);
                            } else {
                              if (transactionController.listSearchProduct[i]
                                          .productStokStatus ==
                                      "true" &&
                                  transactionController
                                          .listSearchProduct[i].productStok ==
                                      "0")
                                showSnackBar(
                                    snackBarType: SnackBarType.WARNING,
                                    message: "Stok Produk Kosong",
                                    title: 'produk'.tr);
                              else
                                cartController.addCart(
                                    transactionController.listSearchProduct[i]);
                            }
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Flexible(
                                      flex: 5,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(100),
                                            child: CachedNetworkImage(
                                              imageUrl:
                                                  "${transactionController.listSearchProduct[i].productPhoto}",
                                              fit: BoxFit.cover,
                                              width: 60,
                                              height: 60,
                                              placeholder: (c, s) => Center(
                                                  child:
                                                      CircularProgressIndicator()),
                                              errorWidget: (context, s, o) =>
                                                  TextAvatar(
                                                shape: Shape.Circular,
                                                size: 30,
                                                fontSize: 16.sp,
                                                fontWeight: FontWeight.w600,
                                                upperCase: true,
                                                numberLetters: 3,
                                                text:
                                                    "${transactionController.listSearchProduct[i].productName}",
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Flexible(
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "${transactionController.listSearchProduct[i].productName}",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 16),
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                Container(
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      color: Colors.green),
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 10,
                                                      vertical: 3),
                                                  child: Text(
                                                    transactionController
                                                                .listSearchProduct[
                                                                    i]
                                                                .productStokStatus ==
                                                            "true"
                                                        ? "${transactionController.listSearchProduct[i].productStok} ${transactionController.listSearchProduct[i].productUnitId}"
                                                        : "Tersedia",
                                                    style: TextStyle(
                                                        fontSize: 12,
                                                        color: Colors.white),
                                                  ),
                                                )
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    ...cartController.listCart.map((element) {
                                      if (transactionController
                                              .listSearchProduct[i]
                                              .productInCart &&
                                          element.dataProduct ==
                                              transactionController
                                                  .listSearchProduct[i])
                                        return Flexible(
                                          flex: 2,
                                          child: GetBuilder<CartController>(
                                              builder: (logic) {
                                            return Container(
                                              height: 38,
                                              width: 120,
                                              margin: EdgeInsets.only(
                                                  top: 10, left: 10, right: 10),
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 3),
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                color: MyColor.colorSilver,
                                              ),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  InkWell(
                                                    onTap: () => cartController
                                                        .removeQty(element),
                                                    child: Container(
                                                      child: LineIcon.minus(
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
                                                          style: GoogleFonts
                                                              .roboto(
                                                                  fontSize: 16,
                                                                  color: Colors
                                                                      .black),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  InkWell(
                                                    onTap: () => cartController
                                                        .addQty(element),
                                                    child: Container(
                                                      child: LineIcon.plus(
                                                        color: Colors.green,
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            );
                                          }),
                                        );
                                      else
                                        return Container();
                                    }).toList(),
                                    if (!transactionController
                                        .listSearchProduct[i].productInCart)
                                      Flexible(
                                        flex: 2,
                                        child: Text(
                                          "Rp. ${formatCurrency.format(transactionController.listSearchProduct[i].productPrice)}",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                      )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  });
    });
  }
}
