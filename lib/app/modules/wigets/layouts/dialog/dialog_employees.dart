import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:warmi/app/data/models/employes/employes_model.dart';
import 'package:warmi/app/modules/owner/settings/controllers/employees_controller.dart';
import 'package:warmi/core/globals/global_color.dart';
import 'package:warmi/core/globals/global_string.dart';

import '../general_button.dart';
import '../general_text_input.dart';

class DialogEmployees extends GetWidget<EmployeesController> {
  final String? employeesID;
  final EmployeData? employeeData;
  const DialogEmployees({Key? key,this.employeesID,this.employeeData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if(employeeData!=null) {
      controller.nameC.value.text=employeeData!.name!;
      controller.phoneNumberC.value.text=employeeData!.phonenumber!;
      controller.pinC.value.text="******";
      controller.addressC.value.text=employeeData!.address.toString();
    }
    return DraggableScrollableSheet(
      expand: false,
      minChildSize: 0.6,
      initialChildSize: 0.6,
      builder: (context, scrollController) {
        return Obx(() {
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
                SizedBox(
                  height: 20,
                ),
                GeneralTextInput(
                    controller: controller.nameC.value,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.visiblePassword,
                    labelTextInputBox: 'Nama',
                    descTextInputBox: 'Masukan Nama Karyawan'),
                GeneralTextInput(
                    controller: controller.phoneNumberC.value,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.phone,
                    labelTextInputBox: 'Nomor Hanphone',
                    descTextInputBox: 'Masukan Nomor Hanphone'),
                GeneralTextInput(
                    controller: controller.pinC.value,
                    textInputAction: TextInputAction.done,
                    keyboardType: TextInputType.number,
                    labelTextInputBox: 'Pin',
                    descTextInputBox: 'Masukan Pin Masuk'),
                GeneralTextInput(
                    controller: controller.addressC.value,
                    textInputAction: TextInputAction.done,
                    keyboardType: TextInputType.visiblePassword,
                    labelTextInputBox: 'Alamat',
                    descTextInputBox: 'Masukan Alamat Karyawan Anda'),

                GeneralButton(label: 'Simpan', onPressed: () => controller.storeEmployees(name: controller.nameC.value.text,
                pin: controller.pinC.value.text,phoneNumber: controller.phoneNumberC.value.text,employeesID: employeesID))
              ],
            ),
          );
        });
      },
    );
  }
}
