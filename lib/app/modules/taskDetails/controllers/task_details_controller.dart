import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sharedtask/app/data/firebase/firebase_service.dart';
import 'package:sharedtask/app/data/models/tasks_model.dart';

class TaskDetailsController extends GetxController {

  final FireBaseService fbs = FireBaseService();

  var token = "";
  
var taskDetails = ''.obs;
  var taskTitle = ''.obs;
  var done = ''.obs;
  var shared = [].obs;
  var id = ''.obs;

  var userName = ''.obs;

  var enableAddButtom = false.obs;


  final count = 0.obs;
  @override
  void onInit() async{
    super.onInit();
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


    Future<void> updateTask() async {
    Map<String, dynamic> taskMap = TasksModel(
            shared: shared,
            taskDetail: taskDetails.value,
            taskTitle: taskTitle.value,
            done: done.value,
            userCreate: token)
        .toFirestore();
    fbs.tasks.doc(id.value).update(taskMap);
  }

}
