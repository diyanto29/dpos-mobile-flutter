import 'package:esc_pos_bluetooth/esc_pos_bluetooth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:warmi/app/modules/owner/settings/controllers/printer_controller.dart';
import 'package:warmi/app/modules/owner/settings/views/printer_blue_list.dart';
import 'package:warmi/core/globals/global_color.dart';
import 'package:warmi/core/globals/global_string.dart';
import 'package:warmi/core/utils/thema.dart';

class BottomDialogPrinter extends StatefulWidget {
  const BottomDialogPrinter({Key? key}) : super(key: key);

  @override
  State<BottomDialogPrinter> createState() => _BottomDialogPrinterState();
}

class _BottomDialogPrinterState extends State<BottomDialogPrinter> {

  @override
  Widget build(BuildContext context) {
    var controller=Get.find<PrinterController>();
    return DraggableScrollableSheet(
      expand: false,
      minChildSize: 0.35,
      initialChildSize: 0.35,
      builder: (context, scrollController) {
        return Container(
          padding: EdgeInsets.all(MyString.DEFAULT_PADDING),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20.0),
                topRight: Radius.circular(20.0),
              ),
              color: MyColor.colorWhite),
          child: ListView(
            controller: scrollController,
            physics: ClampingScrollPhysics(),
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: Container(
                  margin: EdgeInsets.symmetric(vertical: 8),
                  height: 3.0,
                  width: 70.0,
                  decoration: BoxDecoration(
                      color: Colors.grey[400], borderRadius: BorderRadius.circular(10.0)),
                ),
              ),
              ListTile(
                onTap: (){
                  controller.scanBluetooth().then((value){
                    Get.to(PrinterBlueList());
                  });

                },
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)
                ),
                leading: Image.asset("assets/icons/icons8-bluetooth-2-48.png",height: 40,width: 40,),
                title: Text("Printer Bluetooth",style: blackTextTitle,),
                subtitle: Text("Koneksi Menggunakan Printer Bluetoo th"),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Divider(),
              ),
              ListTile(
                onTap: (){

                },
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)
                ),
                leading: Image.asset("assets/icons/icons8-print-48.png",height: 40,width: 40,),
                title: Text("Printer LAN/ETHERNET",style: blackTextTitle,),
                subtitle: Text("Koneksi Menggunakan Printer kabel LAN"),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Divider(),
              ),
              ListTile(
                onTap: (){},
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)
                ),
                leading: Image.asset("assets/icons/icons8-wi-fi-router-48.png",height: 40,width: 40,),
                title: Text("Printer WIFI/INTERNET",style: blackTextTitle,),
                subtitle: Text("Koneksi Menggunakan Printer WIFI/INTERNET"),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Divider(),
              ),
            ],
          ),
        );
      },
    );
  }
}
