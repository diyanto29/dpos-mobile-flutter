import 'package:esc_pos_bluetooth/esc_pos_bluetooth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:warmi/app/data/models/printer/printer_model.dart';
import 'package:warmi/app/modules/owner/settings/controllers/printer_controller.dart';
import 'package:warmi/app/modules/owner/settings/views/printer_blue_list.dart';
import 'package:warmi/core/globals/global_color.dart';
import 'package:warmi/core/globals/global_string.dart';
import 'package:warmi/core/utils/thema.dart';

class BottomDialogDetailPrinter extends StatefulWidget {
  final bool blueDevice;
  final String? namePrinter;
  final String? macPrinter;
  final bool edit;
  final PrinterData? printerData;
  const BottomDialogDetailPrinter({Key? key, this.blueDevice=true, this.namePrinter, this.macPrinter, this.edit=false, this.printerData}) : super(key: key);

  @override
  State<BottomDialogDetailPrinter> createState() => _BottomDialogDetailPrinterState();
}

class _BottomDialogDetailPrinterState extends State<BottomDialogDetailPrinter> {
    int groupValue=1;

    @override
  void initState() {
    setState(() {
      if(widget.edit){
        // print(widget.printerData!.printerpapertype);
        if(widget.printerData!.printerpapertype=="58"){
          groupValue=1;
        }else{
          groupValue=2;
        }
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var controller=Get.find<PrinterController>();
    return DraggableScrollableSheet(
      expand: false,
      minChildSize: 0.5,
      initialChildSize: 0.5,
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
                title: Text("Nama Printer",style: blackTextTitle,),
                subtitle: Text("${widget.namePrinter}"),
                trailing: Text("${widget.macPrinter}"),
              ),
              SizedBox(height: 10,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text("Tipe kertas",style: blackTextTitle,),
              ),
              RadioListTile<int>(value: 1, groupValue: groupValue,

                onChanged: (v){
                  setState(() {
                    groupValue=v!;
                  });

              },title: Text("58mm"),),
              RadioListTile<int>(value: 2, groupValue: groupValue, onChanged: (v){
                setState(() {
                  groupValue=v!;
                });
              },title: Text("80mm"),),
              if(!widget.edit)SizedBox(height: 100,),
              if(widget.edit) SizedBox(height: 30,),
              if(widget.edit) Center(child: TextButton(onPressed: ()=> controller.printTest(printerData: widget.printerData),child: Text("Test Printer"),)),
              if(widget.edit) SizedBox(height: 30,),
              Container(
                  margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  height: 50,
                  width: double.infinity,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Flexible(
                        child: Container(
                          height: 50,
                          width: double.infinity,

                          child:ElevatedButton(
                            child: Text(
                              "Simpan",
                              style: GoogleFonts.droidSans(fontSize: 16),
                            ),
                            style: ElevatedButton.styleFrom(
                                elevation: 1,
                                primary: MyColor.colorPrimary,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(25))),
                            onPressed: () => controller.storePrinter(printerMac: widget.macPrinter,printerName: widget.namePrinter,paperType: groupValue==1 ? "58" : "80",printerId: widget.edit ? widget.printerData!.printerid : null),
                          ),
                        ),
                      ),
                      SizedBox(width: 10,),
                    if(!widget.edit)  Flexible(
                        child: Container(
                          height: 50,
                          width: double.infinity,

                          child: ElevatedButton(
                            child: Text(
                              "Test Printer",
                              style: GoogleFonts.droidSans(fontSize: 16),
                            ),
                            style: ElevatedButton.styleFrom(
                                elevation: 1,
                                primary: MyColor.colorBlue,
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25))),
                            onPressed: () => controller.printTest(mac: widget.macPrinter),
                          ),
                        ),
                      ),
                    if(widget.edit)  Flexible(
                        child: Container(
                          height: 50,
                          width: double.infinity,

                          child: ElevatedButton(
                            child: Text(
                              "Hapus",
                              style: GoogleFonts.droidSans(fontSize: 16),
                            ),
                            style: ElevatedButton.styleFrom(
                                elevation: 1,
                                primary: MyColor.colorRedFlatDark,
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25))),
                            onPressed: () => controller.deletePrinter(widget.printerData!.printerid),
                          ),
                        ),
                      ),
                    ],
                  )),
            ],
          ),
        );
      },
    );
  }
}
