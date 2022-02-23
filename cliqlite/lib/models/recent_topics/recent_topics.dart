import 'dart:convert';

import 'package:cliqlite/models/subject/grade/grade.dart';
import 'package:cliqlite/models/topic/topic.dart';
import 'package:hive/hive.dart';

part 'recent_topics.g.dart';

List<RecentTopic> recentTopicFromJson(String str) => List<RecentTopic>.from(
    json.decode(str).map((x) => RecentTopic.fromJson(x)));

// String recentTopicToJson(List<RecentTopic> data) =>
//     json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

@HiveType(typeId: 16)
class RecentTopic {
  RecentTopic({
    this.id,
    this.child,
    this.grade,
    this.subject,
    this.topic,
    this.lastViewed,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  @HiveField(0)
  String id;
  @HiveField(1)
  String child;
  @HiveField(2)
  Grade grade;
  @HiveField(3)
  Grade subject;
  @HiveField(4)
  Topic topic;
  @HiveField(5)
  DateTime lastViewed;
  @HiveField(6)
  DateTime createdAt;
  @HiveField(7)
  DateTime updatedAt;
  @HiveField(8)
  int v;

  factory RecentTopic.fromJson(Map<String, dynamic> json) => RecentTopic(
        id: json["_id"],
        child: json["child"],
        grade: Grade.fromJson(json["grade"]),
        subject: Grade.fromJson(json["subject"]),
        topic: Topic.fromJson(json["topic"]),
        lastViewed: DateTime.parse(json["lastViewed"]),
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );

  // Map<String, dynamic> toJson() => {
  //       "_id": id,
  //       "child": child,
  //       "grade": grade.toJson(),
  //       "subject": subject.toJson(),
  //       "topic": topic.toJson(),
  //       "lastViewed": lastViewed.toIso8601String(),
  //       "createdAt": createdAt.toIso8601String(),
  //       "updatedAt": updatedAt.toIso8601String(),
  //       "__v": v,
  //     };
}

// class TopicString {
//   TopicString({
//     this.video,
//     this.id,
//     this.name,
//     this.description,
//     this.grade,
//     this.subject,
//     this.isVerified,
//     this.icon,
//     this.primaryColor,
//     this.secondaryColor,
//     this.createdAt,
//     this.updatedAt,
//     this.v,
//     this.lastViewed,
//   });
//
//   VideoClass video;
//   String id;
//   String name;
//   String description;
//   String grade;
//   String subject;
//   bool isVerified;
//   String icon;
//   String primaryColor;
//   String secondaryColor;
//   DateTime createdAt;
//   DateTime updatedAt;
//   int v;
//   DateTime lastViewed;
//
//   factory TopicString.fromJson(Map<String, dynamic> json) => TopicString(
//         video: VideoClass.fromJson(json["video"]),
//         id: json["_id"],
//         name: json["name"],
//         description: json["description"],
//         grade: json["grade"],
//         subject: json["subject"],
//         isVerified: json["isVerified"],
//         icon: json["icon"],
//         primaryColor: json["primaryColor"],
//         secondaryColor: json["secondaryColor"],
//         createdAt: DateTime.parse(json["createdAt"]),
//         updatedAt: DateTime.parse(json["updatedAt"]),
//         v: json["__v"],
//         lastViewed:
//             DateTime.parse(json["lastViewed"] ?? DateTime.now().toString()),
//       );
//
//   Map<String, dynamic> toJson() => {
//         "video": video.toJson(),
//         "_id": id,
//         "name": name,
//         "description": description,
//         "grade": grade,
//         "subject": subject,
//         "isVerified": isVerified,
//         "icon": icon,
//         "primaryColor": primaryColor,
//         "secondaryColor": secondaryColor,
//         "createdAt": createdAt.toIso8601String(),
//         "updatedAt": updatedAt.toIso8601String(),
//         "__v": v,
//         "lastViewed": lastViewed.toIso8601String(),
//       };
// }
