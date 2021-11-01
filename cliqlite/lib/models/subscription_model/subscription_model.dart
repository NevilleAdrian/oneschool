import 'dart:convert';

Subscription subscriptionFromJson(String str) =>
    Subscription.fromJson(json.decode(str));

String subscriptionToJson(Subscription data) => json.encode(data.toJson());

class Subscription {
  Subscription({
    this.id,
    this.user,
    this.parent,
    this.subscription,
    this.createdAt,
    this.v,
  });

  String id;
  SubscribedUser user;
  String parent;
  SubscriptionClass subscription;
  DateTime createdAt;
  int v;

  factory Subscription.fromJson(Map<String, dynamic> json) => Subscription(
        id: json["_id"],
        user: SubscribedUser.fromJson(json["user"]),
        parent: json["parent"],
        subscription: SubscriptionClass.fromJson(json["subscription"]),
        createdAt: DateTime.parse(json["createdAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "user": user.toJson(),
        "parent": parent,
        "subscription": subscription.toJson(),
        "createdAt": createdAt.toIso8601String(),
        "__v": v,
      };
}

class SubscriptionClass {
  SubscriptionClass({
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

  factory SubscriptionClass.fromJson(Map<String, dynamic> json) =>
      SubscriptionClass(
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

class SubscribedUser {
  SubscribedUser({
    this.id,
    this.name,
    this.email,
    this.age,
    this.parent,
    this.isSubscribed,
    this.grade,
    this.role,
    this.photo,
    this.createdAt,
    this.v,
    this.subscriptionDueDate,
    this.userId,
  });

  String id;
  String name;
  String email;
  int age;
  String parent;
  bool isSubscribed;
  String grade;
  String role;
  String photo;
  DateTime createdAt;
  int v;
  DateTime subscriptionDueDate;
  String userId;

  factory SubscribedUser.fromJson(Map<String, dynamic> json) => SubscribedUser(
        id: json["_id"],
        name: json["name"],
        email: json["email"],
        age: json["age"],
        parent: json["parent"],
        isSubscribed: json["isSubscribed"],
        grade: json["grade"],
        role: json["role"],
        photo: json["photo"],
        createdAt: DateTime.parse(json["createdAt"]),
        v: json["__v"],
        subscriptionDueDate: DateTime.parse(json["subscriptionDueDate"]),
        userId: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "email": email,
        "age": age,
        "parent": parent,
        "isSubscribed": isSubscribed,
        "grade": grade,
        "role": role,
        "photo": photo,
        "createdAt": createdAt.toIso8601String(),
        "__v": v,
        "subscriptionDueDate": subscriptionDueDate.toIso8601String(),
        "id": userId,
      };
}
