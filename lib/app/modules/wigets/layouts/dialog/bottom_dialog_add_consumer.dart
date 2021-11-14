
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:warmi/app/modules/transaction/controllers/customer_controller.dart';
import 'package:warmi/app/modules/transaction/controllers/transaction_controller.dart';
import 'package:warmi/app/modules/wigets/layouts/general_button.dart';
import 'package:warmi/app/modules/wigets/layouts/general_text_input.dart';
import 'package:warmi/core/globals/global_color.dart';
import 'package:warmi/core/globals/global_string.dart';

class BottomDialogAddCustomer extends StatelessWidget {
  const BottomDialogAddCustomer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<CustomerController>();
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
                 labelTextInputBox: 'Nama Pelanggan', descTextInputBox: 'Masukan Nama Pelanggan'),
             GeneralTextInput(
                 controller: controller.phoneNumberC,
                 textInputAction: TextInputAction.next,
                 keyboardType: TextInputType.phone,
                 labelTextInputBox: 'Nomor Whatsapp', descTextInputBox: 'Masukan Nomor Whatsapp'),
             GeneralTextInput(
                 controller: controller.emailC,
                 labelTextInputBox: 'Email (Opsional)', descTextInputBox: 'Masukan Email Pelanggan'),
             GeneralTextInput(
                 controller: controller.addressC,
                 labelTextInputBox: 'Alamat', descTextInputBox: 'Alamat Pelanggan'),
              SizedBox(height: 10,),
              GeneralButton(
                  label: 'simpan'.tr, onPressed: ()=> controller.createCustomer())
            ],
          ),
        );
      },
    );
  }
}
