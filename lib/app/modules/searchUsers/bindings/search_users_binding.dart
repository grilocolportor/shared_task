import 'package:get/get.dart';

import '../controllers/search_users_controller.dart';

class SearchUsersBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SearchUsersController>(
      () => SearchUsersController(),
    );
  }
}
