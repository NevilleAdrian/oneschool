import 'dart:convert';

import 'package:hive/hive.dart';

part 'main_auth_user.g.dart';

MainChildUser mainChildUserFromJson(String str) =>
    MainChildUser.fromJson(json.decode(str));

String mainChildUserToJson(MainChildUser data) => json.encode(data.toJson());

@HiveType(typeId: 14)
class MainChildUser {
  MainChildUser(
      {this.id,
      this.name,
      this.email,
      this.age,
      this.isSubscribed,
      this.grade,
      this.role,
      this.photo,
      this.createdAt,
      this.v,
      this.mainChildUserId,
      this.isActive,
      this.dob,
      this.test,
      this.planType});

  @HiveField(0)
  String id;
  @HiveField(1)
  String name;
  @HiveField(2)
  String email;
  @HiveField(3)
  int age;
  @HiveField(4)
  bool isSubscribed;
  @HiveField(5)
  String grade;
  @HiveField(6)
  String role;
  @HiveField(7)
  String photo;
  @HiveField(8)
  DateTime createdAt;
  @HiveField(9)
  int v;
  @HiveField(10)
  String mainChildUserId;
  @HiveField(11)
  bool isActive;
  @HiveField(12)
  bool test;
  @HiveField(13)
  String dob;
  @HiveField(14)
  String planType;

  factory MainChildUser.fromJson(Map<String, dynamic> json) => MainChildUser(
        id: json["_id"],
        name: json["name"],
        email: json["email"],
        age: json["age"],
        isSubscribed: json["subscribed"],
        isActive: json["isActive"],
        test: json["test"],
        grade: json["grade"],
        role: json["role"],
        photo: json["photo"],
        dob: json["dob"],
        createdAt: DateTime.parse(json["createdAt"]),
        v: json["__v"],
        mainChildUserId: json["id"],
        planType: json["planType"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "email": email,
        "age": age,
        "isSubscribed": isSubscribed,
        "isActive": isActive,
        "test": test,
        "grade": grade,
        "role": role,
        "photo": photo,
        "createdAt": createdAt.toIso8601String(),
        "__v": v,
        "id": mainChildUserId,
        "dob": dob,
        "planType": planType,
      };
}
