import 'dart:convert';

import 'package:hive/hive.dart';

part 'grades.g.dart';

List<Grades> gradesFromJson(String str) =>
    List<Grades>.from(json.decode(str).map((x) => Grades.fromJson(x)));

String gradesToJson(List<Grades> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

@HiveType(typeId: 3)
class Grades {
  Grades({
    this.id,
    this.name,
    this.description,
    this.photo,
    this.createdAt,
    this.v,
    this.subjects,
    this.gradeId,
  });

  @HiveField(0)
  String id;
  @HiveField(1)
  String name;
  @HiveField(2)
  String description;
  @HiveField(3)
  String photo;
  @HiveField(4)
  DateTime createdAt;
  @HiveField(5)
  int v;
  @HiveField(6)
  List<Subject> subjects;
  @HiveField(7)
  String gradeId;

  factory Grades.fromJson(Map<String, dynamic> json) => Grades(
        id: json["_id"],
        name: json["name"],
        description: json["description"],
        photo: json["photo"],
        createdAt: DateTime.parse(json["createdAt"]),
        v: json["__v"],
        subjects: List<Subject>.from(
            json["subjects"].map((x) => Subject.fromJson(x))),
        gradeId: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "description": description,
        "photo": photo,
        "createdAt": createdAt.toIso8601String(),
        "__v": v,
        "subjects": List<dynamic>.from(subjects.map((x) => x.toJson())),
        "id": gradeId,
      };
}

class Subject {
  Subject({
    this.id,
    this.name,
    this.grade,
    this.subjectId,
  });

  String id;
  String name;
  String grade;
  String subjectId;

  factory Subject.fromJson(Map<String, dynamic> json) => Subject(
        id: json["_id"],
        name: json["name"],
        grade: json["grade"],
        subjectId: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "grade": grade,
        "id": subjectId,
      };
}
