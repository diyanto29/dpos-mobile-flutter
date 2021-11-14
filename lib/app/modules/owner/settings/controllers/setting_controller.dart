import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:package_info/package_info.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:warmi/app/data/datasource/auth/auth_remote_data_source.dart';
import 'package:warmi/app/modules/wigets/layouts/dialog/dialog_loading.dart';
import 'package:warmi/app/modules/wigets/layouts/dialog/dialog_question.dart';
import 'package:warmi/app/modules/wigets/layouts/dialog/dialog_snackbar.dart';
import 'package:warmi/app/routes/app_pages.dart';
import 'package:warmi/core/globals/global_string.dart';
import 'package:warmi/core/utils/enum.dart';
import 'package:whatsapp_unilink/whatsapp_unilink.dart';

class SettingController extends GetxController{
  RxDouble scrollOpacity=1.0.obs;
  Rx<TextEditingController> passwordC = TextEditingController().obs;
  PackageInfo? packageInfo;



@override
void onInit()async{
  checkPackage();
  super.onInit();
}

void checkPackage()async{
  packageInfo= await PackageInfo.fromPlatform();
  update();
}
  launchWhatsApp() async {
    final link = WhatsAppUnilink(
      phoneNumber: '+6285624277920',  
      text: "Hai DPOS, Saya ingin bertanya...",
    );
    await launch('$link');
  }

  launchCall()async{
    await launch("tel:+6285624277920");
  }


  String? encodeQueryParameters(Map<String, String> params) {
    return params.entries
        .map((e) => '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
        .join('&');
  }


  launchEmail()async{

    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: 'emailmudahkan@gmail.com',
      query: encodeQueryParameters(<String, String>{
        'subject': 'Kami Butuh Bantuan nih'
      }),
    );

    launch(emailLaunchUri.toString());
  }
  launchWebsite()async{
    await canLaunch('https://mudahkan.com/');
  }

  void updatePassword()async{
    if(passwordC.value.text.isEmpty){
      showSnackBar(snackBarType: SnackBarType.WARNING, message: 'Password Baru Wajib Diisi', title: 'Kata Sandi');
      return;
    }
    loadingBuilder();
    await AuthRemoteDataSource().updatePassword(password: passwordC.value.text).then((value) {
      Get.back();
      if(value.status){
        showSnackBar(snackBarType: SnackBarType.SUCCESS, message: value.message, title: 'Kata Sandi');
        passwordC.value.text="";
      }else{
        showSnackBar(snackBarType: SnackBarType.ERROR, message: value.message, title: 'Kata Sandi');
      }
    });
  }
  void logOut(){
    var box=GetStorage();
    showDialogQuestion(title: 'keluar'.tr, message: 'apakah_anda_yakin'.tr + ' ?', clickYes: (){
      box.remove(MyString.USER_ID);
      Get.offAllNamed(Routes.LOGIN_CHOOISE);
    });
  }
}