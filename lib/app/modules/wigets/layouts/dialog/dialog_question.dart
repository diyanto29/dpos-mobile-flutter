import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:warmi/core/utils/thema.dart';

import '../general_button.dart';

Future<dynamic> showDialogQuestion(
    {required String title, required String message, required VoidCallback clickYes}) {
  return Get.dialog(
    AlertDialog(
      title: Text(title),
      content: Text(message),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      actions: [
        GeneralButton(height: 30, width: 60, label: 'Yes', onPressed: clickYes),
        TextButton(
            onPressed: () => Get.back(),
            child: Text(
              'No',
              style: blackTextTitle,
            ))
      ],
    ),
  );
}
