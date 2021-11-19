import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:warmi/app/routes/app_pages.dart';
import 'package:warmi/core/globals/global_color.dart';
import 'package:warmi/core/globals/global_string.dart';

class ReportingView extends StatelessWidget {
  const ReportingView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyColor.colorPrimary,
        title: Text('laporan'.tr),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: MyString.DEFAULT_PADDING,vertical: 10),
        children: ListTile.divideTiles(
            //          <-- ListTile.divideTiles
            context: context,
            tiles: [
              // InkWell(
              //   onTap: () {},
              //   child: ListTile(
              //     title: Text('rangkuman'.tr),
              //     trailing: Icon(
              //       Icons.arrow_forward_ios,
              //       size: 16,
              //     ),
              //   ),
              // ),
              InkWell(
                onTap: () {
                  Get.toNamed(Routes.REPORT_TRANSACTION);
                },
                child: ListTile(
                  title: Text('ringkasan_penjualan'.tr),
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    size: 16,
                  ),
                ),
              ),
              ListTile(
                onTap: ()=> Get.toNamed(Routes.REPORT_BY_METHOD_PAYMENT),
                title: Text('metode_pembayaran'.tr),
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  size: 16,
                ),
              ),
              ListTile(
                onTap: ()=> Get.toNamed(Routes.REPORT_BY_SALES_PRODUCT),
                title: Text('penjualan_per_produk'.tr),
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  size: 16,
                ),
              ),
              InkWell(
                onTap: () {},
                child: ListTile(
                  title: Text('penjualan_per_kategori'.tr),
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    size: 16,
                  ),
                ),
              ),
              // InkWell(
              //   onTap: () {},
              //   child: ListTile(
              //     title: Text('penjualan_per_merek'.tr),
              //     trailing: Icon(
              //       Icons.arrow_forward_ios,
              //       size: 16,
              //     ),
              //   ),
              // ),
              InkWell(
                onTap: () {},
                child: ListTile(
                  title: Text('laporan_pajak'.tr),
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    size: 16,
                  ),
                ),
              ),
              InkWell(
                onTap: () {},
                child: ListTile(
                  title: Text('laporan_pelanggan'.tr),
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    size: 16,
                  ),
                ),
              ),
              InkWell(
                onTap: () {},
                child: ListTile(
                  title: Text('laporan_pegawai'.tr),
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    size: 16,
                  ),
                ),
              ),
            ]).toList(),
      ),
    );
  }
}
