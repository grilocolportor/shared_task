import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  const UserEntity({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.imageUrl,
    required this.tasks,
  });

  final String id;
  final String firstName;
  final String lastName;
  final String email;
  final String imageUrl;
  final List tasks;

  factory UserEntity.fromJson(Map<String, dynamic> json) => UserEntity(
        id: json['id'] ?? "",
        firstName: json['firstName'] ?? "",
        lastName: json['lastName'] ?? "",
        email: json['email'] ?? "",
        imageUrl: json['imageUrl'] ?? "", 
        tasks:  json['tasks'] ?? [],
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'firstName': firstName,
        'lastName': lastName,
        'email': email,
        'imageUrl': imageUrl,
      };
  factory UserEntity.empty() => const UserEntity(
        id: "",
        firstName: "",
        lastName: "",
        email: "",
        imageUrl: "",
        tasks: []
      );
  @override
  List<Object?> get props => [id, firstName, lastName, email, imageUrl, tasks];
}
