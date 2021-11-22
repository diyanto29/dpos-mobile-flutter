import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_statusbarcolor_ns/flutter_statusbarcolor_ns.dart';
import 'package:get/get.dart';
import 'package:warmi/app/modules/owner/outlet/controllers/outlet_controller.dart';
import 'package:warmi/app/modules/owner/outlet/views/outlet_form_edit_view.dart';
import 'package:warmi/app/modules/wigets/layouts/dialog/dialog_question.dart';
import 'package:warmi/app/modules/wigets/package/corolize_text_avatar/src/colorized_text_avatar.dart';
import 'package:warmi/app/modules/wigets/package/corolize_text_avatar/src/constants/enums.dart';
import 'package:warmi/app/routes/app_pages.dart';
import 'package:warmi/core/globals/global_color.dart';
import 'package:warmi/core/utils/enum.dart';
import 'package:warmi/core/utils/thema.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:recase/recase.dart';

class OutletView extends GetWidget<OutletController> {
  @override
  Widget build(BuildContext context) {
    // FlutterStatusbarcolor.setStatusBarColor(MyColor.colorPrimary);
    return Scaffold(
      backgroundColor: MyColor.colorBackground,
      appBar: AppBar(
        backgroundColor: MyColor.colorPrimary,
        title: Text(
          'kelola_toko'.tr,
          style: whiteTextTitle,
        ),
        actions: [IconButton(onPressed: () => Get.toNamed(Routes.ADD_OUTLET), icon: Icon(IconlyBold.plus))],
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
                onChanged: (v) {
                  controller.searchOutlet(v);
                },
                style: TextStyle(height: 0.9, fontSize: 14),
                decoration: InputDecoration(
                    hintText: 'cari_toko'.tr + '...',
                    hintStyle: TextStyle(fontSize: 12, color: Colors.grey[600]),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      borderSide: BorderSide(width: 1, color: MyColor.colorBlackT50),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      borderSide: BorderSide(width: 1, color: MyColor.colorPrimary),
                    ),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide(color: Colors.red, width: 0.1)),
                    suffixIcon: Icon(
                      Icons.search,
                      color: Colors.grey[400],
                    )),
              ),
            ),
            Expanded(
                child: controller.loadingState == LoadingState.loading
                    ? Center(child: CircularProgressIndicator())
                    : controller.listOutlet.length == 0
                        ? Center(
                            child: Text('data_kosong'.tr),
                          )
                        : controller.searchC.value.text.isNotEmpty
                            ? controller.listSearchOutlet.length == 0
                                ? Center(
                                    child: Text("Data yang anda Cari Kosong"),
                                  )
                                : ListView.builder(
                                    itemCount: controller.listSearchOutlet.length,
                                    shrinkWrap: true,
                                    padding: EdgeInsets.symmetric(horizontal: 10),
                                    physics: ClampingScrollPhysics(),
                                    itemBuilder: (c, i) {
                                      var data = controller.listSearchOutlet[i];
                                      return Card(
                                        elevation: 0.1,
                                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                        child: ListTile(
                                          onTap: () => Get.to(OutletFormEdit(
                                            dataOutlet: data,
                                          )),
                                          trailing: IconButton(
                                            onPressed: () {
                                              showDialogQuestion(
                                                  title: 'hapus'.tr,
                                                  message: 'apakah_anda_yakin'.tr + ' ?',
                                                  clickYes: () {
                                                    Get.back();
                                                    controller.deleteOutlet(data.storeId.toString());
                                                  });
                                            },
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
                                            text: "${controller.listOutlet[i].storeName}",
                                          ),
                                          title: Column(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "${controller.listOutlet[i].storeName!.titleCase}",
                                                style: blackTextTitle,
                                              ),
                                              Divider(
                                                thickness: 1,
                                              )
                                            ],
                                          ),
                                          subtitle: Text(
                                            controller.listOutlet[i].address == null
                                                ? "Alamat Belum diatur"
                                                : "Kec. ${controller.listOutlet[i].address!.addressSubdistrictName} ${data.address!.addressType}. "
                                                    "${controller.listOutlet[i].address!.addressCityName} - "
                                                    "${controller.listOutlet[i].address!.addressProvinceName}",
                                            overflow: TextOverflow.ellipsis,
                                            style: blackTextFont,
                                          ),
                                        ),
                                      );
                                    })
                            : ListView.builder(
                                itemCount: controller.listOutlet.length,
                                shrinkWrap: true,
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                physics: ClampingScrollPhysics(),
                                itemBuilder: (c, i) {
                                  var data = controller.listOutlet[i];
                                  return Card(
                                    elevation: 0.1,
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                    child: ListTile(
                                      onTap: () => Get.to(OutletFormEdit(
                                        dataOutlet: data,
                                      )),
                                      trailing: IconButton(
                                        onPressed: () {
                                          showDialogQuestion(
                                              title: 'hapus'.tr,
                                              message: 'apakah_anda_yakin'.tr + ' ?',
                                              clickYes: () {
                                                Get.back();
                                                controller.deleteOutlet(data.storeId.toString());
                                              });
                                        },
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
                                        text: "${controller.listOutlet[i].storeName}",
                                      ),
                                      title: Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "${controller.listOutlet[i].storeName!.titleCase}",
                                            style: blackTextTitle,
                                          ),
                                          Divider(
                                            thickness: 1,
                                          )
                                        ],
                                      ),
                                      subtitle: Text(
                                        controller.listOutlet[i].address == null
                                            ? "Alamat Belum diatur"
                                            : "Kec. ${controller.listOutlet[i].address!.addressSubdistrictName} ${data.address!.addressType}. "
                                                "${controller.listOutlet[i].address!.addressCityName} - "
                                                "${controller.listOutlet[i].address!.addressProvinceName}",
                                        overflow: TextOverflow.ellipsis,
                                        style: blackTextFont,
                                      ),
                                    ),
                                  );
                                })),
          ],
        );
      }),
    );
  }
}
