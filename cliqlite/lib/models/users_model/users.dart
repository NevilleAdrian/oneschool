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
  String dob;
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
  @HiveField(10)
  bool isActive;
  @HiveField(11)
  bool test;
  @HiveField(12)
  int age;
  @HiveField(13)
  String planType;

  Users(
      {this.id,
      this.name,
      this.email,
      this.dob,
      this.parent,
      this.isSubscribed,
      this.grade,
      this.role,
      this.photo,
      this.createdAt,
      this.test,
      this.age,
      this.isActive,
      this.planType});

  factory Users.fromJson(Map<String, dynamic> json) => Users(
        id: json["_id"],
        name: json["name"],
        email: json["email"],
        dob: json["dob"],
        parent: json["parent"],
        isSubscribed: json["subscribed"],
        isActive: json["isActive"],
        age: json["age"],
        test: json["test"],
        grade: json["grade"],
        role: json["role"],
        photo: json["photo"],
        createdAt: DateTime.parse(json["createdAt"]),
        planType: json["planType"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "dob": dob,
        "parent": parent,
        "isSubscribed": isSubscribed,
        "isActive": isActive,
        "test": test,
        "grade": grade,
        "role": role,
        "photo": photo,
        "planType": planType,
        "createdAt": createdAt.toIso8601String(),
      };
}
