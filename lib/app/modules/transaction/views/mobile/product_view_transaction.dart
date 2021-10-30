import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:warmi/app/modules/owner/product/controllers/product_controller.dart';
import 'package:warmi/app/modules/transaction/controllers/cart_controller.dart';
import 'package:warmi/app/modules/transaction/controllers/transaction_controller.dart';
import 'package:warmi/app/modules/wigets/package/corolize_text_avatar/colorize_text_avatar.dart';
import 'package:warmi/app/routes/app_pages.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:warmi/core/globals/global_color.dart';

class ProductTransactionView extends GetWidget<ProductController> {
  final formatCurrency = new NumberFormat.currency(locale: "id_ID", symbol: "", decimalDigits: 0);
  final cartController = Get.find<CartController>();
  final transactionController = Get.find<TransactionController>();


  @override
  Widget build(BuildContext context) {

    controller.checkProductInCart();
    return Obx(() {
      return transactionController.searchC.value.text.isEmpty  ?
      ListView.builder(
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
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  onTap: () => cartController.addCart(controller.listProduct[i]),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Flexible(
                              flex: 5,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(100),
                                    child: CachedNetworkImage(
                                      imageUrl: "${controller.listProduct[i].productPhoto}",
                                      fit: BoxFit.fitWidth,
                                      width: 60,
                                      height: 60,
                                      placeholder: (c, s) =>
                                          Center(child: CircularProgressIndicator()),
                                      errorWidget: (context, s, o) => TextAvatar(
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
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Flexible(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "${controller.listProduct[i].productName}",
                                          style:
                                              TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Container(
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(10),
                                              color: Colors.green),
                                          padding:
                                              EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                                          child: Text(
                                            controller.listProduct[i].productStokStatus == "true"
                                                ? "${controller.listProduct[i].productStok} ${controller.listProduct[i].productUnitId}"
                                                : "Tersedia",
                                            style: TextStyle(fontSize: 12, color: Colors.white),
                                          ),
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Flexible(
                              flex: 2,
                              child: Text(
                                "Rp. ${formatCurrency.format(controller.listProduct[i].productPrice)}",
                                style: TextStyle(fontWeight: FontWeight.bold),
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
          }) :
      transactionController.listSearchProduct.length==0 ?
      Center(child: Text("Produk Kosong"),) :
      ListView.builder(
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
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  onTap: () => cartController.addCart(transactionController.listSearchProduct[i]),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Flexible(
                              flex: 5,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(100),
                                    child: CachedNetworkImage(
                                      imageUrl: "${transactionController.listSearchProduct[i].productPhoto}",
                                      fit: BoxFit.fitWidth,
                                      width: 60,
                                      height: 60,
                                      placeholder: (c, s) =>
                                          Center(child: CircularProgressIndicator()),
                                      errorWidget: (context, s, o) => TextAvatar(
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
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Flexible(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "${transactionController.listSearchProduct[i].productName}",
                                          style:
                                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Container(
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(10),
                                              color: Colors.green),
                                          padding:
                                          EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                                          child: Text(
                                            transactionController.listSearchProduct[i].productStokStatus == "true"
                                                ? "${transactionController.listSearchProduct[i].productStok} ${transactionController.listSearchProduct[i].productUnitId}"
                                                : "Tersedia",
                                            style: TextStyle(fontSize: 12, color: Colors.white),
                                          ),
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Flexible(
                              flex: 2,
                              child: Text(
                                "Rp. ${formatCurrency.format(transactionController.listSearchProduct[i].productPrice)}",
                                style: TextStyle(fontWeight: FontWeight.bold),
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
          }) ;
    });
  }
}
