import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_statusbarcolor_ns/flutter_statusbarcolor_ns.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:warmi/app/modules/owner/settings/controllers/payment_method_controller.dart';
import 'package:warmi/core/globals/global_color.dart';
import 'package:warmi/core/globals/global_string.dart';
import 'package:warmi/core/utils/enum.dart';
import 'package:warmi/core/utils/thema.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class PaymentMethodView extends GetWidget<PaymentMethodController> {
  @override
  Widget build(BuildContext context) {
    // FlutterStatusbarcolor.setStatusBarColor(MyColor.colorPrimary);
    return Scaffold(
      backgroundColor: MyColor.colorBackground,
      appBar: AppBar(
        backgroundColor: MyColor.colorPrimary,
        title: Text(
          'metode_pembayaran'.tr,
          style: whiteTextTitle,
        ),
      ),
      bottomNavigationBar: Container(
          margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          height: 50,
          width: double.infinity,
          child: ElevatedButton(
            child: Text(
              'simpan'.tr,
              style: GoogleFonts.droidSans(fontSize: 16),
            ),
            style: ElevatedButton.styleFrom(
                elevation: 1,
                primary: MyColor.colorPrimary,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25))),
            onPressed: () => controller.updatePaymentMethodChannel(),
          )),
      body: MediaQuery.removePadding(
        context: context,
        removeTop: true,
        child: Obx(() {
          return controller.loadingState == LoadingState.loading
              ? Center(child: CircularProgressIndicator())
              : ListView.builder(
                  itemCount: controller.listPaymentMethod.length,
                  padding: EdgeInsets.symmetric(
                      horizontal: MyString.DEFAULT_PADDING, vertical: 10),
                  itemBuilder: (c, i) {
                    var paymentMethodChannel = controller.listPaymentMethod[i];
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "${paymentMethodChannel.paymentmethodtypealias}",
                              style: GoogleFonts.roboto(
                                  fontWeight: FontWeight.bold, fontSize: 16.sp),
                            ),
                            GetBuilder<PaymentMethodController>(
                                builder: (logic) {
                              return Switch.adaptive(
                                value:
                                    paymentMethodChannel.paymentmethodstatus ==
                                            "Active"
                                        ? true
                                        : false,
                                activeColor: MyColor.colorPrimary,
                                onChanged: (v) {
                                  logic.changePaymentMethodChannel(
                                      value: v, i: i);
                                },
                              );
                            })
                          ],
                        ),
                        GetBuilder<PaymentMethodController>(builder: (logic) {
                          return Visibility(
                              visible:
                                  paymentMethodChannel.paymentmethodstatus ==
                                          "Active"
                                      ? true
                                      : false,
                              child: ListView.builder(
                                itemCount:
                                    paymentMethodChannel.paymentMethod!.length,
                                physics: ClampingScrollPhysics(),
                                shrinkWrap: true,
                                itemBuilder: (c, j) {
                                  var paymentMethod =
                                      paymentMethodChannel.paymentMethod![j];
                                  return Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      CheckboxListTile(
                                          secondary: CachedNetworkImage(
                                            imageUrl:
                                                "${paymentMethod.paymentmethodlogo}",
                                            height: 30,
                                            width: 50,
                                          ),
                                          title: Text(
                                            "${paymentMethod.paymentmethodalias}",
                                            style: GoogleFonts.roboto(
                                                fontSize: 16.sp),
                                          ),
                                          value:
                                              paymentMethod.status == 'Active'
                                                  ? true
                                                  : false,
                                          onChanged: (v) {
                                            logic.changePaymentMethod(
                                                value: v,
                                                indexPaymentMethodChannel: i,
                                                j: j);
                                          }),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 20),
                                        child: Divider(
                                          thickness: 2,
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              ));
                        }),
                        SizedBox(
                          height: 20,
                        ),
                      ],
                    );
                  },
                );
        }),
      ),
    );
  }
}
