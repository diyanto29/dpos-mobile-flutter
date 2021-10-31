import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:warmi/app/modules/owner/settings/controllers/payment_method_controller.dart';
import 'package:warmi/app/modules/transaction/controllers/transaction_controller.dart';
import 'package:warmi/core/globals/global_color.dart';
import 'package:warmi/core/utils/enum.dart';

class CheckoutCashlessView extends StatefulWidget {
  const CheckoutCashlessView({Key? key}) : super(key: key);

  @override
  _CheckoutCashlessViewState createState() => _CheckoutCashlessViewState();
}

class _CheckoutCashlessViewState extends State<CheckoutCashlessView> {
  var conPaymentMethod = Get.find<PaymentMethodController>();
  var conTransaction = Get.find<TransactionController>();


  @override
  void initState() {
    conPaymentMethod.getPaymentMethod();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return
        conPaymentMethod.loadingState.value == LoadingState.loading ? Center(child: CircularProgressIndicator(),) :
        ListView.builder(
          shrinkWrap: true,
          itemCount: conPaymentMethod.listPaymentMethod.length,
          itemBuilder: (BuildContext context, int index) {
            var data = conPaymentMethod.listPaymentMethod[index];
            return Visibility(
              visible:  data.paymentmethodstatus ==
                    "Active"
                    ? true
                    : false,
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                    color: MyColor.colorBlack5,
                    borderRadius: BorderRadius.circular(10)
                ),
                margin: const EdgeInsets.only(bottom: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("${data.paymentmethodtypealias}"),
                    LayoutBuilder(builder: (context,constraints){
                      return   GetBuilder<TransactionController>(builder: (logic) {
                        return GridView.count(
                          primary: true,
                          shrinkWrap: true,
                          childAspectRatio:  constraints.maxWidth>=600 ? 8.3/2.5 :  14 / 9,
                          physics: NeverScrollableScrollPhysics(),
                          crossAxisCount: 3,
                          children: data.paymentMethod!.map((e) =>
                              Visibility(
                                visible: e.status == "Active"
                                    ? true
                                    : false,
                                child: InkWell(
                                  onTap: () => conTransaction.setPaymentMethod(payment_method: e),
                                  child: Card(
                                    borderOnForeground: true,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(5),
                                        side: e.paymentmethodid == conTransaction.paymentMethod.value.paymentmethodid ? BorderSide(color: MyColor.colorPrimary) : BorderSide.none
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: CachedNetworkImage(
                                        imageUrl:
                                        "${e.paymentmethodlogo}",
                                        height: 50,
                                        width: 80,
                                      ),
                                    ),
                                  ),
                                ),
                              ),).toList(),
                        );
                      });
                    })

                  ],
                ),
              ),
            );
          },

        );
    });
  }
}
