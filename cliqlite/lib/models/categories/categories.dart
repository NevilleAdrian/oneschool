import 'dart:convert';

List<Categories> categoriesFromJson(String str) =>
    List<Categories>.from(json.decode(str).map((x) => Categories.fromJson(x)));

String categoriesToJson(List<Categories> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Categories {
  Categories({
    this.name,
    this.id,
  });

  String name;
  String id;

  factory Categories.fromJson(Map<String, dynamic> json) => Categories(
        name: json["name"],
        id: json["_id"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "id": id,
      };
}
