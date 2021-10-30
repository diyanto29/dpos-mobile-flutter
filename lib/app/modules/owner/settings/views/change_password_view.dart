import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_statusbarcolor_ns/flutter_statusbarcolor_ns.dart';
import 'package:get/get.dart';
import 'package:warmi/app/modules/owner/settings/controllers/setting_controller.dart';
import 'package:warmi/app/modules/wigets/layouts/general_button.dart';
import 'package:warmi/app/modules/wigets/layouts/general_text_input.dart';
import 'package:warmi/core/globals/global_color.dart';
import 'package:warmi/core/globals/global_string.dart';
import 'package:warmi/core/utils/thema.dart';

class ChangePasswordView extends GetWidget<SettingController> {
  @override
  Widget build(BuildContext context) {
    FlutterStatusbarcolor.setStatusBarColor(MyColor.colorPrimary);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyColor.colorPrimary,
        title: Text(
          'Ubah Kata Sandi',
          style: whiteTextTitle,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(MyString.DEFAULT_PADDING),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Membuat kata sandi membantu Anda menjaga keamanan akun D-POS",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
            SizedBox(
              height: 30,
            ),
            GeneralTextInput(
              controller: controller.passwordC.value,
                labelTextInputBox: 'Kata Sandi Baru', descTextInputBox: 'Masukan Kata Sandi Baru'),
            Spacer(),
            GeneralButton(label: 'Simpan', onPressed: ()=> controller.updatePassword())
          ],
        ),
      ),
    );
  }
}
