import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:warmi/app/data/models/auth_cashier/auth_cashier.dart';
import 'package:warmi/app/modules/choose_store/controller/choose_store_controller.dart';
import 'package:warmi/core/globals/global_color.dart';
import 'package:warmi/core/globals/global_string.dart';
import 'package:warmi/core/utils/enum.dart';
import 'package:recase/recase.dart';
import 'package:warmi/core/utils/thema.dart';

class ChooseStoreView extends StatefulWidget {
  const ChooseStoreView({Key? key}) : super(key: key);

  @override
  State<ChooseStoreView> createState() => _ChooseStoreViewState();
}

class _ChooseStoreViewState extends State<ChooseStoreView> {

  var controller = Get.find<ChooseStoreController>();
  AuthCashier authCashier = AuthCashier();

  @override
  void initState() {
    // authCashier=Get.arguments;
    controller.getOutletDataSource();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyColor.colorPrimary,
        title: Text("Pilih Lokasi Toko"),
      ),
      body: Obx(() {
        return controller.loadingState.value==LoadingState.loading? Center(child: CircularProgressIndicator(),)  : ListView.builder(

            itemCount: controller.listOutlet.length,
            padding: const EdgeInsets.all(MyString.DEFAULT_PADDING),
            itemBuilder: (c, i) {
              var data=controller.listOutlet[i];
              return InkWell(
                onTap: ()=>controller.setStoreName(data),
                child: Card(child: ListTile(title: Text("${data.storeName.toString().titleCase}"),

                
                subtitle: Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text(
                    controller.listOutlet[i].address == null
                        ? "Alamat Belum diatur"
                        : "Kec. ${controller.listOutlet[i].address!.addressSubdistrictName} ${data.address!.addressType}. "
                        "${controller.listOutlet[i].address!.addressCityName} - "
                        "${controller.listOutlet[i].address!.addressProvinceName}",
                    overflow: TextOverflow.visible,
                    style: blackTextFont,
                  ),
                ),
                )),
              );
            });
      }),
    );
  }
}
