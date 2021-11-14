import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:warmi/app/modules/transaction/controllers/cart_controller.dart';
import 'package:warmi/app/modules/transaction/controllers/customer_controller.dart';
import 'package:warmi/app/modules/transaction/controllers/transaction_controller.dart';
import 'package:warmi/app/modules/wigets/layouts/dialog/bottom_dialog_add_consumer.dart';
import 'package:warmi/app/modules/wigets/layouts/dialog/dialog_question.dart';
import 'package:warmi/app/modules/wigets/package/corolize_text_avatar/colorize_text_avatar.dart';
import 'package:warmi/app/modules/wigets/package/corolize_text_avatar/src/colorized_text_avatar.dart';
import 'package:warmi/core/globals/global_color.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:warmi/core/utils/enum.dart';

class CustomerView extends GetWidget<CustomerController> {
  const CustomerView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var cartController = Get.find<CartController>();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyColor.colorPrimary,
        title: Text('pelanggan'.tr),
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
                onChanged: (v) {
                  controller.searchCustomer(v);
                },
                decoration: InputDecoration(
                    hintText: 'cari_pelanggan_disini'.tr + '...',
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
                    : controller.listCustomer.length == 0
                        ? Center(
                            child: Text('data_kosong'.tr),
                          )
                        : controller.searchC.value.text.isNotEmpty
                            ? controller.listSearchCustomer.length == 0
                                ? Center(
                                    child: Text("Data yang anda Cari Kosong"),
                                  )
                                : ListView.builder(
                                    itemCount: controller.listSearchCustomer.length,
                                    shrinkWrap: true,
                                    padding: EdgeInsets.symmetric(horizontal: 10),
                                    physics: ClampingScrollPhysics(),
                                    itemBuilder: (c, i) {
                                      var customer = controller.listSearchCustomer[i];
                                      return Card(
                                        elevation: 0.4,
                                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: ListTile(
                                            onTap: () {
                                              cartController.addCustomer(customer);
                                              Get.back();
                                            },
                                            contentPadding: const EdgeInsets.all(8),
                                            leading: TextAvatar(
                                              shape: Shape.Circular,
                                              size: 50,
                                              fontSize: 16.sp,
                                              fontWeight: FontWeight.w600,
                                              upperCase: true,
                                              numberLetters: 3,
                                              text: "${customer.customerpartnername}",
                                            ),
                                            dense: true,
                                            title: Text("${customer.customerpartnername}"),
                                            subtitle: Text(
                                              "${customer.customerpartnernumber} | ${customer.customerpartneremail}",
                                              style: GoogleFonts.roboto(fontWeight: FontWeight.bold),
                                            ),
                                            trailing: IconButton(
                                              onPressed: () =>  showDialogQuestion(
                                                  title: 'hapus'.tr,
                                                  message: 'Anda Yakin ?',
                                                  clickYes: () {
                                                    controller.deleteCustomer(
                                                        customer.customerpartnerid);
                                                  }),
                                              icon: Icon(
                                                IconlyLight.delete,
                                                color: MyColor.colorRedFlat,
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    })
                            : ListView.builder(
                                itemCount: controller.listCustomer.length,
                                shrinkWrap: true,
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                physics: ClampingScrollPhysics(),
                                itemBuilder: (c, i) {
                                  var customer = controller.listCustomer[i];
                                  return Card(
                                    elevation: 0.1,
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                    child: ListTile(
                                      onTap: () {
                                        cartController.addCustomer(customer);
                                        Get.back();
                                        // Get.toNamed(Routes.ADD_DISCOUNT,arguments: discount);
                                      },
                                      contentPadding: const EdgeInsets.all(8),
                                      leading: TextAvatar(
                                        shape: Shape.Circular,
                                        size: 50,
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w600,
                                        upperCase: true,
                                        numberLetters: 3,
                                        text: "${customer.customerpartnername}",
                                      ),
                                      dense: true,
                                      title: Text("${customer.customerpartnername}"),
                                      subtitle: Text(
                                        "${customer.customerpartnernumber} | ${customer.customerpartneremail}",
                                        style: GoogleFonts.roboto(fontWeight: FontWeight.bold),
                                      ),
                                      trailing: IconButton(
                                        onPressed: () =>  showDialogQuestion(
                                            title: 'hapus'.tr,
                                            message: 'Anda Yakin ?',
                                            clickYes: () {
                                              controller.deleteCustomer(
                                                  customer.customerpartnerid);
                                            }),
                                        icon: Icon(
                                          IconlyLight.delete,
                                          color: MyColor.colorRedFlat,
                                        ),
                                      ),
                                    ),
                                  );
                                })),
          ],
        );
      }),
      bottomNavigationBar: Container(
          margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          height: 50,
          width: double.infinity,
          child: ElevatedButton(
              child: Text(
                "Tambah Pelanggan",
                style: GoogleFonts.droidSans(fontSize: 16),
              ),
              style: ElevatedButton.styleFrom(elevation: 1, primary: MyColor.colorPrimary, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25))),
              onPressed: () => showBottomSheetCustomer())),
    );
  }

  Future showBottomSheetCustomer() {
    return Get.bottomSheet(BottomDialogAddCustomer(), isScrollControlled: true, elevation: 3);
  }
}
