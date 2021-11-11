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
    this.user,
    this.amount,
    this.status,
    this.confirmed,
    this.createdAt,
    this.v,
  });

  String id;
  String user;
  int amount;
  Status status;
  bool confirmed;
  DateTime createdAt;
  int v;

  factory Transactions.fromJson(Map<String, dynamic> json) => Transactions(
        id: json["_id"],
        user: json["user"],
        amount: json["amount"],
        status: statusValues.map[json["status"]],
        confirmed: json["confirmed"],
        createdAt: DateTime.parse(json["createdAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "user": user,
        "amount": amount,
        "status": statusValues.reverse[status],
        "confirmed": confirmed,
        "createdAt": createdAt.toIso8601String(),
        "__v": v,
      };
}

enum Status { PENDING }

final statusValues = EnumValues({"pending": Status.PENDING});

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
