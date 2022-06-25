import 'package:cloud_firestore/cloud_firestore.dart';

class TasksModel {
  final Timestamp? dateCreate;
  final Timestamp? dateEnd;
  final List<String>? shared;
  final String? taskTitle;
  final String? taskDetail;
  final String? userCreate;

  TasksModel(
      {this.dateCreate,
      this.dateEnd ,
      this.shared,
      this.taskTitle,
      this.taskDetail,
      this.userCreate});
  
  TasksModel.fromJson(Map<String, dynamic> json)
  : dateCreate = json['dataCreate'],
      dateEnd = json['dataEnd'],
      taskTitle = json['taskTitle'],
      taskDetail = json['taskDetail'],
      userCreate = json['userCreate'],
      shared = json['shared'] is Iterable ? List.from(json['shared']) : [];

  factory TasksModel.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> snapshot,
      SnapshotOptions? options) {
    final data = snapshot.data();
    return TasksModel(
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
    };
  }
}
