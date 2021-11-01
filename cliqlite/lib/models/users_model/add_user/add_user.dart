// To parse this JSON data, do
//
//     final addUser = addUserFromJson(jsonString);

import 'dart:convert';

AddUser addUserFromJson(String str) => AddUser.fromJson(json.decode(str));

String addUserToJson(AddUser data) => json.encode(data.toJson());

class AddUser {
  AddUser({
    this.name,
    this.age,
    this.grade,
  });

  String name;
  int age;
  String grade;

  factory AddUser.fromJson(Map<String, dynamic> json) => AddUser(
        name: json["name"],
        age: json["age"],
        grade: json["grade"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "age": age,
        "grade": grade,
      };
}
