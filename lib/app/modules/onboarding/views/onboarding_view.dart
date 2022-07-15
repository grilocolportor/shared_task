// ignore_for_file: unnecessary_null_comparison, must_be_immutable, prefer_typing_uninitialized_variables, unused_field

import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

import 'package:get/get.dart';
import 'package:sharedtask/app/modules/home/views/home_view.dart';
import 'package:sharedtask/app/modules/login/views/login_view.dart';

import '../controllers/onboarding_controller.dart';

class OnboardingView extends GetView<OnboardingController> {
  OnboardingView({Key? key}) : super(key: key);
  final OnboardingController _onboardingController =
      Get.put(OnboardingController());

  initMethod(context) async {
    await _onboardingController.getToken().then((value) {
      if (value.isNotEmpty) {
        Get.off(HomeView(token: value,));
      } else {
        Get.off(LoginView());
      }
      FlutterNativeSplash.remove();
    });
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) => initMethod(context));
    return Container();
  }
}
