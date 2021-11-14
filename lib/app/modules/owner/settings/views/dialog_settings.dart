import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:warmi/app/data/models/type_order/type_order.dart';
import 'package:warmi/app/modules/owner/settings/controllers/employees_controller.dart';
import 'package:warmi/app/modules/owner/settings/controllers/product_category_controller.dart';
import 'package:warmi/app/modules/owner/settings/controllers/setting_controller.dart';
import 'package:warmi/app/modules/owner/settings/controllers/type_order_controller.dart';
import 'package:warmi/app/modules/wigets/layouts/dialog/dialog_loading.dart';
import 'package:warmi/app/modules/wigets/layouts/general_button.dart';
import 'package:warmi/app/modules/wigets/layouts/general_text_input.dart';
import 'package:warmi/app/modules/wigets/layouts/settings/menu_action_button.dart';
import 'package:warmi/core/globals/global_color.dart';
import 'package:warmi/core/globals/global_string.dart';

//bottomsheet about me
Future<dynamic> dialogBottomAboutMe({required String version}) {
  return Get.bottomSheet(
      Container(
        height: 300,
        width: double.infinity,
        decoration: BoxDecoration(
            color: MyColor.colorGrey,
            borderRadius:
                BorderRadius.only(topLeft: Radius.circular(25), topRight: Radius.circular(25))),
        child: ListView(
          physics: ClampingScrollPhysics(),
          padding: EdgeInsets.all(MyString.DEFAULT_PADDING),
          children: [
            MenuActionButton(
              onClick: () {},
              statusIcon: true,
              trailing: false,
              axisSpacing: true,
              icon: "assets/icons/info.png",
              textButton: "Versi Aplikasi",
              subtitle: true,
              textSubtitle: version,
              borderRadius: 10,
              sizeIcon: 35,
            ),
            MenuActionButton(
              onClick: () {},
              statusIcon: true,
              trailing: false,
              axisSpacing: true,
              icon: "assets/icons/privacy_policy.png",
              textButton: "Kebijakan Privasi",
              subtitle: true,
              textSubtitle: 'Baca kebijakan Privasi yang berlaku di Warmi',
              borderRadius: 10,
              sizeIcon: 35,
            ),
            MenuActionButton(
              onClick: () {},
              statusIcon: true,
              trailing: false,
              axisSpacing: true,
              icon: "assets/icons/privacy_policy.png",
              textButton: "Syarat & Ketentuan",
              subtitle: true,
              textSubtitle: 'Baca Syarat Ketentuan yang berlaku di Warmi',
              borderRadius: 10,
              sizeIcon: 35,
            ),
          ],
        ),
      ),
      isScrollControlled: true,
      elevation: 3);
}

//bottomsheet call me
Future<dynamic> dialogBottomCallMe() {
  var settingC=Get.find<SettingController>();
  return Get.bottomSheet(
      Container(
        height: 380,
        width: double.infinity,
        decoration: BoxDecoration(
            color: MyColor.colorGrey,
            borderRadius:
                BorderRadius.only(topLeft: Radius.circular(25), topRight: Radius.circular(25))),
        child: ListView(
          physics: ClampingScrollPhysics(),
          padding: EdgeInsets.all(MyString.DEFAULT_PADDING),
          children: [
            MenuActionButton(
              onClick: () => settingC.launchWhatsApp(),
              statusIcon: true,
              trailing: false,
              axisSpacing: true,
              icon: "assets/icons/whatspp.png",
              textButton: "Whatsapp",
              subtitle: true,
              textSubtitle: "0856-2427-7920",
              borderRadius: 10,
              sizeIcon: 35,
            ),
            MenuActionButton(
              onClick: () => settingC.launchCall(),
              statusIcon: true,
              trailing: false,
              axisSpacing: true,
              icon: "assets/icons/call.png",
              textButton: 'nomor_telp'.tr,
              subtitle: true,
              textSubtitle: '0856-2427-7920',
              borderRadius: 10,
              sizeIcon: 35,
            ),
            MenuActionButton(
              onClick: () => settingC.launchEmail(),
              statusIcon: true,
              trailing: false,
              axisSpacing: true,
              icon: "assets/icons/email_box.png",
              textButton: "Email",
              subtitle: true,
              textSubtitle: 'emailmudahkan@gmail.com',
              borderRadius: 10,
              sizeIcon: 35,
            ),
            MenuActionButton(
              onClick: () => settingC.launchWebsite(),
              statusIcon: true,
              trailing: false,
              axisSpacing: true,
              icon: "assets/icons/internet.png",
              textButton: "Website",
              subtitle: true,
              textSubtitle: 'mudahkan.com',
              borderRadius: 10,
              sizeIcon: 35,
            ),
          ],
        ),
      ),
      isScrollControlled: true,
      elevation: 3);
}

//bottomsheet add cateogry product
Future<dynamic> dialogBottomAddCategoryProduct() {
  var categoryC=Get.find<ProductCategoryController>();
  return Get.bottomSheet(
      Container(
        height: 300,
        width: double.infinity,
        decoration: BoxDecoration(
            color: MyColor.colorGrey,
            borderRadius:
                BorderRadius.only(topLeft: Radius.circular(25), topRight: Radius.circular(25))),
        child: Padding(
          padding: EdgeInsets.all(MyString.DEFAULT_PADDING),
          child: Column(
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
                controller: categoryC.nameCategoryProductC,
                  labelTextInputBox: 'Nama Kategori', descTextInputBox: 'Masukan Kategori Produk'),
              Spacer(),
              GeneralButton(label: 'simpan'.tr, onPressed: () => categoryC.createOrUpdateCategoryProductDataSource())
            ],
          ),
        ),
      ),
      isScrollControlled: true,
      elevation: 3);
}

//bottomsheet add type order
Future<dynamic> dialogBottomAddTypeOrder({TypeOrder? data}) {
  var typeOrderC = Get.find<TypeOrderController>();
  data==null ? null  : typeOrderC.nameTypeOrderC.text = data.orderTypeName!;
  return Get.bottomSheet(
      Container(
        height: 300,
        width: double.infinity,
        decoration: BoxDecoration(
            color: MyColor.colorGrey,
            borderRadius:
                BorderRadius.only(topLeft: Radius.circular(25), topRight: Radius.circular(25))),
        child: Padding(
          padding: EdgeInsets.all(MyString.DEFAULT_PADDING),
          child: Column(
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
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.done,
                  controller: typeOrderC.nameTypeOrderC,
                  labelTextInputBox: 'Tipe Pesanan',
                  descTextInputBox: 'masukkan_nama_tipe_pesanan'.tr),
              Spacer(),
              GeneralButton(
                  label: 'simpan'.tr,
                  onPressed: () => typeOrderC.createOrUpdateTypeOrderDataSource("${data?.orderTypeId.toString()}"))
            ],
          ),
        ),
      ),
      isScrollControlled: true,
      elevation: 3);
}

//bottomsheet add employees cahsier
// Future<dynamic> dialogBottomAddEmployees() {
//   var controller=Get.find<EmployeesController>();
//   return Get.bottomSheet(
//       Container(
//         height: 500,
//         width: double.infinity,
//         decoration: BoxDecoration(
//             color: MyColor.colorGrey,
//             borderRadius:
//                 BorderRadius.only(topLeft: Radius.circular(25), topRight: Radius.circular(25))),
//         child: Padding(
//           padding: EdgeInsets.all(MyString.DEFAULT_PADDING),
//           child: Column(
//             children: [
//               Align(
//                 alignment: Alignment.topCenter,
//                 child: Container(
//                   margin: EdgeInsets.symmetric(vertical: 8),
//                   height: 5.0,
//                   width: 70.0,
//                   decoration: BoxDecoration(
//                       color: Colors.grey[400], borderRadius: BorderRadius.circular(10.0)),
//                 ),
//               ),
//               SizedBox(
//                 height: 20,
//               ),
//               GeneralTextInput(
//                 controller: controller.,
//                   textInputAction: TextInputAction.next,
//                   keyboardType: TextInputType.visiblePassword,
//                   labelTextInputBox: 'Nama',
//                   descTextInputBox: 'Masukan Nama Karyawan'),
//               GeneralTextInput(
//                   textInputAction: TextInputAction.next,
//                   keyboardType: TextInputType.phone,
//                   labelTextInputBox: 'Nomor Hanphone',
//                   descTextInputBox: 'Masukan Nomor Hanphone'),
//               GeneralTextInput(
//                   textInputAction: TextInputAction.done,
//                   keyboardType: TextInputType.visiblePassword,
//                   labelTextInputBox: 'Pin',
//                   descTextInputBox: 'Masukan Pin Masuk'),
//               Spacer(),
//               GeneralButton(label: 'Simpan', onPressed: () {})
//             ],
//           ),
//         ),
//       ),
//       isScrollControlled: true,
//       elevation: 3);
// }

