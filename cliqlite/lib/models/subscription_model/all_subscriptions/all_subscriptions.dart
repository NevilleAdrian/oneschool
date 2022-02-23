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
    this.type,
    this.price,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  String id;
  String type;
  int price;
  DateTime createdAt;
  DateTime updatedAt;
  int v;

  factory AllSubscriptions.fromJson(Map<String, dynamic> json) =>
      AllSubscriptions(
        id: json["_id"],
        type: json["name"],
        price: json["price"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "type": type,
        "price": price,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
      };
}
