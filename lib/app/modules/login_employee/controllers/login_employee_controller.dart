import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:warmi/app/data/datasource/auth/auth_remote_data_source.dart';
import 'package:warmi/app/modules/wigets/layouts/dialog/dialog_loading.dart';
import 'package:warmi/app/modules/wigets/layouts/dialog/dialog_snackbar.dart';
import 'package:warmi/core/utils/enum.dart';

class LoginEmployeeController extends GetxController {
  //TODO: Implement LoginEmployeeController

  final count = 0.obs;

  final TextEditingController emailC=TextEditingController();
  final TextEditingController passwordC=TextEditingController();
  RxBool  obscurtText=false.obs;
  Rx<LoadingState> loadingState=LoadingState.empty.obs;

  @override
  void onInit() async{
    await Permission.storage.request();
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
  void increment() => count.value++;

  void changeObscureText() => obscurtText.value=!obscurtText.value;


  Future<bool> login()async{
    if(emailC.text.isEmpty || passwordC.text.isEmpty){
      showSnackBar(
          snackBarType: SnackBarType.ERROR,
          title: 'Login',
          message: 'Email atau Password Kosong');
      return false;
    }
    loadingBuilder();
    if(emailC.text.isPhoneNumber || emailC.text.isPhoneNumber){
      Get.back();
      await AuthRemoteDataSource().loginAuthCashier(username: emailC.text,password: passwordC.text).then((value){
        Get.back();
        if(value.status){
          return true;
        }else{
          showSnackBar(
              snackBarType: SnackBarType.ERROR,
              title: 'Login',
              message:value.message);
          return false;
        }
      });



    }
    Get.back();


    showSnackBar(
        snackBarType: SnackBarType.ERROR,
        title: 'Login',
        message: 'Pin/No Hanphone tidak valid');
    return false;

  }
}
