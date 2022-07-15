import 'package:get/get.dart';

import '../controllers/taskshareduser_controller.dart';

class TaskshareduserBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TaskshareduserController>(
      () => TaskshareduserController(),
    );
  }
}
