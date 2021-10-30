import 'package:custom_navigation_bar/custom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';

import 'package:get/get.dart';
import 'package:warmi/core/globals/global_color.dart';
import 'package:warmi/core/globals/global_string.dart';

import '../controllers/navigation_controller.dart';

class NavigationView extends GetWidget<NavigationController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Obx(() {
        return IndexedStack(
        index: controller.indexNavigation.value,
          children: controller.pageList,
        );
      }),
      bottomNavigationBar: Obx(() {
        return CustomNavigationBar(
          iconSize: 30.0,
          selectedColor: MyColor.colorPrimary,
          strokeColor: Color(0x30040307),
          unSelectedColor: Color(0xffacacac),
          backgroundColor: Colors.white,
          elevation: 10,
          items: [
            CustomNavigationBarItem(
              icon: Icon(IconlyBold.home),
              title: Text(MyString.homeTitleBottomNavBar),
            ),
            CustomNavigationBarItem(
              icon: Icon(IconlyBold.buy),
              title: Text(MyString.orderTitleBottomNavBar),
            ),

            CustomNavigationBarItem(
              icon: Icon(IconlyBold.document),
              title: Text(MyString.reportTitleBottomNavBar),
            ),
            CustomNavigationBarItem(
              icon: Icon(IconlyBold.setting),
              title: Text(MyString.profileTitleBottomNavBar),
            ),
          ],
          currentIndex: controller.indexNavigation.value,
          onTap: (index) {
            controller.changeIndexNavigation(index);
          },
        );
      }),
    );
  }
}
