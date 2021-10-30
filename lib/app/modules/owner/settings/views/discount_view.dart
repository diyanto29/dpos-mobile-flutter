import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_statusbarcolor_ns/flutter_statusbarcolor_ns.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:warmi/app/modules/owner/settings/controllers/discount_controller.dart';
import 'package:warmi/app/modules/wigets/layouts/general_button.dart';
import 'package:warmi/app/modules/wigets/package/corolize_text_avatar/src/colorized_text_avatar.dart';
import 'package:warmi/app/modules/wigets/package/corolize_text_avatar/src/constants/enums.dart';
import 'package:warmi/app/routes/app_pages.dart';
import 'package:warmi/core/globals/global_color.dart';
import 'package:warmi/core/utils/enum.dart';
import 'package:warmi/core/utils/thema.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import 'dialog_settings.dart';

class DiscountView extends GetWidget<DiscountController> {
  final formatCurrency = new NumberFormat.currency(locale: "id_ID", symbol: "", decimalDigits: 0);

  @override
  Widget build(BuildContext context) {
    FlutterStatusbarcolor.setStatusBarColor(MyColor.colorPrimary);
    return Scaffold(
        backgroundColor: MyColor.colorBackground,
        appBar: AppBar(
          backgroundColor: MyColor.colorPrimary,
          title: Text(
            'Diskon',
            style: whiteTextTitle,
          ),
          actions: [IconButton(onPressed: () => Get.toNamed(Routes.ADD_DISCOUNT), icon: Icon(IconlyBold.plus))],
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
                  style: TextStyle(height: 0.9, fontSize: 14),
                  onChanged: (v) {
                    controller.searchDiscount(v);
                  },
                  decoration: InputDecoration(
                      hintText: "Cari Diskon disini...",
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
                      : controller.listDiscount.length == 0
                          ? Center(
                              child: GeneralButton(label: 'Tambah Data',onPressed: ()=> Get.toNamed(Routes.ADD_DISCOUNT),height: 40,width: 150,),
                            )
                          : controller.searchC.value.text.isNotEmpty
                              ? controller.listSearchDiscount.length == 0
                                  ? Center(
                                      child: Text("Data yang anda Cari Kosong"),
                                    )
                                  : ListView.builder(
                                      itemCount: controller.listSearchDiscount.length,
                                      shrinkWrap: true,
                                      padding: EdgeInsets.symmetric(horizontal: 10),
                                      physics: ClampingScrollPhysics(),
                                      itemBuilder: (c, i) {
                                        var discount=controller.listSearchDiscount[i];
                                        return Card(
                                          elevation: 0.4,
                                          shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(10)),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: ListTile(
                                              onTap: (){
                                                Get.toNamed(Routes.ADD_DISCOUNT,arguments: discount);
                                              },
                                              leading: TextAvatar(
                                                shape: Shape.Circular,
                                                size: 50,
                                                fontSize: 16.sp,
                                                fontWeight: FontWeight.w600,
                                                upperCase: true,
                                                numberLetters: 3,

                                                text: "${controller.listDiscount[i].discountName}",
                                              ),
                                              dense: true,
                                              title: Text(
                                                  "${controller.listSearchDiscount[i].discountName}"),
                                              subtitle:
                                                  controller.listSearchDiscount[i].discountType ==
                                                          "percent"
                                                      ? controller.listSearchDiscount[i]
                                                                      .discountMaxPriceOff ==
                                                                  "0" ||
                                                              controller.listSearchDiscount[i]
                                                                      .discountMaxPriceOff ==
                                                                  null
                                                          ? Container()
                                                          : Text(
                                                              "Max. Discount Rp ${formatCurrency.format(int.parse(controller.listSearchDiscount[i].discountMaxPriceOff!))}",
                                                              style: GoogleFonts.roboto(
                                                                  fontWeight: FontWeight.bold),
                                                            )
                                                      : Container(),
                                              trailing: Text(
                                                controller.listSearchDiscount[i].discountType ==
                                                        "percent"
                                                    ? "${controller.listSearchDiscount[i].discountPercent}%"
                                                    : "Rp ${formatCurrency.format(int.parse(controller.listSearchDiscount[i].discountMaxPriceOff!))}",
                                                style:
                                                    GoogleFonts.roboto(fontWeight: FontWeight.bold),
                                              ),
                                            ),
                                          ),
                                        );
                                      })
                              : ListView.builder(
                                  itemCount: controller.listDiscount.length,
                                  shrinkWrap: true,
                                  padding: EdgeInsets.symmetric(horizontal: 10),
                                  physics: ClampingScrollPhysics(),
                                  itemBuilder: (c, i) {
                                    var discount=controller.listDiscount[i];
                                    return Card(
                                      elevation: 0.1,
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(10)
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: ListTile(
                                          onTap: (){
                                            Get.toNamed(Routes.ADD_DISCOUNT,arguments: discount);
                                          },
                                          dense: true,
                                          leading: TextAvatar(
                                            shape: Shape.Circular,
                                            size: 50,
                                            fontSize: 16.sp,
                                            fontWeight: FontWeight.w600,
                                            upperCase: true,
                                            numberLetters: 3,

                                            text: "${controller.listDiscount[i].discountName}",
                                          ),
                                          title: Text("${controller.listDiscount[i].discountName}"),
                                          subtitle: controller.listDiscount[i].discountType ==
                                                  "percent"
                                              ? controller.listDiscount[i].discountMaxPriceOff ==
                                                          "0" ||
                                                      controller.listDiscount[i]
                                                              .discountMaxPriceOff ==
                                                          null
                                                  ? Container()
                                                  : Text(
                                                      "Max. Discount Rp ${formatCurrency.format(int.parse(controller.listDiscount[i].discountMaxPriceOff!))}",
                                                      style: GoogleFonts.roboto(
                                                          fontWeight: FontWeight.bold),
                                                    )
                                              : Container(),
                                          trailing: Text(
                                            controller.listDiscount[i].discountType == "percent"
                                                ? "${controller.listDiscount[i].discountPercent}%"
                                                : "Rp ${formatCurrency.format(int.parse(controller.listDiscount[i].discountMaxPriceOff!))}",
                                            style: GoogleFonts.roboto(fontWeight: FontWeight.bold),
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
