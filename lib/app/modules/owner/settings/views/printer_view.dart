import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:warmi/app/data/models/printer/printer_model.dart';
import 'package:warmi/app/modules/owner/settings/controllers/printer_controller.dart';
import 'package:warmi/app/modules/wigets/layouts/dialog/bottom_dialog_detail_printer.dart';
import 'package:warmi/app/modules/wigets/layouts/dialog/bottom_dialog_printer.dart';
import 'package:warmi/app/modules/wigets/layouts/general_button.dart';
import 'package:warmi/core/globals/global_color.dart';
import 'package:warmi/core/utils/enum.dart';
import 'package:warmi/core/utils/thema.dart';

class PrinterView extends GetWidget<PrinterController> {
  const PrinterView({Key? key}) : super(key: key);

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
      body:Obx(() =>  controller.loadingState==LoadingState.loading ? Center(
        child: CircularProgressIndicator(),
      ) : MediaQuery.removePadding(context: context,
          removeTop: true,
          child: ListView.builder(
            padding: const EdgeInsets.all(15),
            itemCount:controller.listPrinterDevice.length,
            itemBuilder: (c,i){
              var device=controller.listPrinterDevice[i];
              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListTile(
                    onTap: ()=> showBottomSheetDetailPrinter(mac: device.printermac,name: device.printername,edit: true,printerData: device),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)
                    ),
                    leading: device.printerport!=null ? Image.asset("assets/icons/icons8-print-48.png",height: 40,width: 40,): Image.asset("assets/icons/icons8-bluetooth-2-48.png",height: 40,width: 40,),
                    title: Text("${device.printername}",style: blackTextTitle,),
                    subtitle: Text("${device.printerport!=null ? device.printerip  :  device.printermac}"),
                    trailing:  TextButton(onPressed: ()=> controller.printTest(printerData: device),child: Text("Test Printer"),),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Divider(),
                  ),
                ],
              );
            },
          ))) ,
      bottomNavigationBar: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 15),
          child: GeneralButton(onPressed: ()=> showBottomSheetPrinter(),label: 'Tambahkan Printer',)),
    );

  }

  Future showBottomSheetPrinter() {
    return Get.bottomSheet(BottomDialogPrinter(), isScrollControlled: true, elevation: 3);
  }
  Future showBottomSheetDetailPrinter({String? name,String? mac,bool edit=true,PrinterData? printerData}) {
    return Get.bottomSheet(BottomDialogDetailPrinter(namePrinter: name,macPrinter: mac,edit: true,printerData: printerData,), isScrollControlled: true, elevation: 3);
  }
}
