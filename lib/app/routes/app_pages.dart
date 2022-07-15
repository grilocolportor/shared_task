import 'package:get/get.dart';

import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/onboarding/bindings/onboarding_binding.dart';
import '../modules/onboarding/views/onboarding_view.dart';
import '../modules/searchUsers/bindings/search_users_binding.dart';
import '../modules/searchUsers/views/search_users_view.dart';
import '../modules/signup/bindings/signup_binding.dart';
import '../modules/signup/views/signup_view.dart';
import '../modules/taskDetails/bindings/task_details_binding.dart';
import '../modules/taskDetails/views/task_details_view.dart';
import '../modules/taskshareduser/bindings/taskshareduser_binding.dart';
import '../modules/taskshareduser/views/taskshareduser_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.ONBOARDING;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.SIGNUP,
      page: () => SignUpView(),
      binding: SignupBinding(),
    ),
    GetPage(
      name: _Paths.ONBOARDING,
      page: () => OnboardingView(),
      binding: OnboardingBinding(),
    ),
    GetPage(
      name: _Paths.SEARCH_USERS,
      page: () => SearchUsersView(),
      binding: SearchUsersBinding(),
    ),
    GetPage(
      name: _Paths.TASK_DETAILS,
      page: () => TaskDetailsView(),
      binding: TaskDetailsBinding(),
    ),
    GetPage(
      name: _Paths.TASKSHAREDUSER,
      page: () => const TaskshareduserView(),
      binding: TaskshareduserBinding(),
    ),
  ];
}
