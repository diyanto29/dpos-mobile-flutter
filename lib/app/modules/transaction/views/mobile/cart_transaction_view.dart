import 'package:cached_network_image/cached_network_image.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:line_icons/line_icon.dart';
import 'package:warmi/app/data/models/product/cart.dart';
import 'package:warmi/app/modules/transaction/controllers/cart_controller.dart';
import 'package:warmi/app/modules/transaction/controllers/transaction_controller.dart';
import 'package:warmi/app/modules/transaction/views/table/checkout_table_view.dart';
import 'package:warmi/app/modules/wigets/layouts/dialog/bottom_dialog_contact.dart';
import 'package:warmi/app/modules/wigets/layouts/dialog/dialog_noted.dart';
import 'package:warmi/app/modules/wigets/layouts/dialog/dialog_snackbar.dart';
import 'package:warmi/app/modules/wigets/layouts/general_button.dart';
import 'package:warmi/app/modules/wigets/package/corolize_text_avatar/colorize_text_avatar.dart';
import 'package:warmi/app/routes/app_pages.dart';
import 'package:warmi/core/globals/global_color.dart';
import 'package:warmi/core/globals/global_string.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:warmi/core/utils/enum.dart';
import 'package:warmi/core/utils/responsive_layout.dart';

class CardTransactionView extends StatefulWidget {
  const CardTransactionView({Key? key}) : super(key: key);

  @override
  _CardTransactionViewState createState() => _CardTransactionViewState();
}

class _CardTransactionViewState extends State<CardTransactionView> {
  final controller = Get.find<TransactionController>();
  final cartController = Get.find<CartController>();
  final formatCurrency = new NumberFormat.currency(locale: "id_ID", symbol: "", decimalDigits: 0);

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(desktop: Container(),
      tablet: CheckOutTableView(),
      mobile: Scaffold(
        backgroundColor: MyColor.colorBackground,
        appBar: AppBar(
          backgroundColor: MyColor.colorPrimary,
          title: Text('detail_pesanan'.tr),
          actions: [
            // TextButton(
            //   onPressed: ()=>Get.to(FormInputProductManual(),transition: Transition.zoom),
            //   child: Text(
            //     "Produk Manual",
            //     style: GoogleFonts.roboto(color: Colors.white),
            //   ),
            // )
          ],
        ),
        body: Obx(() {
          return Padding(
            padding: const EdgeInsets.all(MyString.DEFAULT_PADDING),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          InkWell(
                            onTap: () async {
                              Get.toNamed(Routes.CUSTOMER_PAGE);
                            },
                            child: GetBuilder<CartController>(builder: (logic) {
                              return Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(top: 0),
                                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                                    decoration: BoxDecoration(color: Colors.green, borderRadius: BorderRadius.circular(10)),
                                    child: Text(
                                      cartController.customer.value.customerpartnername == null ? 'pelanggan'.tr : cartController.customer.value.customerpartnername!,
                                      style: GoogleFonts.roboto(fontSize: 12.0, color: Colors.white),
                                    ),
                                  ),
                                  Visibility(
                                    visible: cartController.customer.value.customerpartnername == null ? false : true,
                                    child: InkWell(
                                      onTap: () {
                                        cartController.removeCustomer();
                                        print("a");
                                      },
                                      child: Container(
                                        margin: EdgeInsets.only(top: 0, left: 10),
                                        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                                        decoration: BoxDecoration(color: Colors.red, borderRadius: BorderRadius.circular(10)),
                                        child: Text(
                                          'hapus'.tr,
                                          style: GoogleFonts.roboto(fontSize: 12.0, color: Colors.white),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            }),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                      child: Text(
                        "${DateFormat("EEEE, dd MM yyyy H:mm:ss", "id-ID").format(cartController.dateTransaction.value)}",
                        style: GoogleFonts.alice(fontStyle: FontStyle.italic),
                      ),
                    ),
                  ],
                ),
                Expanded(
                    flex: 12,
                    child: ListView(
                      shrinkWrap: true,
                      primary: true,
                      children: [
                        ListView.builder(
                            itemCount: cartController.listCart.length,
                            shrinkWrap: true,
                            physics: ClampingScrollPhysics(),
                            itemBuilder: (c, i) => Card(
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                              elevation: 0.4,
                              child: Column(
                                children: [
                                  ListTile(
                                    isThreeLine: true,
                                    contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                                    leading: ClipRRect(
                                      borderRadius: BorderRadius.circular(100),
                                      child: CachedNetworkImage(
                                        imageUrl: "${cartController.listCart[i].dataProduct!.productPhoto!}",
                                        fit: BoxFit.cover,
                                        width: 60,
                                        height: 60,
                                        placeholder: (c, s) => Center(child: CircularProgressIndicator()),
                                        errorWidget: (context, s, o) => TextAvatar(
                                          shape: Shape.Circular,
                                          size: 30,
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.w600,
                                          upperCase: true,
                                          numberLetters: 3,
                                          text: "${cartController.listCart[i].dataProduct!.productName}",
                                        ),
                                      ),
                                    ),
                                    title: Text(
                                      // "Sate",
                                      "${cartController.listCart[i].dataProduct!.productName}",
                                      overflow: TextOverflow.ellipsis,
                                      style: GoogleFonts.roboto(fontWeight: FontWeight.bold),
                                    ),
                                    subtitle: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          height: 38,
                                          width: 120,
                                          margin: EdgeInsets.only(top: 10),
                                          padding: EdgeInsets.symmetric(horizontal: 3),
                                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), border: Border.all(color: MyColor.colorPrimary)),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              InkWell(
                                                onTap: () => cartController.removeQty(cartController.listCart[i]),
                                                child: Container(
                                                  child: LineIcon.minus(
                                                    color: Colors.red,
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                child: Center(
                                                  child: FittedBox(
                                                    child: Text(
                                                      // "${data.listCart[i].qty}",
                                                      "${cartController.listCart[i].qty}",
                                                      style: GoogleFonts.roboto(fontSize: 16, color: Colors.black),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              InkWell(
                                                onTap: () => cartController.addQty(cartController.listCart[i]),
                                                child: Container(
                                                  child: LineIcon.plus(
                                                    color: Colors.green,
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                    trailing: Column(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Text("@ ${formatCurrency.format(cartController.listCart[i].dataProduct!.productPrice)}"),
                                        InkWell(
                                          onTap: () => cartController.deleteCart(cartModel: cartController.listCart[i]),
                                          child: Container(
                                            child: Icon(
                                              Icons.delete,
                                              color: Colors.red,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 10),
                                    child: Divider(
                                      thickness: 1,
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () => addDiscount(cart: cartController.listCart[i], allProduct: false),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Text("Diskon"),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: [
                                              cartController.listCart[i].discount != null ?   Text(
                                                "${cartController.listCart[i].discount!.discountType!.toLowerCase() == 'price' ? ' - Rp.' + formatCurrency.format(int.parse(cartController.listCart[i].discount!.discountMaxPriceOff!)) : cartController
                                                    .listCart[i].discount!.discountPercent + '%'}",
                                                style: GoogleFonts.roboto(color: Colors.red, fontWeight: FontWeight.bold),
                                              ): Icon(Icons.arrow_forward_ios_rounded,size: 15,),
                                              SizedBox(
                                                width: 4,
                                              ),

                                              Visibility(
                                                visible: cartController.listCart[i].discount == null ? false : true,
                                                child: InkWell(
                                                    onTap: () {
                                                      setState(() {
                                                        cartController.deleteDiscount(dataDiscount: cartController.listCart[i].discount!, cartModel: cartController.listCart[i]);
                                                        cartController.listCart[i].discount = null;
                                                      });
                                                    },
                                                    child: Icon(
                                                      Icons.clear,
                                                      color: Colors.red,
                                                      size: 20,
                                                    )),
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  cartController.listCart[i].discount != null
                                      ? cartController.listCart[i].discount!.discountType != 'price'
                                      ? Padding(
                                    padding: const EdgeInsets.fromLTRB(8, 2, 8, 10),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Text("Max Diskon"),
                                        Text(
                                          "- Rp.${formatCurrency.format(int.parse(cartController.listCart[i].discount!.discountMaxPriceOff!))}",
                                          style: GoogleFonts.roboto(color: Colors.red, fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  )
                                      : Container()
                                      : Container(),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Divider(
                                      thickness: 1,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Text("Sub Total"),
                                        Text(
                                          "Rp.${formatCurrency.format(cartController.listCart[i].subTotal)}",
                                          style: GoogleFonts.roboto(fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            )),
                        Card(
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                          elevation: 0.4,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Sub Total",
                                      style: GoogleFonts.roboto(fontWeight: FontWeight.bold, fontSize: 4.w),
                                    ),
                                    Text(
                                      "Rp.${formatCurrency.format(cartController.totalCart.value)}",
                                      style: GoogleFonts.roboto(fontWeight: FontWeight.bold, fontSize: 4.w),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                InkWell(
                                  onTap: () => addDiscount(allProduct: true),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        "Diskon",
                                        style: GoogleFonts.roboto(fontWeight: FontWeight.bold, fontSize: 4.w),
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          cartController.dataDiscount != null ?  Text(
                                            "${cartController.dataDiscount?.discountType!.toLowerCase() == 'price' ? ' - Rp.' + formatCurrency.format(int.parse(cartController.dataDiscount!.discountMaxPriceOff!)) : cartController.dataDiscount?.discountPercent +
                                                '%'}",
                                            style: GoogleFonts.roboto(color: Colors.red, fontWeight: FontWeight.bold),
                                          ) : Icon(Icons.arrow_forward_ios_rounded,size: 15,),
                                          SizedBox(
                                            width: 4,
                                          ),
                                          Visibility(
                                            visible: cartController.dataDiscount == null ? false : true,
                                            child: InkWell(
                                                onTap: () {
                                                  setState(() {
                                                    cartController.deleteDiscount(dataDiscount: cartController.dataDiscount!,allProduct: true);
                                                  });
                                                },
                                                child: Icon(
                                                  Icons.clear,
                                                  color: Colors.red,
                                                  size: 20,
                                                )),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                cartController.dataDiscount != null
                                    ? cartController.dataDiscount!.discountType != 'price'
                                    ? Padding(
                                  padding: const EdgeInsets.fromLTRB(0, 2, 0, 0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Text("Max Diskon"),
                                      Text(
                                        "- Rp.${formatCurrency.format(int.parse(cartController.dataDiscount!.discountMaxPriceOff!))}",
                                        style: GoogleFonts.roboto(color: Colors.red, fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                )
                                    : Container()
                                    : Container(),
                              ],
                            ),
                          ),
                        )
                      ],
                    )),
              ],
            ),
          );
        }),
        bottomNavigationBar: Obx(() {
          return Container(
            height: 13.5.h,
            width: double.infinity,
            margin: EdgeInsets.only(
              bottom: 10
            ),
            decoration: BoxDecoration(color: MyColor.colorWhite),
            // margin: EdgeInsets.symmetric(horizontal: MyString.DEFAULT_PADDING),
            // padding: EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(MyString.DEFAULT_PADDING, 4, MyString.DEFAULT_PADDING, 6),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Total",
                        style: GoogleFonts.roboto(fontWeight: FontWeight.bold, fontSize: 4.w),
                      ),
                      Text(
                        "Rp.${formatCurrency.format(cartController.totalShopping.value)}",
                        style: GoogleFonts.roboto(fontWeight: FontWeight.bold, fontSize: 4.w),
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Flexible(
                      child: GeneralButton(
                        label: 'simpan'.tr,
                        onPressed: () => showDialogNoted(title: 'Masukan Catatan',message: 'coba',clickYes: (){
                          cartController.storeTransaction();
                        }),
                        width: 45.w,
                        color: MyColor.colorBlue,
                      ),
                    ),
                    Flexible(
                      child: GeneralButton(
                        label: 'bayar_sekarang'.tr,
                        onPressed: (){
                          Map<dynamic,dynamic> data={
                            "from" : "cart",
                            "data" : null
                          };
                          if(cartController.listCart.isEmpty){
                            showSnackBar(snackBarType: SnackBarType.INFO,message: "Keranjang Masih Kosong",title: "Transaksi");
                          }else{
                            Get.toNamed(Routes.CHECKOUT_PAGE,arguments: data);
                          }

                        },
                        width: 45.w,
                      ),
                    ),
                  ],
                )
              ],
            ),
          );
        }),
      ));

  }

  void addDiscount({CartModel? cart, bool allProduct = false}) {
    controller.discountController;
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) => Container(
        height: Get.height * 0.9,
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        child: Obx(() {
          return Column(
            children: [
              Center(child: Text("Daftar Diskon Tersedia", style: GoogleFonts.roboto(fontWeight: FontWeight.bold))),
              controller.discountController.listDiscount.length == 0
                  ? Padding(
                    padding: const EdgeInsets.only(top: 250),
                    child: Column(
                      children: [
                        Center(
                            child:  Text("Diskon Kosong"),
                          ),
                        SizedBox(height: 20,),
                        GeneralButton(label: 'tambah_diskon'.tr, onPressed: ()=> Get.toNamed(Routes.ADD_DISCOUNT),height: 30,width: 200,)
                      ],
                    ),
                  )
                  : Expanded(
                      child: ListView.builder(
                          itemCount: controller.discountController.listDiscount.length,
                          shrinkWrap: true,
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          physics: ClampingScrollPhysics(),
                          itemBuilder: (c, i) {
                            return Card(
                              elevation: 2,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ListTile(
                                  onTap: () {
                                    cartController.addDiscount(dataDiscount: controller.discountController.listDiscount[i], allProduct: allProduct, cartModel: cart);
                                    Get.back();
                                  },
                                  dense: true,
                                  title: Text("${controller.discountController.listDiscount[i].discountName}"),
                                  subtitle: controller.discountController.listDiscount[i].discountType == "percent"
                                      ? controller.discountController.listDiscount[i].discountMaxPriceOff == "0" || controller.discountController.listDiscount[i].discountMaxPriceOff == null
                                          ? Container()
                                          : Text(
                                              "Max. Discount Rp ${formatCurrency.format(int.parse(controller.discountController.listDiscount[i].discountMaxPriceOff!))}",
                                              style: GoogleFonts.roboto(fontWeight: FontWeight.bold),
                                            )
                                      : Container(),
                                  trailing: Text(
                                    controller.discountController.listDiscount[i].discountType == "percent"
                                        ? "${controller.discountController.listDiscount[i].discountPercent}%"
                                        : "Rp ${formatCurrency.format(int.parse(controller.discountController.listDiscount[i].discountMaxPriceOff!))}",
                                    style: GoogleFonts.roboto(fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            );
                          }),
                    )
            ],
          );
        }),
      ),
    );
  }

  Future showBottomSheetContact() {
    return Get.bottomSheet(BottomDialogContact(), isScrollControlled: true, elevation: 3);
  }
}
