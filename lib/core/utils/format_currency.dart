



import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class CurrencyPtBrInputFormatter extends TextInputFormatter {
   CurrencyPtBrInputFormatter({required this.maxDigits, required this.currency});
  final int maxDigits;
  final String currency;

  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {

    if (newValue.selection.baseOffset == 0) {
      return newValue;
    }

    if (maxDigits != null && newValue.selection.baseOffset > maxDigits) {
      return oldValue;
    }

    double value = double.parse(newValue.text);
    final formatter = NumberFormat("#,##0", "id_ID");
    String newText = "$currency " + formatter.format(value);
    return newValue.copyWith(
        text: newText,
        selection: TextSelection.collapsed(offset: newText.length));
  }
}

class Currency{
  getFormatUang(String val){
    var jumlah = NumberFormat.currency(
        locale: "id_ID",
        decimalDigits: 0,
        symbol: "Rp ").format(int.parse(val));
    return jumlah;
  }
}