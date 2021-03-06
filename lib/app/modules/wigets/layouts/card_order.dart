import 'package:flutter/material.dart';
import 'package:warmi/core/globals/global_color.dart';
import 'package:get/get.dart';

class CardOrder extends StatelessWidget {
  final String? orderNumber;
  final String? orderStatus;
  final Color? orderColorStatus;
  final String? orderDate;
  final dynamic orderStore;
  final String? outlet;
  final String? totalOrders;
  final String? qtyOrders;
  final VoidCallback? orderClick;
  final String? cashier;
  final String? noted;
  final bool? showCashier;

  const CardOrder(
      {Key? key,
      this.orderNumber,
      this.orderStatus,
      this.orderColorStatus,
      this.orderDate,
      this.orderStore,
      this.outlet,
      this.totalOrders,
      this.qtyOrders,
      this.orderClick,
      this.cashier,
      this.showCashier = false,
      this.noted})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 1,
      child: InkWell(
        onTap: orderClick,
        splashColor: Colors.grey,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Flexible(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            "Order#$orderNumber",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 14),
                          ),
                          Icon(
                            Icons.arrow_forward_ios,
                            size: 15,
                            color: MyColor.colorPrimary,
                          )
                        ],
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      Text(
                        "$orderDate",
                        style: TextStyle(color: Colors.grey, fontSize: 12),
                      )
                    ],
                  )),
                  Flexible(
                    child: Container(
                      alignment: Alignment.center,
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: orderColorStatus),
                      child: Text(
                        "$orderStatus",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 4,
              ),
              Divider(
                thickness: 1,
              ),
              SizedBox(
                height: 4,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Flexible(child: orderStore),
                  SizedBox(
                    width: 10,
                  ),
                  Flexible(
                      flex: 3,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'toko'.tr,
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Text(
                                "$outlet",
                                style: TextStyle(fontWeight: FontWeight.bold),
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
                                'total_bayar'.tr,
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Text(
                                "$totalOrders",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),

                          // Divider(thickness: 1,),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'jumlah_yg_dibeli'.tr,
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Text(
                                "$qtyOrders" + ' ' + 'produk'.tr,
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ],
                      ))
                ],
              ),
              showCashier!
                  ? Divider(
                      thickness: 1,
                    )
                  : Container(),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  showCashier! ? Text('kasir'.tr + ' : ' + "$cashier") : Container(),
                  if (noted != null) Text("Cat. :  $noted")
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
