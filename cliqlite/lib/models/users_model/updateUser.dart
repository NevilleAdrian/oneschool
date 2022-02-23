import 'dart:convert';

UpdateUser updateUserFromJson(String str) =>
    UpdateUser.fromJson(json.decode(str));

String updateUserToJson(UpdateUser data) => json.encode(data.toJson());

class UpdateUser {
  UpdateUser({
    this.name,
    this.age,
    this.grade,
    // this.email,
    this.photo,
  });

  String name;
  int age;
  String grade;
  // String email;
  String photo;

  factory UpdateUser.fromJson(Map<String, dynamic> json) => UpdateUser(
        name: json["name"],
        age: json["age"],
        grade: json["grade"],
        // email: json["email"],
        photo: json["photo"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "age": age,
        "grade": grade,
        // "email": email,
        "photo": photo,
      };
}
