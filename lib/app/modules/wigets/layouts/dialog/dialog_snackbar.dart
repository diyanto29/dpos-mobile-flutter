import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:warmi/core/globals/global_color.dart';
import 'package:warmi/core/utils/enum.dart';




 void showSnackBar({String? title,String? message, required SnackBarType snackBarType}){
  switch(snackBarType){
    case SnackBarType.SUCCESS:
        return Get.snackbar("$title", "$message",
            backgroundColor: MyColor.colorGreen,
            colorText: MyColor.colorWhite,
            barBlur: 3,
        icon: Icon(Icons.check_circle,color: MyColor.colorWhite,),
        snackStyle: SnackStyle.FLOATING,
        );
    case SnackBarType.ERROR:
      return Get.snackbar("$title", "$message",
        backgroundColor: Colors.red,
        colorText: MyColor.colorWhite,
        barBlur: 3,
        icon: Icon(Icons.error,color: MyColor.colorWhite,),
        snackStyle: SnackStyle.FLOATING,
      );
    case SnackBarType.INFO:
      return Get.snackbar("$title", "$message",
        backgroundColor: MyColor.colorBlue,
        colorText: MyColor.colorWhite,
        barBlur: 3,
        icon: Icon(Icons.info,color: MyColor.colorWhite,),
        snackStyle: SnackStyle.FLOATING,
      );
    case SnackBarType.WARNING:
      return Get.snackbar("$title", "$message",
        backgroundColor: MyColor.colorYellow,
        colorText: MyColor.colorWhite,
        barBlur: 3,
        icon: Icon(Icons.warning_rounded,color: MyColor.colorWhite,),
        snackStyle: SnackStyle.FLOATING,
      );


    default:
      return Get.snackbar("$title", "$message");
  }

}
