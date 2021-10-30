import 'package:flutter/material.dart';
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
  Widget build(BuildContext context) {
    return ResponsiveBuilder(desktop: Container(),
    mobile: TransactionView(),
    tablet: TransactionViewTable(),);
  }
}
