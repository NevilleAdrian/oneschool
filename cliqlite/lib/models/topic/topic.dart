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
    this.id,
    this.title,
    this.description,
    this.tags,
    this.subject,
    this.status,
    this.tutor,
    this.createdAt,
    this.slug,
    this.v,
    this.topicId,
  });
  @HiveField(0)
  String id;
  @HiveField(1)
  String title;
  @HiveField(2)
  String description;
  @HiveField(3)
  List<String> tags;
  @HiveField(4)
  String subject;
  @HiveField(5)
  String status;
  @HiveField(6)
  String tutor;
  @HiveField(7)
  DateTime createdAt;
  @HiveField(8)
  String slug;
  @HiveField(9)
  int v;
  @HiveField(10)
  String topicId;

  factory Topic.fromJson(Map<String, dynamic> json) => Topic(
        id: json["_id"],
        title: json["title"],
        description: json["description"],
        tags: List<String>.from(json["tags"].map((x) => x)),
        subject: json["subject"],
        status: json["status"],
        tutor: json["tutor"],
        createdAt: DateTime.parse(json["createdAt"]),
        slug: json["slug"],
        v: json["__v"],
        topicId: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "title": title,
        "description": description,
        "tags": List<dynamic>.from(tags.map((x) => x)),
        "subject": subject,
        "status": status,
        "tutor": tutor,
        "createdAt": createdAt.toIso8601String(),
        "slug": slug,
        "__v": v,
        "id": topicId,
      };
}
