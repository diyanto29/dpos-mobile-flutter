import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:warmi/app/data/datasource/discount/discount_remote_data_source.dart';
import 'package:warmi/app/data/models/discount/discount.dart';
import 'package:warmi/app/modules/wigets/layouts/dialog/dialog_loading.dart';
import 'package:warmi/app/modules/wigets/layouts/dialog/dialog_snackbar.dart';
import 'package:warmi/core/utils/enum.dart';

class DiscountController extends GetxController {
  var listDiscount = List<DataDiscount>.empty().obs;
  var listSearchDiscount = List<DataDiscount>.empty().obs;

  Rx<TextEditingController> searchC = TextEditingController().obs;
  TextEditingController nameCategoryProductC = TextEditingController();
  Rx<LoadingState> loadingState = LoadingState.loading.obs;

  RxInt value = 1.obs;
  Rx<TextEditingController> conName = TextEditingController().obs;
  Rx<TextEditingController> conDiscount = TextEditingController().obs;
  Rx<TextEditingController> conDiscountMax = TextEditingController().obs;
  Rx<TextEditingController> conPercent = TextEditingController().obs;
  RxInt money = 0.obs;
  RxInt moneyMax = 0.obs;

  @override
  void onInit() {
    print('"Asdadasd');
    getDiscountDataSource();

    super.onInit();
  }

  void getDiscountDataSource() async {
    loadingState(LoadingState.loading);
    await DiscountRemoteDataSource().getDiscount().then((value) {
      listDiscount(value.data);
    });
    loadingState(LoadingState.empty);
  }

  void searchDiscount(String keyword) async {
    loadingState(LoadingState.loading);
    await listSearchDiscount(listDiscount
        .where((item) => item.discountName
            .toString()
            .toLowerCase()
            .contains(keyword.toLowerCase()))
        .toList());
    loadingState(LoadingState.empty);
  }

  void createDiscount({String? id}) async {
    if (conName.value.text.isEmpty ||
        (conDiscount.value.text.isEmpty && conPercent.value.text.isEmpty)) {
      showSnackBar(
          snackBarType: SnackBarType.INFO,
          message: "Kolom harus Diisi",
          title: 'diskon'.tr);
      return;
    }
    loadingBuilder();
    await DiscountRemoteDataSource()
        .createDiscount(
            isPercent: value == 1 ? false : true,
            name: conName.value.text,
            maxPriceOff: money.toString(),
            percent:
                conPercent.value.text.isEmpty ? "0" : conPercent.value.text,
            idDiscount: id)
        .then((value) {
      if (value.status) {
        getDiscountDataSource();
        Get.back();
        Get.back();
        showSnackBar(
            snackBarType: SnackBarType.WARNING,
            title: 'Diskon',
            message: 'Data Berhasil Disimpan');
      } else {
        showSnackBar(
            snackBarType: SnackBarType.ERROR,
            title: 'Diskon',
            message: "${value.message}");
      }
    });
  }

  void deleteDiscount(String? id) async {
    loadingBuilder();
    await DiscountRemoteDataSource().deleteDiscount(id: id).then((value) {
      Get.back();
      Get.back();
      if (value.status) getDiscountDataSource();
      showSnackBar(
          snackBarType: SnackBarType.SUCCESS,
          title: 'diskon'.tr,
          message: value.message);
    });
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  // TODO: implement onStart
  InternalFinalCallback<void> get onStart => super.onStart;
}
