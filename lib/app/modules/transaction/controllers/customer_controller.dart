import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:warmi/app/data/datasource/customer/customer_remote_datasource.dart';
import 'package:warmi/app/data/models/customer/customer_model.dart';
import 'package:warmi/app/modules/wigets/layouts/dialog/dialog_loading.dart';
import 'package:warmi/app/modules/wigets/layouts/dialog/dialog_snackbar.dart';
import 'package:warmi/core/network/base_dio.dart';
import 'package:warmi/core/utils/enum.dart';

class CustomerController extends GetxController {
  Rx<TextEditingController> searchC = TextEditingController().obs;
  TextEditingController nameC = TextEditingController();
  TextEditingController emailC = TextEditingController();
  TextEditingController phoneNumberC = TextEditingController();
  TextEditingController addressC = TextEditingController();
  Rx<LoadingState> loadingState = LoadingState.loading.obs;

  var listCustomer = List<DataCustomer>.empty().obs;
  var listSearchCustomer = List<DataCustomer>.empty().obs;

  @override
  void onInit() {
    getCustomerDataSource();
    super.onInit();
  }

  void getCustomerDataSource() async {
    loadingState(LoadingState.loading);
    await CustomerRemoteDataSource().getCustomer().then((value) {
      listCustomer(value.data);
    });
    loadingState(LoadingState.empty);
  }

  void createCustomer({String? id}) async {
    if (nameC.value.text.isEmpty || phoneNumberC.value.text.isEmpty) {
      showSnackBar(
          snackBarType: SnackBarType.INFO,
          message: "Kolom harus Diisi",
          title: "Pelanggan");
      return;
    }
    loadingBuilder();
    await CustomerRemoteDataSource()
        .createCustomer(
            name: nameC.text,
            address: addressC.text,
            email: emailC.text,
            phoneNumber: phoneNumberC.text,
            id: id)
        .then((value) {
      if (value.status) {
        searchC.value.text = '';
        listCustomer.insert(0, DataCustomer.fromJson(value.data));
        Get.back();
        Get.back();
        showSnackBar(
            snackBarType: SnackBarType.WARNING,
            title: 'Pelanggan',
            message: 'Data Berhasil Disimpan');
      } else {
        showSnackBar(
            snackBarType: SnackBarType.ERROR,
            title: 'Pelanggan',
            message: "${value.message}");
      }
    });
  }

  void deleteCustomer(String? id) async {
    loadingBuilder();
    await CustomerRemoteDataSource().deleteCustomer(id: id).then((value) {
      Get.back();
      Get.back();
      if (value.status) getCustomerDataSource();
      showSnackBar(
          snackBarType: SnackBarType.SUCCESS,
          title: "Pelanggan",
          message: value.message);
    });
  }

  void searchCustomer(String keyword) async {
    loadingState(LoadingState.loading);
    await listSearchCustomer(listCustomer
        .where((item) =>
            item.customerpartnername
                .toString()
                .toLowerCase()
                .contains(keyword.toLowerCase()) ||
            item.customerpartnernumber
                .toString()
                .toLowerCase()
                .contains(keyword.toLowerCase()))
        .toList());
    loadingState(LoadingState.empty);
  }
}
