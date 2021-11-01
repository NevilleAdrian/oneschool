import 'dart:convert';

import 'package:hive/hive.dart';

part 'subject.g.dart';

List<Subject> subjectFromJson(String str) =>
    List<Subject>.from(json.decode(str).map((x) => Subject.fromJson(x)));

String subjectToJson(List<Subject> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

@HiveType(typeId: 6)
class Subject {
  Subject({
    this.photo,
    this.id,
    this.name,
    this.description,
    this.grade,
    this.createdAt,
    this.slug,
    this.v,
    this.subjectId,
  });
  @HiveField(0)
  String photo;
  @HiveField(1)
  String id;
  @HiveField(2)
  String name;
  @HiveField(3)
  String description;
  @HiveField(4)
  String grade;
  @HiveField(5)
  DateTime createdAt;
  @HiveField(6)
  String slug;
  @HiveField(7)
  int v;
  @HiveField(8)
  String subjectId;

  factory Subject.fromJson(Map<String, dynamic> json) => Subject(
        photo: json["photo"],
        id: json["_id"],
        name: json["name"],
        description: json["description"],
        grade: json["grade"],
        createdAt: DateTime.parse(json["createdAt"]),
        slug: json["slug"],
        v: json["__v"],
        subjectId: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "photo": photo,
        "_id": id,
        "name": name,
        "description": description,
        "grade": grade,
        "createdAt": createdAt.toIso8601String(),
        "slug": slug,
        "__v": v,
        "id": subjectId,
      };
}
