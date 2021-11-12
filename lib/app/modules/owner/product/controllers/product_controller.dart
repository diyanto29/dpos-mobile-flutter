import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:warmi/app/data/datasource/product/product_remote_data_source.dart';
import 'package:warmi/app/data/models/outlet/outlet.dart';
import 'package:warmi/app/data/models/product/category_product.dart';
import 'package:warmi/app/data/models/product/product.dart';
import 'package:warmi/app/data/models/product/satuan_product.dart';
import 'package:warmi/app/modules/transaction/controllers/cart_controller.dart';
import 'package:warmi/app/modules/wigets/layouts/dialog/dialog_loading.dart';
import 'package:warmi/app/modules/wigets/layouts/dialog/dialog_snackbar.dart';
import 'package:warmi/app/routes/app_pages.dart';
import 'package:warmi/core/utils/enum.dart';

class ProductController extends GetxController {
  var listUnitProduct = List<SatuanProduct>.empty().obs;
  var listProduct = List<DataProduct>.empty().obs;
  var listSearchProduct = List<DataProduct>.empty().obs;
  Rx<LoadingState> loadingState = LoadingState.loading.obs;
  Rx<TextEditingController> searchC = TextEditingController().obs;

  //Product Controller
  Rx<bool> toggleSwitchStock = false.obs;
  Rx<bool> toggleSwitchDetailProduct = false.obs;
  File? image;
  final picker = ImagePicker();
  RxInt priceProduct = 0.obs;
  RxInt priceModal = 0.obs;
  Rx<TextEditingController> conName = TextEditingController().obs;
  Rx<TextEditingController> conPrice = TextEditingController().obs;
  Rx<TextEditingController> conQty = TextEditingController().obs;
  Rx<TextEditingController> conOutlet = TextEditingController().obs;
  Rx<TextEditingController> conSKU = TextEditingController().obs;
  Rx<TextEditingController> conDesc = TextEditingController().obs;
  Rx<TextEditingController> conModal = TextEditingController().obs;
  Rx<TextEditingController> conBarcode = TextEditingController().obs;
  SatuanProduct? satuanProduct;
  CategoryProduct? categoryProduct;

  //variant controller
  Rx<bool> toggleSwitchStockVariant = false.obs;
  Rx<bool> toggleSwitchVariant= false.obs;
  Rx<TextEditingController> conPriceVariant = TextEditingController().obs;
  Rx<TextEditingController> conNameVariant = TextEditingController().obs;
  Rx<TextEditingController> conQtyVariant = TextEditingController().obs;

  //variabel grosir

  Rx<bool> toggleSwitchWholesale= false.obs;
  Rx<TextEditingController> conPriceWholesale= TextEditingController().obs;
  Rx<TextEditingController> conNameWholesale = TextEditingController().obs;




   @override
  void onReady() {
    print("Hallo");
     listProduct.forEach((element) {
       element.productInCart=false;
     });
     update();
    super.onReady();
  }

  @override
  void dispose() {
    print("disponse");
    listProduct.forEach((element) {
      element.productInCart=false;
    });
    update();
    super.dispose();
  }





  @override
  void onInit() {
    if (listUnitProduct.isEmpty) {
      getUnitProduct();
    }
    print('"Asd');
    getProduct();
    super.onInit();
  }








  Future getImage(ImageSource imageSource) async {
    final pickedFile = await picker.getImage(source: imageSource, imageQuality: 20);

    if (pickedFile != null) {
      image = File(pickedFile.path);
      Get.back();
    } else {
      print('No image selected.');
    }
    update();
  }

  void showBottomSheetImage() {
    showModalBottomSheet(
      context: Get.context!,
      builder: (context) {
        return Container(
          height: 120,
          child: Column(
            children: <Widget>[
              ListTile(
                onTap: () {
                  getImage(ImageSource.camera);
                },
                leading: Icon(IconlyLight.camera),
                title: Text("Ambil Gambar dari Kamera"),
              ),
              ListTile(
                onTap: () {
                  getImage(ImageSource.gallery);
                },
                leading: Icon(IconlyLight.image2),
                title: Text("Ambil Gambar dari Galeri"),
              ),
            ],
          ),
        );
      },
    );
  }

  void searchProductList(String keyword) async {
    loadingState(LoadingState.loading);
    await listSearchProduct(listProduct
        .where((item) => item.productName.toString().toLowerCase().contains(keyword.toLowerCase())
        || item.productPrice.toString().toLowerCase().contains(keyword.toLowerCase())
        || item.productStok.toString().toLowerCase().contains(keyword.toLowerCase())
        || item.productUnitId.toString().toLowerCase().contains(keyword.toLowerCase())

    )
        .toList());

    print(listSearchProduct);

    loadingState(LoadingState.empty);
  }

  void getUnitProduct() async {
    await ProductRemoteDataSource().getUnitProduct().then((value) {
      listUnitProduct(value.data);
    });
  }

  Future<void> getProduct() async {
    await ProductRemoteDataSource().getProduct().then((value) {
      listProduct(value.data);
      loadingState(LoadingState.empty);
    });
  }

  void createOrUpdateProduct({String? idProduct}) async {
    loadingBuilder();
    await ProductRemoteDataSource()
        .insertProduct(
            name: conName.value.text,
            idProduct: idProduct ?? null,
            sku: conSKU.value.text,
            modal: priceModal.value.toString(),
            image: image,
            desc: conDesc.value.text,
            categoryByStore: categoryProduct,
            listTypeOrder: null,
            typeOrder: false,
            qtyStockProduct: conQty.value.text,
            satuanProduct: satuanProduct,
            priceProduct: priceProduct.value.toString(),
            stockProductStatus: toggleSwitchStock.value,
            storeAll: false,
            barcode: conBarcode.value.text,
            listOutlet: null)
        .then((value) {
      Get.back();
      getProduct();
      Get.back();
      showSnackBar(
          snackBarType: value.status ? SnackBarType.SUCCESS : SnackBarType.ERROR,
          title: 'Produk',
          message: value.message);
    });
  }


  void deleteProductDataSource({String? id})async{
     loadingBuilder();
     await ProductRemoteDataSource().deleteProduct(id: id).then((value) {
       Get.back();
       if(value.status){
         getProduct();
         Get.back();

       }

       showSnackBar(snackBarType: SnackBarType.ERROR,title: "Produk",message: value.message);
     });
  }


  void checkProductInCart()async{
     var cartC=Get.find<CartController>();
     if(cartC.listCart.length>0){
       cartC.listCart.forEach((element) {
         listProduct.forEach((item) {
           if(element.dataProduct==item){
             item.productInCart=true;
             update();
           }
         });
       });
     }
  }

  void scanBarcode() async {
    String barcodeScanRes = await FlutterBarcodeScanner.scanBarcode("#ff6666", 'Batal', true, ScanMode.BARCODE);
    if(barcodeScanRes!="-1"){
      conBarcode.value.text = barcodeScanRes;
    }
  }




}
