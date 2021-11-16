import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:warmi/app/modules/wigets/layouts/dialog/bottom_dialog_register.dart';
import 'package:warmi/app/modules/wigets/layouts/general_button.dart';
import 'package:warmi/app/modules/wigets/layouts/general_text_input.dart';
import 'package:warmi/core/globals/global_color.dart';
import 'package:warmi/core/globals/global_string.dart';
import 'package:warmi/core/utils/thema.dart';

import '../controllers/register_controller.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class RegisterView extends GetWidget<RegisterController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
              top: 0,
              left: 0,
              child: Image.asset(
                "assets/food_stick.png",
                height: 20.h,
              )),
          Positioned(
              bottom: -10,
              right: -13.w,
              child: Transform.rotate(
                  angle: 11,
                  child: Image.asset(
                    "assets/food_steak2.png",
                    height: 18.h,
                  ))),
          Positioned(
              top: 5.h,
              bottom: MyString.DEFAULT_PADDING,
              left: MyString.DEFAULT_PADDING,
              right: MyString.DEFAULT_PADDING,
              child: ListView(
                children: [
                  Center(
                    child: Text(
                      "Daftar Akun Baru",
                      style: blackTextTitle.copyWith(fontSize: 20.sp),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Center(
                    child: Text(
                      "Silakan Isi Data dari anda!",
                      style: blackTextFont.copyWith(
                          fontSize: 14.sp,
                          fontStyle: FontStyle.italic,
                          color: MyColor.colorPureBlack),
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Center(
                    child: Column(
                      children: [
                        GeneralTextInput(
                          controller: controller.fullNameC,
                            labelTextInputBox: 'nama_lengkap'.tr, descTextInputBox: 'contoh'.tr + " Diyanto"),
                        GeneralTextInput(
                          controller: controller.emailC,
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.emailAddress,
                            labelTextInputBox: "Email (Opsional)",
                            descTextInputBox: 'contoh'.tr + " example@gmail.com"),
                        GeneralTextInput(
                          controller: controller.noHpC,
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.phone,
                            labelTextInputBox: 'nomor_telp'.tr,
                            descTextInputBox: 'contoh'.tr + " 085624277920"),
                        Obx(() {
                          return Theme(
                            data: ThemeData(primaryColor: MyColor.colorOrangeDark),
                            child: TextFormField(
                              controller: controller.passwordC,
                              obscureText: controller.obscurtText.value,
                              keyboardType: TextInputType.visiblePassword,
                              textInputAction: TextInputAction.go,
                              decoration: InputDecoration(
                                  labelText: "Kata Sandi",
                                  focusColor: MyColor.colorPrimary,
                                  focusedBorder: OutlineInputBorder(
                                    borderSide:
                                        const BorderSide(color: MyColor.colorPrimary, width: 2.0),
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  border: OutlineInputBorder(
                                    borderSide:
                                        const BorderSide(color: MyColor.colorPrimary, width: 2.0),
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  suffixIcon: IconButton(
                                    onPressed: () {
                                      controller.changeObscureText();
                                    },
                                    icon: controller.obscurtText.value
                                        ? Icon(Icons.visibility_off)
                                        : Icon(Icons.visibility),
                                  ),
                                  prefixIcon: Icon(Icons.lock)),
                            ),
                          );
                        }),
                        SizedBox(
                          height: 8.h,
                        ),
                        GeneralButton(
                            label: "Daftar Sekarang", onPressed: () => showDialogRegister())
                      ],
                    ),
                  )
                ],
              ))
        ],
      ),
    );
  }

  void showDialogRegister() {
    Get.bottomSheet(
      BottomDialogRegister(
        title: MyString.dialogTitleRegister,
        data: null,
        callback: (_choosed) {
          Get.back();
        },
      ),
      isScrollControlled: true
    );
  }
}
