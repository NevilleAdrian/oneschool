import 'dart:convert';

import 'package:hive/hive.dart';

part 'grades.g.dart';

List<Grades> gradesFromJson(String str) =>
    List<Grades>.from(json.decode(str).map((x) => Grades.fromJson(x)));

String gradesToJson(List<Grades> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

@HiveType(typeId: 3)
class Grades {
  Grades({
    this.id,
    this.name,
    this.description,
    // this.photo,
    // this.createdAt,
    // this.v,
  });

  @HiveField(0)
  dynamic id;
  @HiveField(1)
  String name;
  @HiveField(2)
  String description;
  // @HiveField(3)
  // String photo;
  // @HiveField(4)
  // DateTime createdAt;
  // @HiveField(5)
  // int v;

  factory Grades.fromJson(Map<String, dynamic> json) => Grades(
        id: json["_id"] ?? '',
        name: json["name"] ?? '',
        description: json["description"] ?? '',
        // photo: json["photo"] ?? '',
        //   createdAt: DateTime.parse(json["createdAt"]) ?? DateTime.now(),
        //   v: json["__v"] ?? 0,
        // );
      );
  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "description": description,
        // "photo": photo,
        // "createdAt": createdAt.toIso8601String(),
        // "__v": v,
      };
}
