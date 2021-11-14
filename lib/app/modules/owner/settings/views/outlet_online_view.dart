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

class OutletOnlineView extends GetWidget<OutletController> {
  @override
  Widget build(BuildContext context) {
    FlutterStatusbarcolor.setStatusBarColor(MyColor.colorPrimary);
    return Scaffold(
      backgroundColor: MyColor.colorBackground,
      appBar: AppBar(
        backgroundColor: MyColor.colorPrimary,
        title: Text(
          'Toko Online',
          style: whiteTextTitle,
        ),
      ),
      body: Obx(() {
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 20,
            ),
            Expanded(
                child: controller.loadingState == LoadingState.loading
                    ? Center(child: CircularProgressIndicator())
                    : controller.listOutlet.length == 0
                        ? Center(
                            child: Text('data_kosong'.tr),
                          )
                        : ListView.builder(
                            itemCount: controller.listOutlet.length,
                            shrinkWrap: true,
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            physics: ClampingScrollPhysics(),
                            itemBuilder: (c, i) {
                              var data = controller.listOutlet[i];
                              return Card(
                                elevation: 0.1,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                child: ExpansionTile(
                                  title: Text(
                                    data.storeName.toString().titleCase,
                                    style: blackTextTitle,
                                  ),
                                  expandedAlignment: Alignment.centerLeft,
                                  childrenPadding: const EdgeInsets.all(8),
                                  initiallyExpanded: i == 0 ? true : false,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10, vertical: 10),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              color: MyColor.colorBlack5),
                                          child: Text(
                                              "http://dpos.mudahkan.com/${data.storeName}"),
                                        ),
                                        Flexible(
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              Flexible(
                                                  child: IconButton(
                                                      onPressed: () => controller
                                                          .copyToClipboard(
                                                              "http://dpos.mudahkan.com/${data.storeName!.replaceAll(' ', '%20')}"),
                                                      icon: Icon(Icons.copy))),
                                              Flexible(
                                                  child: IconButton(
                                                      onPressed: () => controller
                                                          .shareWebsite(
                                                              "http://dpos.mudahkan.com/${data.storeName!.replaceAll(' ', '%20')}",
                                                              data.storeName
                                                                  .toString()),
                                                      icon: Icon(
                                                        Icons.share,
                                                        color: MyColor
                                                            .colorPrimary,
                                                      ))),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          'desc_tokoonline'.tr,
                                          style: blackTextFont.copyWith(
                                              fontStyle: FontStyle.italic,
                                              fontSize: 10),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              );
                            })),
          ],
        );
      }),
    );
  }
}
