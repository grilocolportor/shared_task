// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sharedtask/app/data/models/tasks_model.dart';

class FireBaseService {
  final db = FirebaseFirestore.instance;

  var tasks;

  static const source = Source.cache;

  FireBaseService() {
    tasks = db.collection('tasks');
  }

  Future<void> addNewtask({required Map<String, dynamic> taskMap}) async {
    tasks.add(taskMap);
  }

  Future<void> readTask() async {
    await tasks.get().then(
      (res) {
        for (var element in res.docs) {
          print(element.id);
        }
      },
      onError: (e) => print("Error completing: $e"),
    );
  }

  Future<List> readAllTask({required String token }) async {
    final ret = await tasks
        .where("shared", arrayContains: token)
        .get()
        .then(
      (res) {
        return res.docs
            .map((document) => TasksModel.fromJson(document.data()))
            .toList();
      },
      onError: (e) => print("Error completing: $e"),
    );
    return ret;
  }
}
