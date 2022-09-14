// To parse this JSON data, do
//
//     final register = registerFromJson(jsonString);

import 'dart:convert';

Register registerFromJson(String str) => Register.fromJson(json.decode(str));

String registerToJson(Register data) => json.encode(data.toJson());

class Register {
  Register(
      {this.email,
      this.fullName,
      this.password,
      this.phone,
      this.childName,
      this.dob,
      this.childClass,
      this.category});

  String email;
  String fullName;
  String phone;
  String password;
  String childName;
  String dob;
  String childClass;
  String category;

  factory Register.fromJson(Map<String, dynamic> json) => Register(
        email: json["email"],
        fullName: json["fullname"],
        password: json["password"],
        phone: json["phone"],
        childName: json["childName"],
        dob: json["dob"],
        childClass: json["grade"],
        category: json["category"],
      );

  Map<String, dynamic> toJson() => {
        "email": email,
        "fullname": fullName,
        "phone": phone,
        "password": password,
        "childName": childName,
        "dob": dob,
        "grade": childClass,
        "category": category
      };
}
