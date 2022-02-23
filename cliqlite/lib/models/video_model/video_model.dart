import 'dart:convert';

import 'package:hive/hive.dart';

part 'video_model.g.dart';

List<Video> videoFromJson(String str) =>
    List<Video>.from(json.decode(str).map((x) => Video.fromJson(x)));

String videoToJson(List<Video> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

@HiveType(typeId: 9)
class Video {
  Video(
      {this.id,
      this.title,
      this.originalFilename,
      this.duration,
      this.bytes,
      this.publicId,
      this.resourceType,
      this.secureUrl,
      this.topic,
      this.createdAt,
      this.slug,
      this.tags});
  @HiveField(0)
  String id;
  @HiveField(1)
  String title;
  @HiveField(2)
  String originalFilename;
  @HiveField(3)
  String duration;
  @HiveField(4)
  int bytes;
  @HiveField(5)
  String publicId;
  @HiveField(6)
  String resourceType;
  @HiveField(7)
  String secureUrl;
  @HiveField(8)
  dynamic topic;
  @HiveField(9)
  DateTime createdAt;
  @HiveField(10)
  String slug;
  @HiveField(11)
  List<dynamic> tags;

  factory Video.fromJson(Map<String, dynamic> json) => Video(
        id: json["_id"],
        title: json["title"],
        originalFilename: json["original_filename"],
        duration: json["duration"],
        bytes: json["bytes"],
        publicId: json["public_id"],
        resourceType: json["resource_type"],
        secureUrl: json["secure_url"],
        topic: json["topic"],
        createdAt: DateTime.parse(json["createdAt"]),
        slug: json["slug"],
        tags: json["tags"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "title": title,
        "original_filename": originalFilename,
        "duration": duration,
        "bytes": bytes,
        "public_id": publicId,
        "resource_type": resourceType,
        "secure_url": secureUrl,
        "topic": topic,
        "createdAt": createdAt.toIso8601String(),
        "slug": slug,
        "tags": tags,
      };
}
