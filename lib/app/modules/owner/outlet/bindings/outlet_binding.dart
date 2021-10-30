import 'package:get/get.dart';
import 'package:warmi/app/modules/owner/outlet/controllers/outlet_controller.dart';

class OutletBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<OutletController>(
          () => OutletController(),
    );
  }

}