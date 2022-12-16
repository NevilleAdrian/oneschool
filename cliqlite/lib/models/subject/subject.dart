import 'dart:convert';

import 'package:cliqlite/models/grades/grades.dart';
import 'package:hive/hive.dart';

part 'subject.g.dart';

List<Subject> subjectFromJson(String str) =>
    List<Subject>.from(json.decode(str).map((x) => Subject.fromJson(x)));

String subjectToJson(List<Subject> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

@HiveType(typeId: 6)
class Subject {
  Subject(
      {this.photo,
      this.id,
      this.name,
      this.description,
      this.grade,
      this.createdAt,
      this.slug,
      this.v,
      this.subjectId,
      this.icon,
      this.primaryColor,
      this.secondaryColor});
  @HiveField(0)
  String photo;
  @HiveField(1)
  dynamic id;
  @HiveField(2)
  String name;
  @HiveField(3)
  String description;
  @HiveField(4)
  Grades grade;
  @HiveField(5)
  DateTime createdAt;
  @HiveField(6)
  String slug;
  @HiveField(7)
  dynamic v;
  @HiveField(8)
  String subjectId;
  @HiveField(9)
  String icon;
  @HiveField(10)
  String primaryColor;
  @HiveField(11)
  String secondaryColor;

  factory Subject.fromJson(Map<String, dynamic> json) {
    print(json["grade"]["_id"].runtimeType);
    return Subject(
      photo: json["photo"] ?? '',
      id: json["_id"] ?? '',
      name: json["name"] ?? '',
      description: json["description"] ?? '',
      grade: Grades.fromJson(json["grade"]),
      createdAt: json["createdAt"] == null
          ? DateTime.now()
          : DateTime.parse(json["createdAt"]),
      slug: json["slug"] ?? '',
      v: json["__v"] ?? '',
      subjectId: json["id"] ?? '',
      icon: json["icon"] ?? '',
      primaryColor: json["primaryColor"] ?? '',
      secondaryColor: json["secondaryColor"] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
        "photo": photo,
        "_id": id,
        "name": name,
        "description": description,
        // "grade": grade,
        "createdAt": createdAt.toIso8601String(),
        "slug": slug,
        "__v": v,
        "id": subjectId,
        "icon": icon,
        "primaryColor": primaryColor,
        "secondaryColor": secondaryColor,
      };
}
