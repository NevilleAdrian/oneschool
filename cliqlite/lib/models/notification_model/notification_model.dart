// To parse this JSON data, do
//
//     final notifications = notificationsFromJson(jsonString);

import 'dart:convert';

List<Notifications> notificationsFromJson(String str) =>
    List<Notifications>.from(
        json.decode(str).map((x) => Notifications.fromJson(x)));

String notificationsToJson(List<Notifications> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Notifications {
  Notifications({
    this.id,
    this.message,
    this.tags,
    this.createdAt,
    this.v,
  });

  String id;
  String message;
  List<Tag> tags;
  DateTime createdAt;
  int v;

  factory Notifications.fromJson(Map<String, dynamic> json) => Notifications(
        id: json["_id"],
        message: json["message"],
        tags: List<Tag>.from(json["tags"].map((x) => tagValues.map[x])),
        createdAt: DateTime.parse(json["createdAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "message": message,
        "tags": List<dynamic>.from(tags.map((x) => tagValues.reverse[x])),
        "createdAt": createdAt.toIso8601String(),
        "__v": v,
      };
}

enum Tag { ADMIN, TUTOR }

final tagValues = EnumValues({"admin": Tag.ADMIN, "tutor": Tag.TUTOR});

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
