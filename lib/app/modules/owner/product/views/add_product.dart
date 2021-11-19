import 'package:dotted_decoration/dotted_decoration.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:warmi/app/data/models/product/category_product.dart';
import 'package:warmi/app/data/models/product/satuan_product.dart';
import 'package:warmi/app/modules/owner/product/controllers/product_controller.dart';
import 'package:warmi/app/modules/owner/settings/controllers/product_category_controller.dart';
import 'package:warmi/app/modules/wigets/layouts/general_button.dart';
import 'package:warmi/app/modules/wigets/layouts/general_text_input.dart';
import 'package:warmi/app/modules/wigets/package/dropdown__search/dropdown_search.dart';
import 'package:warmi/app/routes/app_pages.dart';
import 'package:warmi/core/globals/global_color.dart';
import 'package:warmi/core/globals/global_string.dart';
import 'package:warmi/core/utils/format_currency.dart';
import 'package:warmi/core/utils/thema.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class AddProductView extends StatefulWidget {
  @override
  State<AddProductView> createState() => _AddProductViewState();
}

class _AddProductViewState extends State<AddProductView> {
  var controller = Get.find<ProductController>();
  final categoryC = Get.put(ProductCategoryController());

  @override
  void initState() {
    controller.conName.value.text = "";
    controller.conPrice.value.text = "";
    controller.conQty.value.text = "";
    controller.conOutlet.value.text = "";
    controller.conSKU.value.text = "";
    controller.conDesc.value.text = "";
    controller.conModal.value.text = "";
    controller.conBarcode.value.text = "";
    controller.toggleSwitchStock(false);

    controller.toggleSwitchDetailProduct(false);
    setState(() {
      controller.image = null;
      controller.priceProduct(0);
      controller.priceModal(0);
      controller.satuanProduct = null;
      controller.categoryProduct = null;
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyColor.colorPrimary,
        title: Text('tambah_produk'.tr),
      ),
      body: Obx(() {
        return MediaQuery.removePadding(
            removeTop: true,
            context: context,
            child: ListView(
              padding: EdgeInsets.symmetric(horizontal: MyString.DEFAULT_PADDING, vertical: 10),
              children: [
                GeneralTextInput(
                  controller: controller.conName.value,
                    labelTextInputBox: 'nama_produk'.tr, descTextInputBox: 'masukkan_nama_produk'.tr),
                controller.listUnitProduct.length == 0
                    ? DropdownSearch(
                        hint: 'pilih_satuan_produk'.tr,
                        mode: Mode.DIALOG,
                        showSearchBox: true,
                        dropdownBuilderSupportsNullItem: true,
                        items: [],
                      )
                    : DropdownSearch<SatuanProduct?>(
                        hint: 'pilih_satuan_produk'.tr,
                        mode: Mode.BOTTOM_SHEET,
                        showSearchBox: true,
                        itemAsString: (s) => s!.unitProductName.toString(),
                        dropdownBuilderSupportsNullItem: true,
                        items: controller.listUnitProduct,
                        onChanged: (v) {
                          controller.satuanProduct = v;
                        },
                      ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  ' * ' + 'pilih_satuan_produk'.tr,
                  style: blackTextTitle.copyWith(
                      color: MyColor.colorBlackT50,
                      fontStyle: FontStyle.italic,
                      letterSpacing: 0.5),
                ),
                SizedBox(
                  height: 20,
                ),
                categoryC.listCategoryProduct.length == 0
                    ?
                DropdownSearch(
                        hint: 'pilih_kategori_produk'.tr,
                        mode: Mode.DIALOG,
                        showSearchBox: true,
                        emptyBuilder: (c,i){
                          return Center(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 50),
                              child: GeneralButton(label: 'Tambah Kategori', onPressed: (){
                                Get.back();
                                Get.toNamed(Routes.PRODUCT_CATEGORY);
                              }),
                            ),
                          );
                        },
                        dropdownBuilderSupportsNullItem: true,
                        items: [],
                      )
                    : DropdownSearch<CategoryProduct?>(
                        hint: 'pilih_kategori_produk'.tr,
                        mode: Mode.BOTTOM_SHEET,
                        showSearchBox: true,

                        itemAsString: (s) => s!.categoryName.toString(),
                        dropdownBuilderSupportsNullItem: true,

                        items: categoryC.listCategoryProduct,
                        onChanged: (v) {
                          controller.categoryProduct = v;
                        },
                      ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  ' * ' + 'pilih_kategori_produk'.tr,
                  style: blackTextTitle.copyWith(
                      color: MyColor.colorBlackT50,
                      fontStyle: FontStyle.italic,
                      letterSpacing: 0.5),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'atur_stok_produk'.tr,
                        style: GoogleFonts.roboto(fontWeight: FontWeight.bold, fontSize: 3.2.w),
                      ),
                      Switch.adaptive(
                        value: controller.toggleSwitchStock.value,
                        activeColor: MyColor.colorPrimary,
                        onChanged: (v) {
                          controller.toggleSwitchStock(v);
                        },
                      ),
                    ],
                  ),
                ),
                Visibility(
                    visible: controller.toggleSwitchStock.value,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GeneralTextInput(
                            controller: controller.conQty.value,
                            keyboardType: TextInputType.number,
                            textInputAction: TextInputAction.next,
                            labelTextInputBox: 'Stok Produk',
                            descTextInputBox: 'contoh'.tr + ' 10'),
                      ],
                    )),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Atur Varian  Produk",
                        style: GoogleFonts.roboto(
                            fontWeight: FontWeight.bold, fontSize: 3.2.w),
                      ),
                      Switch.adaptive(
                        value: controller.toggleSwitchVariant.value,
                        activeColor: MyColor.colorPrimary,
                        onChanged: (v) {
                          controller.toggleSwitchVariant(v);
                        },
                      ),
                    ],
                  ),
                ),
                Visibility(
                    visible: controller.toggleSwitchVariant.value,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GeneralButton(
                            label: 'Tambah Varian',
                            onPressed: () => openDialogVariant()),
                        SizedBox(
                          height: 15,
                        ),
                        ...List.generate(3, (index) => Card(
                          child: ExpansionTile(
                            title: Text("Variant 1"),
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text("Stok Varian",style: blackTextTitle,),
                                      SizedBox(height: 3,),
                                      Text("Tersedia",style: blackTextFont,)
                                    ],
                                  ),

                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text("Harga Varian",style: blackTextTitle,),
                                      SizedBox(height: 3,),
                                      Text("Rp 10.000",style: blackTextFont,)
                                    ],
                                  ),
                                ],
                              )
                            ],
                            expandedAlignment: Alignment.centerLeft,
                            childrenPadding: const EdgeInsets.all(8),
                          ),
                        ))
                      ],
                    )),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Atur Harga Grosir",
                        style: GoogleFonts.roboto(
                            fontWeight: FontWeight.bold, fontSize: 3.2.w),
                      ),
                      Switch.adaptive(
                        value: controller.toggleSwitchWholesale.value,
                        activeColor: MyColor.colorPrimary,
                        onChanged: (v) {
                          controller.toggleSwitchWholesale(v);
                        },
                      ),
                    ],
                  ),
                ),
                Visibility(
                    visible: controller.toggleSwitchWholesale.value,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GeneralButton(
                            label: 'Tambah Harga Grosir',
                            onPressed: () => openDialogHargaGrosir()),
                        SizedBox(
                          height: 15,
                        ),
                        ...List.generate(3, (index) => Card(
                          child: ExpansionTile(
                            title: Text("Variant 1"),
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text("Stok Varian",style: blackTextTitle,),
                                      SizedBox(height: 3,),
                                      Text("Tersedia",style: blackTextFont,)
                                    ],
                                  ),

                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text("Harga Varian",style: blackTextTitle,),
                                      SizedBox(height: 3,),
                                      Text("Rp 10.000",style: blackTextFont,)
                                    ],
                                  ),
                                ],
                              )
                            ],
                            expandedAlignment: Alignment.centerLeft,
                            childrenPadding: const EdgeInsets.all(8),
                          ),
                        ))
                      ],
                    )),

                TextField(
                  controller: controller.conPrice.value,
                  keyboardType: TextInputType.number,
                  style: GoogleFonts.roboto(),
                  inputFormatters: [
                    WhitelistingTextInputFormatter.digitsOnly,
                    CurrencyPtBrInputFormatter(maxDigits: 10, currency: "Rp "),
                  ],
                  onChanged: (v) {
                    print(v);
                    controller.priceProduct( int.parse(controller.conPrice.value.text
                        .split(" ")
                        .last
                        .replaceAll(".", "")));
                  },
                  decoration: InputDecoration(
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                      labelText: "Harga Jual",
                      labelStyle: GoogleFonts.droidSans(color: Colors.grey)),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  ' * ' 'contoh'.tr + " Rp. 50.000",
                  style: GoogleFonts.droidSans(
                      fontStyle: FontStyle.italic, color: MyColor.colorBlackT50),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Flexible(
                        flex: 5,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'isi_detail_produk'.tr,
                              style:
                                  GoogleFonts.roboto(fontWeight: FontWeight.bold, fontSize: 3.3.w),
                            ),
                            SizedBox(
                              height: 2,
                            ),
                            Text(
                              'isi_detail_produk_anda_disini'.tr,
                              style: GoogleFonts.droidSans(fontSize: 10),
                            )
                          ],
                        ),
                      ),
                      Flexible(
                        child: Switch.adaptive(
                          value: controller.toggleSwitchDetailProduct.value,
                          activeColor: MyColor.colorPrimary,
                          onChanged: (v) {
                            controller.toggleSwitchDetailProduct(v);
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                Visibility(
                    visible: controller.toggleSwitchDetailProduct.value,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          decoration: DottedDecoration(
                              borderRadius: BorderRadius.circular(10), shape: Shape.box),
                          padding: EdgeInsets.all(10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              controller.image == null
                                  ? Image.asset(
                                      "assets/food.png",
                                      height: 80,
                                      width: 80,
                                    )
                                  : Image.file(
                                      controller.image!,
                                      height: 80,
                                      width: 80,
                                    ),
                              ElevatedButton(
                                  style: ElevatedButton.styleFrom(primary: MyColor.colorPrimary),
                                  onPressed: () => controller.showBottomSheetImage(),
                                  child: Text(
                                    "Photo",
                                    style: GoogleFonts.droidSans(),
                                  ))
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),

                        SizedBox(
                          height: 20,
                        ),
                        GeneralTextInput(
                          controller: controller.conDesc.value,
                          labelTextInputBox: 'deskripsi'.tr,
                          descTextInputBox: 'deskripsikan_produk_anda'.tr,
                        ),
                        TextField(
                          controller: controller.conModal.value,
                          keyboardType: TextInputType.number,
                          style: GoogleFonts.roboto(),
                          inputFormatters: [
                            WhitelistingTextInputFormatter.digitsOnly,
                            CurrencyPtBrInputFormatter(maxDigits: 10, currency: "Rp "),
                          ],
                          onChanged: (v) {
                           controller.priceModal( int.parse(controller.conModal.value.text
                                .split(" ")
                                .last
                                .replaceAll(".", "")));
                          },
                          decoration: InputDecoration(
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                              labelText: 'harga_modal'.tr,
                              labelStyle: GoogleFonts.droidSans(color: Colors.grey)),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          ' * ' 'contoh'.tr + " Rp. 50.000",
                          style: GoogleFonts.droidSans(
                              fontStyle: FontStyle.italic, color: MyColor.colorBlackT50),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        GeneralTextInput(
                          controller: controller.conSKU.value,
                            labelTextInputBox: 'SKU Produk', descTextInputBox: 'Masukan Nomor SKU'),
                        TextField(
                          controller: controller.conBarcode.value,
                          keyboardType: TextInputType.emailAddress,
                          style: GoogleFonts.roboto(),
                          onChanged: (v) {

                          },
                          decoration: InputDecoration(
                              suffixIcon: IconButton(
                                onPressed: () => controller.scanBarcode(),
                                icon: Icon(IconlyLight.work),
                              ),
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                              labelText: "Barcode",
                              labelStyle: GoogleFonts.droidSans(color: Colors.grey)),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "* Scan Barcode",
                          style: GoogleFonts.droidSans(
                              fontStyle: FontStyle.italic, color: MyColor.colorBlackT50),
                        ),
                        // SizedBox(
                        //   height: 20,
                        // ),
                        // TextField(
                        //   readOnly: true,
                        //
                        //   keyboardType: TextInputType.emailAddress,
                        //
                        //   style: GoogleFonts.roboto(),
                        //   decoration: InputDecoration(
                        //       suffixIcon: IconButton(
                        //         onPressed: () {},
                        //         icon: Icon(IconlyLight.bag2),
                        //       ),
                        //       border: OutlineInputBorder(
                        //           borderRadius: BorderRadius.circular(10)),
                        //       labelText: "Outlet",
                        //       labelStyle: GoogleFonts.droidSans(color: Colors.grey)),
                        // ),
                      ],
                    ))
              ],
            ));
      }),
      bottomNavigationBar: Container(
          margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          height: 50,
          width: double.infinity,
          child: ElevatedButton(
              child: Text(
                'simpan'.tr,
                style: GoogleFonts.droidSans(fontSize: 16),
              ),
              style: ElevatedButton.styleFrom(
                  elevation: 1,
                  primary: MyColor.colorPrimary,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10))),
              onPressed: () => controller.createOrUpdateProduct())),
    );
  }

  Future openDialogVariant() {
    return Get.defaultDialog(
        title: "Tambah Varian",
        radius: 10,
        barrierDismissible: false,
        contentPadding: const EdgeInsets.all(8),
        content: StatefulBuilder(builder: (context, setState) {
          return Column(
            children: [
              GeneralTextInput(
                  controller: controller.conNameVariant.value,
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.next,
                  labelTextInputBox: 'Nama Varian',
                  descTextInputBox: 'contoh'.tr + ' Putih'),
              GeneralTextInput(
                  controller: controller.conPriceVariant.value,
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.next,
                  labelTextInputBox: 'Harga',
                  descTextInputBox: 'contoh'.tr + ' 10.000'),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'atur_stok_produk'.tr,
                    style: GoogleFonts.roboto(
                        fontWeight: FontWeight.bold, fontSize: 3.2.w),
                  ),
                  Switch.adaptive(
                    value: controller.toggleSwitchStockVariant.value,
                    activeColor: MyColor.colorPrimary,
                    onChanged: (v) {
                      setState(() {
                        controller.toggleSwitchStockVariant(v);
                      });
                    },
                  ),
                ],
              ),
              Visibility(
                  visible: controller.toggleSwitchStockVariant.value,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GeneralTextInput(
                          controller: controller.conQtyVariant.value,
                          keyboardType: TextInputType.number,
                          textInputAction: TextInputAction.next,
                          labelTextInputBox: 'Stok Varian',
                          descTextInputBox: 'contoh'.tr + ' 10'),
                    ],
                  )),
            ],
          );
        }));
  }
  Future openDialogHargaGrosir() {
    return Get.defaultDialog(
        title: "Tambah Harga Grosir",
        radius: 10,
        barrierDismissible: false,
        contentPadding: const EdgeInsets.all(8),
        content: StatefulBuilder(builder: (context, setState) {
          return Column(
            children: [
              GeneralTextInput(
                  controller: controller.conPriceWholesale.value,
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.next,
                  labelTextInputBox: 'Nama Grosir',
                  descTextInputBox: 'contoh'.tr + ' Putih'),
              GeneralTextInput(
                  controller: controller.conPriceWholesale.value,
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.next,
                  labelTextInputBox: 'Harga',
                  descTextInputBox: 'contoh'.tr + ' 10.000'),

            ],
          );
        }));
  }
}
