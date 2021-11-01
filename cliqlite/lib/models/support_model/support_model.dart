// To parse this JSON data, do
//
//     final supportModel = supportModelFromJson(jsonString);

import 'dart:convert';

List<SupportModel> supportModelFromJson(String str) => List<SupportModel>.from(
    json.decode(str).map((x) => SupportModel.fromJson(x)));

String supportModelToJson(List<SupportModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SupportModel {
  SupportModel({
    this.id,
    this.question,
    this.answer,
    this.tags,
    this.createdAt,
    this.v,
  });

  String id;
  String question;
  String answer;
  List<String> tags;
  DateTime createdAt;
  int v;

  factory SupportModel.fromJson(Map<String, dynamic> json) => SupportModel(
        id: json["_id"],
        question: json["question"],
        answer: json["answer"],
        tags: List<String>.from(json["tags"].map((x) => x)),
        createdAt: DateTime.parse(json["createdAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "question": question,
        "answer": answer,
        "tags": List<dynamic>.from(tags.map((x) => x)),
        "createdAt": createdAt.toIso8601String(),
        "__v": v,
      };
}
