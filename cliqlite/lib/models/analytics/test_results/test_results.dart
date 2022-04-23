// To parse this JSON data, do
//
//     final testResults = testResultsFromJson(jsonString);

import 'dart:convert';

List<TestResults> testResultsFromJson(String str) => List<TestResults>.from(
    json.decode(str).map((x) => TestResults.fromJson(x)));

String testResultsToJson(List<TestResults> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TestResults {
  TestResults({
    this.id,
    this.subject,
    this.topic,
    this.quiz,
    this.score,
    this.totalQuestions,
    this.percentage,
  });

  String id;
  TestSubject subject;
  TestSubject topic;
  TestQuiz quiz;
  int score;
  int totalQuestions;
  double percentage;

  factory TestResults.fromJson(Map<String, dynamic> json) => TestResults(
        id: json["_id"],
        subject: TestSubject.fromJson(json["subject"]),
        topic: TestSubject.fromJson(json["topic"]),
        quiz: TestQuiz.fromJson(json["quiz"]),
        score: json["score"],
        totalQuestions: json["totalQuestions"],
        percentage: json["percentage"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "subject": subject.toJson(),
        "topic": topic.toJson(),
        "quiz": quiz.toJson(),
        "score": score,
        "totalQuestions": totalQuestions,
        "percentage": percentage,
      };
}

class TestQuiz {
  TestQuiz({
    this.id,
    this.title,
  });

  String id;
  String title;

  factory TestQuiz.fromJson(Map<String, dynamic> json) => TestQuiz(
        id: json["_id"],
        title: json["title"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "title": title,
      };
}

class TestSubject {
  TestSubject({
    this.id,
    this.name,
  });

  String id;
  String name;

  factory TestSubject.fromJson(Map<String, dynamic> json) => TestSubject(
        id: json["_id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
      };
}
