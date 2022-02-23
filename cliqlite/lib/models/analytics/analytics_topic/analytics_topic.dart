import 'dart:convert';

import 'package:hive/hive.dart';

part 'analytics_topic.g.dart';

AnalyticTopic analyticTopicFromJson(String str) =>
    AnalyticTopic.fromJson(json.decode(str));

String analyticTopicToJson(AnalyticTopic data) => json.encode(data.toJson());

@HiveType(typeId: 12)
class AnalyticTopic {
  AnalyticTopic({
    this.highestPerformingSubject,
    this.videosWatched,
    this.quizCompleted,
    this.graph,
  });
  @HiveField(0)
  HighestPerformingSubject highestPerformingSubject;
  @HiveField(1)
  dynamic videosWatched;
  @HiveField(2)
  dynamic quizCompleted;
  @HiveField(3)
  List<Graph> graph;

  factory AnalyticTopic.fromJson(Map<String, dynamic> json) => AnalyticTopic(
        highestPerformingSubject:
            HighestPerformingSubject.fromJson(json["highestPerformingSubject"]),
        videosWatched: json["videosWatched"],
        quizCompleted: json["quizCompleted"],
        graph: List<Graph>.from(json["graph"].map((x) => Graph.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "highestPerformingSubject": highestPerformingSubject.toJson(),
        "videosWatched": videosWatched,
        "quizCompleted": quizCompleted,
        "graph": List<dynamic>.from(graph.map((x) => x.toJson())),
      };
}

@HiveType(typeId: 17)
class Graph {
  Graph({
    this.id,
    this.score,
  });
  @HiveField(0)
  Id id;
  @HiveField(1)
  dynamic score;

  factory Graph.fromJson(Map<String, dynamic> json) => Graph(
        id: Id.fromJson(json["_id"]),
        score: json["score"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id.toJson(),
        "score": score,
      };
}

@HiveType(typeId: 18)
class Id {
  Id({this.day, this.year, this.month});
  @HiveField(0)
  dynamic day;
  dynamic year;
  dynamic month;

  factory Id.fromJson(Map<String, dynamic> json) => Id(
        day: json["day"],
        year: json["year"],
        month: json["month"],
      );

  Map<String, dynamic> toJson() => {
        "day": day,
        "year": day,
        "month": month,
      };
}

@HiveType(typeId: 19)
class HighestPerformingSubject {
  HighestPerformingSubject({
    this.name,
    this.no,
  });

  @HiveField(0)
  String name;
  @HiveField(1)
  dynamic no;

  factory HighestPerformingSubject.fromJson(Map<String, dynamic> json) =>
      HighestPerformingSubject(
        name: json["name"],
        no: json["no"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "no": no,
      };
}
