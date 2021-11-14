import 'package:flutter/material.dart';
import 'package:warmi/app/modules/owner/settings/controllers/language_setting_controller.dart';
import 'package:warmi/app/modules/wigets/layouts/general_button.dart';
import 'package:warmi/core/globals/global_color.dart';
import 'package:warmi/core/utils/enum.dart';
import 'package:warmi/core/utils/thema.dart';
import 'package:get/get.dart';

class LanguageView extends GetWidget<LanguageSettingController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: MyColor.colorBackground,
        appBar: AppBar(
          backgroundColor: MyColor.colorPrimary,
          title: Text(
            'pengaturan_bahasa'.tr,
            style: whiteTextTitle,
          ),
        ),
        body: Obx(() {
          return Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: <Widget>[
                RadioListTile(
                  title: const Text('Indonesia'),
                  value: LanguageEnum.indonesia,
                  groupValue: controller.languageEnum.value,
                  onChanged: (LanguageEnum? value) {
                    controller.languageEnum(value);
                    controller.setLanguage();
                  },
                ),
                RadioListTile(
                  title: const Text('English'),
                  value: LanguageEnum.english,
                  groupValue: controller.languageEnum.value,
                  onChanged: (LanguageEnum? value) {
                    controller.languageEnum(value);
                    controller.setLanguage();
                  },
                ),
              ],
            ),
          );
        }));
  }
}
