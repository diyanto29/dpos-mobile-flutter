import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_statusbarcolor_ns/flutter_statusbarcolor_ns.dart';
import 'package:get/get.dart';
import 'package:warmi/app/modules/owner/settings/controllers/product_category_controller.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:warmi/app/modules/owner/settings/views/dialog_settings.dart';
import 'package:warmi/app/modules/wigets/layouts/dialog/dialog_question.dart';
import 'package:warmi/app/modules/wigets/layouts/general_button.dart';
import 'package:warmi/app/modules/wigets/package/corolize_text_avatar/src/colorized_text_avatar.dart';
import 'package:warmi/app/modules/wigets/package/corolize_text_avatar/src/constants/enums.dart';
import 'package:warmi/core/globals/global_color.dart';
import 'package:warmi/core/utils/enum.dart';
import 'package:warmi/core/utils/thema.dart';

class ProductCategoryView extends GetWidget<ProductCategoryController> {
  @override
  Widget build(BuildContext context) {
    FlutterStatusbarcolor.setStatusBarColor(MyColor.colorPrimary);
    return Scaffold(
        backgroundColor: MyColor.colorBackground,
        appBar: AppBar(
          backgroundColor: MyColor.colorPrimary,
          title: Text(
            'kategori_produk'.tr,
            style: whiteTextTitle,
          ),
          actions: [
            IconButton(
                onPressed: () => dialogBottomAddCategoryProduct(), icon: Icon(IconlyBold.plus))
          ],
        ),
        body: Obx(() {
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.only(top: 10, bottom: 10, left: 10, right: 10),
                child: TextField(
                  controller: controller.searchC.value,
                  style: TextStyle(height: 0.9, fontSize: 14),
                  onChanged: (v){
                    controller.searchCategoryProduct(v);
                  },
                  decoration: InputDecoration(

                      hintText: 'cari_kategori_produk'.tr + '...',
                      hintStyle: TextStyle(fontSize: 12, color: Colors.grey[600]),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        borderSide: BorderSide(width: 1, color: MyColor.colorBlackT50),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        borderSide: BorderSide(width: 1, color: MyColor.colorPrimary),
                      ),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: Colors.red, width: 0.1)),
                      suffixIcon: Icon(
                        Icons.search,
                        color: Colors.grey[400],
                      )),
                ),
              ),
              Expanded(
                  child: controller.loadingState == LoadingState.loading
                      ? Center(child: CircularProgressIndicator())
                      : controller.listCategoryProduct.length == 0
                      ? Center(
                        child: GeneralButton(label: 'Tambah Data',onPressed: ()=> dialogBottomAddCategoryProduct(),height: 40,width: 150,),
                       )
                      : controller.searchC.value.text.isNotEmpty
                      ? controller.listSearchCategoryProduct.length == 0
                      ? Center(
                    child: Text("Data yang anda Cari Kosong"),
                  )
                      : ListView.builder(
                      itemCount: controller.listSearchCategoryProduct.length,
                      shrinkWrap: true,
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      physics: ClampingScrollPhysics(),
                      itemBuilder: (c, i) {
                        return Card(
                          elevation: 0.1,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          child: ListTile(
                            // onTap: () => dialogBottomAddCategoryProduct(
                            //     data: controller.listSearchCategoryProduct[i]),
                            contentPadding: EdgeInsets.all(8),
                            trailing: IconButton(
                              onPressed: () => showDialogQuestion(
                                  title: 'hapus'.tr,
                                  message: 'Anda Yakin ?',
                                  clickYes: () {
                                    controller.deleteCategoryProductDataSource(
                                        controller.listSearchCategoryProduct[i].categoryId.toString());
                                  }),
                              icon: Icon(
                                IconlyLight.delete,
                                color: MyColor.colorRedFlat,
                              ),
                            ),
                            leading: TextAvatar(
                              shape: Shape.Circular,
                              size: 50,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600,
                              upperCase: true,
                              numberLetters: 2,
                              text:
                              "${controller.listSearchCategoryProduct[i].categoryName}",
                            ),
                            title: Text(
                              "${controller.listSearchCategoryProduct[i].categoryName}",
                              style: blackTextTitle,
                            ),
                          ),
                        );
                      })
                      : ListView.builder(
                      itemCount: controller.listCategoryProduct.length,
                      shrinkWrap: true,
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      physics: ClampingScrollPhysics(),
                      itemBuilder: (c, i) {
                        return Card(
                          elevation: 0.1,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          child: ListTile(
                            // onTap: () => dialogBottomAddCategoryProduct(
                            //     data: controller.listCategoryProduct[i]),
                            contentPadding: EdgeInsets.all(8),
                            trailing: IconButton(
                              onPressed: () => showDialogQuestion(
                                  title: 'hapus'.tr,
                                  message: 'Anda Yakin ?',
                                  clickYes: () {
                                    controller.deleteCategoryProductDataSource(
                                        controller.listCategoryProduct[i].categoryId.toString());
                                  }),
                              icon: Icon(
                                IconlyLight.delete,
                                color: MyColor.colorRedFlat,
                              ),
                            ),
                            leading: TextAvatar(
                              shape: Shape.Circular,
                              size: 50,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600,
                              upperCase: true,
                              numberLetters: 2,
                              text: "${controller.listCategoryProduct[i].categoryName}",
                            ),
                            title: Text(
                              "${controller.listCategoryProduct[i].categoryName}",
                              style: blackTextTitle,
                            ),
                          ),
                        );
                      })),

            ],
          );
        }));
  }


}