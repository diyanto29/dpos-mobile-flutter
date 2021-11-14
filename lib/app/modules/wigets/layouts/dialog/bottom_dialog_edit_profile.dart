
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:warmi/app/modules/owner/settings/controllers/profile_controller.dart';
import 'package:warmi/app/modules/transaction/controllers/customer_controller.dart';
import 'package:warmi/app/modules/transaction/controllers/transaction_controller.dart';
import 'package:warmi/app/modules/wigets/layouts/general_button.dart';
import 'package:warmi/app/modules/wigets/layouts/general_text_input.dart';
import 'package:warmi/core/globals/global_color.dart';
import 'package:warmi/core/globals/global_string.dart';

class BottomDialogEditProfile extends StatelessWidget {
  const BottomDialogEditProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<ProfileController>();
    return DraggableScrollableSheet(
      expand: false,
      minChildSize: 0.6,
      initialChildSize: 0.6,
      builder: (context, scrollController) {
        return Container(
          padding: EdgeInsets.all(MyString.DEFAULT_PADDING),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20.0),
                topRight: Radius.circular(20.0),
              ),
              color: MyColor.colorWhite),
          child: ListView(
            controller: scrollController,
            physics: ClampingScrollPhysics(),
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: Container(
                  margin: EdgeInsets.symmetric(vertical: 8),
                  height: 5.0,
                  width: 70.0,
                  decoration: BoxDecoration(
                      color: Colors.grey[400], borderRadius: BorderRadius.circular(10.0)),
                ),
              ),
             GeneralTextInput(
                 controller: controller.nameC,
                 keyboardType: TextInputType.visiblePassword,
                 labelTextInputBox: 'nama_lengkap'.tr, descTextInputBox: 'nama_lengkap'.tr),
             GeneralTextInput(
                 controller: controller.phoneNumberC,
                 textInputAction: TextInputAction.next,
                 keyboardType: TextInputType.phone,
                 labelTextInputBox: 'nomor_telp'.tr, descTextInputBox: 'nomor_telp'.tr),
             GeneralTextInput(
                 controller: controller.emailC,
                 labelTextInputBox: 'Email (Opsional)', descTextInputBox: 'Email Pengguna'),
              SizedBox(height: 10,),
              GeneralButton(
                  label: 'simpan'.tr, onPressed: ()=> controller.updateUser())
            ],
          ),
        );
      },
    );
  }
}
