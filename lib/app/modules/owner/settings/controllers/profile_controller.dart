import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:warmi/app/data/datalocal/session/auth_session_manager.dart';
import 'package:warmi/app/data/datasource/auth/auth_remote_data_source.dart';
import 'package:warmi/app/modules/navigation/controllers/navigation_controller.dart';
import 'package:warmi/app/modules/wigets/layouts/dialog/dialog_loading.dart';
import 'package:warmi/app/modules/wigets/layouts/dialog/dialog_snackbar.dart';
import 'package:warmi/core/utils/enum.dart';

class ProfileController extends GetxController {
  TextEditingController nameC = TextEditingController();
  TextEditingController emailC = TextEditingController();
  TextEditingController phoneNumberC = TextEditingController();
  AuthSessionManager auth = AuthSessionManager();

  @override
  void onInit() {
    nameC.text = auth.userFullName;
    emailC.text = auth.userEmail;
    phoneNumberC.text = auth.userNoHp;
    super.onInit();
  }

  void updateUser() async {
    if (nameC.value.text.isEmpty || phoneNumberC.value.text.isEmpty) {
      showSnackBar(snackBarType: SnackBarType.INFO, message: "Kolom harus Diisi", title: 'pelanggan'.tr);
      return;
    }
    loadingBuilder();
    await AuthRemoteDataSource()
        .updateUser(
      name: nameC.text,
      email: emailC.text,
      phoneNumber: phoneNumberC.text,
    )
        .then((value) {
      if (value.status) {
        Get.back();
        Get.back();
        showSnackBar(snackBarType: SnackBarType.SUCCESS, title: 'Profile', message: 'Data Berhasil Disimpan');
        var con=Get.find<NavigationController>();
        con.getSession();
        con.auth.refresh();
      } else {
        showSnackBar(snackBarType: SnackBarType.ERROR, title: 'Profile', message: "${value.message}");
      }
    });
  }
}
