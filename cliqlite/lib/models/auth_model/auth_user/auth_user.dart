// To parse this JSON data, do
//
//     final authUser = authUserFromJson(jsonString);

import 'dart:convert';

import 'package:hive/hive.dart';

part 'auth_user.g.dart';

AuthUser authUserFromJson(String str) => AuthUser.fromJson(json.decode(str));

String authUserToJson(AuthUser data) => json.encode(data.toJson());

@HiveType(typeId: 1)
class AuthUser {
  AuthUser({
    this.email,
    this.fullname,
    this.id,
    this.grade,
    this.role,
  });
  @HiveField(0)
  String email;
  @HiveField(1)
  String fullname;
  @HiveField(2)
  String id;
  @HiveField(3)
  String grade;
  @HiveField(4)
  String role;

  factory AuthUser.fromJson(Map<String, dynamic> json) => AuthUser(
        email: json["email"],
        fullname: json["fullname"],
        id: json["id"],
        grade: json["grade"],
        role: json["role"],
      );

  Map<String, dynamic> toJson() => {
        "email": email,
        "fullname": fullname,
        "id": id,
        "grade": grade,
        "role": role,
      };
}
