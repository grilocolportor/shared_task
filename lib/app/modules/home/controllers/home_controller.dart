import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sharedtask/app/data/firebase/firebase_service.dart';

import '../../../data/models/tasks_model.dart';

class HomeController extends GetxController {
  //TODO: Implement HomeController

  final FireBaseService fbs = FireBaseService();
  final dataStorage = GetStorage();

  List taskList = [].obs;

  var token = "";

  @override
  void onInit() {
    token = dataStorage.read('userToken');
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<void> addNewTask() async {
    Map<String, dynamic> taskMap = TasksModel(
            dateCreate: Timestamp.now(),
            shared: [token],
            taskDetail: "Adcionanco com refatorado",
            taskTitle: "TEste com Model refatorado",
            userCreate: token)
        .toFirestore();
    fbs.addNewtask(taskMap: taskMap);
  }

  Future readTasks() async {
    taskList.clear();
    taskList.addAll(await fbs.readAllTask(token: token));
  }
}
