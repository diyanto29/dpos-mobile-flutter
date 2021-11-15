import 'package:get/get.dart';
import 'package:warmi/core/utils/enum.dart';

class TaxServiceController extends GetxController {
  Rx<TaxServiceEnum> taxServiceEnum = TaxServiceEnum.priceWithoutTaxService.obs;
  RxBool switchTax = true.obs;
  RxBool switchService = true.obs;
}
