import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:warmi/app/data/datalocal/session/auth_session_manager.dart';
import 'package:warmi/app/data/datasource/invoice/invoice_data_source.dart';
import 'package:warmi/app/modules/wigets/layouts/dialog/dialog_loading.dart';
import 'package:warmi/app/modules/wigets/layouts/dialog/dialog_snackbar.dart';
import 'package:warmi/core/globals/global_string.dart';
import 'package:warmi/core/utils/enum.dart';

class InvoiceController extends GetxController{

  final box=GetStorage();

  var authSession=AuthSessionManager().obs;


  RxString footerText=''.obs;
  RxBool logo=false.obs;
  RxBool logoDpos=true.obs;
  Rx<TextEditingController> controllerFooter=TextEditingController().obs;

@override
  void onInit() {
    readSessionInvoice();
    getInvoice();
    super.onInit();
  }



  void storeInvoice()async{
  loadingBuilder();
      await InvoiceDataRemote().storeInvoice(footerText: controllerFooter.value.text,logo: logo.value,logoDpos: logoDpos.value).then((value){
        Get.back();
        if(value.status){
          getInvoice();
        }
        showSnackBar(
            snackBarType: SnackBarType.SUCCESS,
            title: 'Invoice',
            message: value.message);

      });
  }

  void getInvoice()async{
    await InvoiceDataRemote().getInvoice().then((value){
      if(value.status!){
        box.write(MyString.FOOTER_TEXT, value.data![0].footertext);
        box.write(MyString.LOGO_BUSINESS, value.data![0].cetaklogostruk);
        box.write(MyString.LOGO_DPOS, value.data![0].cetaklogodpos);
        logo(value.data![0].cetaklogostruk);
        logoDpos(value.data![0].cetaklogodpos);
        controllerFooter.value.text=value.data![0].footertext!;
      }

    });
  }

  void readSessionInvoice()async{
    logo(box.read(MyString.LOGO_BUSINESS));
    logoDpos(box.read(MyString.LOGO_DPOS));
    controllerFooter.value.text=box.read(MyString.FOOTER_TEXT).toString();
  }



}