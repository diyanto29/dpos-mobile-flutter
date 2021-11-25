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
  @override
  void initState() {

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      // If our width is more than 1100 then we consider it a desktop
      builder: (context, constraints) {
        print(constraints.maxWidth);
        if (constraints.maxWidth >= 1100) {
          return TransactionViewTable();
        }
        // If width it less then 1100 and more then 650 we consider it as tablet
        else if (constraints.maxWidth >= 600) {
          return TransactionViewTable();
        }
        // Or less then that we called it mobile
        else {
          return TransactionView();
        }
      },
    );
  }
}
