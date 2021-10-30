import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:warmi/app/modules/owner/settings/controllers/printer_controller.dart';
import 'package:warmi/app/modules/wigets/layouts/dialog/bottom_dialog_detail_printer.dart';
import 'package:warmi/core/globals/global_color.dart';
import 'package:warmi/core/utils/thema.dart';

class PrinterBlueList extends GetWidget<PrinterController> {
  const PrinterBlueList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColor.colorBackground,
      appBar: AppBar(
        backgroundColor: MyColor.colorPrimary,
        title: Text(
          'Printer',
          style: whiteTextTitle,
        ),

      ),
      body: GetBuilder<PrinterController>(
        assignId: true,
        builder: (logic) {
          return MediaQuery.removePadding(context: context,
              removeTop: true,
              child: ListView.builder(
                padding: const EdgeInsets.all(15),
                itemCount:logic.availableBluetoothDevices.length,
                itemBuilder: (c,i){
                  var device=logic.availableBluetoothDevices[i];
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ListTile(
                        onTap: ()=> showBottomSheetPrinter(name: device.name,mac: device.macAdress),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)
                        ),
                        leading: Image.asset("assets/icons/icons8-bluetooth-2-48.png",height: 40,width: 40,),
                        title: Text("${device.name}",style: blackTextTitle,),
                        subtitle: Text("${device.macAdress}"),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Divider(),
                      ),
                    ],
                  );
                },
              ));
        },
      ),
    );
  }
  Future showBottomSheetPrinter({String? name,String? mac}) {
    return Get.bottomSheet(BottomDialogDetailPrinter(namePrinter: name,macPrinter: mac,), isScrollControlled: true, elevation: 3);
  }
}
