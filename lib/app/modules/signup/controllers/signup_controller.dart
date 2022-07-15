// ignore_for_file: prefer_final_fields, unused_field

import 'package:auth_service/auth.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sharedtask/app/data/firebase/firebase_service.dart';

class SignupController extends GetxController {
  final FireBaseService fbs = FireBaseService();

  final userName = ''.obs;
  final userEmail = ''.obs;
  final userId = ''.obs;

  final AuthService _authService = FirebaseAuthService(
    authService: FirebaseAuth.instance,
  );

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

  Future<Either<String, UserEntity>> createUser(
      {required String email, required String password}) async {
    try {
      var userEntity = await _authService.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      SharedPreferences dataStorage = await SharedPreferences.getInstance();
      dataStorage.setString('userToken', userEntity.id);
      return Right(userEntity);
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<void> addNewUser() async {
    SharedPreferences dataStorage = await SharedPreferences.getInstance();

    Map<String, dynamic> userMap = {
      'userName': userName.value,
      'userEmail': userEmail.value,
      'token': dataStorage.getString('userToken'),
      'tasks': [''],
    };
    await fbs.adduser(userMap: userMap);

    dataStorage.setString('userName', userName.value);
  }
}
