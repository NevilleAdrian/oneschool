import 'dart:convert';

import 'package:hive/hive.dart';

part 'first_time.g.dart';

FirstTime firstTimeFromJson(String str) => FirstTime.fromJson(json.decode(str));

String firstTimeToJson(FirstTime data) => json.encode(data.toJson());

@HiveType(typeId: 2)
class FirstTime {
  FirstTime({
    this.firstTimeBool,
  });

  @HiveField(0)
  bool firstTimeBool;

  factory FirstTime.fromJson(Map<String, dynamic> json) => FirstTime(
        firstTimeBool: json["bool"],
      );

  Map<String, dynamic> toJson() => {
        "bool": firstTimeBool,
      };
}
