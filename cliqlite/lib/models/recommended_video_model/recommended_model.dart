// To parse this JSON data, do
//
//     final recommendedVideo = recommendedVideoFromJson(jsonString);

import 'dart:convert';

import 'package:hive/hive.dart';

part 'recommended_model.g.dart';

List<RecommendedVideo> recommendedVideoFromJson(String str) =>
    List<RecommendedVideo>.from(
        json.decode(str).map((x) => RecommendedVideo.fromJson(x)));

String recommendedVideoToJson(List<RecommendedVideo> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

@HiveType(typeId: 17)
class RecommendedVideo {
  RecommendedVideo({
    this.subject,
    this.video,
  });

  @HiveField(0)
  String subject;
  @HiveField(1)
  Video video;

  factory RecommendedVideo.fromJson(Map<String, dynamic> json) =>
      RecommendedVideo(
        subject: json["subject"],
        video: Video.fromJson(json["video"]),
      );

  Map<String, dynamic> toJson() => {
        "subject": subject,
        "video": video.toJson(),
      };
}

class Video {
  Video({
    this.name,
    this.url,
    this.duration,
  });

  String name;
  String url;
  String duration;

  factory Video.fromJson(Map<String, dynamic> json) => Video(
        name: json["name"],
        url: json["url"],
        duration: json["duration"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "url": url,
        "duration": duration,
      };
}
