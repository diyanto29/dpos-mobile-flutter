import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:line_icons/line_icon.dart';
import 'package:warmi/app/data/models/product/cart.dart';
import 'package:warmi/app/modules/navigation/controllers/navigation_controller.dart';
import 'package:warmi/app/modules/owner/product/controllers/product_controller.dart';
import 'package:warmi/app/modules/transaction/controllers/cart_controller.dart';

import 'package:warmi/app/modules/transaction/controllers/transaction_controller.dart';
import 'package:warmi/app/modules/transaction/views/mobile/product_view_transaction.dart';
import 'package:warmi/app/modules/wigets/layouts/dialog/bottom_dialog_cart.dart';
import 'package:warmi/app/modules/wigets/layouts/general_button.dart';
import 'package:warmi/app/modules/wigets/package/corolize_text_avatar/colorize_text_avatar.dart';
import 'package:warmi/app/modules/wigets/package/corolize_text_avatar/src/colorized_text_avatar.dart';
import 'package:warmi/app/routes/app_pages.dart';
import 'package:warmi/core/globals/global_color.dart';
import 'package:warmi/core/globals/global_string.dart';

import 'package:warmi/core/utils/thema.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:warmi/main.dart';
import 'package:recase/recase.dart';

class TransactionViewTable extends StatefulWidget {
  const TransactionViewTable({Key? key}) : super(key: key);

  @override
  _TransactionViewTableState createState() => _TransactionViewTableState();
}

class _TransactionViewTableState extends State<TransactionViewTable> {
  final transactionController = Get.find<TransactionController>();
  var controller = Get.put(ProductController());
  var cartController = Get.find<CartController>();
  var navC = Get.find<NavigationController>();

  @override
  Widget build(BuildContext context) {
    controller.checkProductInCart();
    return Scaffold(
      backgroundColor: MyColor.colorBackground,
      body: Obx(() {
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 20,
            ),
            Container(
              height: 60,
              width: double.infinity,
              decoration: BoxDecoration(color: MyColor.colorPrimary, boxShadow: [BoxShadow(offset: Offset(0, 1), color: MyColor.colorBlackT50)]),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Flexible(
                    flex: 10,
                    child: Row(
                      children: [
                        Flexible(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextAvatar(
                              shape: Shape.Circular,
                              size: 8.h,
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
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: MyColor.colorSilver),
                            margin: const EdgeInsets.only(top: 10, bottom: 10, left: 10, right: 10),
                            child: TextField(
                              controller: transactionController.searchC.value,
                              style: TextStyle(height: 0.9, fontSize: 14),
                              onChanged: (v) {
                                transactionController.getSearchProduct(v);
                              },
                              decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.only(top: 10, left: 10),
                                  hintText: "Cari Produk disini...",
                                  hintStyle: TextStyle(fontSize: 12, color: Colors.grey[600]),
                                  fillColor: Colors.white,
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(10)),
                                    borderSide: BorderSide(width: 1, color: MyColor.colorBlackT50),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(10)),
                                    borderSide: BorderSide(width: 1, color: MyColor.colorPrimary),
                                  ),
                                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide(color: MyColor.colorGrey, width: 0.1)),
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
                  Flexible(
                      flex: 1,
                      child: IconButton(
                        onPressed: () {},
                        icon: LineIcon.addToShoppingCart(
                          color: MyColor.colorSilver,
                        ),
                        iconSize: 30,
                      ))
                ],
              ),
            ),
            Expanded(child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: MyString.DEFAULT_PADDING, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                      flex: 6,
                      child: Obx(() {
                        return transactionController.searchC.value.text.isEmpty ?
                        GridView.builder(
                            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                                maxCrossAxisExtent: 150,
                                childAspectRatio: 2 / 2,
                                crossAxisSpacing: 10,
                                mainAxisSpacing: 10),
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
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                child: InkWell(
                                  onTap: () => cartController.addCart(controller.listProduct[i]),
                                  child: Stack(
                                    children: [

                                      Positioned(
                                        top: 0,
                                        left: 0,
                                        right: 0,
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            ClipRRect(
                                              borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)),
                                              child: CachedNetworkImage(
                                                imageUrl: "${controller.listProduct[i].productPhoto}",
                                                fit: BoxFit.cover,
                                                height: 90,
                                                width: double.infinity,
                                                placeholder: (c, s) =>
                                                    Center(child: CircularProgressIndicator()),
                                                errorWidget: (context, s, o) =>
                                                    TextAvatar(
                                                      shape: Shape.Circular,
                                                      size: 30,
                                                      fontSize: 16.sp,
                                                      fontWeight: FontWeight.w600,
                                                      upperCase: true,
                                                      numberLetters: 3,
                                                      text: "${controller.listProduct[i].productName}",
                                                    ),
                                              ),
                                            ),
                                            SizedBox(height: 4,),
                                            Text(
                                              "${controller.listProduct[i].productName}",
                                              style:
                                              TextStyle(fontWeight: FontWeight.w400, fontSize: 12),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            SizedBox(height: 4,),
                                            Text(
                                              "Rp. ${formatCurrency.format(controller.listProduct[i].productPrice)}",
                                              style: TextStyle(fontWeight: FontWeight.bold),
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
                                                borderRadius: BorderRadius.only(topLeft: Radius.circular(10), bottomRight: Radius.circular(10)),
                                                color: Colors.green),
                                            padding:
                                            EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                                            child: Text(
                                              controller.listProduct[i].productStokStatus == "true"
                                                  ? "${controller.listProduct[i].productStok} ${controller.listProduct[i].productUnitId!.length > 3 ? controller.listProduct[i].productUnitId!.substring(0, 3).titleCase : controller.listProduct[i].productUnitId
                                                  .toString()
                                                  .titleCase}"
                                                  : "Tersedia",
                                              style: TextStyle(fontSize: 12, color: Colors.white,), overflow: TextOverflow.ellipsis,
                                            ),
                                          ))
                                    ],
                                  ),
                                ),
                              );
                            }) :
                        transactionController.listSearchProduct.length == 0 ?
                        Center(child: Text("Produk Kosong"),) :
                        GridView.builder(
                            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                                maxCrossAxisExtent: 150,
                                childAspectRatio: 2 / 2,
                                crossAxisSpacing: 10,
                                mainAxisSpacing: 10),
                            itemCount: transactionController.listSearchProduct.length,
                            shrinkWrap: true,
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            physics: ClampingScrollPhysics(),
                            itemBuilder: (c, i) {
                              return Card(
                                color: transactionController.listSearchProduct[i].productInCart
                                    ? MyColor.colorOrangeLight
                                    : null,
                                elevation: 0.4,
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                child: InkWell(
                                  onTap: () => cartController.addCart(transactionController.listSearchProduct[i]),
                                  child: Stack(
                                    children: [

                                      Positioned(
                                        top: 0,
                                        left: 0,
                                        right: 0,
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            ClipRRect(
                                              borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)),
                                              child: CachedNetworkImage(
                                                imageUrl: "${transactionController.listSearchProduct[i].productPhoto}",
                                                fit: BoxFit.cover,
                                                height: 90,
                                                width: double.infinity,
                                                placeholder: (c, s) =>
                                                    Center(child: CircularProgressIndicator()),
                                                errorWidget: (context, s, o) =>
                                                    TextAvatar(
                                                      shape: Shape.Circular,
                                                      size: 30,
                                                      fontSize: 16.sp,
                                                      fontWeight: FontWeight.w600,
                                                      upperCase: true,
                                                      numberLetters: 3,
                                                      text: "${transactionController.listSearchProduct[i].productName}",
                                                    ),
                                              ),
                                            ),
                                            SizedBox(height: 4,),
                                            Text(
                                              "${transactionController.listSearchProduct[i].productName}",
                                              style:
                                              TextStyle(fontWeight: FontWeight.w400, fontSize: 12),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            SizedBox(height: 4,),
                                            Text(
                                              "Rp. ${formatCurrency.format(transactionController.listSearchProduct[i].productPrice)}",
                                              style: TextStyle(fontWeight: FontWeight.bold),
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
                                                borderRadius: BorderRadius.only(topLeft: Radius.circular(10), bottomRight: Radius.circular(10)),
                                                color: Colors.green),
                                            padding:
                                            EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                                            child: Text(
                                              transactionController.listSearchProduct[i].productStokStatus == "true"
                                                  ? "${transactionController.listSearchProduct[i].productStok} ${transactionController.listSearchProduct[i].productUnitId!.length > 3 ? transactionController.listSearchProduct[i].productUnitId!.substring(0, 3).titleCase : transactionController
                                                  .listSearchProduct[i].productUnitId
                                                  .toString()
                                                  .titleCase}"
                                                  : "Tersedia",
                                              style: TextStyle(fontSize: 12, color: Colors.white,), overflow: TextOverflow.ellipsis,
                                            ),
                                          ))
                                    ],
                                  ),
                                ),
                              );
                            });
                      })),
                  Expanded(
                      flex: 3,
                      child: Column(
                        children: [
                          Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                                color: MyColor.colorPrimary,
                                borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10))
                            ),
                            padding: const EdgeInsets.all(8),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Transaksi Baru", style: whiteTextTitle,),
                                SizedBox(height: 5,),
                                Text(DateFormat("EEEE, dd MMMM yyyy", 'id-ID').format(DateTime.now()), style: whiteTextTitle.copyWith(color: MyColor.colorBlack5, fontSize: 12.sp),),
                                SizedBox(height: 10,),
                                InkWell(
                                  onTap: () async {
                                    Get.toNamed(Routes.CUSTOMER_PAGE);
                                  },
                                  child: GetBuilder<CartController>(builder: (logic) {
                                    return Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Container(
                                          margin: EdgeInsets.only(top: 0),
                                          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                                          decoration: BoxDecoration(color: Colors.green, borderRadius: BorderRadius.circular(10)),
                                          child: Text(
                                            cartController.customer.value.customerpartnername == null ? "Pelanggan" : cartController.customer.value.customerpartnername!,
                                            style: GoogleFonts.roboto(fontSize: 12.0, color: Colors.white),
                                          ),
                                        ),
                                        Visibility(
                                          visible: cartController.customer.value.customerpartnername == null ? false : true,
                                          child: InkWell(
                                            onTap: () {
                                              cartController.removeCustomer();
                                              print("a");
                                            },
                                            child: Container(
                                              margin: EdgeInsets.only(top: 0, left: 10),
                                              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                                              decoration: BoxDecoration(color: Colors.red, borderRadius: BorderRadius.circular(10)),
                                              child: Text(
                                                "Hapus",
                                                style: GoogleFonts.roboto(fontSize: 12.0, color: Colors.white),
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
                                          itemCount: cartController.listCart.length,
                                          shrinkWrap: true,
                                          physics: ClampingScrollPhysics(),
                                          itemBuilder: (c, i) =>
                                             InkWell(
                                                   onTap: () => addDiscount(cart: cartController.listCart[i], allProduct: false),
                                               child: Container(
                                                 decoration: BoxDecoration(
                                                   color: Colors.white
                                                 ),
                                                 child: Padding(
                                                   padding: const EdgeInsets.only(bottom: 20.0,top: 8,left: 8,right: 8),
                                                   child: Row(
                                                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                     crossAxisAlignment: CrossAxisAlignment.center,
                                                     children: [
                                                       Flexible(
                                                           flex: 3,
                                                           child: Row(
                                                             mainAxisAlignment: MainAxisAlignment.start,
                                                             crossAxisAlignment: CrossAxisAlignment.center,
                                                             children: [
                                                               Container(
                                                                 height: 30,
                                                                 width: 30,
                                                                 padding: const EdgeInsets.all(8),
                                                                 decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: MyColor.colorOrange),
                                                                 alignment: Alignment.center,
                                                                 child: Text(
                                                                   "${cartController.listCart[i].qty}",
                                                                   style: whiteTextTitle.copyWith(fontSize: 10.sp,fontWeight: FontWeight.bold),
                                                                 ),
                                                               ),
                                                               SizedBox(width: 10,),
                                                               Flexible(child: Column(
                                                                 mainAxisAlignment: MainAxisAlignment.start,
                                                                 crossAxisAlignment: CrossAxisAlignment.start,
                                                                 children: [
                                                                   Text(
                                                                     "${cartController.listCart[i].dataProduct!.productName}",
                                                                     style: blackTextFont.copyWith(fontSize: 12.sp),
                                                                   ),
                                                                   SizedBox(height: 4,),
                                                                   if(cartController.listCart[i].discount == null)   Text(
                                                                     "Klik untuk tambah diskon",
                                                                     style: blackTextFont.copyWith(fontSize: 10.sp,fontStyle: FontStyle.italic),
                                                                   )
                                                                 ],
                                                               ))
                                                             ],
                                                           )),

                                                       Flexible(child: Column(
                                                         mainAxisAlignment: MainAxisAlignment.center,
                                                         crossAxisAlignment: CrossAxisAlignment.end,
                                                         children: [
                                                           Text(
                                                             "@ ${formatCurrency.format(cartController.listCart[i].dataProduct!.productPrice)}",
                                                             style: blackTextFont.copyWith(fontSize: 12.sp),
                                                           ),
                                                           SizedBox(
                                                             height: 5,
                                                           ),
                                                           if(cartController.listCart[i].discount != null)Text(
                                                             "${cartController.listCart[i].discount!.discountType!.toLowerCase() == 'price' ? ' - Rp.' + formatCurrency.format(int.parse(cartController.listCart[i].discount!.discountMaxPriceOff!)) : cartController
                                                                 .listCart[i].discount!.discountPercent + '%'}",
                                                             style: GoogleFonts.roboto(color: Colors.red, fontWeight: FontWeight.bold),
                                                           )
                                                           // if ((int.tryParse(product.detailtransactionsubtotal!)! - product.priceafterdiscount!) > 0)
                                                           //   Text(
                                                           //     "-  Rp ${formatCurrency.format(int.tryParse(product.detailtransactionsubtotal!)! - product.priceafterdiscount!)}",
                                                           //     style: blackTextFont.copyWith(color: MyColor.colorRedFlat),
                                                           //   ),
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
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                    elevation: 0.4,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              Text(
                                                "Sub Total",
                                                style: GoogleFonts.roboto(fontWeight: FontWeight.bold, fontSize: 4.w),
                                              ),
                                              Text(
                                                "Rp.${formatCurrency.format(cartController.totalCart.value)}",
                                                style: GoogleFonts.roboto(fontWeight: FontWeight.bold, fontSize: 4.w),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          InkWell(
                                            onTap: () => addDiscount(allProduct: true),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: [
                                                Text(
                                                  "Diskon",
                                                  style: GoogleFonts.roboto(fontWeight: FontWeight.bold, fontSize: 4.w),
                                                ),
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  children: [
                                                    cartController.dataDiscount != null ? Text(
                                                      "${cartController.dataDiscount?.discountType!.toLowerCase() == 'price' ? ' - Rp.' + formatCurrency.format(int.parse(cartController.dataDiscount!.discountMaxPriceOff!)) : cartController.dataDiscount?.discountPercent +
                                                          '%'}",
                                                      style: GoogleFonts.roboto(color: Colors.red, fontWeight: FontWeight.bold),
                                                    ) : Icon(Icons.arrow_forward_ios_rounded, size: 15,),
                                                    SizedBox(
                                                      width: 4,
                                                    ),
                                                    Visibility(
                                                      visible: cartController.dataDiscount == null ? false : true,
                                                      child: InkWell(
                                                          onTap: () {
                                                            setState(() {
                                                              cartController.deleteDiscount(dataDiscount: cartController.dataDiscount!, allProduct: true);
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
                                          cartController.dataDiscount != null
                                              ? cartController.dataDiscount!.discountType != 'price'
                                              ? Padding(
                                            padding: const EdgeInsets.fromLTRB(0, 2, 0, 0),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: [
                                                Text("Max Diskon"),
                                                Text(
                                                  "- Rp.${formatCurrency.format(int.parse(cartController.dataDiscount!.discountMaxPriceOff!))}",
                                                  style: GoogleFonts.roboto(color: Colors.red, fontWeight: FontWeight.bold),
                                                ),
                                              ],
                                            ),
                                          )
                                              : Container()
                                              : Container(),
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
            )
            )
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
      builder: (_) =>
          Container(
            height: Get.height * 0.9,
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            child: Obx(() {
              return Column(
                children: [
                  Center(child: Text("Daftar Diskon Tersedia", style: GoogleFonts.roboto(fontWeight: FontWeight.bold))),
                  transactionController.discountController.listDiscount.length == 0
                      ? Padding(
                    padding: const EdgeInsets.only(top: 250),
                    child: Column(
                      children: [
                        Center(
                          child: Text("Diskon Kosong"),
                        ),
                        SizedBox(height: 20,),
                        GeneralButton(label: 'Tambah Diskon', onPressed: () => Get.toNamed(Routes.ADD_DISCOUNT), height: 30, width: 200,)
                      ],
                    ),
                  )
                      : Expanded(
                    child: ListView.builder(
                        itemCount: transactionController.discountController.listDiscount.length,
                        shrinkWrap: true,
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        physics: ClampingScrollPhysics(),
                        itemBuilder: (c, i) {
                          return Card(
                            elevation: 2,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ListTile(
                                onTap: () {
                                  cartController.addDiscount(dataDiscount: transactionController.discountController.listDiscount[i], allProduct: allProduct, cartModel: cart);
                                  Get.back();
                                },
                                dense: true,
                                title: Text("${transactionController.discountController.listDiscount[i].discountName}"),
                                subtitle: transactionController.discountController.listDiscount[i].discountType == "percent"
                                    ? transactionController.discountController.listDiscount[i].discountMaxPriceOff == "0" || transactionController.discountController.listDiscount[i].discountMaxPriceOff == null
                                    ? Container()
                                    : Text(
                                  "Max. Discount Rp ${formatCurrency.format(int.parse(transactionController.discountController.listDiscount[i].discountMaxPriceOff!))}",
                                  style: GoogleFonts.roboto(fontWeight: FontWeight.bold),
                                )
                                    : Container(),
                                trailing: Text(
                                  transactionController.discountController.listDiscount[i].discountType == "percent"
                                      ? "${transactionController.discountController.listDiscount[i].discountPercent}%"
                                      : "Rp ${formatCurrency.format(int.parse(transactionController.discountController.listDiscount[i].discountMaxPriceOff!))}",
                                  style: GoogleFonts.roboto(fontWeight: FontWeight.bold),
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
    return Get.bottomSheet(BottomDialogCart(), isScrollControlled: true, elevation: 3);
  }
}
