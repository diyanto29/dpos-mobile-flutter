import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:warmi/app/data/models/discount/discount.dart';
import 'package:warmi/app/modules/owner/settings/controllers/discount_controller.dart';
import 'package:warmi/app/modules/wigets/layouts/dialog/dialog_question.dart';
import 'package:warmi/app/modules/wigets/layouts/general_text_input.dart';
import 'package:warmi/core/globals/global_color.dart';
import 'package:warmi/core/globals/global_string.dart';
import 'package:warmi/core/utils/format_currency.dart';
import 'package:warmi/core/utils/thema.dart';
import 'package:warmi/main.dart';

class AddDiscountView extends StatefulWidget {
  @override
  State<AddDiscountView> createState() => _AddDiscountViewState();
}

class _AddDiscountViewState extends State<AddDiscountView> {
  var controller = Get.find<DiscountController>();
  DataDiscount? discount;

  @override
  void initState() {
    discount = Get.arguments;
    if (discount != null) {
      controller.conName.value.text = discount!.discountName!;
      print(discount!.discountType);
      if (discount!.discountType == "percent") {
        controller.value(2);
        controller.conPercent.value.text = discount!.discountPercent!;
        controller.conDiscountMax.value.text = "Rp " +
            formatCurrency.format(int.parse(discount!.discountMaxPriceOff!));
      } else {
        controller.value(1);
        controller.conDiscount.value.text = "Rp " +
            formatCurrency.format(int.parse(discount!.discountMaxPriceOff!));
      }
    } else {}
    super.initState();
  }

  @override
  void dispose() {
    controller.value(null);
    controller.conName.value.text = "";
    controller.conPercent.value.text = "";
    controller.conDiscount.value.text = "";
    controller.conDiscountMax.value.text = "";
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        backgroundColor: MyColor.colorPrimary,
        title: Text(
          'Tambah Diskon',
          style: whiteTextTitle,
        ),
      ),
      body: Obx(() {
        return MediaQuery.removePadding(
          context: context,
          removeTop: true,
          child: ListView(
            padding: EdgeInsets.symmetric(
                horizontal: MyString.DEFAULT_PADDING, vertical: 10),
            children: [
              GeneralTextInput(
                  controller: controller.conName.value,
                  labelTextInputBox: 'Nama Diskon',
                  descTextInputBox: 'masukkan_nama_diskon'.tr),
              Text(
                'nilai_diskon'.tr,
                style: GoogleFonts.roboto(),
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(width: 1, color: Colors.grey)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RadioListTile(
                        contentPadding: EdgeInsets.only(left: 0),
                        title: TextField(
                          controller: controller.conDiscount.value,
                          onTap: () {
                            controller.value(1);
                          },
                          keyboardType: TextInputType.number,
                          style: GoogleFonts.roboto(),
                          inputFormatters: [
                            WhitelistingTextInputFormatter.digitsOnly,
                            CurrencyPtBrInputFormatter(
                                maxDigits: 10, currency: "Rp "),
                          ],
                          onChanged: (v) {
                            print(v);
                            controller.money(int.parse(controller
                                .conDiscount.value.text
                                .split(" ")
                                .last
                                .replaceAll(".", "")));
                          },
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Rp. 50.000",
                              hintStyle:
                                  GoogleFonts.droidSans(color: Colors.grey)),
                        ),
                        value: 1,
                        groupValue: controller.value.value,
                        onChanged: (v) {
                          controller.value(int.parse(v.toString()));
                        }),
                    Divider(
                      thickness: 1.4,
                    ),
                    RadioListTile(
                        title: TextField(
                          controller: controller.conPercent.value,
                          onTap: () {
                            controller.value(2);
                          },
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "10%",
                              hintStyle:
                                  GoogleFonts.droidSans(color: Colors.grey)),
                        ),
                        contentPadding: EdgeInsets.only(left: 0),
                        value: 2,
                        groupValue: controller.value.value,
                        onChanged: (v) {
                          controller.value(int.parse(v.toString()));
                        })
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Visibility(
                visible: controller.value.value == 1 ? false : true,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Nilai Maksimun Diskon(Opsional)",
                      style: GoogleFonts.roboto(),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    TextField(
                      controller: controller.conDiscountMax.value,
                      keyboardType: TextInputType.number,
                      style: GoogleFonts.roboto(),
                      inputFormatters: [
                        WhitelistingTextInputFormatter.digitsOnly,
                        CurrencyPtBrInputFormatter(
                            maxDigits: 10, currency: "Rp "),
                      ],
                      onChanged: (v) {
                        // print(v);
                        controller.money(int.parse(controller
                            .conDiscountMax.value.text
                            .split(" ")
                            .last
                            .replaceAll(".", "")));
                        // print(moneyMax);
                      },
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                          hintText: "Rp. 50.000",
                          hintStyle: GoogleFonts.droidSans(color: Colors.grey)),
                    ),
                  ],
                ),
              )
            ],
          ),
        );
      }),
      bottomNavigationBar: Container(
          margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          height: 45,
          width: double.infinity,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              Flexible(
                child: Container(
                  height: 45,
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: ElevatedButton(
                    child: Text(
                      'simpan'.tr,
                      style: GoogleFonts.droidSans(fontSize: 16),
                    ),
                    style: ElevatedButton.styleFrom(
                        elevation: 1,
                        primary: MyColor.colorPrimary,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25))),
                    onPressed: () => controller.createDiscount(
                        id: discount != null ? discount!.discountId! : null),
                  ),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Visibility(
                visible: discount != null ? true : false,
                child: Flexible(
                  child: Container(
                    height: 45,
                    width: double.infinity,
                    child: ElevatedButton(
                      child: Text(
                        'hapus'.tr,
                        style: GoogleFonts.droidSans(fontSize: 16),
                      ),
                      style: ElevatedButton.styleFrom(
                          elevation: 1,
                          primary: MyColor.colorRedFlatDark,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25))),
                      onPressed: () {
                        showDialogQuestion(
                            title: 'hapus'.tr,
                            message: 'apakah_anda_yakin'.tr + ' ?',
                            clickYes: () {
                              Get.back();
                              controller.deleteDiscount(discount!.discountId!);
                            });
                      },
                    ),
                  ),
                ),
              ),
            ],
          )),
    ));
  }
}
