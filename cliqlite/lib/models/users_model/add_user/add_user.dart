// To parse this JSON data, do
//
//     final addUser = addUserFromJson(jsonString);

import 'dart:convert';

AddUser addUserFromJson(String str) => AddUser.fromJson(json.decode(str));

String addUserToJson(AddUser data) => json.encode(data.toJson());

class AddUser {
  AddUser({this.name, this.dob, this.grade, this.image, this.category});

  String name;
  String dob;
  String grade;
  String image;
  String category;

  factory AddUser.fromJson(Map<String, dynamic> json) => AddUser(
        name: json["name"],
        dob: json["dob"],
        grade: json["grade"],
        image: json["image"],
        category: json["category"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "dob": dob,
        "grade": grade,
        "image": image,
        "catId": category,
      };
}
