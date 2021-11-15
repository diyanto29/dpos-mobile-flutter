import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:warmi/app/data/datasource/tax_service/tax_service_data_source.dart';
import 'package:warmi/app/data/models/tax_service/model_tax_service.dart';
import 'package:warmi/app/modules/wigets/layouts/dialog/dialog_loading.dart';
import 'package:warmi/app/modules/wigets/layouts/dialog/dialog_snackbar.dart';
import 'package:warmi/core/globals/global_string.dart';
import 'package:warmi/core/utils/enum.dart';

class TaxServiceController extends GetxController {
  Rx<LoadingState> loadingState = LoadingState.loading.obs;
  Rx<TaxServiceEnum> taxServiceEnum = TaxServiceEnum.priceWithoutTaxService.obs;
  RxBool switchTax = false.obs;
  RxBool switchService = false.obs;
  Rx<TextEditingController> contTaxValue = TextEditingController().obs;
  Rx<TextEditingController> contServiceValue = TextEditingController().obs;

  Rx<ModelTaxService> modelTaxService = ModelTaxService().obs;

  var box = GetStorage();

  @override
  void onInit() {
    getTaxService();
    super.onInit();
  }

  void getTaxService() async {
    loadingState(LoadingState.loading);
    await TaxServiceDataSource().getTaxService().then((value) {
      modelTaxService(value);
      if (value.status!) {
        contTaxValue.value.text = value.data!.taxpercentage.toString();
        contServiceValue.value.text = value.data!.servicepercentage.toString();
        switchTax((value.data!.taxstatus == "1") ? true : false);
        switchService((value.data!.servicestatus == "1") ? true : false);
        taxServiceEnum((value.data!.includecounttaxservice == "1")
            ? TaxServiceEnum.priceWithTaxService
            : TaxServiceEnum.priceWithoutTaxService);

        box.write(
            MyString.TAX_PERCENTAGE, value.data!.taxpercentage.toString());
        box.write(MyString.TAX_STATUS,
            (value.data!.taxstatus == "1") ? 'true' : 'false');
        box.write(MyString.SERVICE_PERCENTAGE,
            value.data!.servicepercentage.toString());
        box.write(MyString.SERVICE_STATUS,
            (value.data!.servicestatus == "1") ? 'true' : 'false');
        box.write(
            MyString.INCLUDE_COUNT_TAX_SERVICE,
            (value.data!.includecounttaxservice == "1")
                ? TaxServiceEnum.priceWithTaxService.toString()
                : TaxServiceEnum.priceWithoutTaxService.toString());
      }
    });
    loadingState(LoadingState.empty);
  }

  void postAddTaxService() async {
    loadingBuilder();
    await TaxServiceDataSource()
        .postAddTaxService(
            taxPercent: contTaxValue.value.text,
            taxStatus: switchTax.value,
            servicePercent: contServiceValue.value.text,
            serviceStatus: switchService.value,
            includeCountTaxService:
                (taxServiceEnum == TaxServiceEnum.priceWithTaxService)
                    ? true
                    : false)
        .then((value) {
      if (value.status) {
        Get.back();
        showSnackBar(
            snackBarType: SnackBarType.SUCCESS,
            title: 'tax_service'.tr,
            message: 'data_berhasil_disimpan'.tr);
      } else {
        showSnackBar(
            snackBarType: SnackBarType.ERROR,
            title: 'tax_service'.tr,
            message: "${value.message}");
      }
    });
  }
}
