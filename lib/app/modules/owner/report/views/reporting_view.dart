import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:warmi/app/modules/history_sales/controllers/history_sales_controller.dart';
import 'package:warmi/app/routes/app_pages.dart';
import 'package:warmi/core/globals/global_color.dart';
import 'package:warmi/core/globals/global_string.dart';

class ReportingView extends GetWidget<HistorySalesController> {
  const ReportingView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: MyColor.colorPrimary,
        title: Text('laporan'.tr),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
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
                  leading: Image.asset(
                    'assets/icons/report/sales-summary.png',
                    width: 25,
                  ),
                  title: Text('ringkasan_penjualan'.tr),
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    size: 16,
                  ),
                ),
              ),
              ListTile(
                onTap: () => Get.toNamed(Routes.REPORT_BY_METHOD_PAYMENT),
                leading: Image.asset(
                  'assets/icons/report/payment-method.png',
                  width: 25,
                ),
                title: Text('metode_pembayaran'.tr),
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  size: 16,
                ),
              ),
              ListTile(
                onTap: () => Get.toNamed(Routes.REPORT_BY_SALES_PRODUCT),
                leading: Image.asset(
                  'assets/icons/report/product-sale.png',
                  width: 25,
                ),
                title: Text('penjualan_per_produk'.tr),
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  size: 16,
                ),
              ),
              InkWell(
                onTap: () => Get.toNamed(Routes.REPORT_BY_CATEGORY),
                child: ListTile(
                  leading: Image.asset(
                    'assets/icons/report/category-sale.png',
                    width: 25,
                  ),
                  title: Text('penjualan_per_kategori'.tr),
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    size: 16,
                  ),
                ),
              ),
              if (controller.auth.value.roleName == "Pemilik Toko")
                InkWell(
                  onTap: () {},
                  child: ListTile(
                    leading: Image.asset(
                      'assets/icons/report/tax-report.png',
                      width: 25,
                    ),
                    title: Text('laporan_pajak'.tr),
                    trailing: Icon(
                      Icons.arrow_forward_ios,
                      size: 16,
                    ),
                  ),
                ),
              InkWell(
                onTap: () => Get.toNamed(Routes.REPORT_BY_CUSTOMER),
                child: ListTile(
                  leading: Image.asset(
                    'assets/icons/report/customer-report.png',
                    width: 25,
                  ),
                  title: Text('laporan_pelanggan'.tr),
                  trailing: Icon(
                    Icons.arrow_forward_ios_outlined,
                    size: 17,
                  ),
                ),
              ),
              // InkWell(
              //   onTap: () {},
              //   child: ListTile(
              //     title: Text('laporan_pegawai'.tr),
              //     trailing: Icon(
              //       Icons.arrow_forward_ios,
              //       size: 16,
              //     ),
              //   ),
              // ),
            ]).toList(),
      ),
    );
  }
}
