import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:warmi/app/modules/transaction/controllers/cart_controller.dart';
import 'package:warmi/app/modules/transaction/views/table/transaction_view_table.dart';
import 'package:warmi/core/utils/responsive_layout.dart';

import 'mobile/transaction_view.dart';

class IndexTransaction extends StatefulWidget {
  const IndexTransaction({Key? key}) : super(key: key);

  @override
  _IndexTransactionState createState() => _IndexTransactionState();
}

class _IndexTransactionState extends State<IndexTransaction> {

  var cartController = Get.isRegistered<CartController>()
      ? Get.find<CartController>()
      : Get.put(CartController());
  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(desktop: TransactionViewTable(),
    mobile: TransactionView(),
    tablet: TransactionViewTable(),);
  }
}
