import 'package:get/get.dart';

import '../controllers/kiblat_controller.dart';

class KiblatBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<KiblatController>(
      () => KiblatController(),
    );
  }
}
