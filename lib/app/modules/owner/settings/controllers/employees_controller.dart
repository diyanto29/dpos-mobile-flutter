import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:warmi/app/data/datasource/employes/employes_data_source.dart';
import 'package:warmi/app/data/models/employes/employes_model.dart';
import 'package:warmi/app/modules/wigets/layouts/dialog/dialog_loading.dart';
import 'package:warmi/app/modules/wigets/layouts/dialog/dialog_snackbar.dart';
import 'package:warmi/core/utils/enum.dart';

class EmployeesController extends GetxController{

  Rx<LoadingState> loadingState = LoadingState.loading.obs;
  var listEmployees = List<EmployeData>.empty().obs;
  var listSearchEmployees = List<EmployeData>.empty().obs;

  Rx<TextEditingController> searchC = TextEditingController().obs;

  Rx<TextEditingController> nameC=TextEditingController().obs;
  Rx<TextEditingController> phoneNumberC=TextEditingController().obs;
  Rx<TextEditingController> pinC=TextEditingController().obs;
  Rx<TextEditingController> addressC=TextEditingController().obs;
  @override
  void onInit() {
    getEmployees();
    super.onInit();
  }

  void getEmployees() async {
    await EmployeesDataSource().getEmployees().then((value) {
      listEmployees(value.data);
    });
    loadingState(LoadingState.empty);
  }

  void searchEmployees(String keyword) async {

    loadingState(LoadingState.loading);
    await listSearchEmployees(listEmployees
        .where((item) => item.name.toString().toLowerCase().contains(keyword.toLowerCase()))
        .toList());
    loadingState(LoadingState.empty);
  }


  void storeEmployees({String? name,String? pin, String? phoneNumber,String? employeesID,String? address})async {
    if (name!.isEmpty || pin!.isEmpty) {
      showSnackBar(snackBarType: SnackBarType.WARNING, message: "Kolom Wajib Diisi", title: 'Karyawan');
      return;
    }
    loadingBuilder();
    await EmployeesDataSource().storeEmployees(employeesID: employeesID,name: name,phoneNumber: phoneNumber,pin: pin,address: addressC.value.text).then((value) {
      Get.back();
      if(value.status){
        Get.back();
        getEmployees();
        showSnackBar(snackBarType: SnackBarType.SUCCESS, message: value.message, title: 'Karyawan');
      }else{
        showSnackBar(snackBarType: SnackBarType.ERROR, message: value.message, title: 'Karyawan');
      }

    });
  }

  void deleteEmployees(String id)async{
    loadingBuilder();
    await EmployeesDataSource().deleteEmployees(id: id).then((value) {
      Get.back();
      if(value.status){
        getEmployees();
        showSnackBar(snackBarType: SnackBarType.SUCCESS, message: value.message, title: 'Karyawan');
      }else{
        showSnackBar(snackBarType: SnackBarType.ERROR, message: value.message, title: 'Karyawan');
      }
    });
  }
}