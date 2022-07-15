import 'package:cloud_firestore/cloud_firestore.dart';

class TasksModel {
  final Timestamp? dateCreate;
  final Timestamp? dateEnd;
  final List? shared;
  final String? taskTitle;
  final String? taskDetail;
  final String? userCreate;
  final String? done;

  TasksModel(
      {this.dateCreate,
      this.dateEnd,
      this.shared,
      this.taskTitle,
      this.taskDetail,
      this.done, 
      this.userCreate});

  TasksModel.fromJson(Map<String, dynamic> json)
      : dateCreate = json['dataCreate'],
        dateEnd = json['dataEnd'],
        taskTitle = json['taskTitle'],
        taskDetail = json['taskDetail'],
        userCreate = json['userCreate'],
        done = json['done'],
        shared = json['shared'] is Iterable ? List.from(json['shared']) : [];

  factory TasksModel.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> snapshot,
      SnapshotOptions? options) {
    final data = snapshot.data();
    return TasksModel(
      done: data?['done'],
      dateCreate: data?['dataCreate'],
      dateEnd: data?['dataEnd'],
      taskTitle: data?['taskTitle'],
      taskDetail: data?['taskDetail'],
      userCreate: data?['userCreate'],
      shared: data?['shared'] is Iterable ? List.from(data?['shared']) : null,
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (dateCreate != null) "dataCreate": dateCreate,
      if (dateEnd != null) "dateEnd": dateEnd,
      if (shared != null) "shared": shared,
      if (taskTitle != null) "taskTitle": taskTitle,
      if (taskDetail != null) "taskDetail": taskDetail,
      if (userCreate != null) "userCreate": userCreate,
      if (done != null) "done": done,
    };
  }
}
