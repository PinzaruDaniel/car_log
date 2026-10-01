import 'package:get/get.dart';
import '../controllers/main_app_controller.dart';

class RootBinding extends Bindings {
  @override
  void dependencies() {
    if (!Get.isRegistered<MainAppController>()) {
      Get.put<MainAppController>(MainAppController(), permanent: true);
    }
  }
}
