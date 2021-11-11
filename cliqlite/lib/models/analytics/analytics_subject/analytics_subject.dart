import 'dart:convert';

import 'package:hive/hive.dart';

part 'analytics_subject.g.dart';

List<AnalyticSubject> analyticSubjectFromJson(String str) =>
    List<AnalyticSubject>.from(
        json.decode(str).map((x) => AnalyticSubject.fromJson(x)));

String analyticSubjectToJson(List<AnalyticSubject> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

@HiveType(typeId: 11)
class AnalyticSubject {
  AnalyticSubject({
    this.id,
    this.subjectPercentile,
    this.subjectInfo,
  });

  @HiveField(0)
  Id id;
  @HiveField(1)
  double subjectPercentile;
  @HiveField(2)
  List<SubjectInfo> subjectInfo;

  factory AnalyticSubject.fromJson(Map<String, dynamic> json) =>
      AnalyticSubject(
        id: Id.fromJson(json["_id"]),
        subjectPercentile: json["subjectPercentile"].toDouble(),
        subjectInfo: List<SubjectInfo>.from(
            json["subject_info"].map((x) => SubjectInfo.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "_id": id.toJson(),
        "subjectPercentile": subjectPercentile,
        "subject_info": List<dynamic>.from(subjectInfo.map((x) => x.toJson())),
      };
}

class Id {
  Id({
    this.subject,
    this.user,
  });

  String subject;
  String user;

  factory Id.fromJson(Map<String, dynamic> json) => Id(
        subject: json["subject"],
        user: json["user"],
      );

  Map<String, dynamic> toJson() => {
        "subject": subject,
        "user": user,
      };
}

class SubjectInfo {
  SubjectInfo({
    this.id,
    this.name,
    this.photo,
    this.description,
    this.grade,
    this.createdAt,
    this.slug,
    this.v,
  });

  String id;
  String name;
  String photo;
  String description;
  String grade;
  DateTime createdAt;
  String slug;
  int v;

  factory SubjectInfo.fromJson(Map<String, dynamic> json) => SubjectInfo(
        id: json["_id"],
        name: json["name"],
        photo: json["photo"],
        description: json["description"],
        grade: json["grade"],
        createdAt: DateTime.parse(json["createdAt"]),
        slug: json["slug"],
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "photo": photo,
        "description": description,
        "grade": grade,
        "createdAt": createdAt.toIso8601String(),
        "slug": slug,
        "__v": v,
      };
}
