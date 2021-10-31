import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

class LoginChooiseController extends GetxController {
  //TODO: Implement LoginChooiseController

  final count = 0.obs;

  @override
  void onInit()async {
    print("asd");
    await Permission.storage.request();
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
  void increment() => count.value++;
}
