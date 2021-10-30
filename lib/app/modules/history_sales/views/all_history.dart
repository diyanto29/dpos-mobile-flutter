import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:warmi/app/modules/history_sales/controllers/history_sales_controller.dart';
import 'package:warmi/app/modules/history_sales/views/detail_history_view.dart';
import 'package:warmi/app/modules/wigets/layouts/card_order.dart';
import 'package:warmi/app/routes/app_pages.dart';
import 'package:warmi/core/globals/global_color.dart';
import 'package:warmi/core/utils/enum.dart';
import 'package:recase/recase.dart';

import '../../../../main.dart';

class AllHistory extends StatefulWidget {
  final String statusTab;

  const AllHistory({Key? key, required this.statusTab}) : super(key: key);

  @override
  _AllHistoryState createState() => _AllHistoryState();
}

class _AllHistoryState extends State<AllHistory> {
  var controller = Get.find<HistorySalesController>();

  @override
  void initState() {
    if (widget.statusTab == "Semua") {
      controller.getTransaction();
    }
    if (widget.statusTab == "Lunas") {
      controller.getTransaction(statusTransaction: "success");
    }
    if (widget.statusTab == "Menunggu Pembayaran") {
      controller.getTransaction(statusTransaction: "pending");
    }
    if (widget.statusTab == "Utang") {
      controller.getTransaction(statusPayment: "debt");
    }
    if (widget.statusTab == "Dibatalkan") {
      controller.getTransaction(statusPayment: "cancel");
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HistorySalesController>(builder: (logic) {
      return controller.loadingState == LoadingState.loading ?
      Center(child: CircularProgressIndicator())
          :
      controller.listTransaction.length == 0 ? Center(child: Text("Data Kosong"),) :ListView.builder(
          shrinkWrap: true,
          itemCount: controller.listTransaction.length,
          physics: ClampingScrollPhysics(),
          itemBuilder: (c, i) {
            var data = controller.listTransaction[i];
            return Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: CardOrder(
                orderClick: () => Get.toNamed(Routes.DETAIL_HISTORY_TRANSACTION,arguments: data),
                orderStore: Image.asset(
                  "assets/food.png",
                  height: 100,
                ),
                orderNumber: "${data.transactionid!.split('-')[0]}",
                outlet: "${data.outlet!
                    .storename
                    .toString()
                    .titleCase}",
                totalOrders: "Rp. ${formatCurrency.format(int.tryParse(data.transactiontotal!))}",
                qtyOrders: "${data.detailCount}",
                orderColorStatus: data.transactionstatus!.contains("pending") ? MyColor.colorRedFlatDark : MyColor.colorPrimary,
                noted: data.transactionstatus!.contains("pending")  ? data.transactionnote : null,
                orderDate: "${DateFormat('dd MMM yyyy', 'id-ID').format(DateTime.parse(data.createdAt!))}",
                orderStatus: "${data.transactionstatus
                    .toString()
                    .titleCase}",
                cashier: data.createdBy==null ?  "asdad" : "${data.createdBy!
                    .userfullname
                    .toString()
                    .titleCase}",
                showCashier: true,
              ),
            );
          });
    });
  }
}