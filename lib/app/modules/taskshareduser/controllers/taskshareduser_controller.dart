import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:sharedtask/app/data/firebase/firebase_service.dart';

class TaskshareduserController extends GetxController {
  final FireBaseService fbs = FireBaseService();

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

  Future<void> updateTask(
      {required String taskId, required String users}) async {
    fbs.tasks.doc(taskId).update({
      "shared": FieldValue.arrayUnion([users])
    });
  }

  Future<void> addTaskToUserCollection({required String taskId, required String token}) async {
    fbs.users.doc(token).update({
      "tasks": FieldValue.arrayUnion([taskId])
    });
  }
}
