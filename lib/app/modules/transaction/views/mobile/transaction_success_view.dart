import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:warmi/app/modules/transaction/controllers/cart_controller.dart';
import 'package:warmi/app/modules/transaction/controllers/transaction_controller.dart';
import 'package:warmi/app/modules/wigets/layouts/general_button.dart';
import 'package:warmi/app/routes/app_pages.dart';
import 'package:warmi/core/globals/global_color.dart';
import 'package:warmi/core/globals/global_string.dart';
import 'package:warmi/core/utils/thema.dart';
import 'package:recase/recase.dart';

import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../../main.dart';


class TransactionSuccessView extends StatefulWidget {
  const TransactionSuccessView({Key? key}) : super(key: key);

  @override
  State<TransactionSuccessView> createState() => _TransactionSuccessViewState();
}

class _TransactionSuccessViewState extends State<TransactionSuccessView> {
  var controller = Get.find<TransactionController>();
  var type;

  @override
  void initState() {
    type =  Get.arguments!=null ?  Get.arguments['type'] : "";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Get.offAllNamed(Routes.NAVIGATION);
        return true;
      },
      child: Scaffold(
        body: LayoutBuilder(builder: (context, constrains) {
          if (constrains.maxWidth <= 600) {
            return Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 100,),
                  Center(child: Image.asset("assets/icons/check-dollar.png",)),
                  SizedBox(height: 10,),
                  Text("Transaksi Success!", style: blackTextTitle.copyWith(fontSize: 16),),
                  SizedBox(height: 20,),
                  if(controller.paymentMethod.value.paymentmethodid == null)Text("Kembalian Rp ${formatCurrency.format(controller.cashReceived.value)}", style: blackTextTitle.copyWith(fontSize: 20),),
                  if(controller.paymentMethod.value.paymentmethodid != null)Container(
                    padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 3),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: MyColor.colorPrimary
                    ),
                    child: Text("Metode Pembayaran : ${type
                        .toString()
                        .titleCase} - ${controller.paymentMethod.value.paymentmethodalias.toString().toUpperCase()}", style: blackTextTitle.copyWith(fontSize: 15.sp, color: Colors.white),),
                  ),
                  SizedBox(height: 100,),
                  Container(
                    decoration: BoxDecoration(
                        color: MyColor.colorBlack5,
                        borderRadius: BorderRadius.circular(5)
                    ),
                    child: ListTile(
                      onTap: () => controller.sendInvoice(),
                      title: Text("Bagikan Nota Transaksi"),
                      trailing: Icon(Icons.share),
                    ),
                  ),
                  SizedBox(height: 10,),
                  GetBuilder<TransactionController>(builder: (logic) {
                    print(logic.isBannerAdReady);
                    return logic.isBannerAdReady ?  Container(
                      height: 60,
                      width: controller.bannerAd.size.width.toDouble(),
                      child: AdWidget(ad: controller.bannerAd),
                    ) : Container();
                  }),
                  Spacer(),
                  GeneralButton(onPressed: () => controller.printNow(), label: 'Cetak Struk',),
                  SizedBox(height: 10,),
                  GeneralButton(onPressed: () async {
                    if (controller.isInterstitialAdReady)
                      Future.delayed(Duration(seconds: 2),(){
                        controller.interstitialAd.show();
                      });
                    var box = GetStorage();
                    if (box.read(MyString.ROLE_NAME) == "Pemilik Toko")
                      Get.offAllNamed(Routes.NAVIGATION);
                    else
                      Get.offAllNamed(Routes.INDEX_TRANSACTION);
                  }, label: 'Transaksi Baru', color: MyColor.colorGreen,),

                ],
              ),
            );
          } else {
            return Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Flexible(
                    flex: 6,
                    child: Column(
                      children: [
                        SizedBox(height: 100,),
                        Center(child: Image.asset("assets/icons/check-dollar.png",)),
                        SizedBox(height: 10,),
                        Text("Transaksi Success!", style: blackTextTitle.copyWith(fontSize: 16),),
                        SizedBox(height: 20,),
                        if(controller.paymentMethod.value.paymentmethodid == null)Text("Kembalian Rp ${formatCurrency.format(controller.cashReceived.value)}", style: blackTextTitle.copyWith(fontSize: 20),),
                        if(controller.paymentMethod.value.paymentmethodid != null)Container(
                          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 3),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: MyColor.colorPrimary
                          ),
                          child: Text("Metode Pembayaran : ${type
                              .toString()
                              .titleCase} - ${controller.paymentMethod.value.paymentmethodalias.toString().toUpperCase()}", style: blackTextTitle.copyWith(fontSize: 15.sp, color: Colors.white),),
                        ),
                        SizedBox(height: 10,),
                        GetBuilder<TransactionController>(builder: (logic) {
                          return logic.isBannerAdReady ?  Container(
                            height:60,
                            width: controller.bannerAd.size.width.toDouble(),
                            child: AdWidget(ad: controller.bannerAd),
                          ) : Container();
                        }),
                      ],
                    ),
                  ),
                  Flexible(
                      flex: 6,
                      child: Column(children: [
                        SizedBox(height: 100,),
                        Container(
                          decoration: BoxDecoration(
                              color: MyColor.colorBlack5,
                              borderRadius: BorderRadius.circular(5)
                          ),
                          child: ListTile(
                            onTap: () => controller.sendInvoice(),
                            title: Text("Bagikan Nota Transaksi"),
                            trailing: Icon(Icons.share),
                          ),
                        ),
                        SizedBox(height: 20,),

                        GeneralButton(onPressed: () => controller.printNow(), label: 'Cetak Struk',),
                        SizedBox(height: 10,),
                        GeneralButton(onPressed: () async {
                          if (controller.isInterstitialAdReady)
                            Future.delayed(Duration(seconds: 2),(){
                              controller.interstitialAd.show();
                            });
                          var box = GetStorage();
                          if (box.read(MyString.ROLE_NAME) == "Pemilik Toko")
                            Get.offAllNamed(Routes.NAVIGATION);
                          else
                            Get.offAllNamed(Routes.INDEX_TRANSACTION);
                        }, label: 'Transaksi Baru', color: MyColor.colorGreen,),

                      ],))

                ],
              ),
            );
          }
        },),
      ),
    );
  }
}
