import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:warmi/app/data/datasource/transactions/transaction_source_data_remote.dart';
import 'package:warmi/app/data/models/customer/customer_model.dart';
import 'package:warmi/app/data/models/discount/discount.dart';
import 'package:warmi/app/data/models/product/cart.dart';
import 'package:warmi/app/data/models/product/product.dart';
import 'package:warmi/app/modules/owner/product/controllers/product_controller.dart';
import 'package:warmi/app/modules/owner/settings/controllers/setup_business_controller.dart';
import 'package:warmi/app/modules/transaction/controllers/transaction_controller.dart';
import 'package:warmi/app/modules/wigets/layouts/dialog/dialog_loading.dart';
import 'package:warmi/app/modules/wigets/layouts/dialog/dialog_question.dart';
import 'package:warmi/app/modules/wigets/layouts/dialog/dialog_snackbar.dart';
import 'package:warmi/app/routes/app_pages.dart';
import 'package:warmi/core/globals/global_string.dart';
import 'package:warmi/core/utils/enum.dart';

class CartController extends GetxController {
  final transactionController = Get.find<TransactionController>();
  final productController = Get.find<ProductController>();
  final businessController = Get.find<SetupBusinessController>();

  var listCart = List<CartModel>.empty().obs;
  RxDouble totalCart = 0.0.obs;
  RxDouble totalShopping = 0.0.obs;
  DataDiscount? dataDiscount;
  var customer = DataCustomer().obs;
  Rx<DateTime> dateTransaction = DateTime.now().obs;
  TextEditingController notedC = TextEditingController();

  @override
  void onInit() {
    businessController.getBusinessProfileDataSource();
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  Future<List<CartModel>> addCart(DataProduct dataProduct) async {
    bool newCart = false;
    totalCart(0);
    if (listCart.isNotEmpty) {
      for (var item in listCart) {
        var index = listCart.indexOf(item);
        if (item.dataProduct == dataProduct) {
          item.qty = item.qty! + 1;
          item.subTotal = item.subTotal! + dataProduct.productPrice!;
          newCart = false;

          break;
        } else {
          newCart = true;
        }
      }

      if (newCart) {
        listCart.add(CartModel(dataProduct: dataProduct, qty: 1, subTotal: (1 * dataProduct.productPrice!)));
        newCart = false;
      }

      for (var product in productController.listProduct) {
        listCart.forEach((element) {
          if (product == element.dataProduct) {
            product.productInCart = true;
          }
        });
      }
      productController.listProduct.refresh();

      listCart.forEach((element) {
        totalCart.value += element.subTotal!;
      });
      getSubTotal();
      return listCart;
    } else {
      listCart.add(CartModel(dataProduct: dataProduct, qty: 1, subTotal: (1 * dataProduct.productPrice!)));
      for (var product in productController.listProduct) {
        listCart.forEach((element) {
          if (product == element.dataProduct) {
            product.productInCart = true;
          }
        });
      }
      productController.listProduct.refresh();
      getSubTotal();
    }
    listCart.forEach((element) {
      totalCart.value += element.subTotal!;
    });
    print("adad");
    getSubTotal();
    return listCart;
  }

  void getSubTotal() {
    totalCart(0);
    totalShopping(0);
    print("asda");
    var transC = Get.isRegistered<TransactionController>() ? Get.find<TransactionController>() : Get.put(TransactionController());
    transC.checkProductInCart();
    listCart.forEach((element) {
      if (element.discount == null) {
        totalCart.value += element.subTotal!;
      } else {
        if (element.discount!.discountType == 'price') {
          if (int.parse(element.discount!.discountMaxPriceOff!) >= element.subTotal!) {
            totalCart.value = totalCart.value - 0;
          } else {
            totalCart.value = totalCart.value + (element.subTotal! - int.parse(element.discount!.discountMaxPriceOff!));
          }
        } else {
          if (element.discount!.discountMaxPriceOff == "0" || element.discount!.discountMaxPriceOff == null) {
            double discount = element.subTotal! * (int.parse(element.discount!.discountPercent!) / 100);

            totalCart.value = totalCart.value + (element.subTotal! - discount);
          } else {
            double discount = element.subTotal! * (int.parse(element.discount!.discountPercent!) / 100);
            if (discount >= double.parse(element.discount!.discountMaxPriceOff!)) {
              totalCart.value = totalCart.value + (element.subTotal! - double.parse(element.discount!.discountMaxPriceOff!));
            } else {
              totalCart.value = totalCart.value + (element.subTotal! - discount);
            }
          }
        }
      }
    });
    // totalShopping(totalCart.value);

    //get total diskon

    if (dataDiscount == null) {
      totalShopping.value = totalCart.value + 0;
    } else {
      if (dataDiscount!.discountType == 'price') {
        if (int.parse(dataDiscount!.discountMaxPriceOff!) >= totalCart.value) {
          totalShopping.value = 0;
        } else {
          double? a = double.tryParse(dataDiscount!.discountMaxPriceOff!);
          totalShopping.value = totalCart.value - a!;
        }
      } else {
        if (dataDiscount!.discountMaxPriceOff == "0" || dataDiscount!.discountMaxPriceOff == null) {
          double discount = totalCart.value * (int.parse(dataDiscount!.discountPercent!) / 100);

          totalShopping.value = totalCart.value - discount;
        } else {
          double discount = totalCart.value * (int.parse(dataDiscount!.discountPercent!) / 100);
          if (discount >= double.parse(dataDiscount!.discountMaxPriceOff!)) {
            totalShopping.value = (totalCart.value - double.parse(dataDiscount!.discountMaxPriceOff!));
          } else {
            totalShopping.value = totalCart.value - discount;
          }
        }
      }
    }
  }

  Future<List<CartModel>> removeQty(CartModel? cartModel) async {
    if (cartModel!.qty! > 1) {
      listCart.forEach((element) {
        if (element.dataProduct == cartModel.dataProduct) {
          element.qty = element.qty! - 1;
          element.subTotal = element.qty! * element.dataProduct!.productPrice!;
          listCart.refresh();
          update();
        }
      });
    }
    getSubTotal();
    update();

    return listCart;
  }

  Future<List<CartModel>> addQty(CartModel? cartModel) async {
    listCart.forEach((element) {
      if (element.dataProduct == cartModel!.dataProduct) {
        element.qty = element.qty! + 1;
        element.subTotal = element.qty! * element.dataProduct!.productPrice!;
        listCart.refresh();
        update();
      }
    });
    getSubTotal();

    return listCart;
  }

  Future<List<CartModel>> addDiscount({CartModel? cartModel, bool allProduct = false, required DataDiscount dataDiscount}) async {
    if (allProduct) {
      this.dataDiscount = dataDiscount;
      getSubTotal();
      listCart.refresh();
      return listCart;
    } else {
      listCart.forEach((element) {
        if (element.dataProduct == cartModel!.dataProduct) {
          if (element.discount != null) {
            if (element.discount!.discountType == 'price') {
              if (int.parse(element.discount!.discountMaxPriceOff!) >= element.subTotal!) {
                totalCart.value = totalCart.value + element.dataProduct!.productPrice!;
              } else {
                totalCart.value = totalCart.value + int.parse(element.discount!.discountMaxPriceOff!);
              }
            } else {
              if (element.discount!.discountMaxPriceOff == "0" || element.discount!.discountMaxPriceOff == null) {
                double discount = element.subTotal! * (int.parse(element.discount!.discountPercent!) / 100);
                totalCart.value = totalCart.value + discount;
              } else {
                double discount = element.subTotal! * (int.parse(element.discount!.discountPercent!) / 100);
                print(discount);
                if (discount >= double.parse(element.discount!.discountMaxPriceOff!)) {
                  totalCart.value = totalCart.value + double.parse(element.discount!.discountMaxPriceOff!);
                } else {
                  totalCart.value = totalCart.value + discount;
                }
              }
            }
          }

          element.discount = dataDiscount;
          if (dataDiscount.discountType == 'price') {
            if (int.parse(dataDiscount.discountMaxPriceOff!) >= element.subTotal!) {
              totalCart.value = totalCart.value - element.dataProduct!.productPrice!;
            } else {
              totalCart.value = totalCart.value - int.parse(dataDiscount.discountMaxPriceOff!);
            }
          } else {
            if (dataDiscount.discountMaxPriceOff == "0" || dataDiscount.discountMaxPriceOff == null) {
              double discount = element.subTotal! * (int.parse(dataDiscount.discountPercent!) / 100);
              totalCart.value = totalCart.value - discount;
            } else {
              double discount = element.subTotal! * (int.parse(dataDiscount.discountPercent!) / 100);
              print(discount);
              if (discount >= double.parse(dataDiscount.discountMaxPriceOff!)) {
                totalCart.value = totalCart.value - double.parse(dataDiscount.discountMaxPriceOff!);
              } else {
                totalCart.value = totalCart.value - discount;
              }
            }
          }
          listCart.refresh();
        }
      });
      // totalShopping(totalCart.value);
      getSubTotal();
      return listCart;
    }
  }

  Future<List<CartModel>> deleteDiscount({CartModel? cartModel, bool allProduct = false, required DataDiscount dataDiscount}) async {
    if (allProduct) {
      this.dataDiscount = null;
      print("hao");
      totalShopping(totalCart.value);
      return listCart;
    } else {
      listCart.forEach((element) {
        if (element.dataProduct == cartModel!.dataProduct) {
          element.discount = null;
        }
        listCart.refresh();
      });

      getSubTotal();
      print("hg");

      return listCart;
    }
  }

  Future<List<CartModel>> deleteCart({CartModel? cartModel}) async {
    showDialogQuestion(
        title: 'Hapus Keranjang',
        message: 'apakah_anda_yakin'.tr + ' ?',
        clickYes: () {
          Get.back();
          listCart.remove(cartModel);
          getSubTotal();

          for (var product in productController.listProduct) {
            if (product == cartModel!.dataProduct) {
              product.productInCart = false;
            }
          }
          productController.listProduct.refresh();
          productController.listSearchProduct.refresh();
        });

    return listCart;
  }

  Future<List<CartModel>> deleteCartFormListProduct(DataProduct dataProduct) async {
    for (var product in productController.listProduct) {
      if (product == dataProduct) {
        product.productInCart = false;
      }
    }
    CartModel? cartModel;
    for (var cart in listCart) {
      if (cart.dataProduct == dataProduct) {
        cartModel=cart;

      }
    }
    listCart.remove(cartModel);
    listCart.refresh();

    getSubTotal();

    productController.listProduct.refresh();
    productController.listSearchProduct.refresh();

    return listCart;
  }

  Future<void> removeCustomer() async {
    customer.value.customerpartnername = null;
    update();
  }

  Future<void> addCustomer(DataCustomer dataCustomer) async {
    customer.value = dataCustomer;
    update();
  }

  void storeTransaction({String? statusPaymentMethod, String? statusTransaction}) async {
    loadingBuilder();
    var box = GetStorage();
    await TransactionRemoteDataSource()
        .storeTransaction(
            customerPartnerID: customer.value.customerpartnerid,
            dateTransaction: DateFormat("yyyy-MM-dd").format(dateTransaction.value),
            discountID: dataDiscount == null ? null : dataDiscount!.discountId.toString(),
            paymentMethodID: "asd",
            listCart: listCart,
            transactionNoted: notedC.text,
            paymentMethodStatus: "Pending",
            priceOff: dataDiscount == null ? null : double.tryParse(dataDiscount!.discountMaxPriceOff!),
            totalTransaction: totalShopping.value,
            transactionPay: 0,
            transactionReceived: 0,
            transactionStatus: "Pending")
        .then((value) {
      Get.back();
      if (value.status) {
        transactionController.getTransaction();

        Get.back();
        Get.back();
        Get.back();
        if (box.read(MyString.ROLE_NAME) != "Pemilik Toko") {
          Get.offAllNamed(Routes.INDEX_TRANSACTION);
          showSnackBar(snackBarType: SnackBarType.SUCCESS, title: 'transaksi'.tr, message: 'Transaksi Berhasil Disimpan');
        }
        showSnackBar(snackBarType: SnackBarType.SUCCESS, title: 'transaksi'.tr, message: 'Transaksi Berhasil Disimpan');
      }
    });
  }
}
