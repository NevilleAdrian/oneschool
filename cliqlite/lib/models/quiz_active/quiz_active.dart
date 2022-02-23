import 'dart:convert';

import 'package:hive/hive.dart';

part 'quiz_active.g.dart';

QuizActive quizActiveFromJson(String str) =>
    QuizActive.fromJson(json.decode(str));

String quizActiveToJson(QuizActive data) => json.encode(data.toJson());

@HiveType(typeId: 15)
class QuizActive {
  QuizActive({
    this.active,
  });

  @HiveField(0)
  bool active;

  factory QuizActive.fromJson(Map<String, dynamic> json) => QuizActive(
        active: json["active"],
      );

  Map<String, dynamic> toJson() => {
        "active": active,
      };
}
