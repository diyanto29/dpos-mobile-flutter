import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:warmi/app/data/models/transactions/transaction_model.dart';
import 'package:warmi/app/modules/transaction/controllers/cart_controller.dart';
import 'package:warmi/app/modules/transaction/controllers/transaction_controller.dart';
import 'package:warmi/app/modules/transaction/views/mobile/checkout_cash_view.dart';
import 'package:warmi/app/modules/transaction/views/mobile/checkout_cashless_view.dart';
import 'package:warmi/app/modules/wigets/layouts/dialog/dialog_noted.dart';
import 'package:warmi/app/modules/wigets/layouts/general_button.dart';
import 'package:warmi/app/routes/app_pages.dart';
import 'package:warmi/core/globals/global_color.dart';
import 'package:warmi/core/utils/thema.dart';
import 'package:recase/recase.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../../main.dart';

class CheckOutTableView extends StatefulWidget {
  const CheckOutTableView({Key? key}) : super(key: key);

  @override
  State<CheckOutTableView> createState() => _CheckOutTableViewState();
}

class _CheckOutTableViewState extends State<CheckOutTableView> {
  var controller=Get.find<TransactionController>();
  var cartController = Get.find<CartController>();
  var type,data;
  @override
  void initState() {
    print("ijni cart");
      print(cartController.listCart.length);
     type =Get.arguments != null ? Get.arguments['from'] : "cart";
     data =Get.arguments != null ? Get.arguments['data'] != null ? Get.arguments['data'] as DataTransaction : null :null ;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: MyColor.colorBackground,
      appBar: AppBar(
        backgroundColor: MyColor.colorPrimary,
        title: Text('metode_pembayaran'.tr),
      ),
      body: Obx(() {
        return Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
                flex: 3,
                child: Column(
                  children: [
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(color: MyColor.colorPrimary,),
                      padding: const EdgeInsets.all(8),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Transaksi Baru",
                            style: whiteTextTitle,
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            DateFormat("EEEE, dd MMMM yyyy", 'id-ID').format(DateTime.now()),
                            style: whiteTextTitle.copyWith(color: MyColor.colorBlack5, fontSize: 12.sp),
                          ),
                          SizedBox(
                            height: 10,
                          ),
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
                    Expanded(
                        child: Column(
                          children: [
                            Expanded(
                              child: MediaQuery.removePadding(
                                context: context,
                                removeTop: true,
                                child: ListView.builder(
                                    itemCount: cartController.listCart.length,
                                    shrinkWrap: true,
                                    physics: ClampingScrollPhysics(),
                                    itemBuilder: (c, i) =>
                                        Container(
                                          decoration: BoxDecoration(color: Colors.white),
                                          child: Padding(
                                            padding: const EdgeInsets.only(bottom: 20.0, top: 8, left: 8, right: 8),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: [
                                                Flexible(
                                                    flex: 3,
                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.start,
                                                      crossAxisAlignment: CrossAxisAlignment.center,
                                                      children: [
                                                        Container(
                                                          height: 30,
                                                          width: 30,
                                                          padding: const EdgeInsets.all(8),
                                                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: MyColor.colorOrange),
                                                          alignment: Alignment.center,
                                                          child: Text(
                                                            "${cartController.listCart[i].qty}",
                                                            style: whiteTextTitle.copyWith(fontSize: 10.sp, fontWeight: FontWeight.bold),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          width: 10,
                                                        ),
                                                        Flexible(
                                                            child: Column(
                                                              mainAxisAlignment: MainAxisAlignment.start,
                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                              children: [
                                                                Text(
                                                                  "${cartController.listCart[i].dataProduct!.productName}",
                                                                  style: blackTextFont.copyWith(fontSize: 12.sp),
                                                                ),
                                                                SizedBox(
                                                                  height: 4,
                                                                ),
                                                                if (cartController.listCart[i].discount == null)
                                                                  Text(
                                                                    "Klik untuk tambah diskon",
                                                                    style: blackTextFont.copyWith(fontSize: 10.sp, fontStyle: FontStyle.italic),
                                                                  )
                                                              ],
                                                            ))
                                                      ],
                                                    )),
                                                Flexible(
                                                    flex: 2,
                                                    child: Column(
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      crossAxisAlignment: CrossAxisAlignment.end,
                                                      children: [
                                                        Row(
                                                          mainAxisAlignment: MainAxisAlignment.end,
                                                          children: [
                                                            Text(
                                                              "@ ${formatCurrency.format(cartController.listCart[i].dataProduct!.productPrice)}",
                                                              style: blackTextFont.copyWith(fontSize: 12.sp),
                                                            ),


                                                          ],
                                                        ),
                                                        SizedBox(
                                                          height: 5,
                                                        ),
                                                        if (cartController.listCart[i].discount != null)
                                                          Row(
                                                            mainAxisAlignment: MainAxisAlignment.end,
                                                            children: [
                                                              Text(
                                                                "${cartController.listCart[i].discount!.discountType!.toLowerCase() == 'price' ? ' - Rp.' + formatCurrency.format(int.parse(cartController.listCart[i].discount!.discountMaxPriceOff!)) : cartController.listCart[i].discount!
                                                                    .discountPercent + '%'}",
                                                                style: GoogleFonts.roboto(color: Colors.red, fontWeight: FontWeight.bold, fontSize: 12.sp),
                                                              ),

                                                            ],
                                                          ),
                                                        if (cartController.listCart[i].discount != null)
                                                          if (cartController.listCart[i].discount!.discountType != 'price')
                                                            Padding(
                                                              padding: const EdgeInsets.fromLTRB(8, 2, 8, 10),
                                                              child: Row(
                                                                mainAxisAlignment: MainAxisAlignment.end,
                                                                crossAxisAlignment: CrossAxisAlignment.end,
                                                                children: [
                                                                  Text(
                                                                    "Max Diskon : ",
                                                                    style: blackTextFont.copyWith(fontSize: 11.sp),
                                                                  ),
                                                                  Text(
                                                                    "- Rp.${formatCurrency.format(int.parse(cartController.listCart[i].discount!.discountMaxPriceOff!))}",
                                                                    style: GoogleFonts.roboto(color: Colors.red, fontWeight: FontWeight.bold, fontSize: 11.sp),
                                                                  ),
                                                                ],
                                                              ),
                                                            )
                                                      ],
                                                    ))
                                              ],
                                            ),
                                          ),
                                        )),
                              ),
                            ),
                            Card(
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                              elevation: 0.4,
                              child: Container(
                                padding: const EdgeInsets.all(8),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          "Sub Total",
                                          style: GoogleFonts.roboto(fontWeight: FontWeight.bold, fontSize: 12.sp),
                                        ),
                                        Text(
                                          "Rp.${formatCurrency.format(cartController.totalCart.value)}",
                                          style: GoogleFonts.roboto(fontWeight: FontWeight.bold, fontSize: 12.sp),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          'diskon'.tr,
                                          style: GoogleFonts.roboto(fontWeight: FontWeight.bold, fontSize: 12.sp),
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            cartController.dataDiscount != null
                                                ? Text(
                                              "${cartController.dataDiscount?.discountType!.toLowerCase() == 'price' ? ' - Rp.' + formatCurrency.format(int.parse(cartController.dataDiscount!.discountMaxPriceOff!)) : cartController.dataDiscount?.discountPercent + '%'}",
                                              style: GoogleFonts.roboto(color: Colors.red, fontWeight: FontWeight.bold, fontSize: 12.sp),
                                            )
                                                : Icon(
                                              Icons.arrow_forward_ios_rounded,
                                              size: 15,
                                            ),
                                            SizedBox(
                                              width: 4,
                                            ),

                                          ],
                                        ),
                                      ],
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
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Flexible(
                                          flex: 2,
                                          child: Container(
                                            height: GetPlatform.isWindows ?80 :40,
                                            width: GetPlatform.isWindows ? 80:40,
                                            decoration: BoxDecoration(color: MyColor.colorRedFlat, borderRadius: BorderRadius.circular(5)),
                                            child: IconButton(
                                              color: Colors.white,
                                              onPressed: () =>
                                                  showDialogNoted(
                                                      title: 'Masukan Catatan',
                                                      message: 'coba',
                                                      clickYes: () {
                                                        cartController.storeTransaction();
                                                      }),
                                              icon: Icon(Icons.save),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Flexible(
                                          flex: 7,
                                          child: GeneralButton(
                                            label: "Rp ${formatCurrency.format(cartController.totalShopping.value)}",
                                            borderRadius: 10,
                                            fontSize: 16.sp,
                                            onPressed: () {
                                              Map<dynamic, dynamic> data = {"from": "cart", "data": null};
                                              Get.toNamed(Routes.CHECKOUT_TABLET, arguments: data);
                                            },
                                            height: GetPlatform.isWindows ? 80 :45,
                                          ),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            )
                          ],
                        )),
                  ],
                )),
            Expanded(
                flex: 6,
                child:Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0,horizontal: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                     Row(
                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                       crossAxisAlignment: CrossAxisAlignment.center,
                       children: [
                        Flexible(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Total Tagihan",
                                style: blackTextTitle.copyWith(fontWeight: FontWeight.normal),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                "Rp ${formatCurrency.format(cartController.totalShopping.value)}",
                                style: blackTextTitle.copyWith(fontSize: 23.sp),
                              ),
                            ],
                          ),
                        ),
                         Flexible(
                           child: Column(
                             mainAxisAlignment: MainAxisAlignment.end,
                             crossAxisAlignment: CrossAxisAlignment.end,
                             children: [
                               Text(
                                 'kembalian'.tr,
                                 style: blackTextTitle.copyWith(fontWeight: FontWeight.normal),
                               ),
                               SizedBox(
                                 height: 5,
                               ),
                               Text(
                                 "Rp ${formatCurrency.format(controller.cashReceived.value)}",
                                 style: blackTextTitle.copyWith(fontSize: 23.sp),
                               ),
                             ],
                           ),
                         )
                       ],
                     ),
                      SizedBox(
                        height: 5,
                      ),
                      TabBar(
                        unselectedLabelColor: MyColor.colorBlackT50,
                        indicatorColor: MyColor.colorPrimary,
                        labelColor: MyColor.colorPrimary,
                        indicatorSize: TabBarIndicatorSize.tab,
                        onTap: (v) {
                          controller.controllerPageCheckout.jumpToPage(v);
                          controller.indexCheckout(v);
                        },
                        tabs: controller.tabsCheckout,
                        labelStyle: blackTextFont.copyWith(fontSize: 12, fontWeight: FontWeight.bold),
                        controller: controller.tabControllerCheckout,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Expanded(
                        child: PageView(
                          allowImplicitScrolling: true,
                          onPageChanged: (v) {
                            controller.tabControllerCheckout!.index = v;
                          },
                          controller: controller.controllerPageCheckout,
                          children: controller.tabsCheckout.map<Widget>((Tab tab) {
                            if (tab.text == 'tunai'.tr.tr) {
                              return CheckoutCashView();
                            } else if (tab.text == 'non_tunai'.tr) {
                              return CheckoutCashlessView();
                            } else {
                              return Container();
                            }
                          }).toList(),
                        ),
                      ),
                      Container(
                          padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),

                          child: GeneralButton(onPressed: (){
                            if(type=="cart"){
                              controller.storeTransaction();
                            }else{
                              controller.changeStatusTransaction(dataTransaction: data);
                            }
                          },label: 'lanjut'.tr,borderRadius: 10,height: GetPlatform.isWindows ? 80 :45,fontSize: GetPlatform.isWindows ? 14.sp : 12.sp,))
                    ],
                  ),
                ))
          ],
        );
      }),
    );
  }
}
