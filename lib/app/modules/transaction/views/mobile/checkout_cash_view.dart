import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:warmi/app/modules/transaction/controllers/cart_controller.dart';
import 'package:warmi/app/modules/transaction/controllers/transaction_controller.dart';
import 'package:warmi/app/modules/wigets/layouts/general_button.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:warmi/app/modules/wigets/layouts/general_text_input.dart';
import 'package:warmi/core/globals/global_color.dart';
import 'package:warmi/core/utils/format_currency.dart';
import 'package:warmi/core/utils/responsive_layout.dart';
import 'package:warmi/core/utils/thema.dart';

import '../../../../../main.dart';

class CheckoutCashView extends StatefulWidget {
  const CheckoutCashView({Key? key}) : super(key: key);

  @override
  _CheckoutCashViewState createState() => _CheckoutCashViewState();
}

class _CheckoutCashViewState extends State<CheckoutCashView> {
  var conTransaction = Get.find<TransactionController>();
  var conCart = Get.find<CartController>();

  @override
  void initState() {
    conTransaction.cashC.value.text = "Rp 0";
    conTransaction.is20(false);
    conTransaction.is50(false);
    conTransaction.is100(false);
    conTransaction.isPassed(false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context,constrain){
      if(Get.mediaQuery.orientation==Orientation.landscape){
        return Obx(() {
          return ListView(
            children: [
              SizedBox(
                height: 3,
              ),
              Text(
                "Uang Terima",
                style: blackTextTitle.copyWith(fontWeight: FontWeight.normal, fontSize: 16.sp),
              ),
              TextField(
                controller: conTransaction.cashC.value,
                keyboardType: TextInputType.number,
                style: GoogleFonts.roboto(fontSize: 18.sp),
                inputFormatters: [
                  WhitelistingTextInputFormatter.digitsOnly,
                  CurrencyPtBrInputFormatter(maxDigits: 10, currency: "Rp "),
                ],
                onChanged: (v) {
                  print(v);
                  conTransaction.is20(false);
                  conTransaction.is50(false);
                  conTransaction.is100(false);
                  conTransaction.isPassed(false);
                  conTransaction.pay(double.tryParse(conTransaction.cashC.value.text
                      .split(" ")
                      .last
                      .replaceAll(".", "")));
                  conTransaction.getCashReceived();
                },
                decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: MyColor.colorPrimary, width: 2.0),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(color: MyColor.colorPrimary, width: 2.0),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    hintText: "Rp 0",
                    labelStyle: GoogleFonts.droidSans(color: Colors.grey)),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Flexible(
                    child: Container(
                        height: 45,
                        width: Get.width * 0.6,
                        child: GeneralButton(
                            borderRadius: 10,
                            color: conTransaction.is20.value ? MyColor.colorGreen : MyColor.colorPrimary,
                            label: '20.000',
                            onPressed: () {
                              conTransaction.is20.value = !conTransaction.is20.value;
                              conTransaction.getPayMoney20();
                            },
                            fontSize: 18.sp)),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Flexible(
                    child: Container(
                        height: 45,
                        width: Get.width * 0.6,
                        child: GeneralButton(
                            borderRadius: 10,
                            color: conTransaction.is50.value ? MyColor.colorGreen : MyColor.colorPrimary,
                            label: '50.000',
                            onPressed: () {
                              conTransaction.is50.value = !conTransaction.is50.value;
                              conTransaction.getPayMoney50();
                            },
                            fontSize: 18.sp)),
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
                  Flexible(
                    child: Container(
                        height: 45,
                        width: Get.width * 0.6,
                        child: GeneralButton(
                            borderRadius: 10,
                            color: conTransaction.is100.value ? MyColor.colorGreen : MyColor.colorPrimary,
                            label: '100.000',
                            onPressed: () {
                              conTransaction.is100.value = !conTransaction.is100.value;
                              conTransaction.getPayMoney100();
                            },
                            fontSize: 18.sp)),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Flexible(
                    child: Container(
                        height: 45,
                        width: Get.width * 0.6,
                        child: GeneralButton(
                            borderRadius: 10,
                            color: conTransaction.isPassed.value ? MyColor.colorGreen : MyColor.colorPrimary,
                            label: 'Uang Pass',
                            onPressed: () {
                              conTransaction.isPassed.value = !conTransaction.isPassed.value;
                              conTransaction.getMoneyPassed(conCart.totalShopping.value);
                            },
                            fontSize: 18.sp)),
                  ),
                ],
              ),
              SizedBox(
                height: 30,
              ),


            ],
          );
        });
      }else{
        return Obx(() {
          return ListView(
            children: [
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Flexible(
                    child: Container(
                        height: 45,
                        width: Get.width * 0.6,
                        child: GeneralButton(
                            borderRadius: 10,
                            color: conTransaction.is20.value ? MyColor.colorGreen : MyColor.colorPrimary,
                            label: '20.000',
                            onPressed: () {
                              conTransaction.is20.value = !conTransaction.is20.value;
                              conTransaction.getPayMoney20();
                            },
                            fontSize: 18.sp)),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Flexible(
                    child: Container(
                        height: 45,
                        width: Get.width * 0.6,
                        child: GeneralButton(
                            borderRadius: 10,
                            color: conTransaction.is50.value ? MyColor.colorGreen : MyColor.colorPrimary,
                            label: '50.000',
                            onPressed: () {
                              conTransaction.is50.value = !conTransaction.is50.value;
                              conTransaction.getPayMoney50();
                            },
                            fontSize: 18.sp)),
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
                  Flexible(
                    child: Container(
                        height: 45,
                        width: Get.width * 0.6,
                        child: GeneralButton(
                            borderRadius: 10,
                            color: conTransaction.is100.value ? MyColor.colorGreen : MyColor.colorPrimary,
                            label: '100.000',
                            onPressed: () {
                              conTransaction.is100.value = !conTransaction.is100.value;
                              conTransaction.getPayMoney100();
                            },
                            fontSize: 18.sp)),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Flexible(
                    child: Container(
                        height: 45,
                        width: Get.width * 0.6,
                        child: GeneralButton(
                            borderRadius: 10,
                            color: conTransaction.isPassed.value ? MyColor.colorGreen : MyColor.colorPrimary,
                            label: 'Uang Pass',
                            onPressed: () {
                              conTransaction.isPassed.value = !conTransaction.isPassed.value;
                              conTransaction.getMoneyPassed(conCart.totalShopping.value);
                            },
                            fontSize: 18.sp)),
                  ),
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                "Uang Terima",
                style: blackTextTitle.copyWith(fontWeight: FontWeight.normal, fontSize: 16.sp),
              ),
              SizedBox(
                height: 5,
              ),
              TextField(
                controller: conTransaction.cashC.value,
                keyboardType: TextInputType.number,
                style: GoogleFonts.roboto(fontSize: 18.sp),
                inputFormatters: [
                  WhitelistingTextInputFormatter.digitsOnly,
                  CurrencyPtBrInputFormatter(maxDigits: 10, currency: "Rp "),
                ],
                onChanged: (v) {
                  print(v);
                  conTransaction.is20(false);
                  conTransaction.is50(false);
                  conTransaction.is100(false);
                  conTransaction.isPassed(false);
                  conTransaction.pay(double.tryParse(conTransaction.cashC.value.text
                      .split(" ")
                      .last
                      .replaceAll(".", "")));
                  conTransaction.getCashReceived();
                },
                decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: MyColor.colorPrimary, width: 2.0),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(color: MyColor.colorPrimary, width: 2.0),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    hintText: "Rp 0",
                    labelStyle: GoogleFonts.droidSans(color: Colors.grey)),
              ),
              SizedBox(
                height: 15,
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                "Total Kembalian",
                style: blackTextTitle.copyWith(fontWeight: FontWeight.normal),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                "Rp ${formatCurrency.format(conTransaction.cashReceived.value)}",
                style: blackTextTitle.copyWith(fontSize: 23.sp),
              ),

            ],
          );
        });
      }
    });
    return ResponsiveBuilder(desktop: Container(),
      mobile: Obx(() {
        return ListView(
          children: [
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Flexible(
                  child: Container(
                      height: 45,
                      width: Get.width * 0.6,
                      child: GeneralButton(
                          borderRadius: 10,
                          color: conTransaction.is20.value ? MyColor.colorGreen : MyColor.colorPrimary,
                          label: '20.000',
                          onPressed: () {
                            conTransaction.is20.value = !conTransaction.is20.value;
                            conTransaction.getPayMoney20();
                          },
                          fontSize: 18.sp)),
                ),
                SizedBox(
                  width: 10,
                ),
                Flexible(
                  child: Container(
                      height: 45,
                      width: Get.width * 0.6,
                      child: GeneralButton(
                          borderRadius: 10,
                          color: conTransaction.is50.value ? MyColor.colorGreen : MyColor.colorPrimary,
                          label: '50.000',
                          onPressed: () {
                            conTransaction.is50.value = !conTransaction.is50.value;
                            conTransaction.getPayMoney50();
                          },
                          fontSize: 18.sp)),
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
                Flexible(
                  child: Container(
                      height: 45,
                      width: Get.width * 0.6,
                      child: GeneralButton(
                          borderRadius: 10,
                          color: conTransaction.is100.value ? MyColor.colorGreen : MyColor.colorPrimary,
                          label: '100.000',
                          onPressed: () {
                            conTransaction.is100.value = !conTransaction.is100.value;
                            conTransaction.getPayMoney100();
                          },
                          fontSize: 18.sp)),
                ),
                SizedBox(
                  width: 10,
                ),
                Flexible(
                  child: Container(
                      height: 45,
                      width: Get.width * 0.6,
                      child: GeneralButton(
                          borderRadius: 10,
                          color: conTransaction.isPassed.value ? MyColor.colorGreen : MyColor.colorPrimary,
                          label: 'Uang Pass',
                          onPressed: () {
                            conTransaction.isPassed.value = !conTransaction.isPassed.value;
                            conTransaction.getMoneyPassed(conCart.totalShopping.value);
                          },
                          fontSize: 18.sp)),
                ),
              ],
            ),
            SizedBox(
              height: 30,
            ),
            Text(
              "Uang Terima",
              style: blackTextTitle.copyWith(fontWeight: FontWeight.normal, fontSize: 16.sp),
            ),
            SizedBox(
              height: 5,
            ),
            TextField(
              controller: conTransaction.cashC.value,
              keyboardType: TextInputType.number,
              style: GoogleFonts.roboto(fontSize: 18.sp),
              inputFormatters: [
                WhitelistingTextInputFormatter.digitsOnly,
                CurrencyPtBrInputFormatter(maxDigits: 10, currency: "Rp "),
              ],
              onChanged: (v) {
                print(v);
                conTransaction.is20(false);
                conTransaction.is50(false);
                conTransaction.is100(false);
                conTransaction.isPassed(false);
                conTransaction.pay(double.tryParse(conTransaction.cashC.value.text
                    .split(" ")
                    .last
                    .replaceAll(".", "")));
                conTransaction.getCashReceived();
              },
              decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: MyColor.colorPrimary, width: 2.0),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  border: OutlineInputBorder(
                    borderSide: const BorderSide(color: MyColor.colorPrimary, width: 2.0),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  hintText: "Rp 0",
                  labelStyle: GoogleFonts.droidSans(color: Colors.grey)),
            ),
            SizedBox(
              height: 15,
            ),
            SizedBox(
              height: 15,
            ),
            Text(
              'total_kembalian'.tr,
              style: blackTextTitle.copyWith(fontWeight: FontWeight.normal),
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              "Rp ${formatCurrency.format(conTransaction.cashReceived.value)}",
              style: blackTextTitle.copyWith(fontSize: 23.sp),
            ),

          ],
        );
      }),
      tablet: Obx(() {
        return ListView(
          children: [
            SizedBox(
              height: 3,
            ),
            Text(
              "Uang Terima",
              style: blackTextTitle.copyWith(fontWeight: FontWeight.normal, fontSize: 16.sp),
            ),
            TextField(
              controller: conTransaction.cashC.value,
              keyboardType: TextInputType.number,
              style: GoogleFonts.roboto(fontSize: 18.sp),
              inputFormatters: [
                WhitelistingTextInputFormatter.digitsOnly,
                CurrencyPtBrInputFormatter(maxDigits: 10, currency: "Rp "),
              ],
              onChanged: (v) {
                print(v);
                conTransaction.is20(false);
                conTransaction.is50(false);
                conTransaction.is100(false);
                conTransaction.isPassed(false);
                conTransaction.pay(double.tryParse(conTransaction.cashC.value.text
                    .split(" ")
                    .last
                    .replaceAll(".", "")));
                conTransaction.getCashReceived();
              },
              decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: MyColor.colorPrimary, width: 2.0),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  border: OutlineInputBorder(
                    borderSide: const BorderSide(color: MyColor.colorPrimary, width: 2.0),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  hintText: "Rp 0",
                  labelStyle: GoogleFonts.droidSans(color: Colors.grey)),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Flexible(
                  child: Container(
                      height: 45,
                      width: Get.width * 0.6,
                      child: GeneralButton(
                          borderRadius: 10,
                          color: conTransaction.is20.value ? MyColor.colorGreen : MyColor.colorPrimary,
                          label: '20.000',
                          onPressed: () {
                            conTransaction.is20.value = !conTransaction.is20.value;
                            conTransaction.getPayMoney20();
                          },
                          fontSize: 18.sp)),
                ),
                SizedBox(
                  width: 10,
                ),
                Flexible(
                  child: Container(
                      height: 45,
                      width: Get.width * 0.6,
                      child: GeneralButton(
                          borderRadius: 10,
                          color: conTransaction.is50.value ? MyColor.colorGreen : MyColor.colorPrimary,
                          label: '50.000',
                          onPressed: () {
                            conTransaction.is50.value = !conTransaction.is50.value;
                            conTransaction.getPayMoney50();
                          },
                          fontSize: 18.sp)),
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
                Flexible(
                  child: Container(
                      height: 45,
                      width: Get.width * 0.6,
                      child: GeneralButton(
                          borderRadius: 10,
                          color: conTransaction.is100.value ? MyColor.colorGreen : MyColor.colorPrimary,
                          label: '100.000',
                          onPressed: () {
                            conTransaction.is100.value = !conTransaction.is100.value;
                            conTransaction.getPayMoney100();
                          },
                          fontSize: 18.sp)),
                ),
                SizedBox(
                  width: 10,
                ),
                Flexible(
                  child: Container(
                      height: 45,
                      width: Get.width * 0.6,
                      child: GeneralButton(
                          borderRadius: 10,
                          color: conTransaction.isPassed.value ? MyColor.colorGreen : MyColor.colorPrimary,
                          label: 'Uang Pass',
                          onPressed: () {
                            conTransaction.isPassed.value = !conTransaction.isPassed.value;
                            conTransaction.getMoneyPassed(conCart.totalShopping.value);
                          },
                          fontSize: 18.sp)),
                ),
              ],
            ),
            SizedBox(
              height: 30,
            ),


          ],
        );
      }),);

  }
}
