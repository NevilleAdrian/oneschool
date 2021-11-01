import 'dart:convert';

import 'package:hive/hive.dart';

part 'users.g.dart';

List<Users> usersFromJson(String str) =>
    List<Users>.from(json.decode(str).map((x) => Users.fromJson(x)));

String usersToJson(List<Users> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

@HiveType(typeId: 4)
class Users {
  @HiveField(0)
  String id;
  @HiveField(1)
  String name;
  @HiveField(2)
  String email;
  @HiveField(3)
  int age;
  @HiveField(4)
  String parent;
  @HiveField(5)
  bool isSubscribed;
  @HiveField(6)
  String grade;
  @HiveField(7)
  String role;
  @HiveField(8)
  String photo;
  @HiveField(9)
  DateTime createdAt;

  Users({
    this.id,
    this.name,
    this.email,
    this.age,
    this.parent,
    this.isSubscribed,
    this.grade,
    this.role,
    this.photo,
    this.createdAt,
  });

  factory Users.fromJson(Map<String, dynamic> json) => Users(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        age: json["age"],
        parent: json["parent"],
        isSubscribed: json["isSubscribed"],
        grade: json["grade"],
        role: json["role"],
        photo: json["photo"],
        createdAt: DateTime.parse(json["createdAt"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "age": age,
        "parent": parent,
        "isSubscribed": isSubscribed,
        "grade": grade,
        "role": role,
        "photo": photo,
        "createdAt": createdAt.toIso8601String(),
      };
}
