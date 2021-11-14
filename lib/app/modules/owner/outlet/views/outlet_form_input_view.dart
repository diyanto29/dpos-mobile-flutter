import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:warmi/app/data/models/rajaongkir/city.dart';
import 'package:warmi/app/data/models/rajaongkir/province.dart';
import 'package:warmi/app/data/models/rajaongkir/subdistrict.dart';
import 'package:warmi/app/modules/owner/outlet/controllers/outlet_controller.dart';
import 'package:warmi/app/modules/wigets/layouts/general_text_input.dart';
import 'package:warmi/app/modules/wigets/package/dropdown__search/dropdown_search.dart';
import 'package:warmi/core/globals/global_color.dart';
import 'package:warmi/core/globals/global_string.dart';
import 'package:warmi/core/utils/thema.dart';

class OutletFormInput extends StatefulWidget {

  @override
  State<OutletFormInput> createState() => _OutletFormInputState();
}

class _OutletFormInputState extends State<OutletFormInput> {
  var controller=Get.find<OutletController>();

  @override
  void initState() {
   controller.nameC.value.text = "";
   controller.descC.value.text = "";
   controller.selectedCity.value= new City();
   controller.selectedSubDistrict(new Subdistrict());
   controller.selectedProvince(new Province());
   controller.timeCloseC.value.text = "";
   controller.timeOpenC.value.text = "";
   controller.postalCodeC.value.text = "";
   controller.detailAddressC.value.text = "";
   controller.toggleSwitchOutlet(false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColor.colorBackground,
      appBar: AppBar(
        backgroundColor: MyColor.colorPrimary,
        title: Text(
          "Tambah Outlet",
          style: whiteTextTitle,
        ),
      ),
      bottomNavigationBar: Container(
          margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          height: 50,
          width: double.infinity,
          child: ElevatedButton(
            child: Text(
              'simpan'.tr,
              style: GoogleFonts.droidSans(fontSize: 16),
            ),
            style: ElevatedButton.styleFrom(
                elevation: 1,
                primary: MyColor.colorPrimary,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
            onPressed: () => controller.createOrupdate(),
          )),
      body: MediaQuery.removePadding(
          context: Get.context!,
          removeTop: true,
          child: ListView(
            padding: EdgeInsets.all(MyString.DEFAULT_PADDING),
            children: [
              GeneralTextInput(
                controller: controller.nameC.value,
                  labelTextInputBox: 'Nama Outlet', descTextInputBox: 'Masukan Nama Outlet'),
              GeneralTextInput(
                  controller: controller.descC.value,
                  labelTextInputBox: 'Deskripsi', descTextInputBox: 'Deskripsikan Outletmu'),
              GeneralTextInput(
                  readOnly: true,
                  controller: controller.timeOpenC.value,
                  keyboardType: TextInputType.number,
                  onClick: (){
                    controller.selectTimeOpen();
                  },
                  labelTextInputBox: "Jam Buka", descTextInputBox: "Conth. 08:00"),
              GeneralTextInput(
                  readOnly: true,
                  controller: controller.timeCloseC.value,
                  keyboardType: TextInputType.number,
                  onClick: (){
                    controller.selectTimeClose();
                  },
                  labelTextInputBox: "Jam Tutup", descTextInputBox: "Conth. 22:00"),
              Obx(() {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Atur Alamat Outlet",
                        style: blackTextTitle,
                      ),
                      Switch.adaptive(
                        value: controller.toggleSwitchOutlet.value,
                        activeColor: MyColor.colorPrimary,
                        onChanged: (v) {
                          controller.toggleSwitchOutlet(v);
                        },)
                    ],
                  ),
                );
              }),
              Obx(() {
                return Visibility(
                    visible: controller.toggleSwitchOutlet.value,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        controller.listProvince.length == 0 ? DropdownSearch(
                          hint: "Pilih Provinsi",
                          mode: Mode.BOTTOM_SHEET,
                          autoFocusSearchBox: true,
                          showSearchBox: true,
                          items: [],
                        ) : DropdownSearch<Province?>(
                            hint: "Pilih Provinsi",
                            mode: Mode.BOTTOM_SHEET,
                            autoFocusSearchBox: true,
                            dropdownBuilderSupportsNullItem: true,
                            selectedItem: null,
                            maxHeight: Get.height * 0.7,
                            onChanged: (p) {
                              controller.selectedCity(null);
                              controller.province = p!;
                              controller.selectedProvince.value=p;
                              controller.getCity(p.provinceId);
                              controller.listSubDistrict.clear();

                            },
                            itemAsString: (p) => p!.province.toString(),

                            showSearchBox: true,
                            items: controller.listProvince),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          "   * Pilih Provinsi Anda",
                          style: GoogleFonts.droidSans(
                              fontStyle: FontStyle.italic, color: MyColor.colorBlackT50),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        controller.listCity.length == 0 ? GeneralTextInput(
                            readOnly: true,
                            keyboardType: TextInputType.number,
                            labelTextInputBox:
                             "Pilih Kabupaten",
                            descTextInputBox: "* Pilih Kabupaten Anda") :
                        Obx(() {
                          return DropdownSearch<City?>(
                            hint: "Pilih Kabupaten",
                            mode: Mode.BOTTOM_SHEET,
                            autoFocusSearchBox: true,
                            showSearchBox: true,
                            maxHeight: 600,
                            selectedItem: controller.selectedCity.value!.cityId==null ? null :controller.selectedCity.value ,
                            dropdownBuilderSupportsNullItem: true,
                            itemAsString: (c) => c!.cityName.toString(),
                            items: controller.listCity,
                            onChanged: (c){
                              controller.getSubDistrict(c!.cityId);
                              controller.selectedCity(c);
                            },
                          );
                        }),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          "   * Pilih Kabupaten Anda",
                          style: GoogleFonts.droidSans(
                              fontStyle: FontStyle.italic, color: MyColor.colorBlackT50),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                    controller.listSubDistrict.length==0?    GeneralTextInput(
                        readOnly: true,
                        keyboardType: TextInputType.number,
                        labelTextInputBox:
                        "Pilih Kecamatan",
                        descTextInputBox: "* Pilih Kecamatan Anda"):
                    DropdownSearch<Subdistrict?>(
                      hint: "Pilih Kecamatan",
                      mode: Mode.BOTTOM_SHEET,
                      autoFocusSearchBox: true,
                      showSearchBox: true,
                       dropdownBuilderSupportsNullItem: true,
                      itemAsString: (v)=> v!.subdistrictName.toString(),
                      items: controller.listSubDistrict,
                      onChanged: (v){
                        controller.selectedSubDistrict(v);
                      },
                    ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          "   * Pilih Kecamatan Anda",
                          style: GoogleFonts.droidSans(
                              fontStyle: FontStyle.italic, color: MyColor.colorBlackT50),
                        ),
                        SizedBox(
                          height: 10,
                        ),

                        GeneralTextInput(
                          controller: controller.postalCodeC.value,
                            keyboardType: TextInputType.number,
                            labelTextInputBox: "Kode Pos", descTextInputBox: "Conth. 45252"),
                        GeneralTextInput(
                          controller: controller.detailAddressC.value,
                            labelTextInputBox: "Detail Alamat",
                            keyboardType: TextInputType.visiblePassword,
                            maxLines: 3,
                            descTextInputBox: "Conth. Nomor Rumah dll")
                      ],
                    ));
              }),
            ],
          )),
    );
  }
}
