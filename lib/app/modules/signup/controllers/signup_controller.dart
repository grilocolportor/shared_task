import 'package:auth_service/auth.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class SignupController extends GetxController {
  final dataStorage = GetStorage();

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
      dataStorage.write('userToken', userEntity.id);
      return Right(userEntity);
    } catch (e) {
      return Left(e.toString());
    }
  }
}
