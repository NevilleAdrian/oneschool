// To parse this JSON data, do
//
//     final addUser = addUserFromJson(jsonString);

import 'dart:convert';

AddUser addUserFromJson(String str) => AddUser.fromJson(json.decode(str));

String addUserToJson(AddUser data) => json.encode(data.toJson());

class AddUser {
  AddUser({this.name, this.age, this.grade, this.image});

  String name;
  int age;
  String grade;
  String image;

  factory AddUser.fromJson(Map<String, dynamic> json) => AddUser(
        name: json["name"],
        age: json["age"],
        grade: json["grade"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "age": age,
        "grade": grade,
        "image": image,
      };
}
