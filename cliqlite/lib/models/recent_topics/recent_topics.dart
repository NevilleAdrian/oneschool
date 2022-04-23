// import 'dart:convert';
//
// import 'package:cliqlite/models/subject/grade/grade.dart';
// import 'package:cliqlite/models/topic/topic.dart';
// import 'package:hive/hive.dart';
//
// part 'recent_topics.g.dart';
//
// List<RecentTopic> recentTopicFromJson(String str) => List<RecentTopic>.from(
//     json.decode(str).map((x) => RecentTopic.fromJson(x)));
//
// // String recentTopicToJson(List<RecentTopic> data) =>
// //     json.encode(List<dynamic>.from(data.map((x) => x.toJson())));
//
// @HiveType(typeId: 16)
// class RecentTopic {
//   RecentTopic({
//     this.id,
//     this.child,
//     this.grade,
//     this.subject,
//     this.topic,
//     this.lastViewed,
//     this.createdAt,
//     this.updatedAt,
//     this.v,
//   });
//
//   @HiveField(0)
//   String id;
//   @HiveField(1)
//   String child;
//   @HiveField(2)
//   GradeClass grade;
//   @HiveField(3)
//   GradeClass subject;
//   @HiveField(4)
//   Topic topic;
//   @HiveField(5)
//   DateTime lastViewed;
//   @HiveField(6)
//   DateTime createdAt;
//   @HiveField(7)
//   DateTime updatedAt;
//   @HiveField(8)
//   int v;
//
//   factory RecentTopic.fromJson(Map<String, dynamic> json) => RecentTopic(
//         id: json["_id"],
//         child: json["child"],
//         grade: GradeClass.fromJson(json["grade"]),
//         subject: GradeClass.fromJson(json["subject"]),
//         topic: Topic.fromJson(json["topic"]),
//         lastViewed: DateTime.parse(json["lastViewed"]),
//         createdAt: DateTime.parse(json["createdAt"]),
//         updatedAt: DateTime.parse(json["updatedAt"]),
//         v: json["__v"],
//       );
//
//   // Map<String, dynamic> toJson() => {
//   //       "_id": id,
//   //       "child": child,
//   //       "grade": grade.toJson(),
//   //       "subject": subject.toJson(),
//   //       "topic": topic.toJson(),
//   //       "lastViewed": lastViewed.toIso8601String(),
//   //       "createdAt": createdAt.toIso8601String(),
//   //       "updatedAt": updatedAt.toIso8601String(),
//   //       "__v": v,
//   //     };
// }
//
// // class TopicString {
// //   TopicString({
// //     this.video,
// //     this.id,
// //     this.name,
// //     this.description,
// //     this.grade,
// //     this.subject,
// //     this.isVerified,
// //     this.icon,
// //     this.primaryColor,
// //     this.secondaryColor,
// //     this.createdAt,
// //     this.updatedAt,
// //     this.v,
// //     this.lastViewed,
// //   });
// //
// //   VideoClass video;
// //   String id;
// //   String name;
// //   String description;
// //   String grade;
// //   String subject;
// //   bool isVerified;
// //   String icon;
// //   String primaryColor;
// //   String secondaryColor;
// //   DateTime createdAt;
// //   DateTime updatedAt;
// //   int v;
// //   DateTime lastViewed;
// //
// //   factory TopicString.fromJson(Map<String, dynamic> json) => TopicString(
// //         video: VideoClass.fromJson(json["video"]),
// //         id: json["_id"],
// //         name: json["name"],
// //         description: json["description"],
// //         grade: json["grade"],
// //         subject: json["subject"],
// //         isVerified: json["isVerified"],
// //         icon: json["icon"],
// //         primaryColor: json["primaryColor"],
// //         secondaryColor: json["secondaryColor"],
// //         createdAt: DateTime.parse(json["createdAt"]),
// //         updatedAt: DateTime.parse(json["updatedAt"]),
// //         v: json["__v"],
// //         lastViewed:
// //             DateTime.parse(json["lastViewed"] ?? DateTime.now().toString()),
// //       );
// //
// //   Map<String, dynamic> toJson() => {
// //         "video": video.toJson(),
// //         "_id": id,
// //         "name": name,
// //         "description": description,
// //         "grade": grade,
// //         "subject": subject,
// //         "isVerified": isVerified,
// //         "icon": icon,
// //         "primaryColor": primaryColor,
// //         "secondaryColor": secondaryColor,
// //         "createdAt": createdAt.toIso8601String(),
// //         "updatedAt": updatedAt.toIso8601String(),
// //         "__v": v,
// //         "lastViewed": lastViewed.toIso8601String(),
// //       };
// // }

// To parse this JSON data, do
//
//     final recentTopic = recentTopicFromJson(jsonString);

import 'dart:convert';

import 'package:cliqlite/models/topic/topic.dart';
import 'package:hive/hive.dart';

part 'recent_topics.g.dart';

List<RecentTopic> recentTopicFromJson(String str) => List<RecentTopic>.from(
    json.decode(str).map((x) => RecentTopic.fromJson(x)));

String recentTopicToJson(List<RecentTopic> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

@HiveType(typeId: 16)
class RecentTopic {
  RecentTopic({
    this.id,
    this.child,
    this.grade,
    this.subject,
    this.topic,
    this.lastViewed,
    this.expireAt,
    this.v,
    this.createdAt,
    this.updatedAt,
  });

  @HiveField(0)
  String id;
  @HiveField(1)
  String child;
  @HiveField(2)
  SubjectClass grade;
  @HiveField(3)
  SubjectClass subject;
  @HiveField(4)
  Topic topic;
  @HiveField(5)
  DateTime lastViewed;
  @HiveField(6)
  DateTime expireAt;
  @HiveField(7)
  int v;
  @HiveField(8)
  DateTime createdAt;
  @HiveField(9)
  DateTime updatedAt;

  factory RecentTopic.fromJson(Map<String, dynamic> json) => RecentTopic(
        id: json["_id"],
        child: json["child"],
        grade: SubjectClass.fromJson(json["grade"]),
        subject: SubjectClass.fromJson(json["subject"]),
        topic: Topic.fromJson(json["topic"]),
        lastViewed: DateTime.parse(json["lastViewed"]),
        expireAt: DateTime.parse(json["expireAt"]),
        v: json["__v"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "child": child,
        "grade": grade.toJson(),
        "subject": subject.toJson(),
        "topic": topic.toJson(),
        "lastViewed": lastViewed.toIso8601String(),
        "expireAt": expireAt.toIso8601String(),
        "__v": v,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
      };
}

class SubjectClass {
  SubjectClass({
    this.id,
    this.name,
    this.description,
  });

  String id;
  String name;
  String description;

  factory SubjectClass.fromJson(Map<String, dynamic> json) => SubjectClass(
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

class TopicClass {
  TopicClass({
    this.video,
    this.id,
    this.name,
    this.description,
    this.grade,
    this.subject,
    this.isVerified,
    this.icon,
    this.primaryColor,
    this.secondaryColor,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  VideoClass video;
  String id;
  String name;
  String description;
  TopicGrade grade;
  SubjectTopicClass subject;
  bool isVerified;
  String icon;
  String primaryColor;
  String secondaryColor;
  DateTime createdAt;
  DateTime updatedAt;
  int v;

  factory TopicClass.fromJson(Map<String, dynamic> json) => TopicClass(
        video: VideoClass.fromJson(json["video"]),
        id: json["_id"],
        name: json["name"],
        description: json["description"],
        grade: TopicGrade.fromJson(json["grade"]),
        subject: SubjectTopicClass.fromJson(json["subject"]),
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

class TopicGrade {
  TopicGrade({
    this.id,
    this.name,
    this.description,
    this.subjectsNo,
    this.topicsNo,
    this.photo,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  String id;
  String name;
  String description;
  int subjectsNo;
  int topicsNo;
  String photo;
  DateTime createdAt;
  DateTime updatedAt;
  int v;

  factory TopicGrade.fromJson(Map<String, dynamic> json) => TopicGrade(
        id: json["_id"],
        name: json["name"],
        description: json["description"],
        subjectsNo: json["subjectsNo"],
        topicsNo: json["topicsNo"],
        photo: json["photo"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "description": description,
        "subjectsNo": subjectsNo,
        "topicsNo": topicsNo,
        "photo": photo,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
      };
}

class SubjectTopicClass {
  SubjectTopicClass({
    this.id,
    this.name,
    this.description,
    this.photo,
    this.grade,
    this.icon,
    this.primaryColor,
    this.secondaryColor,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.tutor,
  });

  String id;
  String name;
  String description;
  String photo;
  String grade;
  String icon;
  String primaryColor;
  String secondaryColor;
  DateTime createdAt;
  DateTime updatedAt;
  int v;
  String tutor;

  factory SubjectTopicClass.fromJson(Map<String, dynamic> json) =>
      SubjectTopicClass(
        id: json["_id"],
        name: json["name"],
        description: json["description"],
        photo: json["photo"],
        grade: json["grade"],
        icon: json["icon"],
        primaryColor: json["primaryColor"],
        secondaryColor: json["secondaryColor"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
        tutor: json["tutor"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "description": description,
        "photo": photo,
        "grade": grade,
        "icon": icon,
        "primaryColor": primaryColor,
        "secondaryColor": secondaryColor,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
        "tutor": tutor,
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
