import 'dart:convert';

import 'package:hive/hive.dart';

part 'analytics_topic.g.dart';

List<AnalyticTopic> analyticTopicFromJson(String str) =>
    List<AnalyticTopic>.from(
        json.decode(str).map((x) => AnalyticTopic.fromJson(x)));

String analyticTopicToJson(List<AnalyticTopic> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

@HiveType(typeId: 12)
class AnalyticTopic {
  AnalyticTopic({
    this.id,
    this.topicPercentile,
    this.topicInfo,
  });

  @HiveField(0)
  Id id;
  @HiveField(1)
  double topicPercentile;
  @HiveField(2)
  List<TopicInfo> topicInfo;

  factory AnalyticTopic.fromJson(Map<String, dynamic> json) => AnalyticTopic(
        id: Id.fromJson(json["_id"]),
        topicPercentile: json["topicPercentile"].toDouble(),
        topicInfo: List<TopicInfo>.from(
            json["topic_info"].map((x) => TopicInfo.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "_id": id.toJson(),
        "topicPercentile": topicPercentile,
        "topic_info": List<dynamic>.from(topicInfo.map((x) => x.toJson())),
      };
}

class Id {
  Id({
    this.topic,
    this.user,
  });

  String topic;
  String user;

  factory Id.fromJson(Map<String, dynamic> json) => Id(
        topic: json["topic"],
        user: json["user"],
      );

  Map<String, dynamic> toJson() => {
        "topic": topic,
        "user": user,
      };
}

class TopicInfo {
  TopicInfo({
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
  });

  String id;
  String title;
  String description;
  List<String> tags;
  String subject;
  String status;
  String tutor;
  DateTime createdAt;
  String slug;
  int v;

  factory TopicInfo.fromJson(Map<String, dynamic> json) => TopicInfo(
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
      };
}
