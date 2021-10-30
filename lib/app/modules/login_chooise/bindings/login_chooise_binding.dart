import 'package:get/get.dart';

import '../controllers/login_chooise_controller.dart';

class LoginChooiseBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoginChooiseController>(
      () => LoginChooiseController(),
    );
  }
}
