import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:warmi/app/data/datasource/auth/auth_remote_data_source.dart';
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
  void onInit() {
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

    if(emailC.text.isEmail || emailC.text.isPhoneNumber){

      loadingState(LoadingState.loading);
      await AuthRemoteDataSource().loginAuth(username: emailC.text,password: passwordC.text);
      loadingState(LoadingState.empty);
      return true;

    }

    showSnackBar(
        snackBarType: SnackBarType.ERROR,
        title: 'Login',
        message: 'Email/No Hanphone tidak valid');
    return false;

  }
}
