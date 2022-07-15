// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnboardingController extends GetxController {
  var dataStorage;
  

  @override
  void onInit() {
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<String> getToken() async {
    SharedPreferences dataStorage = await SharedPreferences.getInstance();
    return dataStorage.getString('userToken') ?? "";
  }
}
