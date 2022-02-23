// To parse this JSON data, do
//
//     final transactions = transactionsFromJson(jsonString);

import 'dart:convert';

List<Transactions> transactionsFromJson(String str) => List<Transactions>.from(
    json.decode(str).map((x) => Transactions.fromJson(x)));

String transactionsToJson(List<Transactions> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Transactions {
  Transactions({
    this.id,
    this.amount,
    this.reference,
    this.subscription,
    this.payer,
    this.role,
    this.child,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  String id;
  int amount;
  String reference;
  Subscribe subscription;
  Payer payer;
  String role;
  String child;
  DateTime createdAt;
  DateTime updatedAt;
  int v;

  factory Transactions.fromJson(Map<String, dynamic> json) => Transactions(
        id: json["_id"],
        amount: json["amount"],
        reference: json["reference"],
        subscription: Subscribe.fromJson(json["subscription"]),
        payer: Payer.fromJson(json["payer"]),
        role: json["role"],
        child: json["child"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "amount": amount,
        "reference": reference,
        "subscription": subscription.toJson(),
        "payer": payer.toJson(),
        "role": role,
        "child": child,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
      };
}

class Payer {
  Payer({
    this.id,
    this.name,
  });

  String id;
  String name;

  factory Payer.fromJson(Map<String, dynamic> json) => Payer(
        id: json["_id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
      };
}

class Subscribe {
  Subscribe({
    this.id,
    this.plan,
    this.status,
    this.amount,
  });

  String id;
  Plan plan;
  String status;
  int amount;

  factory Subscribe.fromJson(Map<String, dynamic> json) => Subscribe(
        id: json["_id"],
        plan: Plan.fromJson(json["plan"]),
        status: json["status"],
        amount: json["amount"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "plan": plan.toJson(),
        "status": status,
        "amount": amount,
      };
}

class Plan {
  Plan({
    this.id,
    this.name,
    this.price,
    this.duration,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  String id;
  String name;
  int price;
  int duration;
  DateTime createdAt;
  DateTime updatedAt;
  int v;

  factory Plan.fromJson(Map<String, dynamic> json) => Plan(
        id: json["_id"],
        name: json["name"],
        price: json["price"],
        duration: json["duration"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "price": price,
        "duration": duration,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
      };
}
