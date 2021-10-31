import 'package:flutter/material.dart';
import 'package:flutter_statusbarcolor_ns/flutter_statusbarcolor_ns.dart';

import 'package:get/get.dart';
import 'package:warmi/core/globals/global_color.dart';

import 'package:warmi/core/globals/global_string.dart';

import '../controllers/splash_controller.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class SplashView extends GetWidget<SplashController> {
  @override
  Widget build(BuildContext context) {
    FlutterStatusbarcolor.setStatusBarColor(Colors.transparent);
    return Scaffold(
      backgroundColor: Colors.white,
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
          Center(
            child: Image.asset(
              "assets/d-post.png",
              width: 20.w,
              fit: BoxFit.fitWidth,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom:MyString.DEFAULT_PADDING+20),
            child: Align(
                alignment: Alignment.bottomCenter,
                child: CircularProgressIndicator(
                  color: MyColor.colorPrimary,
                  // valueColor: Animation<>,
                )),
          )
        ],
      ),
    );
  }
}
