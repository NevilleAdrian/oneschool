// To parse this JSON data, do
//
//     final allSubscriptions = allSubscriptionsFromJson(jsonString);

import 'dart:convert';

List<AllSubscriptions> allSubscriptionsFromJson(String str) =>
    List<AllSubscriptions>.from(
        json.decode(str).map((x) => AllSubscriptions.fromJson(x)));

String allSubscriptionsToJson(List<AllSubscriptions> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AllSubscriptions {
  AllSubscriptions({
    this.id,
    this.title,
    this.description,
    this.amount,
    this.duration,
    this.createdAt,
    this.slug,
    this.v,
  });

  String id;
  String title;
  String description;
  int amount;
  String duration;
  DateTime createdAt;
  String slug;
  int v;

  factory AllSubscriptions.fromJson(Map<String, dynamic> json) =>
      AllSubscriptions(
        id: json["_id"],
        title: json["title"],
        description: json["description"],
        amount: json["amount"],
        duration: json["duration"],
        createdAt: DateTime.parse(json["createdAt"]),
        slug: json["slug"],
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "title": title,
        "description": description,
        "amount": amount,
        "duration": duration,
        "createdAt": createdAt.toIso8601String(),
        "slug": slug,
        "__v": v,
      };
}
