import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:warmi/app/modules/transaction/controllers/cart_controller.dart';
import 'package:warmi/app/modules/transaction/controllers/transaction_controller.dart';
import 'package:warmi/app/modules/wigets/layouts/general_button.dart';
import 'package:warmi/app/routes/app_pages.dart';
import 'package:warmi/core/globals/global_color.dart';
import 'package:warmi/core/utils/thema.dart';
import 'package:recase/recase.dart';

import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../../main.dart';


class TransactionSuccessView extends GetWidget<TransactionController> {
  const TransactionSuccessView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(Get.arguments);
    var type=Get.arguments['type'];

    return WillPopScope(
      onWillPop: ()async{
        Get.offAllNamed(Routes.NAVIGATION);
        return true;
      },
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 100,),
              Center(child: Image.asset("assets/icons/check-dollar.png",)),
              SizedBox(height: 10,),
              Text("Transaksi Success!",style: blackTextTitle.copyWith(fontSize: 16),),
              SizedBox(height: 20,),
              if(controller.paymentMethod.value.paymentmethodid==null)Text("Kembalian Rp ${formatCurrency.format(controller.cashReceived.value)}",style: blackTextTitle.copyWith(fontSize: 20),),
              if(controller.paymentMethod.value.paymentmethodid!=null)Container(
                padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 3),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: MyColor.colorPrimary
                ),
                child: Text("Metode Pembayaran : ${type.toString().titleCase} - ${controller.paymentMethod.value.paymentmethodalias.toString().toUpperCase()}",style: blackTextTitle.copyWith(fontSize: 15.sp,color: Colors.white),),
              ),
              SizedBox(height: 100,),
              Container(
                decoration: BoxDecoration(
                  color: MyColor.colorBlack5,
                  borderRadius: BorderRadius.circular(5)
                ),
                child: ListTile(
                  onTap: ()=> controller.sendInvoice(),
                  title: Text("Bagikan Nota Transaksi"),
                  trailing: Icon(Icons.share),
                ),
              ),
              Spacer(),
              GeneralButton(onPressed: ()=> controller.printNow(),label: 'Cetak Struk',),
              SizedBox(height: 10,),
              GeneralButton(onPressed: ()=> Get.offAllNamed(Routes.NAVIGATION),label: 'Transaksi Baru',color: MyColor.colorGreen,),

            ],
          ),
        ),
      ),
    );
  }
}
