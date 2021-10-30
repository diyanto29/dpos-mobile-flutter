import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:warmi/app/modules/history_sales/controllers/history_sales_controller.dart';

class HomeController extends GetxController{


  final RxInt currentSlider=0.obs;
  final CarouselController carouselController=CarouselController();
   var imageSliders=List<Widget>.empty().obs;
  var historySalesC = Get.isRegistered<HistorySalesController>()
      ? Get.find<HistorySalesController>() :Get.put(HistorySalesController());

   RxDouble scrollOpacity=1.0.obs;


  @override
  void onInit() {
  imageSliders.add(Image.asset("assets/Banner1.jpg",fit: BoxFit.fitWidth,width:  10000,));
  imageSliders.add(Image.asset("assets/Banner2.jpg",fit: BoxFit.fitWidth,width: 200.w,));
  imageSliders.add(Image.asset("assets/Banner3.jpg",fit :BoxFit.fitWidth,width: 200.w,));
  historySalesC.getTransaction();
  print("home");
    super.onInit();
  }




}