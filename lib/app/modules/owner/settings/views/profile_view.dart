import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:warmi/app/modules/navigation/controllers/navigation_controller.dart';
import 'package:warmi/app/modules/owner/settings/controllers/profile_controller.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:recase/recase.dart';
import 'package:warmi/app/modules/wigets/layouts/dialog/bottom_dialog_edit_profile.dart';
import 'package:warmi/app/modules/wigets/layouts/general_button.dart';
import 'package:warmi/app/modules/wigets/layouts/settings/menu_action_button.dart';
import 'package:warmi/app/modules/wigets/package/corolize_text_avatar/src/colorized_text_avatar.dart';
import 'package:warmi/app/modules/wigets/package/corolize_text_avatar/src/constants/enums.dart';
import 'package:warmi/core/globals/global_color.dart';

class ProfileView extends GetWidget<ProfileController> {
  const ProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var navC = Get.find<NavigationController>();
    return Scaffold(
      backgroundColor: MyColor.colorBackground,
      body: Obx(() {
        return Stack(
          children: [
            Positioned(
              top: 10.h,
              left: 0,
              right: 0,
              child: Align(
                alignment: Alignment.topCenter,
                child: TextAvatar(
                  shape: Shape.Circular,
                  size: 14.h,
                  fontSize: 28.sp,
                  fontWeight: FontWeight.w600,
                  upperCase: true,
                  numberLetters: 2,
                  text: "${navC.auth.value.userFullName}",
                ),
              ),
            ),
            Positioned(
                top: 28.h,
                right: 0,
                left: 0,
                bottom: 0,
                child: ListView(
                  padding: const EdgeInsets.all(20),
                  children: [
                    MenuActionButton(
                      onClick: () {},
                      statusIcon: true,
                      icon: "assets/icons/profile.png",
                      textButton: "Nama Lengkap",
                      sizeIcon: 35,
                      subtitle: true,
                      textSubtitle: "${navC.auth.value.userFullName}",
                      trailing: false,
                    ),

                    MenuActionButton(
                      onClick: () {},
                      statusIcon: true,
                      icon: "assets/icons/email_box.png",
                      textButton: "Email",
                      sizeIcon: 35,
                      subtitle: true,
                      textSubtitle: "${navC.auth.value.userEmail.isNotEmpty ? navC.auth.value.userEmail : '-'}",
                      trailing: false,
                    ),
                    MenuActionButton(
                      onClick: () {},
                      statusIcon: true,
                      icon: "assets/icons/call.png",
                      textButton: "Nomor Telp",
                      sizeIcon: 35,
                      subtitle: true,
                      textSubtitle: "${navC.auth.value.userNoHp.isNotEmpty ? navC.auth.value.userNoHp : '-'}",
                      trailing: false,
                    ),
                  ],
                ))

          ],
        );
      }),
      bottomNavigationBar: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: GeneralButton(label: 'Edit Profile', onPressed: () => showBottomSheetCustomer(),),
      ),
    );
  }

  Future showBottomSheetCustomer() {
    return Get.bottomSheet(BottomDialogEditProfile(), isScrollControlled: true, elevation: 3);
  }
}
