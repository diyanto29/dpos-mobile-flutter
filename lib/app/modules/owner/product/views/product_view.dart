import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_statusbarcolor_ns/flutter_statusbarcolor_ns.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:warmi/app/modules/owner/product/controllers/product_controller.dart';
import 'package:warmi/app/modules/wigets/layouts/general_button.dart';
import 'package:warmi/app/modules/wigets/package/corolize_text_avatar/colorize_text_avatar.dart';
import 'package:warmi/app/routes/app_pages.dart';
import 'package:warmi/core/globals/global_color.dart';
import 'package:warmi/core/utils/enum.dart';
import 'package:warmi/core/utils/thema.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class ProductView extends GetWidget<ProductController> {
  final formatCurrency = new NumberFormat.currency(locale: "id_ID", symbol: "", decimalDigits: 0);

  @override
  Widget build(BuildContext context) {
    FlutterStatusbarcolor.setStatusBarColor(MyColor.colorPrimary);
    return Scaffold(
        backgroundColor: MyColor.colorBackground,
        appBar: AppBar(
          backgroundColor: MyColor.colorPrimary,
          title: Text(
            'Produk',
            style: whiteTextTitle,
          ),
          actions: [
            IconButton(
                onPressed: () => Get.toNamed(Routes.ADD_PRODUCT), icon: Icon(IconlyBold.plus))
          ],
        ),
        body: Obx(() {
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.only(top: 10, bottom: 10, left: 10, right: 10),
                child: TextField(
                    controller: controller.searchC.value,
                  onChanged: (v){
                      controller.searchProductList(v);
                  },
                  style: TextStyle(height: 0.9, fontSize: 14),
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
              Expanded(
                  child: controller.loadingState == LoadingState.loading
                      ? Center(child: CircularProgressIndicator())
                      : controller.listProduct.length == 0
                          ? Center(
                              child:  GeneralButton(label: 'Tambah Data',onPressed: ()=> Get.toNamed(Routes.ADD_PRODUCT),height: 40,width: 150,),
                            )
                          : controller.searchC.value.text.isNotEmpty
                              ? controller.listSearchProduct.length == 0
                                  ? Center(
                                      child: Text("Data yang anda Cari Kosong"),
                                    )
                                  : ListView.builder(
                      itemCount: controller.listSearchProduct.length,
                      shrinkWrap: true,
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      physics: ClampingScrollPhysics(),
                      itemBuilder: (c, i) {
                        return Card(
                          elevation: 0.4,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          child: InkWell(
                            onTap: () => Get.toNamed(Routes.EDIT_PRODUCT,arguments: controller.listSearchProduct[i]),
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
                                                imageUrl:
                                                "${controller.listSearchProduct[i].productPhoto}",
                                                fit: BoxFit.fitWidth,
                                                width: 60,
                                                height: 60,
                                                placeholder: (c, s) => Center(
                                                    child: CircularProgressIndicator()),
                                                errorWidget: (context, s, o) =>
                                                    TextAvatar(
                                                      shape: Shape.Circular,
                                                      size: 30,
                                                      fontSize: 16.sp,
                                                      fontWeight: FontWeight.w600,
                                                      upperCase: true,
                                                      numberLetters: 3,

                                                      text: "${controller.listSearchProduct[i].productName}",
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
                                                    "${controller.listSearchProduct[i].productName}",
                                                    style: TextStyle(
                                                        fontWeight: FontWeight.bold,
                                                        fontSize: 16),
                                                    overflow: TextOverflow.ellipsis,
                                                  ),
                                                  SizedBox(
                                                    height: 5,
                                                  ),
                                                  Container(
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                        BorderRadius.circular(10),
                                                        color: Colors.green),
                                                    padding: EdgeInsets.symmetric(
                                                        horizontal: 10, vertical: 3),
                                                    child: Text(
                                                      controller.listSearchProduct[i]
                                                          .productStokStatus ==
                                                          "true"
                                                          ? "${controller.listSearchProduct[i].productStok} ${controller.listSearchProduct[i].productUnitId}"
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
                                      Flexible(
                                        flex: 2,
                                        child: Text(
                                          "Rp. ${formatCurrency.format(controller.listSearchProduct[i].productPrice)}",
                                          style: TextStyle(fontWeight: FontWeight.bold),
                                        ),
                                      )
                                    ],
                                  ),
                                  Divider(
                                    thickness: 1,
                                  ),
                                  Text(
                                      "${DateFormat("EEEE, dd-MM-yyyy HH:MM:ss", 'ID-id').format(controller.listSearchProduct[i].updatedAt!)}")
                                ],
                              ),
                            ),
                          ),
                        );
                      })
                              : ListView.builder(
                                  itemCount: controller.listProduct.length,
                                  shrinkWrap: true,
                                  padding: EdgeInsets.symmetric(horizontal: 10),
                                  physics: ClampingScrollPhysics(),
                                  itemBuilder: (c, i) {
                                    return Card(
                                      elevation: 0.4,
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(10)),
                                      child: InkWell(
                                        onTap: () => Get.toNamed(Routes.EDIT_PRODUCT,arguments: controller.listProduct[i]),
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
                                                            imageUrl:
                                                                "${controller.listProduct[i].productPhoto}",
                                                            fit: BoxFit.fitWidth,
                                                            width: 60,
                                                            height: 60,
                                                            placeholder: (c, s) => Center(
                                                                child: CircularProgressIndicator()),
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
                                                                    fontWeight: FontWeight.bold,
                                                                    fontSize: 16),
                                                                overflow: TextOverflow.ellipsis,
                                                              ),
                                                              SizedBox(
                                                                height: 5,
                                                              ),
                                                              Container(
                                                                decoration: BoxDecoration(
                                                                    borderRadius:
                                                                        BorderRadius.circular(10),
                                                                    color: Colors.green),
                                                                padding: EdgeInsets.symmetric(
                                                                    horizontal: 10, vertical: 3),
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
                                                  Flexible(
                                                    flex: 2,
                                                    child: Text(
                                                      "Rp. ${formatCurrency.format(controller.listProduct[i].productPrice)}",
                                                      style: TextStyle(fontWeight: FontWeight.bold),
                                                    ),
                                                  )
                                                ],
                                              ),
                                              Divider(
                                                thickness: 1,
                                              ),
                                              Text(
                                                  "${DateFormat("EEEE, dd-MM-yyyy HH:MM:ss", 'ID-id').format(controller.listProduct[i].updatedAt!)}")
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  })),
            ],
          );
        }));
  }
}
