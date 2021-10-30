import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:warmi/app/modules/owner/outlet/controllers/outlet_controller.dart';
import 'package:warmi/core/globals/global_color.dart';
import 'package:warmi/core/globals/global_string.dart';
import 'package:warmi/core/utils/enum.dart';
import 'package:warmi/core/utils/thema.dart';
import 'package:recase/recase.dart';

import 'dialog_question.dart';

class BottomDialogOutlet extends StatefulWidget {
  const BottomDialogOutlet({Key? key}) : super(key: key);

  @override
  State<BottomDialogOutlet> createState() => _BottomDialogOutletState();
}

class _BottomDialogOutletState extends State<BottomDialogOutlet> {
  var controller;


  @override
  void initState() {
    controller=  Get.isRegistered<OutletController>()
        ? Get.find<OutletController>()
        : Get.put(OutletController());
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    var groupValue=1;
    return
        DraggableScrollableSheet(
          expand: false,
          minChildSize: 0.3,
          initialChildSize: 0.3,
          builder: (context, scrollController) {
            return Container(
              padding: EdgeInsets.all(MyString.DEFAULT_PADDING),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20.0),
                    topRight: Radius.circular(20.0),
                  ),
                  color: MyColor.colorWhite),
              child: Obx(() {
                return ListView(
                  controller: scrollController,
                  physics: ClampingScrollPhysics(),
                  children: [
                    Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        margin: EdgeInsets.symmetric(vertical: 8),
                        height: 5.0,
                        width: 70.0,
                        decoration: BoxDecoration(
                            color: Colors.grey[400],
                            borderRadius: BorderRadius.circular(10.0)),
                      ),
                    ),
                    controller.loadingState.value == LoadingState.loading
                        ? Center(
                      child: CircularProgressIndicator(),
                    )
                        : ListView.builder(
                        itemCount: controller.listOutlet.length,
                        physics: ClampingScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (c, i) {
                          var data = controller.listOutlet[i];
                          return InkWell(
                            onTap: (){
                              showDialogQuestion(
                                  title: 'Ganti Toko',
                                  message: 'Apakah Anda Yakin?',
                                  clickYes: () {
                                    Get.back();
                                    controller.changeOutlet(dataOutlet: data);
                                  });
                            },
                            child: RadioListTile(

                              value: controller.auth.value.storeName==data.storeName ?  1: 0,
                              groupValue: groupValue,
                              onChanged: (v) {
                                showDialogQuestion(
                                    title: 'Ganti Toko',
                                    message: 'Apakah Anda Yakin?',
                                    clickYes: () {
                                      Get.back();
                                      controller.changeOutlet(dataOutlet: data);
                                    });
                              },
                              subtitle: Text(
                                controller.listOutlet[i].address == null
                                    ? "Alamat Belum diatur"
                                    : "Kec. ${controller.listOutlet[i].address!.addressSubdistrictName} ${data.address!.addressType}. "
                                    "${controller.listOutlet[i].address!.addressCityName} - "
                                    "${controller.listOutlet[i].address!.addressProvinceName}",
                                overflow: TextOverflow.ellipsis,
                                style: blackTextFont,
                              ),
                              title: Text("${data.storeName.toString().titleCase}",style: blackTextTitle,),
                            ),
                          );
                        })
                  ],
                );
              }),
            );
          },
        );
  }
}
