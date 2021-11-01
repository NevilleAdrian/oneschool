import 'dart:convert';

import 'package:hive/hive.dart';

part 'child_index_model.g.dart';

ChildIndex childIndexFromJson(String str) =>
    ChildIndex.fromJson(json.decode(str));

String childIndexToJson(ChildIndex data) => json.encode(data.toJson());

@HiveType(typeId: 10)
class ChildIndex {
  ChildIndex({
    this.index,
  });

  @HiveField(0)
  int index;

  factory ChildIndex.fromJson(Map<String, dynamic> json) => ChildIndex(
        index: json["index"],
      );

  Map<String, dynamic> toJson() => {
        "index": index,
      };
}
