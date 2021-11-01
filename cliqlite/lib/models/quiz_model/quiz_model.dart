// To parse this JSON data, do
//
//     final quiz = quizFromJson(jsonString);

import 'dart:convert';

List<Quiz> quizFromJson(String str) =>
    List<Quiz>.from(json.decode(str).map((x) => Quiz.fromJson(x)));

String quizToJson(List<Quiz> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Quiz {
  Quiz({
    this.id,
    this.resource,
    this.quiz,
    this.createdAt,
    this.v,
  });

  String id;
  Resource resource;
  String quiz;
  DateTime createdAt;
  int v;

  factory Quiz.fromJson(Map<String, dynamic> json) => Quiz(
        id: json["_id"],
        resource: Resource.fromJson(json["resource"]),
        quiz: json["quiz"],
        createdAt: DateTime.parse(json["createdAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "resource": resource.toJson(),
        "quiz": quiz,
        "createdAt": createdAt.toIso8601String(),
        "__v": v,
      };
}

class Resource {
  Resource({
    this.description,
    this.image,
    this.questions,
    this.options,
    this.type,
    this.option1,
    this.option2,
    this.option3,
    this.option4,
    this.correctAnswer,
  });

  List<String> description;
  List<String> image;
  List<Question> questions;
  List<Option> options;
  List<String> type;
  List<String> option1;
  List<String> option2;
  List<String> option3;
  List<String> option4;
  List<String> correctAnswer;

  factory Resource.fromJson(Map<String, dynamic> json) => Resource(
        description: List<String>.from(json["description"].map((x) => x)),
        image: List<String>.from(json["image"].map((x) => x)),
        questions: json["questions"] == null
            ? null
            : List<Question>.from(
                json["questions"].map((x) => Question.fromJson(x))),
        options: json["options"] == null
            ? null
            : List<Option>.from(json["options"].map((x) => Option.fromJson(x))),
        type: List<String>.from(json["type"].map((x) => x)),
        option1: json["option1"] == null
            ? null
            : List<String>.from(json["option1"].map((x) => x)),
        option2: json["option2"] == null
            ? null
            : List<String>.from(json["option2"].map((x) => x)),
        option3: json["option3"] == null
            ? null
            : List<String>.from(json["option3"].map((x) => x)),
        option4: json["option4"] == null
            ? null
            : List<String>.from(json["option4"].map((x) => x)),
        correctAnswer: json["correctAnswer"] == null
            ? null
            : List<String>.from(json["correctAnswer"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "description": List<dynamic>.from(description.map((x) => x)),
        "image": List<dynamic>.from(image.map((x) => x)),
        "questions": questions == null
            ? null
            : List<dynamic>.from(questions.map((x) => x.toJson())),
        "options": options == null
            ? null
            : List<dynamic>.from(options.map((x) => x.toJson())),
        "type": List<dynamic>.from(type.map((x) => x)),
        "option1":
            option1 == null ? null : List<dynamic>.from(option1.map((x) => x)),
        "option2":
            option2 == null ? null : List<dynamic>.from(option2.map((x) => x)),
        "option3":
            option3 == null ? null : List<dynamic>.from(option3.map((x) => x)),
        "option4":
            option4 == null ? null : List<dynamic>.from(option4.map((x) => x)),
        "correctAnswer": correctAnswer == null
            ? null
            : List<dynamic>.from(correctAnswer.map((x) => x)),
      };
}

class Option {
  Option({
    this.name,
  });

  String name;

  factory Option.fromJson(Map<String, dynamic> json) => Option(
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
      };
}

class Question {
  Question({
    this.id,
    this.name,
    this.active,
  });

  int id;
  String name;
  bool active;

  factory Question.fromJson(Map<String, dynamic> json) => Question(
        id: json["id"],
        name: json["name"],
        active: json["active"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "active": active,
      };
}
