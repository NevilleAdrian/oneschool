// To parse this JSON data, do
//
//     final transactions = transactionsFromJson(jsonString);

import 'dart:convert';

Transactions transactionsFromJson(String str) =>
    Transactions.fromJson(json.decode(str));

String transactionsToJson(Transactions data) => json.encode(data.toJson());

class Transactions {
  Transactions({
    this.id,
    this.child,
    this.plan,
    this.subscription,
    this.expireAt,
    this.expired,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  String id;
  Child child;
  TransactionsPlan plan;
  Subscriptions subscription;
  DateTime expireAt;
  bool expired;
  DateTime createdAt;
  DateTime updatedAt;
  int v;

  factory Transactions.fromJson(Map<String, dynamic> json) => Transactions(
        id: json["_id"],
        child: Child.fromJson(json["child"]),
        plan: TransactionsPlan.fromJson(json["plan"]),
        subscription: Subscriptions.fromJson(json["subscription"]),
        expireAt: DateTime.parse(json["expireAt"]),
        expired: json["expired"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "child": child.toJson(),
        "plan": plan.toJson(),
        "subscription": subscription.toJson(),
        "expireAt": expireAt.toIso8601String(),
        "expired": expired,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
      };
}

class Child {
  Child({
    this.id,
    this.name,
  });

  String id;
  String name;

  factory Child.fromJson(Map<String, dynamic> json) => Child(
        id: json["_id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
      };
}

class TransactionsPlan {
  TransactionsPlan({
    this.id,
    this.name,
    this.duration,
    this.price,
  });

  String id;
  String name;
  int duration;
  int price;

  factory TransactionsPlan.fromJson(Map<String, dynamic> json) =>
      TransactionsPlan(
        id: json["_id"],
        name: json["name"],
        duration: json["duration"],
        price: json["price"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "duration": duration,
        "price": price,
      };
}

class Subscriptions {
  Subscriptions({
    this.id,
    this.owner,
    this.role,
    this.plan,
    this.type,
  });

  String id;
  String owner;
  String role;
  SubscriptionPlan plan;
  String type;

  factory Subscriptions.fromJson(Map<String, dynamic> json) => Subscriptions(
        id: json["_id"],
        owner: json["owner"],
        role: json["role"],
        plan: SubscriptionPlan.fromJson(json["plan"]),
        type: json["type"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "owner": owner,
        "role": role,
        "plan": plan.toJson(),
        "type": type,
      };
}

class SubscriptionPlan {
  SubscriptionPlan({
    this.id,
    this.name,
    this.duration,
    this.price,
    this.v,
    this.createdAt,
    this.updatedAt,
  });

  String id;
  String name;
  int duration;
  int price;
  int v;
  DateTime createdAt;
  DateTime updatedAt;

  factory SubscriptionPlan.fromJson(Map<String, dynamic> json) =>
      SubscriptionPlan(
        id: json["_id"],
        name: json["name"],
        duration: json["duration"],
        price: json["price"],
        v: json["__v"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "duration": duration,
        "price": price,
        "__v": v,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
      };
}
