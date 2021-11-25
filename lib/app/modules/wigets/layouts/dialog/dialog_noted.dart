import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:warmi/app/modules/transaction/controllers/cart_controller.dart';
import 'package:warmi/app/modules/transaction/controllers/transaction_controller.dart';
import 'package:warmi/core/utils/thema.dart';

import '../general_button.dart';
import '../general_text_input.dart';

Future<dynamic> showDialogNoted(
    {required String title, required String message, required VoidCallback clickYes}) {
  var transactionC=Get.find<TransactionController>();
  return Get.dialog(
    AlertDialog(
      title: Text(title),
      content:  Container(
        height: 100,
        child: GeneralTextInput(
          controller: transactionC.notedC,
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            labelTextInputBox: 'catatan'.tr,
            descTextInputBox: 'No. Meja / Nama Pembeli'),
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      actions: [
        GeneralButton(height: 45, width: double.infinity, label: 'simpan'.tr, onPressed: clickYes),

      ],
    ),
  );
}
