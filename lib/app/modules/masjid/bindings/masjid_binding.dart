import 'package:get/get.dart';

import '../controllers/masjid_controller.dart';

class MasjidBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MasjidController>(
      () => MasjidController(),
    );
  }
}
