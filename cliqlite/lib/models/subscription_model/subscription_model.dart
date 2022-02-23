// To parse this JSON data, do
//
//     final subscription = subscriptionFromJson(jsonString);

import 'dart:convert';

Subscription subscriptionFromJson(String str) =>
    Subscription.fromJson(json.decode(str));

String subscriptionToJson(Subscription data) => json.encode(data.toJson());

class Subscription {
  Subscription({
    this.id,
    this.owner,
    this.role,
    this.plan,
    this.status,
    this.child,
    this.amount,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  String id;
  Owner owner;
  String role;
  Plan plan;
  String status;
  String child;
  int amount;
  DateTime createdAt;
  DateTime updatedAt;
  int v;

  factory Subscription.fromJson(Map<String, dynamic> json) => Subscription(
        id: json["_id"],
        owner: Owner.fromJson(json["owner"]),
        role: json["role"],
        plan: Plan.fromJson(json["plan"]),
        status: json["status"],
        child: json["child"],
        amount: json["amount"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "owner": owner.toJson(),
        "role": role,
        "plan": plan.toJson(),
        "status": status,
        "child": child,
        "amount": amount,
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
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
      };
}

class Plan {
  Plan({
    this.id,
    this.name,
    this.price,
    this.duration,
  });

  String id;
  String name;
  int price;
  int duration;

  factory Plan.fromJson(Map<String, dynamic> json) => Plan(
        id: json["_id"],
        name: json["name"],
        price: json["price"],
        duration: json["duration"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "price": price,
        "duration": duration,
      };
}
