import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:warmi/app/data/datasource/business/business_data_source.dart';
import 'package:warmi/app/routes/app_pages.dart';
import 'package:warmi/core/globals/global_string.dart';

class SplashController extends GetxController {


  @override
  void onInit() async{
    print("init");
    await Permission.storage.request();
     BusinessDataSource().getTypeBusiness();

    checkSessionLogin();
    super.onInit();
  }

  @override
  void onReady() {
    print("hg");
    super.onReady();
  }
  @override
  void dispose() {

    super.dispose();
  }

  @override
  void onClose() {}


  Future<void> checkSessionLogin()async{
    GetStorage box=GetStorage();
    Future.delayed(Duration(seconds: 1),(){
      if(box.hasData(MyString.USER_ID)){
        if(box.read(MyString.ROLE_NAME).toString().toLowerCase().contains('pemilik toko')){
          Get.offAllNamed(Routes.NAVIGATION);
        }
      }else{
        Get.offAllNamed(Routes.LOGIN_CHOOISE);
      }

    });
  }


}