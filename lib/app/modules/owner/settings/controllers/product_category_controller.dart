import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:warmi/app/data/datasource/product/category_product_remote_data_source.dart';
import 'package:warmi/app/data/models/product/category_product.dart';
import 'package:warmi/app/modules/wigets/layouts/dialog/dialog_loading.dart';
import 'package:warmi/app/modules/wigets/layouts/dialog/dialog_snackbar.dart';
import 'package:warmi/core/utils/enum.dart';

class ProductCategoryController extends GetxController {
  var listCategoryProduct = List<CategoryProduct>.empty().obs;
  var listSearchCategoryProduct = List<CategoryProduct>.empty().obs;
  Rx<TextEditingController> searchC = TextEditingController().obs;
  TextEditingController nameCategoryProductC = TextEditingController();
  Rx<LoadingState> loadingState = LoadingState.loading.obs;

  @override
  void onInit() {
    getCategoryProductDataSource();
    super.onInit();
  }

  void getCategoryProductDataSource() async {
    loadingState(LoadingState.loading);
    await CategoryProductRemoteDataSource().getCategoryProduct().then((value) {
      listCategoryProduct(value.data);
    });
    loadingState(LoadingState.empty);
  }

  void searchCategoryProduct(String keyword) async {

    loadingState(LoadingState.loading);
    await listSearchCategoryProduct(listCategoryProduct
        .where((item) => item.categoryName.toString().toLowerCase().contains(keyword.toLowerCase()))
        .toList());
    print(listSearchCategoryProduct.length);
    loadingState(LoadingState.empty);
  }

  void createOrUpdateCategoryProductDataSource() async {
    if (nameCategoryProductC.text.isEmpty) {
      showSnackBar(
          snackBarType: SnackBarType.WARNING,
          title: 'Kategori Produk',
          message: 'Nama Wajib Diisi');
      return;
    }
    loadingBuilder();
    await CategoryProductRemoteDataSource()
        .createCategoryProduct(id: null, name: nameCategoryProductC.text).then((value) {
          if(value.status){
            getCategoryProductDataSource();
            Get.back();
            Get.back();
            showSnackBar(
                snackBarType: SnackBarType.WARNING,
                title: 'Kategori Produk',
                message: 'Data Berhasil Disimpan');
          }else{
            showSnackBar(
                snackBarType: SnackBarType.ERROR,
                title: 'Kategori Produk',
                message: "${value.message}");
          }


    });

  }

  void deleteCategoryProductDataSource(String id) async {
    Get.back();
    loadingBuilder();
    await CategoryProductRemoteDataSource().deleteCategoryProduct(id: id);
    getCategoryProductDataSource();

    Get.back();
  }
}
