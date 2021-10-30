import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:warmi/app/modules/owner/home/controllers/home_controller.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class CarouselSliderCustom extends StatelessWidget {
  const CarouselSliderCustom({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.isRegistered<HomeController>()
        ? Get.find<HomeController>() :Get.put(HomeController());
    return Obx(() {
      return Column(
        children: [
          CarouselSlider(
            items: controller.imageSliders
                .map((element) => Container(
                      width: 94.w,
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
                      child: ClipRRect(borderRadius: BorderRadius.circular(10), child: element),
                    ))
                .toList(),
            carouselController: controller.carouselController,
            options: CarouselOptions(
                height: 150.0,
                autoPlay: true,
                enlargeCenterPage: true,
                viewportFraction: 1,
                onPageChanged: (index, reason) {
                  controller.currentSlider(index);
                }),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: controller.imageSliders.asMap().entries.map((entry) {
                return GestureDetector(
                  onTap: () => controller.carouselController.animateToPage(entry.key),
                  child: Container(
                    width: 8.0,
                    height: 8.0,
                    margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 2.0),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.black
                            .withOpacity(controller.currentSlider == entry.key ? 1 : 0.4)),
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      );
    });
  }
}
