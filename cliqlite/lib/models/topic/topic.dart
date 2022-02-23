import 'dart:convert';

import 'package:hive/hive.dart';

part 'topic.g.dart';

List<Topic> topicFromJson(String str) =>
    List<Topic>.from(json.decode(str).map((x) => Topic.fromJson(x)));

String topicToJson(List<Topic> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

@HiveType(typeId: 8)
class Topic {
  Topic({
    this.video,
    this.id,
    this.name,
    this.description,
    this.grade,
    this.subject,
    this.icon,
    this.primaryColor,
    this.secondaryColor,
    this.isVerified,
    this.createdAt,
    this.updatedAt,
    this.v,
  });
  @HiveField(0)
  VideoClass video;
  @HiveField(1)
  String id;
  @HiveField(2)
  String name;
  @HiveField(3)
  String description;
  @HiveField(4)
  GradeClass grade;
  @HiveField(5)
  GradeClass subject;
  @HiveField(6)
  String icon;
  @HiveField(7)
  String primaryColor;
  @HiveField(8)
  String secondaryColor;
  @HiveField(9)
  bool isVerified;
  @HiveField(10)
  DateTime createdAt;
  @HiveField(11)
  DateTime updatedAt;
  @HiveField(12)
  int v;

  factory Topic.fromJson(Map<String, dynamic> json) => Topic(
        video: VideoClass.fromJson(json["video"]),
        id: json["_id"],
        name: json["name"],
        description: json["description"],
        grade: GradeClass.fromJson(json["grade"]),
        subject: GradeClass.fromJson(json["subject"]),
        isVerified: json["isVerified"],
        icon: json["icon"],
        primaryColor: json["primaryColor"],
        secondaryColor: json["secondaryColor"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "video": video.toJson(),
        "_id": id,
        "name": name,
        "description": description,
        "grade": grade.toJson(),
        "subject": subject.toJson(),
        "isVerified": isVerified,
        "icon": icon,
        "primaryColor": primaryColor,
        "secondaryColor": secondaryColor,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
      };
}

class VideoClass {
  VideoClass({
    this.name,
    this.url,
  });

  String name;
  String url;

  factory VideoClass.fromJson(Map<String, dynamic> json) => VideoClass(
        name: json["name"],
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "url": url,
      };
}

class GradeClass {
  GradeClass({
    this.id,
    this.name,
    this.description,
  });

  String id;
  String name;
  String description;

  factory GradeClass.fromJson(Map<String, dynamic> json) => GradeClass(
        id: json["_id"],
        name: json["name"],
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "description": description,
      };
}

class TopicSubject {
  TopicSubject({
    this.id,
    this.name,
    this.photo,
    this.description,
    this.grade,
    this.createdAt,
    this.slug,
    this.v,
    this.subjectId,
  });

  String id;
  String name;
  String photo;
  String description;
  String grade;
  DateTime createdAt;
  String slug;
  int v;
  String subjectId;

  factory TopicSubject.fromJson(Map<String, dynamic> json) => TopicSubject(
        id: json["_id"],
        name: json["name"],
        photo: json["photo"],
        description: json["description"],
        grade: json["grade"],
        createdAt: DateTime.parse(json["createdAt"]),
        slug: json["slug"],
        v: json["__v"],
        subjectId: json["id"],
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
        "id": subjectId,
      };
}

class TopicTutor {
  TopicTutor({
    this.id,
    this.fullname,
    this.tutorId,
  });

  String id;
  String fullname;
  String tutorId;

  factory TopicTutor.fromJson(Map<String, dynamic> json) => TopicTutor(
        id: json["_id"],
        fullname: json["fullname"],
        tutorId: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "fullname": fullname,
        "id": tutorId,
      };
}
