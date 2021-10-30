import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:warmi/app/data/datasource/type_order/type_order_remote_data_source.dart';
import 'package:warmi/app/data/models/type_order/type_order.dart';
import 'package:warmi/app/modules/wigets/layouts/dialog/dialog_loading.dart';
import 'package:warmi/app/modules/wigets/layouts/dialog/dialog_snackbar.dart';
import 'package:warmi/core/utils/enum.dart';

class TypeOrderController extends GetxController {
  Rx<LoadingState> loadingState = LoadingState.loading.obs;

  //list type order
  var listTypeOrder = List<TypeOrder>.empty().obs;
  var listSearchTypeOrder = List<TypeOrder>.empty().obs;
  Rx<TextEditingController> searchC = TextEditingController().obs;
  TextEditingController nameTypeOrderC = TextEditingController();

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void onInit() {
    getTypeOrderDataSource();
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  void getTypeOrderDataSource() async {
    loadingState(LoadingState.loading);
    await TypeOrderRemoteDataSource().getTypeOrder().then((value) {
      listTypeOrder(value.data);
    });
    loadingState(LoadingState.empty);
  }

  void searchTypeOrder(String keyword) async {
    loadingState(LoadingState.loading);
    await listSearchTypeOrder(listTypeOrder
        .where(
            (item) => item.orderTypeName.toString().toLowerCase().contains(keyword.toLowerCase()))
        .toList());
    loadingState(LoadingState.empty);
  }

  void createOrUpdateTypeOrderDataSource(String? id) async {
    if (nameTypeOrderC.text.isEmpty) {
      showSnackBar(
          snackBarType: SnackBarType.WARNING, title: 'Tipe Pesanan', message: 'Nama Wajib Diisi');
      return;
    }
    loadingBuilder();
    await TypeOrderRemoteDataSource().createOrUpdateTypeOrder(id: id, name: nameTypeOrderC.text);
    getTypeOrderDataSource();
    Get.back();
    Get.back();
    showSnackBar(
        snackBarType: SnackBarType.WARNING,
        title: 'Tipe Pesanan',
        message: 'Data Berhasil Disimpan');
  }

  void deleteTypeOrderDataSource(String? id) async {
    Get.back();
    loadingBuilder();
    await TypeOrderRemoteDataSource().deleteTypeOrder(id: id);
    getTypeOrderDataSource();

    Get.back();
  }
}
