import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:get/get.dart';
import 'package:warmi/app/modules/owner/report/controllers/report_controller.dart';
import 'package:warmi/app/modules/wigets/layouts/dialog/bottom_dialog_outlet.dart';
import 'package:warmi/core/globals/global_color.dart';
import 'package:warmi/core/utils/thema.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class ReportView extends GetWidget<ReportController>{
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: MyColor.colorBackground,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(130.0),
          child: Card(
            elevation: 2,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Flexible(
                        child: InkWell(
                          onTap: () => showBottomSheetOutlet(),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.keyboard_arrow_down_rounded,
                                    color: MyColor.colorBlack,
                                  ),
                                  Text(
                                    "Toko Anda",
                                    style: blackTextTitle.copyWith(fontSize: 14.sp),
                                  ),
                                ],
                              ),
                              Text(
                                " Toko Barokah",
                                style: blackTextTitle.copyWith(fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                        ),
                      ),
                      Flexible(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(
                                  IconlyLight.notification,
                                  color: MyColor.colorWhite,
                                ),
                                SizedBox(
                                  width: 15,
                                ),
                                Icon(
                                  IconlyLight.logout,
                                  color: MyColor.colorWhite,
                                )
                              ],
                            ),
                          ))
                    ],
                  ),
                  SizedBox(height: 10,),
                  TextField(
                    onTap: () async {
                      DateTimeRange? picked = await showDateRangePicker(
                        context: Get.context!,
                        firstDate: DateTime(DateTime.now().year - 5),
                        lastDate: DateTime(DateTime.now().year + 5),
                        initialDateRange: DateTimeRange(
                          end: DateTime.now().add(Duration(days: 30)),
                          start: DateTime.now(),
                        ),
                      );
                      print(picked);
                    },
                    readOnly: true,
                    style: TextStyle(height: 0.9, fontSize: 14),
                    decoration: InputDecoration(
                        hintText: "01 April 2021 - 01 Mei 2021",
                        hintStyle:
                        TextStyle(fontSize: 12, color: MyColor.colorBlackT50),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          borderSide:
                          BorderSide(width: 1, color: MyColor.colorBlackT50),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          borderSide:
                          BorderSide(width: 1, color: MyColor.colorPrimary),
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide:
                            BorderSide(color: Colors.red, width: 0.1)),
                        suffixIcon: Icon(
                          IconlyLight.calendar,
                          color: MyColor.colorBlackT50,
                        )),
                  )
                ],
              ),
            ),
          ),

        ),
        body: Column(
          children: [

            Expanded(
                child: ListView(
                  shrinkWrap: true,
                  padding: EdgeInsets.symmetric(
                      horizontal: 10, vertical: 0),
                  physics: ClampingScrollPhysics(),
                  children: [
                    Card(
                      elevation: 0.4,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Ringkasan",
                              style: blackTextTitle
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Divider(
                              thickness: 1,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Flexible(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Penjualan Kotor",
                                        style: blackTextFont,
                                      ),
                                      SizedBox(
                                        height: 6,
                                      ),
                                      Text(
                                        "Rp. 1.050.000",
                                        style: blackTextTitle,
                                      ),
                                    ],
                                  ),
                                ),
                                Flexible(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text(
                                        "Uang Diterima",
                                        style: blackTextFont,
                                      ),
                                      SizedBox(
                                        height: 6,
                                      ),
                                      Text(
                                        "Rp. 1.050.000",
                                        style:blackTextTitle,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Flexible(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Diskon",
                                        style: blackTextFont,
                                      ),
                                      SizedBox(
                                        height: 6,
                                      ),
                                      Text(
                                        "- Rp. 50.000",
                                        style: blackTextTitle,
                                      ),
                                    ],
                                  ),
                                ),
                                Flexible(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text(
                                        "Pembatalan",
                                        style: blackTextFont,
                                      ),
                                      SizedBox(
                                        height: 6,
                                      ),
                                      Text(
                                        "- Rp. 400.000",
                                        style: blackTextTitle,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Flexible(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Penjualan Bersih",
                                        style: blackTextFont,
                                      ),
                                      SizedBox(
                                        height: 6,
                                      ),
                                      Text(
                                        "Rp. 1.050.000",
                                        style: blackTextTitle,
                                      ),
                                    ],
                                  ),
                                ),
                                Flexible(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text(
                                        "Pesanan",
                                        style: blackTextFont,
                                      ),
                                      SizedBox(
                                        height: 6,
                                      ),
                                      Text(
                                        "10",
                                        style: blackTextTitle,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),

                    Card(
                      elevation: 0.4,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "Penjulan Produk",
                                  style: blackTextTitle,
                                ),
                                Icon(IconlyLight.arrowRightCircle,size: 25,)
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Divider(
                              thickness: 1,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            ListView.builder(
                                shrinkWrap: true,
                                itemCount: 2,
                                physics: ClampingScrollPhysics(),
                                itemBuilder: (c, i) {
                                  return ListTile(
                                    title: Text(
                                      "Gorengan",
                                      style: blackTextFont,
                                    ),
                                    subtitle: Divider(
                                      thickness: 1,
                                    ),
                                    trailing: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Rp.100.000",
                                          style:blackTextTitle,
                                        ),
                                        SizedBox(
                                          height: 2,
                                        ),
                                        Text(
                                          "81 Terjual",
                                          style: blackTextTitle,
                                        ),
                                      ],
                                    ),
                                  );
                                })
                          ],
                        ),
                      ),
                    ),

                    Card(
                      elevation: 0.4,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "Metode Pembayaran",
                                  style: blackTextTitle,
                                ),
                                Icon(IconlyLight.arrowRightCircle,size: 25,)
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Divider(
                              thickness: 1,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            ListView.builder(
                                shrinkWrap: true,
                                itemCount: 4,
                                physics: ClampingScrollPhysics(),
                                itemBuilder: (c, i) {
                                  return ListTile(
                                    title: Text(
                                      "Cash",
                                      style: blackTextFont,
                                    ),
                                    subtitle: Divider(
                                      thickness: 1,
                                    ),
                                    trailing: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Rp.100.000",
                                          style:blackTextTitle,
                                        ),
                                        SizedBox(
                                          height: 2,
                                        ),
                                        Text(
                                          "81 Transaksi",
                                          style: blackTextTitle,
                                        ),
                                      ],
                                    ),
                                  );
                                })
                          ],
                        ),
                      ),
                    )
                  ],
                ))
          ],
        ),
      ),
    );
  }


  Future showBottomSheetOutlet() {
    return Get.bottomSheet(BottomDialogOutlet(), isScrollControlled: true, elevation: 3);
  }
}