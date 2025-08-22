import 'package:get/get.dart';

import '../controllers/outlook_compose_controller.dart';

class OutlookComposeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OutlookComposeController>(() => OutlookComposeController());
  }
}
