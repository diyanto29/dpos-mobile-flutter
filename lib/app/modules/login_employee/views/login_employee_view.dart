import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:warmi/core/globals/global_color.dart';
import 'package:warmi/core/globals/global_string.dart';
import 'package:warmi/core/utils/enum.dart';
import 'package:warmi/core/utils/thema.dart';

import '../controllers/login_employee_controller.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:responsive_sizer/responsive_sizer.dart' as rs;

class LoginEmployeeView extends GetWidget<LoginEmployeeController> {
  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(builder: (context, orientation, screenType) {
      print(orientation);
      return orientation == Orientation.portrait
          ? Scaffold(
              body: SingleChildScrollView(
              physics: ClampingScrollPhysics(),
              child: Container(
                height: Get.height,
                width: Get.width,
                child: Stack(
                  children: [
                    Positioned(
                        top: 0,
                        left: 0,
                        right: 0,
                        child: Image.asset(
                          "assets/food_login.png",
                          height: Get.height * 0.45,
                          fit: BoxFit.fitWidth,
                        )),
                    Positioned(
                        top: Get.height * 0.50,
                        left: MyString.DEFAULT_PADDING,
                        right: MyString.DEFAULT_PADDING,
                        bottom: MyString.DEFAULT_PADDING,
                        child: Column(
                          children: [
                            Text(
                              "Login",
                              style: blackTextTitle.copyWith(fontSize: 25.sp),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              "Selamat Datang Kembali!",
                              style: blackTextFont.copyWith(fontSize: 16.sp, fontStyle: FontStyle.italic, color: MyColor.colorPureBlack),
                            ),
                            SizedBox(
                              height: 5.h,
                            ),
                            Theme(
                              data: ThemeData(primaryColor: MyColor.colorPrimary),
                              child: TextFormField(
                                controller: controller.emailC,
                                keyboardType: TextInputType.emailAddress,
                                textInputAction: TextInputAction.next,
                                decoration: InputDecoration(
                                    labelText: "Email/No Handpone",
                                    focusColor: MyColor.colorPrimary,
                                    labelStyle: whiteTextFont.copyWith(color: MyColor.colorPrimary),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(color: MyColor.colorPrimary, width: 2.0),
                                      borderRadius: BorderRadius.circular(25.0),
                                    ),
                                    border: OutlineInputBorder(
                                      borderSide: const BorderSide(color: MyColor.colorPrimary, width: 2.0),
                                      borderRadius: BorderRadius.circular(25.0),
                                    ),
                                    prefixIcon: Icon(Icons.account_circle)),
                              ),
                            ),
                            SizedBox(
                              height: 4.h,
                            ),
                            Obx(() {
                              return Theme(
                                data: ThemeData(primaryColor: MyColor.colorPrimary),
                                child: TextFormField(
                                  controller: controller.passwordC,
                                  obscureText: controller.obscurtText.value,
                                  keyboardType: TextInputType.visiblePassword,
                                  textInputAction: TextInputAction.go,
                                  decoration: InputDecoration(
                                      labelText: "Kata Sandi",
                                      focusColor: MyColor.colorPrimary,
                                      labelStyle: whiteTextFont.copyWith(color: MyColor.colorPrimary),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(color: MyColor.colorPrimary, width: 2.0),
                                        borderRadius: BorderRadius.circular(25.0),
                                      ),
                                      border: OutlineInputBorder(
                                        borderSide: const BorderSide(color: MyColor.colorPrimary, width: 2.0),
                                        borderRadius: BorderRadius.circular(25.0),
                                      ),
                                      suffixIcon: IconButton(
                                        onPressed: () {
                                          controller.changeObscureText();
                                        },
                                        icon: controller.obscurtText.value ? Icon(Icons.visibility_off) : Icon(Icons.visibility),
                                      ),
                                      prefixIcon: Icon(Icons.lock)),
                                ),
                              );
                            }),
                            Spacer(),
                            Container(
                                height: 6.5.h,
                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(25.0)),
                                width: double.infinity,
                                child: ElevatedButton(onPressed: () => controller.login(), style: ElevatedButton.styleFrom(primary: MyColor.colorPrimary, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.0))), child: Text("Masuk")))
                          ],
                        )),
                    Obx(() => controller.loadingState.value == LoadingState.loading
                        ? Positioned.fill(
                            child: Container(
                            color: MyColor.colorGrey.withOpacity(0.4),
                            child: Center(
                              child: CircularProgressIndicator(
                                color: MyColor.colorPrimary,
                                strokeWidth: 5,
                              ),
                            ),
                          ))
                        : Container()),
                  ],
                ),
              ),
            ))
          : Scaffold(
              backgroundColor: Colors.white,
              body: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Flexible(
                    child: Image.asset(
                      "assets/food_login.png",
                      width: Get.width * 0.40,
                      height: Get.height,
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                  Flexible(
                      child: Padding(
                    padding: const EdgeInsets.all(MyString.DEFAULT_PADDING + 20),
                    child: SingleChildScrollView(
                      child: Container(
                        width: double.infinity,
                        height: Get.height,
                        child: Column(
                          children: [
                            Text(
                              "Login",
                              style: blackTextTitle.copyWith(fontSize: 25.sp),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              "Selamat Datang Kembali!",
                              style: blackTextFont.copyWith(fontSize: 16.sp, fontStyle: FontStyle.italic, color: MyColor.colorPureBlack),
                            ),
                            SizedBox(
                              height: 5.w,
                            ),
                            Theme(
                              data: ThemeData(primaryColor: MyColor.colorPrimary),
                              child: TextFormField(
                                controller: controller.emailC,
                                keyboardType: TextInputType.emailAddress,
                                textInputAction: TextInputAction.next,
                                decoration: InputDecoration(
                                    labelText: "Email/No Handpone",
                                    focusColor: MyColor.colorPrimary,
                                    labelStyle: whiteTextFont.copyWith(color: MyColor.colorPrimary),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(color: MyColor.colorPrimary, width: 2.0),
                                      borderRadius: BorderRadius.circular(25.0),
                                    ),
                                    border: OutlineInputBorder(
                                      borderSide: const BorderSide(color: MyColor.colorPrimary, width: 2.0),
                                      borderRadius: BorderRadius.circular(25.0),
                                    ),
                                    prefixIcon: Icon(Icons.account_circle)),
                              ),
                            ),
                            SizedBox(
                              height: 4.w,
                            ),
                            Obx(() {
                              return Theme(
                                data: ThemeData(primaryColor: MyColor.colorPrimary),
                                child: TextFormField(
                                  controller: controller.passwordC,
                                  obscureText: controller.obscurtText.value,
                                  keyboardType: TextInputType.visiblePassword,
                                  textInputAction: TextInputAction.go,
                                  decoration: InputDecoration(
                                      labelText: "Kata Sandi",
                                      focusColor: MyColor.colorPrimary,
                                      labelStyle: whiteTextFont.copyWith(color: MyColor.colorPrimary),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(color: MyColor.colorPrimary, width: 2.0),
                                        borderRadius: BorderRadius.circular(25.0),
                                      ),
                                      border: OutlineInputBorder(
                                        borderSide: const BorderSide(color: MyColor.colorPrimary, width: 2.0),
                                        borderRadius: BorderRadius.circular(25.0),
                                      ),
                                      suffixIcon: IconButton(
                                        onPressed: () {
                                          controller.changeObscureText();
                                        },
                                        icon: controller.obscurtText.value ? Icon(Icons.visibility_off) : Icon(Icons.visibility),
                                      ),
                                      prefixIcon: Icon(Icons.lock)),
                                ),
                              );
                            }),
                            SizedBox(
                              height: 10.w,
                            ),
                            Container(
                                height: 5.5.w,
                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(25.0)),
                                width: double.infinity,
                                child: ElevatedButton(onPressed: () => controller.login(), style: ElevatedButton.styleFrom(primary: MyColor.colorPrimary, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.0))), child: Text("Masuk")))
                          ],
                        ),
                      ),
                    ),
                  ))
                ],
              ));
    });
  }
}
