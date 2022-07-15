import 'package:get/get.dart';
import 'package:sharedtask/app/data/firebase/firebase_service.dart';

class SearchUsersController extends GetxController {
  final FireBaseService fbs = FireBaseService();

  List getList = [].obs;

  Map<String, String> userListSelected = {'':''}.obs;

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

  void toogleButtomCheckChange(String idUser, String token) {
    userListSelected.remove('');
    buttomToggleCheck.value = !buttomToggleCheck.value;
    if (buttomToggleCheck.value) {
      userListSelected.addAll({idUser: token});
    } else {
      userListSelected.remove({idUser: token});
    }
  }

  Future search(String flag, String searchParam) async {
    getList.clear();
    getList.addAll(await fbs.searchUserByParam(flag, searchParam));
    print('--------${getList.length}');
  }
}
