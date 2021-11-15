import 'package:flutter/material.dart';
import 'package:warmi/app/modules/owner/settings/controllers/tax_service_controller.dart';
import 'package:warmi/app/modules/wigets/layouts/general_button.dart';
import 'package:warmi/app/modules/wigets/layouts/general_text_input.dart';
import 'package:warmi/core/globals/global_color.dart';
import 'package:warmi/core/utils/enum.dart';
import 'package:warmi/core/utils/thema.dart';
import 'package:get/get.dart';

class TaxAndServiceView extends GetWidget<TaxServiceController> {
  const TaxAndServiceView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyColor.colorPrimary,
        title: Text(
          'tax_service'.tr,
          style: whiteTextTitle,
        ),
      ),
      body: Obx(() {
        return Stack(
          children: [
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: GeneralButton(
                    label: 'simpan'.tr,
                    onPressed: () {
                      print(controller.switchTax.value);
                      print(controller.taxServiceEnum.value.toString());
                    }),
              ),
            ),
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SwitchListTile(
                        value: controller.switchTax.value,
                        activeColor: MyColor.colorPrimary,
                        title: Text(
                          'pajak'.tr,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                        onChanged: (value) {
                          controller.switchTax.value = value;
                        }),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Column(
                        children: [
                          GeneralTextInput(
                              labelTextInputBox: 'nilai_pajak'.tr + ' (%)',
                              descTextInputBox: 'desc_nilai_pajak'.tr)
                        ],
                      ),
                    ),
                    SwitchListTile(
                        value: controller.switchService.value,
                        activeColor: MyColor.colorPrimary,
                        title: Text(
                          'biaya_layanan'.tr,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                        onChanged: (value) {
                          controller.switchService.value = value;
                        }),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Column(
                        children: [
                          GeneralTextInput(
                              labelTextInputBox: 'service_charge'.tr + ' (%)',
                              descTextInputBox: 'desc_service_charge'.tr)
                        ],
                      ),
                    ),
                    Divider(),
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        'pengaturan_perhitungan'.tr,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    RadioListTile(
                      activeColor: MyColor.colorPrimary,
                      title: Text(
                        'harga_tidak_termasuk_pajak'.tr,
                        style: TextStyle(fontSize: 14),
                      ),
                      value: TaxServiceEnum.priceWithoutTaxService,
                      groupValue: controller.taxServiceEnum.value,
                      onChanged: (TaxServiceEnum? value) {
                        controller.taxServiceEnum(value);
                      },
                    ),
                    RadioListTile(
                      activeColor: MyColor.colorPrimary,
                      title: Text(
                        'harga_termasuk_pajak'.tr,
                        style: TextStyle(fontSize: 14),
                      ),
                      value: TaxServiceEnum.priceWithTaxService,
                      groupValue: controller.taxServiceEnum.value,
                      onChanged: (TaxServiceEnum? value) {
                        controller.taxServiceEnum(value);
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}
