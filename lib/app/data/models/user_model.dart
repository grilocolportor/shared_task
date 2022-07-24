import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String? id;
  final String? token;
  final String? userEmail;
  final String? userName;
  final List? tasks;
  final String? imagePath;

  UserModel({this.id, this.token, this.userEmail, this.userName, this.tasks, this.imagePath});

  UserModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        token = json['token'],
        userEmail = json['userEmail'],
        userName = json['userName'],
        tasks = json['tasks'] is Iterable ? List.from(json['tasks']) : [],
        imagePath = json['imagePath'];

  factory UserModel.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> snapshot) {
    final data = snapshot.data();
    return UserModel(
      id: data?['id'],
      token: data?['token'],
      userEmail: data?['userEmail'],
      userName: data?['userName'],
      imagePath: data?['imagePath'],
      tasks: data?['tasks'] is Iterable ? List.from(data?['tasks']) : null,
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (id != null) "id": id,
      if (token != null) "token": token,
      if (userEmail != null) "userEmail": userEmail,
      if (userName != null) "userName": userName,
      if (imagePath != null) "imagePath": imagePath,
      if (tasks != null) "tasks": tasks,
    };
  }
}
