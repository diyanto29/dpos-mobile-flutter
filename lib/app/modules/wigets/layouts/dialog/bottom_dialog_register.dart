import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:warmi/app/data/models/business/type_business.dart';
import 'package:warmi/app/data/models/rajaongkir/city.dart';
import 'package:warmi/app/data/models/rajaongkir/province.dart';
import 'package:warmi/app/data/models/rajaongkir/subdistrict.dart';
import 'package:warmi/app/modules/owner/outlet/controllers/outlet_controller.dart';
import 'package:warmi/app/modules/owner/settings/controllers/setup_business_controller.dart';
import 'package:warmi/app/modules/register/controllers/register_controller.dart';
import 'package:warmi/app/modules/wigets/layouts/dialog/dialog_snackbar.dart';
import 'package:warmi/app/modules/wigets/layouts/general_button.dart';
import 'package:warmi/app/modules/wigets/layouts/general_text_input.dart';
import 'package:warmi/app/modules/wigets/package/dropdown__search/dropdown_search.dart';
import 'package:warmi/core/globals/global_color.dart';
import 'package:warmi/core/globals/global_string.dart';
import 'package:warmi/core/utils/enum.dart';
import 'package:warmi/core/utils/thema.dart';

class BottomDialogRegister extends StatefulWidget {
  final String title;
  final List<dynamic>? data;
  final Function(dynamic) callback;

  const BottomDialogRegister({
    Key? key,
    required this.title,
    required this.data,
    required this.callback,
  }) : super(key: key);

  @override
  _BottomDialogRegisterState createState() => _BottomDialogRegisterState();
}

class _BottomDialogRegisterState extends State<BottomDialogRegister> {
  @override
  Widget build(BuildContext context) {
    final registerC = Get.find<RegisterController>();
    return DraggableScrollableSheet(
      expand: true,
      minChildSize: 0.6,
      initialChildSize: 0.6,
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
                  height: 5.0,
                  width: 70.0,
                  decoration: BoxDecoration(color: Colors.grey[400], borderRadius: BorderRadius.circular(10.0)),
                ),
              ),
              SizedBox(height: 16),
              Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    widget.title,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              SizedBox(height: 16),
              GeneralTextInput(
                controller: registerC.businessNameC,
                labelTextInputBox: 'Nama Bisnismu',
                descTextInputBox: 'Informasi Nama Bisnismu',
              ),
              Obx(() {
                return registerC.listTypeBusiness.length == 0
                    ? DropdownSearch(
                        hint: "Tipe Bisnis",
                        mode: Mode.MENU,
                        showSearchBox: false,
                        dropdownBuilderSupportsNullItem: true,
                        onChanged: (b) {},
                      )
                    : DropdownSearch<TypeBusiness?>(
                        hint: "Tipe Bisnis",
                        mode: Mode.MENU,
                        loadingBuilder: (c, s) => CircularProgressIndicator(),
                        showSearchBox: false,
                        dropdownBuilderSupportsNullItem: true,
                        items: registerC.listTypeBusiness,
                        itemAsString: (item) => item!.businessCategoryName.toString(),
                        onChanged: (b) {
                          registerC.typeBusiness(b);
                        },
                      );
              }),
              Text(
                "   * Pilih Tipe Bisnis Anda",
                style: GoogleFonts.droidSans(fontStyle: FontStyle.italic, color: MyColor.colorBlackT50),
              ),
              SizedBox(
                height: 20,
              ),
              Obx(() {
                return DropdownSearch<String?>(
                  hint: "Jumlah Outlet",
                  mode: Mode.MENU,
                  showSearchBox: false,
                  selectedItem: registerC.totalBranch.value,
                  dropdownBuilderSupportsNullItem: true,
                  items: ['Hanya 1 Outlet', '2-15 Outlet', '> 15 Outlet'],
                  onChanged: (b) {
                    registerC.totalBranch(b);
                  },
                );
              }),
              SizedBox(
                height: 20,
              ),
              Obx(() {
                return DropdownSearch<String?>(
                  hint: "Jumlah Karyawan",
                  mode: Mode.MENU,
                  showSearchBox: false,
                  selectedItem: registerC.totalCrew.value,
                  dropdownBuilderSupportsNullItem: true,
                  items: ['Bekerja Sendiri', '1-5 Orang Karyawan', '>5 Orang Karyawan'],
                  onChanged: (b) {
                    registerC.totalCrew(b);
                  },
                );
              }),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Atur Alamat Bisnis",
                      style: blackTextTitle,
                    ),
                    Obx(() {
                      return Switch.adaptive(
                        value: registerC.toggleSwitchBusiness.value,
                        activeColor: MyColor.colorOrangeDark,
                        onChanged: (v) {
                          registerC.changeToggleSwitchBusiness();
                        },
                      );
                    })
                  ],
                ),
              ),
              Obx(() {
                return Visibility(
                    visible: registerC.toggleSwitchBusiness.value,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        registerC.listProvince.length == 0
                            ? DropdownSearch(
                                hint: "Pilih Provinsi",
                                mode: Mode.BOTTOM_SHEET,
                                autoFocusSearchBox: true,
                                showSearchBox: true,
                                items: [],
                              )
                            : DropdownSearch<Province?>(
                                hint: "Pilih Provinsi",
                                mode: Mode.BOTTOM_SHEET,
                                autoFocusSearchBox: true,
                                dropdownBuilderSupportsNullItem: true,
                                selectedItem: null,
                                maxHeight: Get.height * 0.7,
                                onChanged: (p) {
                                  registerC.selectedCity(null);
                                  registerC.province = p!;
                                  registerC.selectedProvince.value = p;
                                  registerC.getCity(p.provinceId);
                                  registerC.listSubDistrict.clear();
                                },
                                itemAsString: (p) => p!.province.toString(),
                                showSearchBox: true,
                                items: registerC.listProvince),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          "   * Pilih Provinsi Anda",
                          style: GoogleFonts.droidSans(fontStyle: FontStyle.italic, color: MyColor.colorBlackT50),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        registerC.listCity.length == 0
                            ?  GeneralTextInput( keyboardType: TextInputType
                            .number, labelTextInputBox:  "Pilih Kabupaten",
                            readOnly: true
                            , descTextInputBox:  "   * Pilih Kabupaten Anda")
                            : Obx(() {
                                return DropdownSearch<City?>(
                                  hint: "Pilih Kabupaten",
                                  mode: Mode.BOTTOM_SHEET,
                                  autoFocusSearchBox: true,
                                  showSearchBox: true,
                                  maxHeight: 600,
                                  selectedItem: registerC.selectedCity.value!.cityId == null ? null : registerC.selectedCity.value,
                                  dropdownBuilderSupportsNullItem: true,
                                  itemAsString: (c) => c!.cityName.toString(),
                                  items: registerC.listCity,
                                  onChanged: (c) {
                                    registerC.getSubDistrict(c!.cityId);
                                    registerC.selectedCity(c);
                                  },
                                );
                              }),
                        SizedBox(
                          height: 5,
                        ),
                        if( registerC.listCity.length>0)    Text(
                          "   * Pilih Kabupaten Anda",
                          style: GoogleFonts.droidSans(fontStyle: FontStyle.italic, color: MyColor.colorBlackT50),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        registerC.listSubDistrict.length == 0
                            ?  GeneralTextInput(readOnly: true,keyboardType:
                        TextInputType.number, labelTextInputBox:  "Pilih Kecamatan", descTextInputBox: "* Pilih Kecamatan Anda")
                            : DropdownSearch<Subdistrict?>(
                                hint: "Pilih Kecamatan",
                                mode: Mode.BOTTOM_SHEET,
                                autoFocusSearchBox: true,
                                showSearchBox: true,
                                dropdownBuilderSupportsNullItem: true,
                                itemAsString: (v) => v!.subdistrictName.toString(),
                                items: registerC.listSubDistrict,
                                onChanged: (v) {
                                  registerC.selectedSubDistrict(v);
                                },
                              ),
                        SizedBox(
                          height: 5,
                        ),
                        if(registerC.listSubDistrict.length>0)    Text(
                          "   * Pilih Kecamatan Anda",
                          style: GoogleFonts.droidSans(fontStyle: FontStyle.italic, color: MyColor.colorBlackT50),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        GeneralTextInput(controller: registerC.postalCodeC.value, keyboardType: TextInputType.number, labelTextInputBox: "Kode Pos", descTextInputBox: "Conth. 45252"),
                        GeneralTextInput(controller: registerC.detailAddressC.value, labelTextInputBox: "Detail Alamat", keyboardType: TextInputType.visiblePassword, maxLines: 3, descTextInputBox: "Conth. Nomor Rumah dll")
                      ],
                    ));
              }),
              GeneralButton(label: 'lanjut'.tr, onPressed: () => registerC.register())
            ],
          ),
        );
      },
    );
  }
}
