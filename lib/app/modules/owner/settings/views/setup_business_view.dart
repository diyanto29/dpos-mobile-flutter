import 'package:cached_network_image/cached_network_image.dart';
import 'package:dotted_decoration/dotted_decoration.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:warmi/app/data/datasource/business/business_data_source.dart';
import 'package:warmi/app/data/models/business/type_business.dart';
import 'package:warmi/app/modules/owner/settings/controllers/setup_business_controller.dart';
import 'package:warmi/app/modules/wigets/layouts/general_text_input.dart';
import 'package:warmi/app/modules/wigets/package/dropdown__search/dropdown_search.dart';
import 'package:warmi/core/globals/global_color.dart';
import 'package:warmi/core/globals/global_string.dart';
import 'package:warmi/core/utils/thema.dart';

class SetupBusinessView extends GetWidget<SetupBusinessController> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          backgroundColor: MyColor.colorWhite,
          appBar: AppBar(
            leading: InkWell(
              onTap: () => Get.back(),
              child: Icon(
                IconlyLight.arrowLeft2,
                color: MyColor.colorWhite,
              ),
            ),
            backgroundColor: MyColor.colorPrimary,
            elevation: 2,
            title: Text(
              "Atur Bisnis Mu",
              style: whiteTextTitle,
            ),
          ),
          body: MediaQuery.removePadding(
              context: Get.context!,
              removeTop: true,
              child: ListView(
                padding: EdgeInsets.all(MyString.DEFAULT_PADDING),
                children: [
                  GeneralTextInput(
                    controller: controller.businessNameC,
                    labelTextInputBox: 'Nama Bisnismu',
                    descTextInputBox: 'Informasi Nama Bisnismu',
                  ),
                  Obx(() {
                    return controller.listTypeBusiness.length == 0
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
                      selectedItem: controller.typeBusiness.value,
                      items: controller.listTypeBusiness,
                      itemAsString: (item) => item!.businessCategoryName.toString(),
                      onChanged: (b) {
                        controller.typeBusiness(b);
                      },
                    );
                  }),

                  SizedBox(
                    height: 20,
                  ),
                  Obx(() {
                    return DropdownSearch<String?>(
                      hint: "Jumlah Outlet",
                      mode: Mode.MENU,
                      showSearchBox: false,
                      selectedItem: controller.totalBranch.value,
                      dropdownBuilderSupportsNullItem: true,
                      items: ['Hanya 1 Outlet', '2-15 Outlet', '> 15 Outlet'],
                      onChanged: (b) {
                        controller.totalBranch(b);
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
                      selectedItem: controller.totalCrew.value,
                      dropdownBuilderSupportsNullItem: true,
                      items: ['Bekerja Sendiri', '1-5 Orang Karyawan', '>5 Orang Karyawan'],
                      onChanged: (b) {
                        controller.totalCrew(b);
                      },
                    );
                  }),
                  SizedBox(
                    height: 4,
                  ),
                  Text(
                    "   * Banyak Karyawan Anda",
                    style: GoogleFonts.droidSans(
                        fontStyle: FontStyle.italic, color: MyColor.colorBlackT50),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Visibility(
                    visible: false,
                    child: GeneralTextInput(
                        controller: controller.websiteNameC,
                        labelTextInputBox: 'Website Toko',
                        descTextInputBox: 'cth. mudahkan.com/toko-kami'),
                  ),
                  GeneralTextInput(
                      controller: controller.contactC,
                      labelTextInputBox: 'kontak Bisnis',
                      descTextInputBox: 'cth. 0856-2427-7920'),
                  Text(
                    "Logo Toko",
                    style: GoogleFonts.droidSans(),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  GetBuilder<SetupBusinessController>(
                    builder: (logic) {
                      return Container(
                        decoration:
                        DottedDecoration(borderRadius: BorderRadius.circular(10), shape: Shape.box),
                        padding: EdgeInsets.all(10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            controller.image != null
                                ? Image.file(
                              controller.image!,
                              height: 60,
                              width: 60,
                            )
                                : CachedNetworkImage(
                              imageUrl: "${controller.businessProfile.value.data!.businessLogo ?? "NULL"}",
                              height: 60,
                              width: 60,
                              placeholder: (c, s) => Center(child: CircularProgressIndicator()),
                              errorWidget: (BuildContext c, s, d) =>
                                  Image.asset(
                                    "assets/food.png",
                                    height: 60,
                                    width: 60,
                                  ),
                            ),
                            ElevatedButton(
                                style: ElevatedButton.styleFrom(primary: MyColor.colorPrimary),
                                onPressed: () => controller.showBottomSheetImage(),
                                child: Text(
                                  "Photo",
                                  style: GoogleFonts.droidSans(),
                                ))
                          ],
                        ),
                      );
                    },
                  ),
                ],
              )),
          bottomNavigationBar: Container(
              margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              height: 50,
              width: double.infinity,
              child: ElevatedButton(
                child: Text(
                  "Simpan",
                  style: GoogleFonts.droidSans(fontSize: 16),
                ),
                style: ElevatedButton.styleFrom(
                    elevation: 1,
                    primary: MyColor.colorPrimary,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25))),
                onPressed: () => controller.updateBusinessProfile(),
              )),
        ));
  }
}
