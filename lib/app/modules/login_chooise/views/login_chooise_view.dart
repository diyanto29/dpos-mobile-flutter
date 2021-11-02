import 'package:flutter/material.dart';
import 'package:flutter_statusbarcolor_ns/flutter_statusbarcolor_ns.dart';

import 'package:get/get.dart';
import 'package:warmi/app/routes/app_pages.dart';
import 'package:warmi/core/globals/global_color.dart';
import 'package:warmi/core/globals/global_string.dart';
import 'package:warmi/core/utils/thema.dart';

import '../controllers/login_chooise_controller.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class LoginChooiseView extends GetWidget<LoginChooiseController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MediaQuery.removePadding(
        removeTop: true,
        removeLeft: true,
        removeRight: true,
        context: context,
        child: ListView(
          children: [
            Image.asset(
              "assets/food_login.png",
              height: Get.height * 0.45,
              fit: BoxFit.fitWidth,
            ),
            Center(
              child: Text(
                "D-POS",
                style: blackTextTitle.copyWith(fontSize: 25.sp),
              ),
            ),
            SizedBox(
              height: 2,
            ),
            Center(
              child: Text(
                "Selamat Datang!",
                style: blackTextFont.copyWith(fontSize: 15.sp, fontStyle: FontStyle.italic, color: MyColor.colorPureBlack),
              ),
            ),
            SizedBox(
              height: Device.orientation == Orientation.portrait ? 10.h : 2.w,
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Container(
                      height: Device.orientation == Orientation.portrait ? 7.h : 5.w,
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.0)),
                      width: double.infinity,
                      child: ElevatedButton(onPressed: () => Get.toNamed(Routes.LOGIN), style: ElevatedButton.styleFrom(primary: MyColor.colorPrimary, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0))), child: Text("Masuk Sbg. Pemilik"))),
                  SizedBox(
                    height: 3.h,
                  ),
                  Container(
                      height: Device.orientation == Orientation.portrait ? 7.h : 5.w,
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.0)),
                      width: double.infinity,
                      child: ElevatedButton(onPressed: () => Get.toNamed(Routes.LOGIN_EMPLOYEE), style: ElevatedButton.styleFrom(primary: MyColor.colorPrimary, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0))), child: Text("Masuk Sbg. Kasir"))),
                ],
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: Container(
        height: 50,
        alignment: Alignment.center,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Buat akun baru",
              style: blackTextFont,
            ),
            TextButton(
                onPressed: () => Get.toNamed(Routes.REGISTER),
                child: Text(
                  "disini",
                  style: blackTextFont.copyWith(color: MyColor.colorBlue),
                ))
          ],
        ),
      ),
    );
  }
}
