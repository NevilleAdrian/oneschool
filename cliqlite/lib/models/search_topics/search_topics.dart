// To parse this JSON data, do
//
//     final searchTopics = searchTopicsFromJson(jsonString);

import 'dart:convert';

List<SearchTopics> searchTopicsFromJson(String str) => List<SearchTopics>.from(
    json.decode(str).map((x) => SearchTopics.fromJson(x)));

String searchTopicsToJson(List<SearchTopics> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SearchTopics {
  SearchTopics({
    this.id,
    this.name,
    this.description,
    this.grade,
    this.subject,
    this.icon,
    this.primaryColor,
    this.secondaryColor,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  String id;
  String name;
  String description;
  String grade;
  String subject;
  String icon;
  String primaryColor;
  String secondaryColor;
  DateTime createdAt;
  DateTime updatedAt;
  int v;

  factory SearchTopics.fromJson(Map<String, dynamic> json) => SearchTopics(
        id: json["_id"],
        name: json["name"],
        description: json["description"],
        grade: json["grade"],
        subject: json["subject"],
        icon: json["icon"],
        primaryColor: json["primaryColor"],
        secondaryColor: json["secondaryColor"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "description": description,
        "grade": grade,
        "subject": subject,
        "icon": icon,
        "primaryColor": primaryColor,
        "secondaryColor": secondaryColor,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "__v": v,
      };
}
