import 'package:flutter/material.dart';
import 'package:warmi/app/modules/history_sales/views/all_history.dart';
import 'package:warmi/core/globals/global_color.dart';
import 'package:warmi/core/utils/thema.dart';

class TransactionPending extends StatelessWidget {
  const TransactionPending({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColor.colorBackground,
      appBar: AppBar(
        backgroundColor: MyColor.colorPrimary,
        title: Text(
          'Menunggu Pembayaran',
          style: whiteTextTitle,
        ),
      ),
      body: AllHistory(statusTab: "Menunggu Pembayaran",),
    );
  }
}
