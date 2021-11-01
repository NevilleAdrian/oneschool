import 'package:hive/hive.dart';

part 'grade.g.dart';

@HiveType(typeId: 7)
class Grade {
  Grade({this.grade, this.name});
  @HiveField(0)
  String grade;
  @HiveField(1)
  String name;

  factory Grade.fromJson(Map<String, dynamic> json) => Grade(
        grade: json["grade"],
        name: json["name"],
      );
}
