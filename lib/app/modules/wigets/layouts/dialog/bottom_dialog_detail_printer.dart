import 'package:esc_pos_bluetooth/esc_pos_bluetooth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:warmi/app/data/models/printer/printer_model.dart';
import 'package:warmi/app/modules/owner/settings/controllers/printer_controller.dart';
import 'package:warmi/app/modules/owner/settings/views/printer_blue_list.dart';
import 'package:warmi/app/modules/wigets/package/dropdown__search/dropdown_search.dart';
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
    int groupValueFontTypeHeader=1;
    int groupValueFontTypeFooter=1;
    int groupValueFontTypeContent=1;
    int groupValueFontTypeTotal=1;
    String? fontSizeHeader,fontSizeFooter,fontSizeContent,fontSizeTotal;
    var box=GetStorage();

    @override
  void initState() {
    setState(() {
      groupValueFontTypeHeader=box.read(MyString.TYPE_FONT_HEADER);
      fontSizeHeader=box.read(MyString.FONT_HEADER);

      groupValueFontTypeFooter=box.read(MyString.TYPE_FONT_FOOTER);
      fontSizeFooter=box.read(MyString.FONT_FOOTER);

      groupValueFontTypeContent=box.read(MyString.TYPE_FONT_CONTENT);
      fontSizeContent=box.read(MyString.FONT_CONTENT);

      groupValueFontTypeTotal=box.read(MyString.TYPE_FONT_TOTAL);
      fontSizeTotal=box.read(MyString.FONT_TOTAL);

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
    var controller=Get.isRegistered<PrinterController>() ? Get.find<PrinterController>() : Get.put(PrinterController());
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
                    // box.read(MyString.TYP)
                  });

              },title: Text("58mm"),),
              RadioListTile<int>(value: 2, groupValue: groupValue, onChanged: (v){
                setState(() {
                  groupValue=v!;
                });
              },title: Text("80mm"),),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text("Header",style: blackTextTitle,),
              ),
              SizedBox(height: 10,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text("Tipe Font",style: blackTextTitle.copyWith(fontWeight: FontWeight.w200),),
              ),
              RadioListTile<int>(value: 1, groupValue: groupValueFontTypeHeader,

                onChanged: (v){
                  setState(() {
                    groupValueFontTypeHeader=v!;
                    box.write(MyString.TYPE_FONT_HEADER, v);
                  });

                },title: Text("Tipe A"),),
              RadioListTile<int>(value: 2, groupValue: groupValueFontTypeHeader, onChanged: (v){
                setState(() {
                  groupValueFontTypeHeader=v!;
                  box.write(MyString.TYPE_FONT_HEADER, v);
                });
              },title: Text("Tipe B"),),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text("Ukuran Font",style: blackTextTitle.copyWith(fontWeight: FontWeight.w200),),
              ),
              Container(
                height: 50,
                margin: EdgeInsets.symmetric(horizontal: MyString.DEFAULT_PADDING,vertical: 10),
                child: DropdownSearch(
                  hint: "Pilih Ukuran Font",
                  mode: Mode.BOTTOM_SHEET,
                  selectedItem: fontSizeHeader,
                  // autoFocusSearchBox: true,
                  // showSearchBox: true,
                  items: ['size1','size2','size3','size4'],
                  onChanged: (v){
                    box.write(MyString.FONT_HEADER, v);
                  },
                ),
              ),
              SizedBox(height: 10,),
              Divider(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text("Footer",style: blackTextTitle,),
              ),
              SizedBox(height: 10,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text("Tipe Font",style: blackTextTitle.copyWith(fontWeight: FontWeight.w200),),
              ),
              RadioListTile<int>(value: 1, groupValue: groupValueFontTypeFooter,

                onChanged: (v){
                  setState(() {
                    groupValueFontTypeFooter=v!;
                    box.write(MyString.TYPE_FONT_FOOTER, v);
                  });

                },title: Text("Tipe A"),),
              RadioListTile<int>(value: 2, groupValue: groupValueFontTypeFooter, onChanged: (v){
                setState(() {
                  groupValueFontTypeFooter=v!;
                  box.write(MyString.TYPE_FONT_FOOTER, v);
                });
              },title: Text("Tipe B"),),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text("Ukuran Font",style: blackTextTitle.copyWith(fontWeight: FontWeight.w200),),
              ),
              Container(
                height: 50,
                margin: EdgeInsets.symmetric(horizontal: MyString.DEFAULT_PADDING,vertical: 10),
                child: DropdownSearch(
                  hint: "Pilih Ukuran Font",
                  mode: Mode.BOTTOM_SHEET,
                  // autoFocusSearchBox: true,
                  // showSearchBox: true,
                  selectedItem: fontSizeFooter,
                  items: ['size1','size2','size3','size4'],
                  onChanged: (v){
                    box.write(MyString.FONT_FOOTER, v);
                  },
                ),
              ),
              Divider(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text("Konten",style: blackTextTitle,),
              ),
              SizedBox(height: 10,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text("Tipe Font",style: blackTextTitle.copyWith(fontWeight: FontWeight.w200),),
              ),
              RadioListTile<int>(value: 1, groupValue: groupValueFontTypeContent,

                onChanged: (v){
                  setState(() {
                    groupValueFontTypeContent=v!;
                    box.write(MyString.TYPE_FONT_CONTENT, v);
                  });

                },title: Text("Tipe A"),),
              RadioListTile<int>(value: 2, groupValue: groupValueFontTypeContent, onChanged: (v){
                setState(() {
                  groupValueFontTypeContent=v!;
                  box.write(MyString.TYPE_FONT_CONTENT, v);
                });
              },title: Text("Tipe B"),),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text("Ukuran Font",style: blackTextTitle.copyWith(fontWeight: FontWeight.w200),),
              ),
              Container(
                height: 50,
                margin: EdgeInsets.symmetric(horizontal: MyString.DEFAULT_PADDING,vertical: 10),
                child: DropdownSearch(
                  hint: "Pilih Ukuran Font",
                  mode: Mode.BOTTOM_SHEET,
                  // autoFocusSearchBox: true,
                  // showSearchBox: true,
                  selectedItem: fontSizeContent,
                  items: ['size1','size2','size3','size4'],
                  onChanged: (v){
                    box.write(MyString.FONT_CONTENT, v);
                  },
                ),
              ),
              Divider(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text("Tipe dan Ukuran Total",style: blackTextTitle,),
              ),
              SizedBox(height: 10,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text("Tipe Font",style: blackTextTitle.copyWith(fontWeight: FontWeight.w200),),
              ),
              RadioListTile<int>(value: 1, groupValue: groupValueFontTypeTotal,

                onChanged: (v){
                  setState(() {
                    groupValueFontTypeTotal=v!;
                    box.write(MyString.TYPE_FONT_TOTAL, v);
                  });

                },title: Text("Tipe A"),),
              RadioListTile<int>(value: 2, groupValue: groupValueFontTypeTotal, onChanged: (v){
                setState(() {
                  groupValueFontTypeTotal=v!;
                  box.write(MyString.TYPE_FONT_TOTAL, v);
                });
              },title: Text("Tipe B"),),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text("Ukuran Font",style: blackTextTitle.copyWith(fontWeight: FontWeight.w200),),
              ),
              Container(
                height: 50,
                margin: EdgeInsets.symmetric(horizontal: MyString.DEFAULT_PADDING,vertical: 10),
                child: DropdownSearch(
                  hint: "Pilih Ukuran Font",
                  mode: Mode.BOTTOM_SHEET,
                  // autoFocusSearchBox: true,
                  // showSearchBox: true,
                  selectedItem: fontSizeTotal,
                  items: ['size1','size2','size3','size4'],
                  onChanged: (v){
                    box.write(MyString.FONT_TOTAL, v);
                  },
                ),
              ),

              Divider(),
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
                              'simpan'.tr,
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
                              'hapus'.tr,
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
