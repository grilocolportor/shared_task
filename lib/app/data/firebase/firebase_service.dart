// ignore_for_file: prefer_typing_uninitialized_variables, no_leading_underscores_for_local_identifiers

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/state_manager.dart';

class FireBaseService {
  final db = FirebaseFirestore.instance;

  late final CollectionReference tasks;
  late final CollectionReference users;
  late final CollectionReference searchUser;
  late final CollectionReference taskByUser;
  late final CollectionReference userByTask;

  late final Query query;
  late final Query userQuery;
  late final Query searchUserQuery;
  late final Query taskByUserQuery;
  late final Query userByTaskQuery;

  static const source = Source.cache;

  FireBaseService({String? token}) {
    tasks = db.collection('tasks');
    users = db.collection('users');
    searchUser = db.collection('users');
    userByTask = users;

    query = tasks.where("shared", arrayContains: token);
    userQuery = users.where("token", isEqualTo: token);
  }
  

  Future<String> addNewtask({required Map<String, dynamic> taskMap}) async {
    return await tasks.add(taskMap).then((value) {
      return value.id;
    });
  }

  Future<void> adduser({required Map<String, dynamic> userMap}) async {
    users.add(userMap);
  }

  Future<void> updateUser(
      {required String doc, required Map<String, dynamic> userMap}) async {
    users.doc(doc).update(userMap);
  }

  Future<void> removeTaskFromUserColelction(String taskId) async {
    users.where('tasks', arrayContains: taskId).snapshots().forEach((element) {
      element.docs.forEach((value) {
        users.doc(value.id).update({
          'tasks': FieldValue.arrayRemove([taskId])
        });
      });
    });
  }

  Future<void> getUserByTask(String taskId) async {
    userByTaskQuery = userByTask.where('tasks', arrayContains: taskId);
  }

  Future<List> searchUserByParam(String flag, String search) async {
    if (flag.contains('email')) {
      return searchUser
          .where("userEmail", isGreaterThanOrEqualTo: search)
          .where("userEmail", isLessThan: search + 'z')
          .get()
          .then((value) {
        print('------------${value.size})}');
        return value.docs;
      });
    } else {
      return searchUser
          .where("userName", isGreaterThanOrEqualTo: search)
          .where("userName", isLessThan: search + 'z')
          .get()
          .then((value) {
        print('------------${value.docs}');
        return value.docs;
      });
    }
  }
}
