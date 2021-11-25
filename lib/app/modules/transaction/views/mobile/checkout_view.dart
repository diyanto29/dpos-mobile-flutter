import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:warmi/app/data/models/transactions/transaction_model.dart';
import 'package:warmi/app/modules/transaction/controllers/cart_controller.dart';
import 'package:warmi/app/modules/transaction/controllers/transaction_controller.dart';
import 'package:warmi/app/modules/transaction/views/mobile/checkout_cash_view.dart';
import 'package:warmi/app/modules/transaction/views/mobile/checkout_cashless_view.dart';
import 'package:warmi/app/modules/wigets/layouts/general_button.dart';
import 'package:warmi/core/globals/global_color.dart';
import 'package:warmi/core/utils/thema.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:warmi/main.dart';

class CheckoutView extends GetWidget<TransactionController> {
  @override
  Widget build(BuildContext context) {
    var conTransaction = Get.find<TransactionController>();
    var type=Get.arguments['from'];
    print(type);
    var data=Get.arguments['data']!=null ? Get.arguments['data'] as DataTransaction : null;
    print(type);
    return Scaffold(
      backgroundColor: MyColor.colorBackground,
      appBar: AppBar(
        backgroundColor: MyColor.colorPrimary,
        title: Text('metode_pembayaran'.tr),
        actions: [
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
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
              "Rp ${formatCurrency.format(conTransaction.totalShopping.value)}",
              style: blackTextTitle.copyWith(fontSize: 23.sp),
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
          ],
        ),
      ),
      bottomNavigationBar: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
          child: GeneralButton(onPressed: (){
            print("asda");
            if(type=="cart"){
              controller.storeTransaction();
            }else{
              controller.changeStatusTransaction(dataTransaction: data);
            }
          },label: 'lanjut'.tr,)),
    );
  }
}
