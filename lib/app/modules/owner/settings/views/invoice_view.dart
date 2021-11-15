import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:warmi/app/modules/owner/settings/controllers/invoce_controller.dart';
import 'package:warmi/app/modules/wigets/layouts/general_text_input.dart';
import 'package:warmi/core/globals/global_color.dart';
import 'package:warmi/core/utils/thema.dart';

class InvoiceView extends GetWidget<InvoiceController> {
  const InvoiceView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColor.colorBackground,
      appBar: AppBar(
        backgroundColor: MyColor.colorPrimary,
        title: Text(
          'struk_pembelian'.tr,
          style: whiteTextTitle,
        ),
      ),
      body: Obx(() {
        return ListView(
          padding: const EdgeInsets.all(20),
          children: [
            Text(
              "Header",
              style: blackTextTitle.copyWith(fontSize: 20),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Flexible(
                    child: Text(
                  'tampilkan_logo_bisnis_anda'.tr,
                  style: blackTextTitle,
                )),
                Flexible(
                    child: Switch.adaptive(
                  value: controller.logo.value,
                  onChanged: (v) {
                    controller.logo(v);
                  },
                  activeColor: MyColor.colorPrimary,
                )),
              ],
            ),
            Divider(
              thickness: 0.5,
            ),
            SizedBox(
              height: 25,
            ),
            Text(
              "Footer",
              style: blackTextTitle.copyWith(fontSize: 20),
            ),
            SizedBox(
              height: 10,
            ),
            GeneralTextInput(
              controller: controller.controllerFooter.value,
              labelTextInputBox: '',
              descTextInputBox: 'masukkan_catatan_kaki'.tr,
              maxLines: 5,
              borderRadius: 10,
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Flexible(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'tampilkan_logo_dpos'.tr,
                      style: blackTextTitle,
                    ),
                    Text(
                      '(' + 'hanya_bisa_dimatikan_oleh_member_premium'.tr + ')',
                      style: blackTextFont,
                    )
                  ],
                )),
                Flexible(
                    child: Switch.adaptive(
                  value: controller.logoDpos.value,
                  onChanged: (v) {},
                  activeColor: MyColor.colorPrimary,
                )),
              ],
            ),
          ],
        );
      }),
      bottomNavigationBar: Container(
          margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          height: 50,
          width: double.infinity,
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
            onPressed: () {
              controller.storeInvoice();
            },
          )),
    );
  }
}
