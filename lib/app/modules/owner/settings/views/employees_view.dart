import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_statusbarcolor_ns/flutter_statusbarcolor_ns.dart';
import 'package:get/get.dart';
import 'package:warmi/app/data/models/employes/employes_model.dart';
import 'package:warmi/app/modules/owner/settings/controllers/employees_controller.dart';
import 'package:warmi/app/modules/wigets/layouts/dialog/dialog_employees.dart';
import 'package:warmi/app/modules/wigets/layouts/dialog/dialog_question.dart';
import 'package:warmi/app/modules/wigets/package/corolize_text_avatar/src/colorized_text_avatar.dart';
import 'package:warmi/app/modules/wigets/package/corolize_text_avatar/src/constants/enums.dart';
import 'package:warmi/core/globals/global_color.dart';
import 'package:warmi/core/utils/enum.dart';
import 'package:warmi/core/utils/thema.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class EmployeesView extends GetWidget<EmployeesController> {
  @override
  Widget build(BuildContext context) {
    // FlutterStatusbarcolor.setStatusBarColor(MyColor.colorPrimary);
    return Scaffold(
        backgroundColor: MyColor.colorBackground,
        appBar: AppBar(
          backgroundColor: MyColor.colorPrimary,
          title: Text(
            'kelola_karyawan'.tr,
            style: whiteTextTitle,
          ),
          actions: [IconButton(onPressed: () => showBottomDialogEmployees(), icon: Icon(IconlyBold.plus))],
        ),
        body: Obx(() {
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.only(top: 10, bottom: 10, left: 15, right: 15),
                child: TextField(
                  controller: controller.searchC.value,
                  style: TextStyle(height: 0.9, fontSize: 14),
                  onChanged: (v) {
                    controller.searchEmployees(v);
                  },
                  decoration: InputDecoration(
                      hintText: 'cari_karyawan'.tr + '...',
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
                      : controller.listEmployees.length == 0
                          ? Center(
                              child: Text('data_kosong'.tr),
                            )
                          : controller.searchC.value.text.isNotEmpty
                              ? controller.listSearchEmployees.length == 0
                                  ? Center(
                                      child: Text("Data yang anda Cari Kosong"),
                                    )
                                  : ListView.builder(
                                      itemCount: controller.listSearchEmployees.length,
                                      shrinkWrap: true,
                                      padding: EdgeInsets.symmetric(horizontal: 10),
                                      physics: ClampingScrollPhysics(),
                                      itemBuilder: (c, i) {
                                        var data = controller.listSearchEmployees[i];
                                        return Card(
                                          elevation: 0.1,
                                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                          child: ListTile(
                                            onTap: () {
                                              showBottomDialogEmployees(employeesID: data.employeid, employeeData: data);
                                            },
                                            trailing: IconButton(
                                              onPressed: () {
                                                showDialogQuestion(
                                                    title: 'hapus'.tr,
                                                    message: 'apakah_anda_yakin'.tr + ' ?',
                                                    clickYes: () {
                                                      Get.back();
                                                      controller.deleteEmployees(data.employeid.toString());
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
                                              text: "${data.name}",
                                            ),
                                            title: Column(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "${data.name}",
                                                  style: blackTextTitle,
                                                ),
                                                Divider(
                                                  thickness: 0.5,
                                                )
                                              ],
                                            ),
                                            subtitle: Text(
                                              "${data.address == null ? '-' : data.address}",
                                              overflow: TextOverflow.ellipsis,
                                              style: blackTextFont,
                                            ),
                                          ),
                                        );
                                      })
                              : ListView.builder(
                                  itemCount: controller.listEmployees.length,
                                  shrinkWrap: true,
                                  padding: EdgeInsets.symmetric(horizontal: 10),
                                  physics: ClampingScrollPhysics(),
                                  itemBuilder: (c, i) {
                                    var data = controller.listEmployees[i];
                                    return Card(
                                      elevation: 0.1,
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                      child: ListTile(
                                        onTap: () {
                                          showBottomDialogEmployees(employeesID: data.employeid, employeeData: data);
                                        },
                                        trailing: IconButton(
                                          onPressed: () {
                                            showDialogQuestion(
                                                title: 'hapus'.tr,
                                                message: 'apakah_anda_yakin'.tr + ' ?',
                                                clickYes: () {
                                                  Get.back();
                                                  controller.deleteEmployees(data.employeid.toString());
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
                                          text: "${data.name}",
                                        ),
                                        title: Column(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "${data.name}",
                                              style: blackTextTitle,
                                            ),
                                            Divider(
                                              thickness: 0.5,
                                            )
                                          ],
                                        ),
                                        subtitle: Text(
                                          "${data.address == null ? '-' : data.address}",
                                          overflow: TextOverflow.ellipsis,
                                          style: blackTextFont,
                                        ),
                                      ),
                                    );
                                  })),
            ],
          );
        }));
  }

  Future showBottomDialogEmployees({String? employeesID, EmployeData? employeeData}) {
    return Get.bottomSheet(
        DialogEmployees(
          employeesID: employeesID,
          employeeData: employeeData,
        ),
        isScrollControlled: true,
        elevation: 3);
  }
}
