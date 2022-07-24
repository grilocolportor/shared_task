// ignore_for_file: list_remove_unrelated_type

import 'package:get/get.dart';
import 'package:sharedtask/app/data/firebase/firebase_service.dart';
import 'package:sharedtask/app/data/models/user_model.dart';

class SearchUsersController extends GetxController {
  final FireBaseService fbs = FireBaseService();

  List getList = [].obs;

  List<UserModel> userListSelected = [UserModel()].obs;

  var buttomToggleCheck = false.obs;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void toogleButtomCheckChange(UserModel userModel) {
    userListSelected.remove('');
    buttomToggleCheck.value = !buttomToggleCheck.value;
    if (buttomToggleCheck.value) {
      userListSelected.add(userModel);
    } else {
      userListSelected.remove({userModel});
    }
  }

  Future search(String flag, String searchParam) async {
    getList.clear();
    getList.addAll(await fbs.searchUserByParam(flag, searchParam));
  }
}
