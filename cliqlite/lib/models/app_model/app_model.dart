import 'package:hive/hive.dart';

part 'app_model.g.dart';

@HiveType(typeId: 5)
class AppModel {
  @HiveField(0)
  String token;

  AppModel({this.token});
}
