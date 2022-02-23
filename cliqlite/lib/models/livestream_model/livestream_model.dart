// To parse this JSON data, do
//
//     final liveStream = liveStreamFromJson(jsonString);

import 'dart:convert';

import 'package:hive/hive.dart';

part 'livestream_model.g.dart';

List<LiveStream> liveStreamFromJson(String str) =>
    List<LiveStream>.from(json.decode(str).map((x) => LiveStream.fromJson(x)));

String liveStreamToJson(List<LiveStream> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

@HiveType(typeId: 13)
class LiveStream {
  LiveStream({
    this.id,
    this.broadcast,
    this.broadcastUrl,
    this.tutor,
    this.appointment,
    this.subject,
    this.grade,
    this.createdAt,
    this.v,
  });

  @HiveField(0)
  String id;
  @HiveField(1)
  String broadcast;
  @HiveField(2)
  String broadcastUrl;
  @HiveField(3)
  Tutor tutor;
  @HiveField(4)
  Appointment appointment;
  @HiveField(5)
  ChildGrade subject;
  @HiveField(6)
  ChildGrade grade;
  @HiveField(7)
  DateTime createdAt;
  @HiveField(8)
  int v;

  factory LiveStream.fromJson(Map<String, dynamic> json) => LiveStream(
        id: json["_id"],
        broadcast: json["broadcast"],
        broadcastUrl: json["broadcastUrl"],
        tutor: Tutor.fromJson(json["tutor"]),
        appointment: Appointment.fromJson(json["appointment"] ??
            {
              "id": "",
              "start": "2021-11-11T13:50:18.232Z",
              "end": "2021-11-11T13:50:18.232Z"
            }),
        subject: ChildGrade.fromJson(json["subject"]),
        grade: ChildGrade.fromJson(json["grade"]),
        createdAt: DateTime.parse(json["createdAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "broadcast": broadcast,
        "broadcastUrl": broadcastUrl,
        "tutor": tutor.toJson(),
        "appointment": appointment.toJson(),
        "subject": subject.toJson(),
        "grade": grade.toJson(),
        "createdAt": createdAt.toIso8601String(),
        "__v": v,
      };
}

class Appointment {
  Appointment({
    this.id,
    this.start,
    this.end,
  });

  String id;
  DateTime start;
  DateTime end;

  factory Appointment.fromJson(Map<String, dynamic> json) => Appointment(
        id: json["_id"],
        start: DateTime.parse(json["start"]),
        end: DateTime.parse(json["end"]),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "start": start.toIso8601String(),
        "end": end.toIso8601String(),
      };
}

class ChildGrade {
  ChildGrade({
    this.id,
    this.name,
    this.description,
    this.photo,
    this.createdAt,
    this.v,
    this.gradeId,
    this.grade,
    this.slug,
  });

  String id;
  String name;
  String description;
  String photo;
  DateTime createdAt;
  int v;
  String gradeId;
  String grade;
  String slug;

  factory ChildGrade.fromJson(Map<String, dynamic> json) => ChildGrade(
        id: json["_id"],
        name: json["name"],
        description: json["description"],
        photo: json["photo"],
        createdAt: DateTime.parse(json["createdAt"]),
        v: json["__v"],
        gradeId: json["id"],
        grade: json["grade"] == null ? null : json["grade"],
        slug: json["slug"] == null ? null : json["slug"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "description": description,
        "photo": photo,
        "createdAt": createdAt.toIso8601String(),
        "__v": v,
        "id": gradeId,
        "grade": grade == null ? null : grade,
        "slug": slug == null ? null : slug,
      };
}

class Tutor {
  Tutor({
    this.isOnline,
    this.id,
    this.fullname,
    this.email,
    this.phone,
    this.role,
    this.photo,
    this.createdAt,
    this.v,
    this.tutorId,
  });

  bool isOnline;
  String id;
  String fullname;
  String email;
  String phone;
  String role;
  String photo;
  DateTime createdAt;
  int v;
  String tutorId;

  factory Tutor.fromJson(Map<String, dynamic> json) => Tutor(
        isOnline: json["isOnline"],
        id: json["_id"],
        fullname: json["fullname"],
        email: json["email"],
        phone: json["phone"],
        role: json["role"],
        photo: json["photo"],
        createdAt: DateTime.parse(json["createdAt"]),
        v: json["__v"],
        tutorId: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "isOnline": isOnline,
        "_id": id,
        "fullname": fullname,
        "email": email,
        "phone": phone,
        "role": role,
        "photo": photo,
        "createdAt": createdAt.toIso8601String(),
        "__v": v,
        "id": tutorId,
      };
}
