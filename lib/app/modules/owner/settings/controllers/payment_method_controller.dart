import 'dart:convert';

import 'package:get/get.dart';
import 'package:warmi/app/data/datasource/payment/payment_method_remote_data_source.dart';
import 'package:warmi/app/data/models/payment_method/payment_method_channel.dart';
import 'package:warmi/app/modules/wigets/layouts/dialog/dialog_loading.dart';
import 'package:warmi/app/modules/wigets/layouts/dialog/dialog_snackbar.dart';

import 'package:warmi/core/utils/enum.dart';

class PaymentMethodController extends GetxController{
  RxBool togglePaymentWallet = true.obs;
  RxBool togglePaymentDebit = true.obs;
  RxBool togglePaymentCredit = true.obs;
  RxBool togglePaymentEcommerce = true.obs;
  RxBool togglePaymentOther = true.obs;
  var listPaymentMethod = List<DataPaymentMethod>.empty().obs;
  Rx<LoadingState> loadingState = LoadingState.loading.obs;

  @override
  void onInit() {
    getPaymentMethod();
    super.onInit();
  }
  void getPaymentMethod() async {
    loadingState(LoadingState.loading);
    await PaymentMethodRemoteDataSource().getPaymentMethod().then((value) {
      listPaymentMethod(value.data);
    });
    loadingState(LoadingState.empty);
  }

  void changePaymentMethodChannel({bool? value,int? i})async{
    if(value!)
      listPaymentMethod[i!].paymentmethodstatus='Active';
    else
      listPaymentMethod[i!].paymentmethodstatus='Disable';
    print(listPaymentMethod[i].paymentmethodstatus);
    update();
  }

  void changePaymentMethod({bool? value,int? indexPaymentMethodChannel,int? j})async{
    if(value!)
      listPaymentMethod[indexPaymentMethodChannel!].paymentMethod![j!].status='Active';
    else
      listPaymentMethod[indexPaymentMethodChannel!].paymentMethod![j!].status='Disable';
    update();
  }


  Future<void> updatePaymentMethodChannel()async{
    loadingBuilder();
    await PaymentMethodRemoteDataSource().updatePaymentMethod(paymentMethod: listPaymentMethod).then((value){
      Get.back();
      if(value.status){
        showSnackBar(
            snackBarType: SnackBarType.SUCCESS,
            title: 'Payment Method',
            message: 'Data Berhasil Disimpan');
        value.data.forEach((v) {
          listPaymentMethod.value.add(DataPaymentMethod.fromJson(v));
        });
      }else{
        showSnackBar(
            snackBarType: SnackBarType.ERROR,
            title: 'Payment Method',
            message: 'Data Gagal Disimpan');
      }
    });
  }

}