// ignore_for_file: invalid_use_of_protected_member, must_call_super

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sharedtask/app/data/firebase/firebase_service.dart';

import '../../../data/models/tasks_model.dart';

class HomeController extends GetxController {
  //TODO: Implement HomeController

  final FireBaseService fbs = FireBaseService();

  late final CollectionReference tasks;

  var taskList = [].obs;

  var token = "";

  var taskDetails = ''.obs;
  var taskTitle = ''.obs;
  var done = ''.obs;
  var shared = [''].obs;
  var id = ''.obs;

  var creatorTask = false.obs;
  var userName = ''.obs;

  var enableAddButtom = false.obs;

  @override
  void onInit() async {
    SharedPreferences dataStorage = await SharedPreferences.getInstance();
    token = dataStorage.getString('userToken') ?? "";
    userName.value = dataStorage.getString('userName') ?? '';
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
            shared: shared.value,
            taskDetail: taskDetails.value,
            taskTitle: taskTitle.value,
            done: done.value,
            userCreate: token)
        .toFirestore();
    String idTask = await fbs.addNewtask(taskMap: taskMap);
    await addTaskToUserCollection(idTask);
  }

  Future<void> deleteTask(String id) async {
    await fbs.tasks.doc(id).delete();
  }

  Future<void> updateTask() async {
    Map<String, dynamic> taskMap = TasksModel(
            shared: [token],
            taskDetail: taskDetails.value,
            taskTitle: taskTitle.value,
            done: done.value,
            userCreate: token)
        .toFirestore();
    fbs.tasks.doc(id.value).update(taskMap);
  }

  Future<void> deleteTaskFromUserCollection(String taskId) async {
    fbs.removeTaskFromUserColelction(taskId);
  }

  Future<void> addTaskToUserCollection(String taskId) async {
    fbs.userQuery.where('token', isEqualTo: token).get().then((value) {
      DocumentSnapshot documentSnapshot = value.docs[0];

      Map<String, dynamic> userMap = {
        'tasks': FieldValue.arrayUnion([taskId]),
      };

      fbs.updateUser(doc: documentSnapshot.id, userMap: userMap);
    });
  }
}
