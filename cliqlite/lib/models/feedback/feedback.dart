// To parse this JSON data, do
//
//     final feedback = feedbackFromJson(jsonString);

import 'dart:convert';

import 'package:hive/hive.dart';

part 'feedback.g.dart';

List<Feedbacks> feedbackFromJson(String str) =>
    List<Feedbacks>.from(json.decode(str).map((x) => Feedbacks.fromJson(x)));

String feedbackToJson(List<Feedbacks> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

@HiveType(typeId: 17)
class Feedbacks {
  Feedbacks({
    this.id,
    this.message,
    this.owner,
    this.role,
    this.verified,
    this.createdAt,
    this.updatedAt,
    this.v,
  });
  @HiveField(0)
  String id;
  @HiveField(1)
  String message;
  @HiveField(2)
  Owner owner;
  @HiveField(3)
  String role;
  @HiveField(4)
  bool verified;
  @HiveField(5)
  DateTime createdAt;
  @HiveField(6)
  DateTime updatedAt;
  @HiveField(7)
  int v;

  factory Feedbacks.fromJson(Map<String, dynamic> json) => Feedbacks(
        id: json["_id"],
        message: json["message"],
        owner:
            Owner.fromJson(json["owner"] ?? {"_id": '', "name": 'Anonymous'}),
        role: json["role"],
        verified: json["verified"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "message": message,
        "owner": owner.toJson(),
        "role": role,
        "verified": verified,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
      };
}

class Owner {
  Owner({
    this.id,
    this.name,
  });

  String id;
  String name;

  factory Owner.fromJson(Map<String, dynamic> json) => Owner(
        id: json["_id"],
        name: json["name"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
      };
}
